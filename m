From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Wed, 25 Mar 2015 09:51:17 +0100
Message-ID: <CAPDyKFoF+xwX4F7ZXeA6fyL3Gbi93Ag6E9dfjzEdH-GsDTSspg@mail.gmail.com>
References: <1427129249-3259-1-git-send-email-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1427129249-3259-1-git-send-email-georgi.djakov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 March 2015 at 17:47, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Some versions of this controller do not advertise their 3.0v and
> 8bit bus-width support capabilities. It is required to explicitly
> set these capabilities for the specific controller versions.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks! Applied.

Kind regards
Uffe

> ---
>
> Changes since v2:
>  * Use the generic sdhci bitfield defines, as the bits are matching.
>    Thanks Bjorn for noticing this.
>
> Changes since v1:
>  * Converted to separate read, modify, write statements.
>  * Slightly updated comment text.
>
>  Tested on msm8916-mtp board.
>
>  drivers/mmc/host/sdhci-msm.c |   29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3d32ce896b09..4a09f7608c66 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -22,6 +22,11 @@
>
>  #include "sdhci-pltfm.h"
>
> +#define CORE_MCI_VERSION               0x50
> +#define CORE_VERSION_MAJOR_SHIFT       28
> +#define CORE_VERSION_MAJOR_MASK                (0xf << CORE_VERSION_MAJOR_SHIFT)
> +#define CORE_VERSION_MINOR_MASK                0xff
> +
>  #define CORE_HC_MODE           0x78
>  #define HC_MODE_EN             0x1
>  #define CORE_POWER             0x0
> @@ -41,6 +46,8 @@
>  #define CORE_VENDOR_SPEC       0x10c
>  #define CORE_CLK_PWRSAVE       BIT(1)
>
> +#define CORE_VENDOR_SPEC_CAPABILITIES0 0x11c
> +
>  #define CDR_SELEXT_SHIFT       20
>  #define CDR_SELEXT_MASK                (0xf << CDR_SELEXT_SHIFT)
>  #define CMUX_SHIFT_PHASE_SHIFT 24
> @@ -426,7 +433,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         struct sdhci_msm_host *msm_host;
>         struct resource *core_memres;
>         int ret;
> -       u16 host_version;
> +       u16 host_version, core_minor;
> +       u32 core_version, caps;
> +       u8 core_major;
>
>         msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
>         if (!msm_host)
> @@ -516,6 +525,24 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
>                                SDHCI_VENDOR_VER_SHIFT));
>
> +       core_version = readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION);
> +       core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
> +                     CORE_VERSION_MAJOR_SHIFT;
> +       core_minor = core_version & CORE_VERSION_MINOR_MASK;
> +       dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
> +               core_version, core_major, core_minor);
> +
> +       /*
> +        * Support for some capabilities is not advertised by newer
> +        * controller versions and must be explicitly enabled.
> +        */
> +       if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
> +               caps = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
> +               caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> +               writel_relaxed(caps, host->ioaddr +
> +                              CORE_VENDOR_SPEC_CAPABILITIES0);
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto clk_disable;
