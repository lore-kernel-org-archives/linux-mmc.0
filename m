From: <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 1/2] mmc: atmel-mci: Use dma_request_chan() directly for
 channel request
Date: Wed, 13 Nov 2019 13:34:29 +0000
Message-ID: <20191113133417.zrz5zcwuyxjskaes@M43218.corp.atmel.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
 <20191113093616.32474-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113093616.32474-2-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-ID: <14F9A1929CF5AE40891E63ADE53B85E2@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.ujfalusi@ti.com
Cc: ulf.hansson@linaro.org, vkoul@kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 13, 2019 at 11:36:15AM +0200, Peter Ujfalusi wrote:
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> ---
>  drivers/mmc/host/atmel-mci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 34c992d87529..6f065bb5c55a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2347,8 +2347,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slo=
t *slot,
> =20
>  static int atmci_configure_dma(struct atmel_mci *host)
>  {
> -	host->dma.chan =3D dma_request_slave_channel_reason(&host->pdev->dev,
> -							"rxtx");
> +	host->dma.chan =3D dma_request_chan(&host->pdev->dev, "rxtx");
> =20
>  	if (PTR_ERR(host->dma.chan) =3D=3D -ENODEV) {
>  		struct mci_platform_data *pdata =3D host->pdev->dev.platform_data;
> --=20
> Peter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20
>=20
