# Análisis exploratorio de un conjunto de datos en R/RStudio - Trabajo Parcial
# Integrantes
* Claudia Letizia Sifuentes Mendieta
* Renato Guillermo Vivas Alejandro
* Diego Armando Flores Carrizales
* Ayrton Jafet Samaniego Millan

# Objetivo
El objetivo principal de este estudio es realizar un análisis exhaustivo del conjunto de datos "Hotel booking demand datasets", con el propósito de proporcionar una comprensión detallada de las tendencias de reservas y la demanda de habitaciones en la industria hotelera. Además, se busca identificar patrones y relaciones significativas en los datos, teniendo en cuenta el ruido presente en la información, con el fin de ofrecer información valiosa para cadenas hoteleras y agencias de viajes en línea.
# Dataset
<table>
    <thead>
        <tr class="rowsep-1">
            <th scope="col"><strong>Variable</strong></th>
            <th scope="col"><strong>Tipo</strong></th>
            <th scope="col"><strong>Descripción</strong></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th scope="row"><em>Hotel</em></th>
            <td>Categórico</td>
            <td>Nombre del tipo de hotel (City Hotel, Resort Hotel)</td>
        </tr>
        <tr>
            <th scope="row"><em>Iscanceled</em></th>
            <td>Categórico</td>
            <td>Indica si la reserva fue cancelada o no</td>
        </tr>
        <tr>
            <th scope="row"><em>LeadTime</em></th>
            <td>Entero</td>
            <td>Número de días desde la realización de reserva y la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>ArrivalDateYear</em></th>
            <td>Entero</td>
            <td>Año de la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>ArrivalDateMonth</em></th>
            <td>Categórico</td>
            <td>Mes de la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>ArrivalDateWeekNumber</em></th>
            <td>Entero</td>
            <td>Número de semana de la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>ArrivalDateDayOfMonth</em></th>
            <td>Entero</td>
            <td>Dia del mes de la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>StayInWeekendNights</em></th>
            <td>Entero</td>
            <td>Número de días de fin de semana de la estadía</td>
        </tr>
        <tr>
            <th scope="row"><em>StayInWeekNights</em></th>
            <td>Entero</td>
            <td>Número de días de semana de la estadía</td>
        </tr>
        <tr>
            <th scope="row"><em>Adults</em></th>
            <td>Entero</td>
            <td>Number of adults</td>
        </tr>
        <tr>
            <th scope="row"><em>Children</em></th>
            <td>Entero</td>
            <td>Número de niños en la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>Babies</em></th>
            <td>Entero</td>
            <td>Número de bebés en la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>Meal</em></th>
            <td>Categórico</td>
            <td>Tipo de comida solicitada para la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>Country</em></th>
            <td>Categórico</td>
            <td>Pais de origen del cliente</td>
        </tr>
        <tr>
            <th scope="row"><em>MarkedSegment</em></th>
            <td>Categórico</td>
            <td>Indica el segmento de mercado de la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>DistributionChannel</em></th>
            <td>Categórico</td>
            <td>Indica el canal de distribución de la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>IsRepeatGuest</em></th>
            <td>Categórico</td>
            <td>Indica si la reserva es de un cliente recurrente o no</td>
        </tr>
        <tr>
            <th scope="row"><em>PreviousCancellation</em></th>
            <td>Entero</td>
            <td>Número de reservas canceladas previamente por el cliente</td>
        </tr>
        <tr>
            <th scope="row"><em></em>PreviousBookingNotCanceled</th>
            <td>Entero</td>
            <td>Número de reservas no canceladas previamente por el cliente</td>
        </tr>
        <tr>
            <th scope="row"><em>Agent</em></th>
            <td>Entero</td>
            <td>ID de la agencia de viajes que realizó la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>Company</em></th>
            <td>Categórico</td>
            <td>ID de la compañía que realizó la reserva o es responsable del pago</td>
        </tr>
        <tr>
            <th scope="row"><em>ReservedRoomType</em></th>
            <td>Categórico</td>
            <td>Código del tipo de habitación reservada</td>
        </tr>
        <tr>
            <th scope="row"><em>AssignedRoomType</em></th>
            <td>Categórico</td>
            <td>Código del tipo de habitación asignada</td>
        </tr>
        <tr>
            <th scope="row"><em>BookingChanges</em></th>
            <td>Entero</td>
            <td>Número de cambios que tuvo la reserva hasta el momento de la fecha de llegada</td>
        </tr>
        <tr>
            <th scope="row"><em>DepositType</em></th>
            <td>Categórico</td>
            <td>Tipo de depósito que se realizó para el pago de la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>DaysInWaitingList</em></th>
            <td>Entero</td>
            <td>Número de días de la reserva en lista de espera hasta la confirmación al cliente</td>
        </tr>
        <tr>
            <th scope="row"><em>CustomerType</em></th>
            <td>Categórico</td>
            <td>Tipo de contrato realizado para la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>Adr</em></th>
            <td>Numérico</td>
            <td>Costo promedio por dia de la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>RequiredParkingSpaces</em></th>
            <td>Entero</td>
            <td>Indica si la reserva necesita espacio de estacionamiento</td>
        </tr>
        <tr>
            <th scope="row"><em>TotalOfSpecialRequests</em></th>
            <td>Entero</td>
            <td>Número de peticiones especiales hechas por el cliente</td>
        </tr>
        <tr>
            <th scope="row"><em>ReservationStatus</em></th>
            <td>Categórico</td>
            <td>Estado de la reserva</td>
        </tr>
        <tr>
            <th scope="row"><em>ReservationStatusDate</em></th>
            <td>Fecha</td>
            <td>Fecha del último cambio de estado de la reserva</td>
        </tr>
    </tbody>
</table>

# Conclusiones
1. Durante los años 2015-2017, el hotel más reservado fue el "City Hotel" con 53,428 reservas, seguido por el "Resort Hotel" con 33,968 reservas.

2. Se observa un aumento constante en la cantidad de reservas cada año, a pesar de las fluctuaciones estacionales.

3. La temporada más popular para ambas categorías de hoteles es el verano, seguida de la primavera, mientras que el invierno tiene la menor demanda.

4. Solo el 7.82% de las reservas incluyen niños o bebés, mientras que el 92.18% no los incluye.

5. El 6.21% de las reservas solicita estacionamiento, indicando que la mayoría no lo necesita.
   
7. Los meses de agosto, julio y mayo experimentan el mayor número de cancelaciones durante los años 2015-2017.

8. El tipo de habitación "A" es el más reservado, seguido por "D" y "E", mientras que otros tipos tienen menos registros.

9. Los tipos de habitaciones más costosos son H, G y F, con precios promedio de 171, 166 y 151 respectivamente, mientras que los más económicos son L, I y K.

10. El "Resort Hotel" tiene una estadía promedio más larga que el "City Hotel", con una mediana de 5 días frente a 3 días.

11. Los hoteles "City Hotel" tienden a ser más costosos en promedio, con una mediana de 105.3, mientras que los "Resort Hotel" son más económicos, con una mediana de 
     79.5. Los datos muestran una gran dispersión y valores atípicos en los precios.

# Licencia
 Se ha acordado usar para este proyecto analítico la licencia [Atribución-NoComercial-CompartirIgual 4.0 Internacional (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es)
