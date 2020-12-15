classdef ClasificacionLineal < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        ClasificacionlinealMetodosnumericosUIFigure  matlab.ui.Figure
        ArchivoMenu                    matlab.ui.container.Menu
        SalirMenu                      matlab.ui.container.Menu
        AyudaMenu                      matlab.ui.container.Menu
        InformacionMenu                matlab.ui.container.Menu
        TabGroup                       matlab.ui.container.TabGroup
        ProcesamientodelosdatosTab     matlab.ui.container.Tab
        DatosPanel                     matlab.ui.container.Panel
        ClaseATable                    matlab.ui.control.Table
        ClaseBTable                    matlab.ui.control.Table
        ClaseBLabel                    matlab.ui.control.Label
        ClaseALabel                    matlab.ui.control.Label
        AgregarpuntoButton             matlab.ui.control.Button
        EliminarpuntoButton            matlab.ui.control.Button
        GraficaPanel                   matlab.ui.container.Panel
        Plotter                        matlab.ui.control.UIAxes
        IteracionactualEditFieldLabel  matlab.ui.control.Label
        IterationEditField             matlab.ui.control.NumericEditField
        EjecutarSwitchLabel            matlab.ui.control.Label
        EjecutarSwitch                 matlab.ui.control.ToggleSwitch
        ParametrosPanel                matlab.ui.container.Panel
        MaximodeiteracionesSpinnerLabel  matlab.ui.control.Label
        MaxIteSpinner                  matlab.ui.control.Spinner
        MargendeerrorEditFieldLabel    matlab.ui.control.Label
        DeltaEditField                 matlab.ui.control.NumericEditField
        TasadeaprendizajeSliderLabel   matlab.ui.control.Label
        LearningRateSlider             matlab.ui.control.Slider
        Vector1EditField               matlab.ui.control.NumericEditField
        Vector2EditField               matlab.ui.control.NumericEditField
        Vector3EditField               matlab.ui.control.NumericEditField
        DiscriminantelinealLabel       matlab.ui.control.Label
        EcuacionLabel                  matlab.ui.control.Label
        VectorLabel                    matlab.ui.control.Label
        EquationLabel                  matlab.ui.control.Label
        LinealmenteSeparableLabel      matlab.ui.control.Label
        LinearLamp                     matlab.ui.control.Lamp
        EnejecucionLampLabel           matlab.ui.control.Label
        ExecutionLamp                  matlab.ui.control.Lamp
        ClasificacionlinealLabel       matlab.ui.control.Label
    end

    
    properties (Access = private)
        a
        eta
        k_max
        delta
        X_a
        X_b
        plot_timer
        b
        Y
        k
        e
        isCalculated
    end
    
    methods (Access = public)
        
        function Plot(app)
            x1 = app.X_a(:, 1);
            y1 = app.X_a(:, 2);
            
            x2 = app.X_b(:, 1);
            y2 = app.X_b(:, 2);
            
            x3 = linspace(min([x1; x2]) - 1, max([x1; x2]) + 1);
            y3 = - app.a(2) / app.a(3) * x3 - app.a(1) / app.a(3);
            
            p1 = scatter(app.Plotter, x1, y1, 75, 'blue', 'filled', '^');
            hold(app.Plotter, 'on');
            p2 = scatter(app.Plotter, x2, y2, 75, 'red', 'filled', 'square');
            p3 = plot(app.Plotter, x3, y3, '-black');
            xline(app.Plotter, 0);
            yline(app.Plotter, 0);
            hold(app.Plotter, 'off');
            
            legend(app.Plotter, [p1 p2 p3], {'Clase A', 'Clase B', 'Discriminante lineal'});
            
            axis(app.Plotter, [min([x1; x2])-1 max([x1; x2])+1 min([y1; y2])-1 max([y1; y2])+1]);
            
        end
        
        function [a, b, e] = HosKashyap(~, a, b, Y, eta)
            e = Y*a - b;
            b = b + eta * (e + abs(e));
            a = (Y' * Y)^-1 * Y' * b;
        end
        
        function [out] = sym2str(~, sy)
            sy = sym(sy);
            siz = numel(sy);
            in = cell(1, siz);
            for i = 1 : siz
                in{i} = char(sy(i));
                in{i} = strrep(in{i}, '^', '^');
                in{i} = strrep(in{i}, '*', '*');
                in{i} = strrep(in{i}, '/', '/');
                in{i} = strrep(in{i}, 'atan', 'atan2');
                in{i} = strrep(in{i}, 'array([[', '[');
                in{i} = strrep(in{i}, '],[', ';');
                in{i} = strrep(in{i}, ']])', ']');
            end
            if siz == 1
                in = char(in);
            end
            out = in;
        end
        
        function Iterate(app, ~, ~)
            b_1 = app.b;
            [app.a, app.b, app.e] = HosKashyap(app, app.a, app.b, app.Y, app.eta);
          
            flag = true;
            for n = 1 : size(b_1, 1)
                flag = flag && b_1(n) == app(n);
            end
            
            app.k = app.k + 1;
            app.Vector1EditField.Value = app.a(1);
            app.Vector2EditField.Value = app.a(2);
            app.Vector3EditField.Value = app.a(3);
            
            syms x; sympref('FloatingPointOutput', true);
            y = - app.a(2)/app.a(3) * x - app.a(1)/app.a(3);
            app.EquationLabel.Text = strcat("y = ", sym2str(app, vpa(expand(y))));
            app.IterationEditField.Value = app.k;
            Plot(app);
            
            if max(app.e) < 0
                app.LinearLamp.Color = [1 0 0];
                flag = true;
            else
                app.LinearLamp.Color = [0 1 0];
            end
            
            
            if app.k >= app.k_max || min(app.e) >= 0 || flag || min(abs(app.Y * app.a)) < app.delta
                stop(app.plot_timer);
                app.EjecutarSwitch.Value = "Off";
                app.ExecutionLamp.Color = [1 0 0];
                app.isCalculated = true;
            end
        end
        
        function Init_Method(app)
            app.Y = [ones(size(app.ClaseATable.Data, 1), 1) app.ClaseATable.Data; -ones(size(app.ClaseBTable.Data, 1), 1) -app.ClaseBTable.Data];
            app.a = app.a;
            app.b = ones(size(app.Y, 1) , 1);
            app.k = 1;
            app.e = -ones(size(app.Y, 1) , 1);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function InitParameters(app)
            Data = app.ClaseATable.Data;
            Data(size(Data, 1) + 1, 1) = 0;
            Data(size(Data, 1), 2) = 0;
            app.ClaseATable.Data = Data;
            
            Data = app.ClaseBTable.Data;
            Data(size(Data, 1) + 1, 1) = 0;
            Data(size(Data, 1), 2) = 0;
            app.ClaseBTable.Data = Data;
            
            app.a = [app.Vector1EditField.Value; app.Vector2EditField.Value ; app.Vector3EditField.Value];
            app.eta = app.LearningRateSlider.Value;
            app.k_max = app.MaxIteSpinner.Value;
            app.X_a = app.ClaseATable.Data;
            app.X_b = app.ClaseBTable.Data;
            app.delta = app.DeltaEditField.Value;
            app.isCalculated = true;
            app.plot_timer = timer(...
                'ExecutionMode', 'fixedRate', ...    
                'Period', 0.25, ...                   
                'BusyMode', 'queue',...              
                'TimerFcn', @app.Iterate);
            Plot(app);
        end

        % Menu selected function: SalirMenu
        function OnClickMenuSalir(app, event)
            delete(app);
        end

        % Menu selected function: InformacionMenu
        function OnClickMenuInformacion(app, event)
            disp(newline + "Clasificacion Lineal - Metodos numericos" + newline);
            disp("Juan Diego Preciado Mahecha");
            disp("Jorge Aurelio Morales Manrique");
            disp("Ricardo Andres Calvo Mendez");
        end

        % Button pushed function: AgregarpuntoButton
        function OnClickAgregarPunto(app, event)
            Data = app.ClaseATable.Data;
            Data(size(Data, 1) + 1, 1) = 0;
            Data(size(Data, 1), 2) = 0;
            app.ClaseATable.Data = Data;
            
            Data = app.ClaseBTable.Data;
            Data(size(Data, 1) + 1, 1) = 0;
            Data(size(Data, 1), 2) = 0;
            app.ClaseBTable.Data = Data;
            
            OnEditClass(app, event);
        end

        % Button pushed function: EliminarpuntoButton
        function OnClickEliminarPunto(app, event)
            Data = app.ClaseATable.Data;
            Data = Data(1 : size(Data, 1) - 1, 1 : 2);
            app.ClaseATable.Data = Data;
            
            Data = app.ClaseBTable.Data;
            Data = Data(1 : size(Data, 1) - 1, 1 : 2);
            app.ClaseBTable.Data = Data;
            
            OnEditClass(app, event);
        end

        % Cell edit callback: ClaseATable, ClaseBTable
        function OnEditClass(app, event)
            app.X_a = app.ClaseATable.Data;
            app.X_b = app.ClaseBTable.Data;
            Plot(app);
            app.Y = [ones(size(app.X_a, 1), 1) app.X_a; -ones(size(app.X_b, 1), 1) -app.X_b];
            d = det(app.Y' * app.Y);
            if(d == 0)
                app.EjecutarSwitch.Enable = false;
            else 
                app.EjecutarSwitch.Enable = true;
            end
        end

        % Value changed function: EjecutarSwitch
        function Executer(app, event)
            if app.EjecutarSwitch.Value == "On"
                if app.isCalculated
                   Init_Method(app); 
                   app.isCalculated = false;
                end
                start(app.plot_timer);
                app.ExecutionLamp.Color = [0 1 0];
            else
                stop(app.plot_timer);
                app.ExecutionLamp.Color = [1 0 0];
                
            end
        end

        % Value changed function: Vector1EditField, 
        % Vector2EditField, Vector3EditField
        function OnEditDiscrminant(app, event)
            app.a = [app.Vector1EditField.Value; app.Vector2EditField.Value ; app.Vector3EditField.Value];
            syms x; sympref('FloatingPointOutput', true);
            y = - app.a(2)/app.a(3) * x - app.a(1)/app.a(3);
            app.EquationLabel.Text = strcat("y = ", sym2str(app, vpa(expand(y))));
            Plot(app);
        end

        % Value changed function: LearningRateSlider
        function OnChangeEta(app, event)
            app.eta = app.LearningRateSlider.Value;
        end

        % Value changed function: DeltaEditField
        function OnChangeDelta(app, event)
            app.delta = app.DeltaEditField.Value;
        end

        % Value changed function: MaxIteSpinner
        function OnChangeMaxIt(app, event)
            app.k_max = app.MaxIteSpinner.Value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create ClasificacionlinealMetodosnumericosUIFigure and hide until all components are created
            app.ClasificacionlinealMetodosnumericosUIFigure = uifigure('Visible', 'off');
            app.ClasificacionlinealMetodosnumericosUIFigure.Position = [100 100 1200 800];
            app.ClasificacionlinealMetodosnumericosUIFigure.Name = 'Clasificacion lineal - Metodos numericos';

            % Create ArchivoMenu
            app.ArchivoMenu = uimenu(app.ClasificacionlinealMetodosnumericosUIFigure);
            app.ArchivoMenu.Text = 'Archivo';

            % Create SalirMenu
            app.SalirMenu = uimenu(app.ArchivoMenu);
            app.SalirMenu.MenuSelectedFcn = createCallbackFcn(app, @OnClickMenuSalir, true);
            app.SalirMenu.Accelerator = 'X';
            app.SalirMenu.Text = 'Salir';

            % Create AyudaMenu
            app.AyudaMenu = uimenu(app.ClasificacionlinealMetodosnumericosUIFigure);
            app.AyudaMenu.Text = 'Ayuda';

            % Create InformacionMenu
            app.InformacionMenu = uimenu(app.AyudaMenu);
            app.InformacionMenu.MenuSelectedFcn = createCallbackFcn(app, @OnClickMenuInformacion, true);
            app.InformacionMenu.Text = 'Informacion';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.ClasificacionlinealMetodosnumericosUIFigure);
            app.TabGroup.Position = [1 1 1199 749];

            % Create ProcesamientodelosdatosTab
            app.ProcesamientodelosdatosTab = uitab(app.TabGroup);
            app.ProcesamientodelosdatosTab.Title = 'Procesamiento de los datos';

            % Create DatosPanel
            app.DatosPanel = uipanel(app.ProcesamientodelosdatosTab);
            app.DatosPanel.Title = 'Datos';
            app.DatosPanel.Position = [51 324 470 350];

            % Create ClaseATable
            app.ClaseATable = uitable(app.DatosPanel);
            app.ClaseATable.ColumnName = {'X'; 'Y'};
            app.ClaseATable.RowName = {};
            app.ClaseATable.ColumnSortable = [true false];
            app.ClaseATable.ColumnEditable = true;
            app.ClaseATable.CellEditCallback = createCallbackFcn(app, @OnEditClass, true);
            app.ClaseATable.Position = [21 50 200 220];

            % Create ClaseBTable
            app.ClaseBTable = uitable(app.DatosPanel);
            app.ClaseBTable.ColumnName = {'X'; 'Y'};
            app.ClaseBTable.RowName = {};
            app.ClaseBTable.ColumnSortable = [true false];
            app.ClaseBTable.ColumnEditable = true;
            app.ClaseBTable.CellEditCallback = createCallbackFcn(app, @OnEditClass, true);
            app.ClaseBTable.Position = [251 50 200 220];

            % Create ClaseBLabel
            app.ClaseBLabel = uilabel(app.DatosPanel);
            app.ClaseBLabel.Position = [251 288 48 22];
            app.ClaseBLabel.Text = 'Clase B';

            % Create ClaseALabel
            app.ClaseALabel = uilabel(app.DatosPanel);
            app.ClaseALabel.Position = [21 288 48 22];
            app.ClaseALabel.Text = 'Clase A';

            % Create AgregarpuntoButton
            app.AgregarpuntoButton = uibutton(app.DatosPanel, 'push');
            app.AgregarpuntoButton.ButtonPushedFcn = createCallbackFcn(app, @OnClickAgregarPunto, true);
            app.AgregarpuntoButton.Position = [131 18 90 22];
            app.AgregarpuntoButton.Text = 'Agregar punto';

            % Create EliminarpuntoButton
            app.EliminarpuntoButton = uibutton(app.DatosPanel, 'push');
            app.EliminarpuntoButton.ButtonPushedFcn = createCallbackFcn(app, @OnClickEliminarPunto, true);
            app.EliminarpuntoButton.Position = [251 18 90 22];
            app.EliminarpuntoButton.Text = 'Eliminar punto';

            % Create GraficaPanel
            app.GraficaPanel = uipanel(app.ProcesamientodelosdatosTab);
            app.GraficaPanel.Title = 'Grafica';
            app.GraficaPanel.Position = [581 104 570 570];

            % Create Plotter
            app.Plotter = uiaxes(app.GraficaPanel);
            title(app.Plotter, 'Grafica de los puntos')
            xlabel(app.Plotter, 'X')
            ylabel(app.Plotter, 'Y')
            app.Plotter.XGrid = 'on';
            app.Plotter.XMinorGrid = 'on';
            app.Plotter.YGrid = 'on';
            app.Plotter.YMinorGrid = 'on';
            app.Plotter.Position = [21 20 530 510];

            % Create IteracionactualEditFieldLabel
            app.IteracionactualEditFieldLabel = uilabel(app.ProcesamientodelosdatosTab);
            app.IteracionactualEditFieldLabel.HorizontalAlignment = 'right';
            app.IteracionactualEditFieldLabel.Position = [641 52 87 22];
            app.IteracionactualEditFieldLabel.Text = 'Iteracion actual';

            % Create IterationEditField
            app.IterationEditField = uieditfield(app.ProcesamientodelosdatosTab, 'numeric');
            app.IterationEditField.ValueDisplayFormat = '%.0f';
            app.IterationEditField.Editable = 'off';
            app.IterationEditField.Position = [741 52 52 22];
            app.IterationEditField.Value = 1;

            % Create EjecutarSwitchLabel
            app.EjecutarSwitchLabel = uilabel(app.ProcesamientodelosdatosTab);
            app.EjecutarSwitchLabel.HorizontalAlignment = 'center';
            app.EjecutarSwitchLabel.Position = [861 32 50 22];
            app.EjecutarSwitchLabel.Text = 'Ejecutar';

            % Create EjecutarSwitch
            app.EjecutarSwitch = uiswitch(app.ProcesamientodelosdatosTab, 'toggle');
            app.EjecutarSwitch.Orientation = 'horizontal';
            app.EjecutarSwitch.ValueChangedFcn = createCallbackFcn(app, @Executer, true);
            app.EjecutarSwitch.Position = [863 64 45 20];

            % Create ParametrosPanel
            app.ParametrosPanel = uipanel(app.ProcesamientodelosdatosTab);
            app.ParametrosPanel.Title = 'Parametros';
            app.ParametrosPanel.Position = [50 34 471 266];

            % Create MaximodeiteracionesSpinnerLabel
            app.MaximodeiteracionesSpinnerLabel = uilabel(app.ParametrosPanel);
            app.MaximodeiteracionesSpinnerLabel.HorizontalAlignment = 'right';
            app.MaximodeiteracionesSpinnerLabel.Position = [11 214 126 22];
            app.MaximodeiteracionesSpinnerLabel.Text = 'Maximo de iteraciones';

            % Create MaxIteSpinner
            app.MaxIteSpinner = uispinner(app.ParametrosPanel);
            app.MaxIteSpinner.ValueChangedFcn = createCallbackFcn(app, @OnChangeMaxIt, true);
            app.MaxIteSpinner.Position = [151 214 69 22];
            app.MaxIteSpinner.Value = 200;

            % Create MargendeerrorEditFieldLabel
            app.MargendeerrorEditFieldLabel = uilabel(app.ParametrosPanel);
            app.MargendeerrorEditFieldLabel.HorizontalAlignment = 'right';
            app.MargendeerrorEditFieldLabel.Position = [243 214 92 22];
            app.MargendeerrorEditFieldLabel.Text = 'Margen de error';

            % Create DeltaEditField
            app.DeltaEditField = uieditfield(app.ParametrosPanel, 'numeric');
            app.DeltaEditField.ValueChangedFcn = createCallbackFcn(app, @OnChangeDelta, true);
            app.DeltaEditField.Position = [350 214 100 22];
            app.DeltaEditField.Value = 0.01;

            % Create TasadeaprendizajeSliderLabel
            app.TasadeaprendizajeSliderLabel = uilabel(app.ParametrosPanel);
            app.TasadeaprendizajeSliderLabel.HorizontalAlignment = 'right';
            app.TasadeaprendizajeSliderLabel.Position = [11 174 113 22];
            app.TasadeaprendizajeSliderLabel.Text = 'Tasa de aprendizaje';

            % Create LearningRateSlider
            app.LearningRateSlider = uislider(app.ParametrosPanel);
            app.LearningRateSlider.Limits = [0 1];
            app.LearningRateSlider.ValueChangedFcn = createCallbackFcn(app, @OnChangeEta, true);
            app.LearningRateSlider.Position = [145 183 305 3];
            app.LearningRateSlider.Value = 0.9;

            % Create Vector1EditField
            app.Vector1EditField = uieditfield(app.ParametrosPanel, 'numeric');
            app.Vector1EditField.ValueChangedFcn = createCallbackFcn(app, @OnEditDiscrminant, true);
            app.Vector1EditField.Position = [131 94 41 22];
            app.Vector1EditField.Value = 1;

            % Create Vector2EditField
            app.Vector2EditField = uieditfield(app.ParametrosPanel, 'numeric');
            app.Vector2EditField.ValueChangedFcn = createCallbackFcn(app, @OnEditDiscrminant, true);
            app.Vector2EditField.Position = [131 64 41 22];
            app.Vector2EditField.Value = 1;

            % Create Vector3EditField
            app.Vector3EditField = uieditfield(app.ParametrosPanel, 'numeric');
            app.Vector3EditField.ValueChangedFcn = createCallbackFcn(app, @OnEditDiscrminant, true);
            app.Vector3EditField.Position = [131 34 41 22];
            app.Vector3EditField.Value = 1;

            % Create DiscriminantelinealLabel
            app.DiscriminantelinealLabel = uilabel(app.ParametrosPanel);
            app.DiscriminantelinealLabel.Position = [21 124 110 22];
            app.DiscriminantelinealLabel.Text = 'Discriminante lineal';

            % Create EcuacionLabel
            app.EcuacionLabel = uilabel(app.ParametrosPanel);
            app.EcuacionLabel.Position = [231 94 58 22];
            app.EcuacionLabel.Text = 'Ecuacion:';

            % Create VectorLabel
            app.VectorLabel = uilabel(app.ParametrosPanel);
            app.VectorLabel.Position = [51 94 43 22];
            app.VectorLabel.Text = 'Vector:';

            % Create EquationLabel
            app.EquationLabel = uilabel(app.ParametrosPanel);
            app.EquationLabel.HorizontalAlignment = 'center';
            app.EquationLabel.FontAngle = 'italic';
            app.EquationLabel.Position = [235 64 211 22];
            app.EquationLabel.Text = 'y = - x - 1';

            % Create LinealmenteSeparableLabel
            app.LinealmenteSeparableLabel = uilabel(app.ParametrosPanel);
            app.LinealmenteSeparableLabel.HorizontalAlignment = 'right';
            app.LinealmenteSeparableLabel.Position = [259 28 129 22];
            app.LinealmenteSeparableLabel.Text = 'Linealmente Separable';

            % Create LinearLamp
            app.LinearLamp = uilamp(app.ParametrosPanel);
            app.LinearLamp.Position = [403 28 20 20];
            app.LinearLamp.Color = [1 1 1];

            % Create EnejecucionLampLabel
            app.EnejecucionLampLabel = uilabel(app.ProcesamientodelosdatosTab);
            app.EnejecucionLampLabel.HorizontalAlignment = 'right';
            app.EnejecucionLampLabel.Position = [993 52 74 22];
            app.EnejecucionLampLabel.Text = 'En ejecucion';

            % Create ExecutionLamp
            app.ExecutionLamp = uilamp(app.ProcesamientodelosdatosTab);
            app.ExecutionLamp.Position = [1082 52 20 20];
            app.ExecutionLamp.Color = [1 0 0];

            % Create ClasificacionlinealLabel
            app.ClasificacionlinealLabel = uilabel(app.ClasificacionlinealMetodosnumericosUIFigure);
            app.ClasificacionlinealLabel.HorizontalAlignment = 'center';
            app.ClasificacionlinealLabel.FontSize = 16;
            app.ClasificacionlinealLabel.FontWeight = 'bold';
            app.ClasificacionlinealLabel.Position = [1 751 1200 50];
            app.ClasificacionlinealLabel.Text = 'Clasificacion lineal';

            % Show the figure after all components are created
            app.ClasificacionlinealMetodosnumericosUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ClasificacionLineal

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.ClasificacionlinealMetodosnumericosUIFigure)

            % Execute the startup function
            runStartupFcn(app, @InitParameters)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.ClasificacionlinealMetodosnumericosUIFigure)
        end
    end
end