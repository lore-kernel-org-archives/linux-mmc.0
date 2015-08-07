From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface support
Date: Fri, 7 Aug 2015 23:32:05 +0200
Message-ID: <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
	<1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438843491-23853-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Govindraj Raja <govindraj.raja-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 6 August 2015 at 08:44, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> @@ -2256,26 +2373,30 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>         }
>
> -#ifdef CONFIG_MMC_DW_IDMAC
> -       /* Handle DMA interrupts */
> -       if (host->dma_64bit_address == 1) {
> -               pending = mci_readl(host, IDSTS64);
> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
> -                                                       SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete(host);
> -               }
> -       } else {
> -               pending = mci_readl(host, IDSTS);
> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
> -                                                       SDMMC_IDMAC_INT_RI);
> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete(host);
> +       if (host->use_dma == TRANS_MODE_IDMAC) {

Doing:
if (host->use_dma != TRANS_MODE_IDMAC)
    return IRQ_HANDLED;

Could save you the extra level of identation you add below.

> +               /* Handle DMA interrupts */
> +               if (host->dma_64bit_address == 1) {
> +                       pending = mci_readl(host, IDSTS64);
> +                       if (pending & (SDMMC_IDMAC_INT_TI |
> +                                      SDMMC_IDMAC_INT_RI)) {
> +                               mci_writel(host, IDSTS64,
> +                                          SDMMC_IDMAC_INT_TI |
> +                                          SDMMC_IDMAC_INT_RI);
> +                               mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> +                               host->dma_ops->complete((void *)host);
> +                       }
> +               } else {
> +                       pending = mci_readl(host, IDSTS);
> +                       if (pending & (SDMMC_IDMAC_INT_TI |
> +                                      SDMMC_IDMAC_INT_RI)) {
> +                               mci_writel(host, IDSTS,
> +                                          SDMMC_IDMAC_INT_TI |
> +                                          SDMMC_IDMAC_INT_RI);
> +                               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> +                               host->dma_ops->complete((void *)host);
> +                       }
>                 }
>         }
> -#endif
>
>         return IRQ_HANDLED;
>  }


> @@ -2437,6 +2567,21 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>  static void dw_mci_init_dma(struct dw_mci *host)
>  {
>         int addr_config;
> +       int trans_mode;
> +       struct device *dev = host->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       /* Check tansfer mode */
> +       trans_mode = (mci_readl(host, HCON) >> 16) & 0x3;

I think it would be nice if you could add some defines for 16 and 0x03
or add a macro like SDMMC_GET_FCNT() that is in dw_mmc.h.

> +       if (trans_mode == 0) {
> +               trans_mode = TRANS_MODE_IDMAC;
> +       } else if (trans_mode == 1 || trans_mode == 2) {
> +               trans_mode = TRANS_MODE_EDMAC;
> +       } else {
> +               trans_mode = TRANS_MODE_PIO;
> +               goto no_dma;
> +       }
> +
>         /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>         addr_config = (mci_readl(host, HCON) >> 27) & 0x01;

I'll try to get this patch tested on my lpc18xx platform soon.
btw, the HCON reg on lpc18xx reads as 0x00e42cc1 (address 0x40004070).


regard,
Joachim Eastwood
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
