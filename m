From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 1/3] mmc: Add size for caller in init+register
Date: Wed, 29 May 2013 14:01:54 +0200
Message-ID: <CAPDyKFoPO0KTfW_i1EP8urSUT+U8yEaafrE2HdN2mmEkYCZm-w@mail.gmail.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1369790016-13270-1-git-send-email-csd@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christian Daudt <csd@broadcom.com>
Cc: linux-doc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, matt.porter@linaro.org, Kevin Liu <kliu5@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, csd_b@daudt.org, Viresh Kumar <viresh.kumar@linaro.org>, Chris Ball <cjb@laptop.org>, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Bill Pemberton <wfp5p@virginia.edu>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@arm.linux.org.uk>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atm>
List-Id: linux-mmc@vger.kernel.org

On 29 May 2013 03:13, Christian Daudt <csd@broadcom.com> wrote:
> Add a param to allow users of sdhci_pltfm to allocate private space
> in calls to sdhci_pltfm_init+sdhci_pltfm_register. This is implemented
> in the same way as sdhci does for its users.
>  None of the users have been migrated yet and are passing in zero to
> retain their private allocation.
>
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
>
> Also removed unused variable in sdhci_pltfm_init fn
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>

Hi Christian,

Sorry if being a bit picky, do you mind using "mmc: sdhci" as the
prefix for the heading of this patch?

>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index d49bc95..0584a1c 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -148,7 +148,7 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         int ret;
>
> -       host = sdhci_pltfm_init(pdev, &bcm2835_sdhci_pdata);
> +       host = sdhci_pltfm_init(pdev, &bcm2835_sdhci_pdata, 0);
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
> index 8ebb6b6..f2cc266 100644
> --- a/drivers/mmc/host/sdhci-cns3xxx.c
> +++ b/drivers/mmc/host/sdhci-cns3xxx.c
> @@ -96,7 +96,7 @@ static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
>
>  static int sdhci_cns3xxx_probe(struct platform_device *pdev)
>  {
> -       return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
> +       return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata, 0);
>  }
>
>  static int sdhci_cns3xxx_remove(struct platform_device *pdev)
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index 15e7803..8424839 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -130,7 +130,7 @@ static int sdhci_dove_probe(struct platform_device *pdev)
>                 gpio_direction_input(priv->gpio_cd);
>         }
>
> -       host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata);
> +       host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata, 0);
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
>                 goto err_sdhci_pltfm_init;
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 67d6dde..9a1e6fa 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -470,7 +470,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         int err;
>         struct pltfm_imx_data *imx_data;
>
> -       host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
> +       host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata, 0);
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 5e68adc..37e668f 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -262,7 +262,7 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
> -       return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
> +       return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata, 0);
>  }
>
>  static int sdhci_esdhc_remove(struct platform_device *pdev)
> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
> index 200a6a9..57c514a 100644
> --- a/drivers/mmc/host/sdhci-of-hlwd.c
> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
> @@ -68,7 +68,7 @@ static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
>
>  static int sdhci_hlwd_probe(struct platform_device *pdev)
>  {
> -       return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata);
> +       return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata, 0);
>  }
>
>  static int sdhci_hlwd_remove(struct platform_device *pdev)
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index cd0f1f6..38e38a5 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -115,10 +115,10 @@ void sdhci_get_of_property(struct platform_device *pdev) {}
>  EXPORT_SYMBOL_GPL(sdhci_get_of_property);
>
>  struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
> -                                   const struct sdhci_pltfm_data *pdata)
> +                                   const struct sdhci_pltfm_data *pdata,
> +                                   size_t priv_size)
>  {
>         struct sdhci_host *host;
> -       struct sdhci_pltfm_host *pltfm_host;
>         struct device_node *np = pdev->dev.of_node;
>         struct resource *iomem;
>         int ret;
> @@ -134,17 +134,17 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>
>         /* Some PCI-based MFD need the parent here */
>         if (pdev->dev.parent != &platform_bus && !np)
> -               host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
> +               host = sdhci_alloc_host(pdev->dev.parent,
> +                       sizeof(struct sdhci_pltfm_host) + priv_size);
>         else
> -               host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
> +               host = sdhci_alloc_host(&pdev->dev,
> +                       sizeof(struct sdhci_pltfm_host) + priv_size);
>
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
>                 goto err;
>         }
>
> -       pltfm_host = sdhci_priv(host);
> -
>         host->hw_name = dev_name(&pdev->dev);
>         if (pdata && pdata->ops)
>                 host->ops = pdata->ops;
> @@ -202,12 +202,13 @@ void sdhci_pltfm_free(struct platform_device *pdev)
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
>
>  int sdhci_pltfm_register(struct platform_device *pdev,
> -                        const struct sdhci_pltfm_data *pdata)
> +                       const struct sdhci_pltfm_data *pdata,
> +                       size_t priv_size)
>  {
>         struct sdhci_host *host;
>         int ret = 0;
>
> -       host = sdhci_pltfm_init(pdev, pdata);
> +       host = sdhci_pltfm_init(pdev, pdata, priv_size);
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 1210ed1..ed4a85d 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -27,6 +27,8 @@ struct sdhci_pltfm_host {
>         /* migrate from sdhci_of_host */
>         unsigned int clock;
>         u16 xfer_mode_shadow;
> +
> +       unsigned long private[0] ____cacheline_aligned;

Why do you need this to be "____cacheline_aligned"?

>  };
>
>  #ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> @@ -91,15 +93,22 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
>  extern void sdhci_get_of_property(struct platform_device *pdev);
>
>  extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
> -                                         const struct sdhci_pltfm_data *pdata);
> +                                         const struct sdhci_pltfm_data *pdata,
> +                                         size_t priv_size);
>  extern void sdhci_pltfm_free(struct platform_device *pdev);
>
>  extern int sdhci_pltfm_register(struct platform_device *pdev,
> -                               const struct sdhci_pltfm_data *pdata);
> +                               const struct sdhci_pltfm_data *pdata,
> +                               size_t priv_size);
>  extern int sdhci_pltfm_unregister(struct platform_device *pdev);
>
>  extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
>
> +static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
> +{
> +       return (void *)host->private;
> +}
> +
>  #ifdef CONFIG_PM
>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
>  #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 6a3f702..1cf093f 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -175,7 +175,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>         if (!pxa)
>                 return -ENOMEM;
>
> -       host = sdhci_pltfm_init(pdev, NULL);
> +       host = sdhci_pltfm_init(pdev, NULL, 0);
>         if (IS_ERR(host)) {
>                 kfree(pxa);
>                 return PTR_ERR(host);
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 1ae358e..9124104 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -230,7 +230,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         if (!pxa)
>                 return -ENOMEM;
>
> -       host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata);
> +       host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, 0);
>         if (IS_ERR(host)) {
>                 kfree(pxa);
>                 return PTR_ERR(host);
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e0dba74..c8b0582 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -231,7 +231,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         soc_data = match->data;
>
> -       host = sdhci_pltfm_init(pdev, soc_data->pdata);
> +       host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>         pltfm_host = sdhci_priv(host);
> --
> 1.7.10.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Kind regards
Ulf Hansson
