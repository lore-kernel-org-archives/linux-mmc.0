From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/2] mmc: atmel-mci: DMA can be used with other controller
Date: Tue, 28 Aug 2012 15:25:58 +0200
Message-ID: <503CC6E6.1020403@atmel.com>
References: <503A852B.8010902@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <503A852B.8010902@yahoo.es>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Havard Skinnemoen <havard@skinnemoen.net>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, egtvedt@samfundet.no
List-Id: linux-mmc@vger.kernel.org

Hi Hein,

Thanks for your investigation about the MCI issue with AVR chips.

Le 08/26/2012 10:20 PM, Hein Tibosch a =E9crit :
> After the latest changes to atmel-mci, it could not be used with
> DMA on the AVR32 platform. This patch will allow to use DMA again
> and it will avoid access to MCI register ATMCI_DMA.
>

I think you should add more details about the issue:
Even if the IP version is lower than v3xx and doesn't have the DMA
configuration register, DMA transfers can be used with a different
controller than the Atmel AHB DMA one. For instance, some AVR chips use =

the Synopsys DesignWare AHB DMA controller.

> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
>

Some comments below...

> ---
>   drivers/mmc/host/atmel-mci.c |   21 +++++++++------------
>   1 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index f2c115e..66e9fdc 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -71,7 +71,7 @@ enum atmci_pdc_buf {
>   };
>
>   struct atmel_mci_caps {
> -	bool    has_dma;
> +	bool    has_dma_conf_reg;
>   	bool    has_pdc;
>   	bool    has_cfg_reg;
>   	bool    has_cstor_reg;
> @@ -411,7 +411,7 @@ static int atmci_regs_show(struct seq_file *s, void *=
v)
>   	atmci_show_status_reg(s, "SR", buf[ATMCI_SR / 4]);
>   	atmci_show_status_reg(s, "IMR", buf[ATMCI_IMR / 4]);
>
> -	if (host->caps.has_dma) {
> +	if (host->caps.has_dma_conf_reg) {
>   		u32 val;
>
>   		val =3D buf[ATMCI_DMA / 4];
> @@ -767,7 +767,7 @@ static void atmci_dma_complete(void *arg)
>
>   	dev_vdbg(&host->pdev->dev, "DMA complete\n");
>
> -	if (host->caps.has_dma)
> +	if (host->caps.has_dma_conf_reg)
>   		/* Disable DMA hardware handshaking on MCI */
>   		atmci_writel(host, ATMCI_DMA, atmci_readl(host, ATMCI_DMA) & ~ATMCI_D=
MAEN);
>
> @@ -954,7 +954,9 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct=
 mmc_data *data)
>   		maxburst =3D atmci_convert_chksize(host->dma_conf.dst_maxburst);
>   	}
>
> -	atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) | ATMCI_DMAEN=
);
> +	if (host->caps.has_dma_conf_reg)
> +		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) |
> +			ATMCI_DMAEN);
>
>   	sglen =3D dma_map_sg(chan->device->dev, data->sg,
>   			data->sg_len, direction);
> @@ -2202,7 +2204,7 @@ static void __init atmci_get_cap(struct atmel_mci *=
host)
>   	dev_info(&host->pdev->dev,
>   			"version: 0x%x\n", version);
>
> -	host->caps.has_dma =3D 0;
> +	host->caps.has_dma_conf_reg =3D 0;
>   	host->caps.has_pdc =3D 1;
>   	host->caps.has_cfg_reg =3D 0;
>   	host->caps.has_cstor_reg =3D 0;
> @@ -2219,12 +2221,7 @@ static void __init atmci_get_cap(struct atmel_mci =
*host)
>   		host->caps.has_odd_clk_div =3D 1;
>   	case 0x400:
>   	case 0x300:
> -#ifdef CONFIG_AT_HDMAC
> -		host->caps.has_dma =3D 1;
> -#else
> -		dev_info(&host->pdev->dev,
> -			"has dma capability but dma engine is not selected, then use pio\n");
> -#endif
> +		host->caps.has_dma_conf_reg =3D 1;
>   		host->caps.has_pdc =3D 0;
>   		host->caps.has_cfg_reg =3D 1;
>   		host->caps.has_cstor_reg =3D 1;
> @@ -2298,7 +2295,7 @@ static int __init atmci_probe(struct platform_devic=
e *pdev)
>
>   	/* Get MCI capabilities and set operations according to it */
>   	atmci_get_cap(host);
> -	if (host->caps.has_dma && atmci_configure_dma(host)) {
> +	if (atmci_configure_dma(host)) {
>   		host->prepare_data =3D &atmci_prepare_data_dma;
>   		host->submit_data =3D &atmci_submit_data_dma;
>   		host->stop_transfer =3D &atmci_stop_transfer_dma;
>

I have tested this patch on at91sam9m10g45, at91sam9g10 and at91sam9261. =

For chips without MCI support for Atmel AHB DMA, removing the =

host->caps.has_dma test involves to use pdata->dma_slave with more =

caution to avoid some NULL pointer dereferences

@@ -2168,16 +2168,21 @@ static bool atmci_configure_dma(struct atmel_mci =

*host)
                 return false;

         pdata =3D host->pdev->dev.platform_data;
+       if (!pdata)
+               return false;

-       if (pdata && find_slave_dev(pdata->dma_slave)) {
+       if (pdata->dma_slave && find_slave_dev(pdata->dma_slave)) {
                 dma_cap_mask_t mask;


Regards

Ludovic
