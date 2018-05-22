From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V1 3/3] mmc: host: Register changes for sdcc V5
Date: Tue, 22 May 2018 11:12:34 -0700
Message-ID: <CAE=gft4DOJTuZDQDX1PL0fXHKPBsgWRPsO1bgunfO0VZ+pa6zQ@mail.gmail.com>
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org> <1526552938-21292-4-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526552938-21292-4-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vviswana@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org, vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Vijay. Thanks for this patch.

On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org>
wrote:

> From: Sayali Lokhande <sayalil@codeaurora.org>

> For SDCC version 5.0.0 and higher, new compatible string
> "qcom,sdhci-msm-v5" is added.

> Based on the msm variant, pick the relevant variant data and
> use it for register read/write to msm specific registers.

> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>   .../devicetree/bindings/mmc/sdhci-msm.txt          |   5 +-
>   drivers/mmc/host/sdhci-msm.c                       | 344
+++++++++++++--------
>   2 files changed, 222 insertions(+), 127 deletions(-)

> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index bfdcdc4..c2b7b2b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -4,7 +4,10 @@ This file documents differences between the core
properties in mmc.txt
>   and the properties used by the sdhci-msm driver.

>   Required properties:
> -- compatible: Should contain "qcom,sdhci-msm-v4".
> +- compatible: Should contain "qcom,sdhci-msm-v4" or "qcom,sdhci-msm-v5".
> +                For SDCC version 5.0.0, MCI registers are removed from
SDCC
> +                interface and some registers are moved to HC. New
compatible
> +                string is added to support this change -
"qcom,sdhci-msm-v5".
>   - reg: Base address and length of the register in the following order:
>          - Host controller register map (required)
>          - SD Core register map (required)
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index bb2bb59..408e6b2 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -33,16 +33,11 @@
>   #define CORE_MCI_GENERICS              0x70
>   #define SWITCHABLE_SIGNALING_VOLTAGE   BIT(29)

> -#define CORE_HC_MODE           0x78

Remove CORE_MCI_VERSION as well.

>   #define HC_MODE_EN             0x1
>   #define CORE_POWER             0x0
>   #define CORE_SW_RST            BIT(7)
>   #define FF_CLK_SW_RST_DIS      BIT(13)

> -#define CORE_PWRCTL_STATUS     0xdc
> -#define CORE_PWRCTL_MASK       0xe0
> -#define CORE_PWRCTL_CLEAR      0xe4
> -#define CORE_PWRCTL_CTL                0xe8
>   #define CORE_PWRCTL_BUS_OFF    BIT(0)
>   #define CORE_PWRCTL_BUS_ON     BIT(1)
>   #define CORE_PWRCTL_IO_LOW     BIT(2)
> @@ -63,17 +58,13 @@
>   #define CORE_CDR_EXT_EN                BIT(19)
>   #define CORE_DLL_PDN           BIT(29)
>   #define CORE_DLL_RST           BIT(30)
> -#define CORE_DLL_CONFIG                0x100
>   #define CORE_CMD_DAT_TRACK_SEL BIT(0)
> -#define CORE_DLL_STATUS                0x108

> -#define CORE_DLL_CONFIG_2      0x1b4
>   #define CORE_DDR_CAL_EN                BIT(0)
>   #define CORE_FLL_CYCLE_CNT     BIT(18)
>   #define CORE_DLL_CLOCK_DISABLE BIT(21)

> -#define CORE_VENDOR_SPEC       0x10c
> -#define CORE_VENDOR_SPEC_POR_VAL       0xa1c
> +#define CORE_VENDOR_SPEC_POR_VAL 0xa1c
>   #define CORE_CLK_PWRSAVE       BIT(1)
>   #define CORE_HC_MCLK_SEL_DFLT  (2 << 8)
>   #define CORE_HC_MCLK_SEL_HS400 (3 << 8)
> @@ -111,17 +102,14 @@
>   #define CORE_CDC_SWITCH_BYPASS_OFF     BIT(0)
>   #define CORE_CDC_SWITCH_RC_EN          BIT(1)

