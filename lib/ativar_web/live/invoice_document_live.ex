defmodule AtivarWeb.InvoiceDocumentLive do
  use AtivarWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    items = [
      %{
        id: 1,
        name: "Ginger",
        quantity: 540,
        rate: 32.00,
        total: 12096.00
      }
    ]

    {:ok, assign(socket, :items, items)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="invoice-document-wrapper">
      <div class="invoice-document">
        <div class="invoice-document-header">
          <img src={~p"/images/logo_horizontal.svg"} />
          <img src={~p"/images/logo_farm_to_trader.svg"} />
        </div>
        <div class="invoice-document-title">
          <div class="title">ATV-2542023-A</div>
          <div class="date">June 6th 2023</div>
        </div>

        <div class="invoice-document-data">
          <div class="row">
            <div class="input-data">
              <div class="text-wrapper-1">Importer:</div>
              <div class="text-wrapper-2">ROVEG</div>
            </div>
            <div class="input-data">
              <div class="text-wrapper-1">Address:</div>
              <div class="text-wrapper-2">7326 NW 79 Terr, Medley, FL 33166</div>
            </div>
            <div class="input-data">
              <div class="text-wrapper-1">Phone Number:</div>
              <div class="text-wrapper-2">305-599-9302</div>
            </div>
          </div>
          <div class="row">
            <div class="input-data">
              <div class="text-wrapper-1">FDA:</div>
              <div class="text-wrapper-2">18708577282</div>
            </div>
            <div class="input-data">
              <div class="text-wrapper-1">EIN:</div>
              <div class="text-wrapper-2">65-1011256</div>
            </div>
          </div>
        </div>

        <hr class="divider" />

        <div class="invoice-document-details">
          <div class="text-wrapper">General Info</div>
          <div class="details">
            <div class="column">
              <div class="input-data">
                <div class="text-wrapper-1">Product/Activity:</div>
                <div class="text-wrapper-2">Fresh Ginger Root by Air Freight</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Quantity:</div>
                <div class="text-wrapper-2">15 pallets x 36 boxes with 13,6kg each</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Net Weight:</div>
                <div class="text-wrapper-2">7.344 kg</div>
              </div>
            </div>
            <div class="column">
              <div class="input-data">
                <div class="text-wrapper-1">Global Gap:</div>
                <div class="text-wrapper-2">4063061860668</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Tracer:</div>
                <div class="text-wrapper-2">2303-A</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Gross Weight:</div>
                <div class="text-wrapper-2">8.367 kg</div>
              </div>
            </div>
          </div>
        </div>

        <hr class="divider" />

        <div class="invoice-document-details">
          <div class="text-wrapper">Commercial Agreement</div>
          <div class="details table">
            <div class="column">
              <div class="input-data">
                <div class="text-wrapper-1">Incoterm:</div>
                <div class="text-wrapper-2">FOB</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Box Price:</div>
                <div class="text-wrapper-2">US$ 32.00/box</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Payment Terms:</div>
                <div class="text-wrapper-2">100% at good arival</div>
              </div>
            </div>
            <div class="table">
              <.table id="items" rows={@items}>
                <:col :let={%{id: _id, name: name}} label="Items">
                  <%= name %>
                </:col>
                <:col :let={%{id: _id, quantity: quantity}} label="Qty">
                  <%= quantity %>
                </:col>
                <:col :let={%{id: _id, rate: rate}} label="Rate">
                  <%= rate %>
                </:col>
                <:col :let={%{id: _id, total: total}} label="Total Amount">
                  <%= total %>
                </:col>
              </.table>
              <div class="total-items">
                <div class="text-wrapper-1">Total</div>
                <div class="text-wrapper-2">US$ 12.096.00</div>
              </div>
              <div class="due-date">
                <div class="text-wrapper-1">Due date (estimated by flight schedule):</div>
                <div class="text-wrapper-2">June 27th</div>
              </div>
            </div>
          </div>
        </div>

        <hr class="divider" />

        <div class="invoice-document-data">
          <div class="text-wrapper">Shipping Info</div>
          <div class="details gap-1">
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">Packing:</div>
                <div class="text-wrapper-2">07/09/2023</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">ETH:</div>
                <div class="text-wrapper-2">07/10/2023 - 23:45 LT</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">ETA:</div>
                <div class="text-wrapper-2">07/10/2023 - 07:20 LT</div>
              </div>
            </div>
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">Flight Info:</div>
                <div class="text-wrapper-2">
                  AZUL LINHAS AÉREAS BRASILEIRAS - Voo AD 8704 VCP x FLL | MAWB 577 1074 6164 | HAWB 1938-000 46894
                </div>
              </div>
            </div>
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">All freight costs are to be paid by the importer.</div>
              </div>
            </div>
          </div>
        </div>

        <hr class="divider" />

        <div class="invoice-document-data">
          <div class="text-wrapper">Banking Info</div>
          <div class="details gap-1 banking-info">
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">Beneficiary:</div>
                <div class="text-wrapper-2">
                  ATIVAR Importação, Exportação & Representação Comercial Eireli
                </div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Iban</div>
                <div class="text-wrapper-2">BR4500000000080170000019631C1</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">CNPJ</div>
                <div class="text-wrapper-2">Banco do Brasil S.A.</div>
              </div>
            </div>
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">Intermediate Bank:</div>
                <div class="text-wrapper-2">Banco do Brasil S.A.</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Swift:</div>
                <div class="text-wrapper-2">BRASUS33</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Branch:</div>
                <div class="text-wrapper-2">New York</div>
              </div>
            </div>
            <div class="row">
              <div class="input-data">
                <div class="text-wrapper-1">Receiver Bank:</div>
                <div class="text-wrapper-2">Banco do Brasil S.A.</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Swift:</div>
                <div class="text-wrapper-2">BRASBRRJBHE</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Branch:</div>
                <div class="text-wrapper-2">Belo Horizonte</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Account:</div>
                <div class="text-wrapper-2">1.963-1</div>
              </div>
              <div class="input-data">
                <div class="text-wrapper-1">Agency:</div>
                <div class="text-wrapper-2">8017</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="invoice-document-footer">
        <p>
          ATIVAR Importação, Exportação & Representação Comercial Eireli    |    CNPJ 24.437.437/0001-55
          Estr. Cap. Pedro Afonso, 570 - Vargem Grande Rio de Janeiro - RJ - Brazil    |    Zip Code: 22783-200
        </p>
      </div>
    </div>
    """
  end
end