> -#define CORE_DDR_200_CFG               0x184
>   #define CORE_CDC_T4_DLY_SEL            BIT(0)
>   #define CORE_CMDIN_RCLK_EN             BIT(1)
>   #define CORE_START_CDC_TRAFFIC         BIT(6)
> -#define CORE_VENDOR_SPEC3      0x1b0
> +
>   #define CORE_PWRSAVE_DLL       BIT(3)

> -#define CORE_DDR_CONFIG                0x1b8
>   #define DDR_CONFIG_POR_VAL     0x80040853

> -#define CORE_VENDOR_SPEC_CAPABILITIES0 0x11c

>   #define INVALID_TUNING_PHASE   -1
>   #define SDHCI_MSM_MIN_CLOCK    400000
> @@ -380,10 +368,14 @@ static inline int msm_dll_poll_ck_out_en(struct
sdhci_host *host, u8 poll)
>          u32 wait_cnt = 50;
>          u8 ck_out_en;
>          struct mmc_host *mmc = host->mmc;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_msm_offset *msm_offset =
> +                                       msm_host->offset;

I notice this pattern is pasted all over the place in order to get to the
offsets. Maybe a macro or inlined function would be cleaner to get you to
directly to the sdhci_msm_offset struct from sdhci_host, rather than this
blob of paste soup everywhere. In some places you do seem to use the
intermediate locals, so those cases wouldn't need to use the new helper.


>          /* Poll for CK_OUT_EN bit.  max. poll time = 50us */
> -       ck_out_en = !!(readl_relaxed(host->ioaddr + CORE_DLL_CONFIG) &
> -                       CORE_CK_OUT_EN);
> +       ck_out_en = !!(readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config) & CORE_CK_OUT_EN);

>          while (ck_out_en != poll) {
>                  if (--wait_cnt == 0) {
> @@ -393,8 +385,8 @@ static inline int msm_dll_poll_ck_out_en(struct
sdhci_host *host, u8 poll)
>                  }
>                  udelay(1);

> -               ck_out_en = !!(readl_relaxed(host->ioaddr +
CORE_DLL_CONFIG) &
> -                               CORE_CK_OUT_EN);
> +               ck_out_en = !!(readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config) & CORE_CK_OUT_EN);
>          }

>          return 0;
> @@ -410,16 +402,20 @@ static int msm_config_cm_dll_phase(struct
sdhci_host *host, u8 phase)
>          unsigned long flags;
>          u32 config;
>          struct mmc_host *mmc = host->mmc;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_msm_offset *msm_offset =
> +                                       msm_host->offset;

>          if (phase > 0xf)
>                  return -EINVAL;

>          spin_lock_irqsave(&host->lock, flags);

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_dll_config);
>          config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
>          config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_dll_config);

>          /* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '0' */
>          rc = msm_dll_poll_ck_out_en(host, 0);
> @@ -430,24 +426,24 @@ static int msm_config_cm_dll_phase(struct
sdhci_host *host, u8 phase)
>           * Write the selected DLL clock output phase (0 ... 15)
>           * to CDR_SELEXT bit field of DLL_CONFIG register.
>           */
> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_dll_config);
>          config &= ~CDR_SELEXT_MASK;
>          config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_dll_config);

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_dll_config);
>          config |= CORE_CK_OUT_EN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_dll_config);

>          /* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
>          rc = msm_dll_poll_ck_out_en(host, 1);
>          if (rc)
>                  goto err_out;

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_dll_config);
>          config |= CORE_CDR_EN;
>          config &= ~CORE_CDR_EXT_EN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_dll_config);

Nit: host->ioaddr + msm_offset->core_dll_config might benefit from having
its own local, since you use it so much in this function. Same goes for
where I've noted below...

>          goto out;

>   err_out:
> @@ -573,6 +569,10 @@ static int msm_find_most_appropriate_phase(struct
sdhci_host *host,
>   static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
>   {
>          u32 mclk_freq = 0, config;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_msm_offset *msm_offset =
> +                                       msm_host->offset;

>          /* Program the MCLK value to MCLK_FREQ bit field */
>          if (host->clock <= 112000000)
> @@ -592,10 +592,10 @@ static inline void msm_cm_dll_set_freq(struct
sdhci_host *host)
>          else if (host->clock <= 200000000)
>                  mclk_freq = 7;

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_dll_config);
>          config &= ~CMUX_SHIFT_PHASE_MASK;
>          config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_dll_config);
>   }

>   /* Initialize the DLL (Programmable Delay Line) */
> @@ -607,6 +607,8 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>          int wait_cnt = 50;
>          unsigned long flags;
>          u32 config;
> +       const struct sdhci_msm_offset *msm_offset =
> +                                       msm_host->offset;

>          spin_lock_irqsave(&host->lock, flags);

> @@ -615,34 +617,43 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>           * tuning is in progress. Keeping PWRSAVE ON may
>           * turn off the clock.
>           */
> -       config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +       config = readl_relaxed(host->ioaddr +
msm_offset->core_vendor_spec);
>          config &= ~CORE_CLK_PWRSAVE;
> -       writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +       writel_relaxed(config, host->ioaddr +
msm_offset->core_vendor_spec);

>          if (msm_host->use_14lpp_dll_reset) {
> -               config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_dll_config);
>                  config &= ~CORE_CK_OUT_EN;
> -               writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +               writel_relaxed(config, host->ioaddr +
> +                               msm_offset->core_dll_config);

> -               config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>                  config |= CORE_DLL_CLOCK_DISABLE;
> -               writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> +               writel_relaxed(config, host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>          }

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config |= CORE_DLL_RST;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config |= CORE_DLL_PDN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);
>          msm_cm_dll_set_freq(host);

>          if (msm_host->use_14lpp_dll_reset &&
>              !IS_ERR_OR_NULL(msm_host->xo_clk)) {
>                  u32 mclk_freq = 0;

> -               config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>                  config &= CORE_FLL_CYCLE_CNT;
>                  if (config)
>                          mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock *
8),
> @@ -651,40 +662,52 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>                          mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock *
4),
>                                          clk_get_rate(msm_host->xo_clk));

> -               config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>                  config &= ~(0xFF << 10);
>                  config |= mclk_freq << 10;

> -               writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> +               writel_relaxed(config, host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>                  /* wait for 5us before enabling DLL clock */
>                  udelay(5);
>          }

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config &= ~CORE_DLL_RST;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config &= ~CORE_DLL_PDN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);

>          if (msm_host->use_14lpp_dll_reset) {
>                  msm_cm_dll_set_freq(host);
> -               config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>                  config &= ~CORE_DLL_CLOCK_DISABLE;
> -               writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> +               writel_relaxed(config, host->ioaddr +
> +                               msm_offset->core_dll_config_2);
>          }

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config |= CORE_DLL_EN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);

> -       config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +       config = readl_relaxed(host->ioaddr +
> +                       msm_offset->core_dll_config);
>          config |= CORE_CK_OUT_EN;
> -       writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +       writel_relaxed(config, host->ioaddr +
> +                       msm_offset->core_dll_config);


...here. A local for host->ioaddr + msm_offset->core_dll_config would save
you a lot of split lines.

> @@ -1272,12 +1327,17 @@ static void sdhci_msm_dump_pwr_ctrl_regs(struct
sdhci_host *host)
>   {
>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>          struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_msm_offset *msm_offset =
> +                                       msm_host->offset;

>          pr_err("%s: PWRCTL_STATUS: 0x%08x | PWRCTL_MASK: 0x%08x |
PWRCTL_CTL: 0x%08x\n",
> -                       mmc_hostname(host->mmc),
> -                       readl_relaxed(msm_host->core_mem +
CORE_PWRCTL_STATUS),
> -                       readl_relaxed(msm_host->core_mem +
CORE_PWRCTL_MASK),
> -                       readl_relaxed(msm_host->core_mem +
CORE_PWRCTL_CTL));
> +               mmc_hostname(host->mmc),
> +                msm_host->var_ops->msm_readl_relaxed(host,

There's a weird extra space here.

> +                       msm_offset->core_pwrctl_status),
> +               msm_host->var_ops->msm_readl_relaxed(host,
> +                       msm_offset->core_pwrctl_mask),
> +               msm_host->var_ops->msm_readl_relaxed(host,
> +                       msm_offset->core_pwrctl_ctl));

I think the idea of function pointers is fine, but overall the use of them
everywhere sure is ugly. It makes it really hard to actually see what's
happening. I wonder if things might look a lot cleaner with a helper
function here. Then instead of:

msm_host->var_ops->msm_readl_relaxed(host, msm_offset->core_pwrctl_ctl);

You could have

msm_core_read(host, msm_offset->core_pwrctl_ctl);

> @@ -1553,7 +1619,8 @@ static void sdhci_msm_set_regulator_caps(struct
sdhci_msm_host *msm_host)
>                   */
>                  u32 io_level = msm_host->curr_io_level;

> -               config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +               config =  readl_relaxed(host->ioaddr +
> +                               msm_offset->core_vendor_spec);

Remove the second space before the readl_relaxed.

> @@ -1710,32 +1793,40 @@ static int sdhci_msm_probe(struct platform_device
*pdev)
>                  dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
>          }

> -       core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
core_memres);
> +       if (!msm_host->mci_removed) {
> +               core_memres = platform_get_resource(pdev, IORESOURCE_MEM,
1);
> +               msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
> +                               core_memres);

> -       if (IS_ERR(msm_host->core_mem)) {
> -               dev_err(&pdev->dev, "Failed to remap registers\n");
> -               ret = PTR_ERR(msm_host->core_mem);
> -               goto clk_disable;
> +               if (IS_ERR(msm_host->core_mem)) {
> +                       dev_err(&pdev->dev, "Failed to remap
registers\n");
> +                       ret = PTR_ERR(msm_host->core_mem);
> +                       goto clk_disable;
> +               }
>          }

>          /* Reset the vendor spec register to power on reset state */
>          writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
> -                      host->ioaddr + CORE_VENDOR_SPEC);
> -
> -       /* Set HC_MODE_EN bit in HC_MODE register */
> -       writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
> -
> -       config = readl_relaxed(msm_host->core_mem + CORE_HC_MODE);
> -       config |= FF_CLK_SW_RST_DIS;
> -       writel_relaxed(config, msm_host->core_mem + CORE_HC_MODE);
> +                       host->ioaddr + msm_offset->core_vendor_spec);
> +
> +       if (!msm_host->mci_removed) {
> +               /* Set HC_MODE_EN bit in HC_MODE register */
> +               msm_host->var_ops->msm_writel_relaxed(HC_MODE_EN, host,
> +                               msm_offset->core_hc_mode);
> +               config = msm_host->var_ops->msm_readl_relaxed(host,
> +                               msm_offset->core_hc_mode);
> +               config |= FF_CLK_SW_RST_DIS;
> +               msm_host->var_ops->msm_writel_relaxed(config, host,
> +                               msm_offset->core_hc_mode);
> +       }

>          host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
>          dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
>                  host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
>                                 SDHCI_VENDOR_VER_SHIFT));

> -       core_version = readl_relaxed(msm_host->core_mem +
CORE_MCI_VERSION);
> +       core_version =  msm_host->var_ops->msm_readl_relaxed(host,
> +               msm_offset->core_mci_version);

Another double space after the =. Perhaps this was a find/replace error?
Look out for more of these that I missed.

-Evan
