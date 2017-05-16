From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] drivers/mmc/host: hi3660: add sd support
Date: Tue, 16 May 2017 13:35:01 +0200
Message-ID: <CAPDyKFqwNdjcPhfifgCA=JbgncO-+Y4uJwTkASszCmp25rna0w@mail.gmail.com>
References: <20170516112026.48313-1-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34891 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdEPLfD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 07:35:03 -0400
Received: by mail-qk0-f175.google.com with SMTP id a72so125115759qkj.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2017 04:35:03 -0700 (PDT)
In-Reply-To: <20170516112026.48313-1-liwei213@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: liwei <liwei213@huawei.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>

On 16 May 2017 at 13:20, liwei <liwei213@huawei.com> wrote:
> Add sd card support for hi3660 soc
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 311 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 311 insertions(+)

Jaehoon Chung maintains the dw_mmc driver(s). Please re-send this to
include him and perhaps also some other relevant dw_mmc people. Then
take the opportunity to change the prefix of the commit msg header
into "mmc: dw_mmc-k3".

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index e38fb0020bb1..59d6e0870fb1 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -8,6 +8,7 @@
>   * (at your option) any later version.
>   */
>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mmc/host.h>
> @@ -28,7 +29,44 @@
>  #define AO_SCTRL_SEL18         BIT(10)
>  #define AO_SCTRL_CTRL3         0x40C
>
> +#define DWMMC_SD_ID   1
> +#define DWMMC_SDIO_ID 2
> +
> +#define SOC_SCTRL_SCPERCTRL5    (0x314)
> +#define SDCARD_IO_SEL18         BIT(2)
> +
> +#define GENCLK_DIV (7)
> +
> +#define GPIO_CLK_ENABLE                 BIT(16)
> +#define GPIO_CLK_DIV(x)                 (((x) & 0xf) << 8)
> +#define GPIO_USE_SAMPLE_DLY(x)          (((x) & 0x1) << 13)
> +#define UHS_REG_EXT_SAMPLE_PHASE(x)     (((x) & 0x1f) << 16)
> +#define UHS_REG_EXT_SAMPLE_DLY(x)       (((x) & 0x1f) << 26)
> +#define UHS_REG_EXT_SAMPLE_DRVPHASE(x)  (((x) & 0x1f) << 21)
> +#define SDMMC_UHS_REG_EXT_VALUE(x, y, z) (UHS_REG_EXT_SAMPLE_PHASE(x) |\
> +                                         UHS_REG_EXT_SAMPLE_DLY(y) |\
> +                                         UHS_REG_EXT_SAMPLE_DRVPHASE(z))
> +#define SDMMC_GPIO_VALUE(x, y) (GPIO_CLK_DIV(x) | GPIO_USE_SAMPLE_DLY(y))
> +
> +#define SDMMC_UHS_REG_EXT      0x108
> +#define SDMMC_ENABLE_SHIFT     0x110
> +
> +#define TIMING_MODE     3
> +#define TIMING_CFG_NUM 10
> +
> +#define PULL_DOWN BIT(1)
> +#define PULL_UP   BIT(0)
> +
> +#define NUM_PHASES (40)
> +
> +#define ENABLE_SHIFT_MIN_SMPL (4)
> +#define ENABLE_SHIFT_MAX_SMPL (12)
> +#define USE_DLY_MIN_SMPL (11)
> +#define USE_DLY_MAX_SMPL (14)
> +
>  struct k3_priv {
> +       u8 ctrl_id;
> +       u32 cur_speed;
>         struct regmap   *reg;
>  };
>
> @@ -38,6 +76,41 @@ static unsigned long dw_mci_hi6220_caps[] = {
>         0
>  };
>
> +struct hs_timing {
> +       int drv_phase;
> +       int sam_dly;
> +       int sam_phase_max;
> +       int sam_phase_min;
> +};
> +
> +struct hs_timing hs_timing_cfg[TIMING_MODE][TIMING_CFG_NUM] = {
> +       { /* reserved */ },
> +       { /* SD */
> +               {7, 0, 15, 15,},  /* 0: LEGACY 400k */
> +               {6, 0,  4,  4,},  /* 1: MMC_HS */
> +               {6, 0,  3,  3,},  /* 2: SD_HS */
> +               {6, 0, 15, 15,},  /* 3: SDR12 */
> +               {6, 0,  2,  2,},  /* 4: SDR25 */
> +               {4, 0, 11,  0,},  /* 5: SDR50 */
> +               {6, 4, 15,  0,},  /* 6: SDR104 */
> +               {0},              /* 7: DDR50 */
> +               {0},              /* 8: DDR52 */
> +               {0},              /* 9: HS200 */
> +       },
> +       { /* SDIO */
> +               {7, 0, 15, 15,},  /* 0: LEGACY 400k */
> +               {0},              /* 1: MMC_HS */
> +               {6, 0, 15, 15,},  /* 2: SD_HS */
> +               {6, 0, 15, 15,},  /* 3: SDR12 */
> +               {6, 0,  0,  0,},  /* 4: SDR25 */
> +               {4, 0, 12,  0,},  /* 5: SDR50 */
> +               {5, 4, 15,  0,},  /* 6: SDR104 */
> +               {0},              /* 7: DDR50 */
> +               {0},              /* 8: DDR52 */
> +               {0},              /* 9: HS200 */
> +       }
> +};
> +
>  static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         int ret;
> @@ -66,6 +139,10 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
>         if (IS_ERR(priv->reg))
>                 priv->reg = NULL;
>
> +       priv->ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> +       if (priv->ctrl_id < 0)
> +               priv->ctrl_id = 0;
> +
>         host->priv = priv;
>         return 0;
>  }
> @@ -144,7 +221,236 @@ static const struct dw_mci_drv_data hi6220_data = {
>         .execute_tuning         = dw_mci_hi6220_execute_tuning,
>  };
>
> +static void dw_mci_hs_set_timing(struct dw_mci *host, int timing, int sam_phase)
> +{
> +       int drv_phase;
> +       int sam_dly;
> +       int ctrl_id;
> +       int use_sam_dly = 0;
> +       int enable_shift = 0;
> +       int reg_value;
> +       struct k3_priv *priv;
> +
> +       priv = host->priv;
> +       ctrl_id = priv->ctrl_id;
> +
> +       drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
> +       sam_dly   = hs_timing_cfg[ctrl_id][timing].sam_dly;
> +       if (sam_phase == -1)
> +               sam_phase = (hs_timing_cfg[ctrl_id][timing].sam_phase_max +
> +                            hs_timing_cfg[ctrl_id][timing].sam_phase_min) / 2;
> +
> +       if (timing == MMC_TIMING_UHS_SDR50 ||
> +           timing == MMC_TIMING_UHS_SDR104) {
> +               if (sam_phase >= ENABLE_SHIFT_MIN_SMPL &&
> +                   sam_phase <= ENABLE_SHIFT_MAX_SMPL)
> +                       enable_shift = 1;
> +       }
> +       if (timing == MMC_TIMING_UHS_SDR104) {
> +               if (sam_phase >= USE_DLY_MIN_SMPL &&
> +                   sam_phase <= USE_DLY_MAX_SMPL)
> +                       use_sam_dly = 1;
> +       }
> +
> +       mci_writel(host, GPIO, 0x0);
> +       udelay(5);
> +
> +       reg_value = SDMMC_UHS_REG_EXT_VALUE(sam_phase, sam_dly, drv_phase);
> +       mci_writel(host, UHS_REG_EXT, reg_value);
> +
> +       mci_writel(host, ENABLE_SHIFT, enable_shift);
> +
> +       reg_value = SDMMC_GPIO_VALUE(GENCLK_DIV, use_sam_dly);
> +       mci_writel(host, GPIO, (unsigned int)reg_value | GPIO_CLK_ENABLE);
> +
> +       /* We should delay 1ms wait for timing setting finished. */
> +       mdelay(1);
> +}
> +
> +int dw_mci_hi3660_init(struct dw_mci *host)
> +{
> +       /* set threshold to 512 bytes */
> +       mci_writel(host, CDTHRCTL, 0x02000001);
> +
> +       dw_mci_hs_set_timing(host, MMC_TIMING_LEGACY, -1);
> +       host->bus_hz /= (GENCLK_DIV + 1);
> +
> +       return 0;
> +}
> +
> +static int dw_mci_set_sel18(struct dw_mci *host, bool set)
> +{
> +       int ret;
> +       unsigned int val;
> +       struct k3_priv *priv;
> +
> +       priv = host->priv;
> +
> +       val = set ? SDCARD_IO_SEL18 : 0;
> +       ret = regmap_update_bits(priv->reg, SOC_SCTRL_SCPERCTRL5,
> +                                SDCARD_IO_SEL18, val);
> +       if (ret) {
> +               dev_err(host->dev, "sel18 %u error\n", val);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +void dw_mci_hi3660_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +       int ret;
> +       unsigned long wanted;
> +       unsigned long actual;
> +       struct k3_priv *priv = host->priv;
> +
> +       if (!ios->clock || ios->clock == priv->cur_speed)
> +               return;
> +
> +       wanted = ios->clock * (GENCLK_DIV + 1);
> +       ret = clk_set_rate(host->ciu_clk, wanted);
> +       if (ret) {
> +               dev_err(host->dev, "failed to set rate %luHz\n", wanted);
> +               return;
> +       }
> +       actual = clk_get_rate(host->ciu_clk);
> +
> +       dw_mci_hs_set_timing(host, ios->timing, -1);
> +       host->bus_hz = actual / (GENCLK_DIV + 1);
> +       host->current_speed = 0;
> +       priv->cur_speed = host->bus_hz;
> +}
> +
> +static int dw_mci_get_best_clksmpl(unsigned int sample_flag)
> +{
> +       int i;
> +       int interval;
> +       unsigned int v;
> +       unsigned int len;
> +       unsigned int range_start = 0;
> +       unsigned int range_length = 0;
> +       unsigned int middle_range = 0;
> +
> +       if (!sample_flag)
> +               return -EIO;
> +
> +       if (~sample_flag == 0)
> +               return 0;
> +
> +       i = ffs(sample_flag) - 1;
> +
> +       while (i < 32) {
> +               v = ror32(sample_flag, i);
> +               len = ffs(~v) - 1;
> +
> +               if (len > range_length) {
> +                       range_length = len;
> +                       range_start = i;
> +               }
> +
> +               interval = ffs(v >> len) - 1;
> +               if (interval < 0)
> +                       break;
> +
> +               i += len + interval;
> +       }
> +
> +       middle_range = range_start + range_length / 2;
> +       if (middle_range >= 32)
> +               middle_range %= 32;
> +
> +       return middle_range;
> +}
> +
> +static int dw_mci_hi3660_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
> +{
> +       int i = 0;
> +       struct dw_mci *host = slot->host;
> +       struct mmc_host *mmc = slot->mmc;
> +       int sam_phase = 0;
> +       u32 tuning_sample_flag = 0;
> +       int best_clksmpl = 0;
> +
> +       for (i = 0; i < NUM_PHASES; ++i, ++sam_phase) {
> +               sam_phase %= 32;
> +
> +               mci_writel(host, TMOUT, ~0);
> +               dw_mci_hs_set_timing(host, mmc->ios.timing, sam_phase);
> +
> +               if (!mmc_send_tuning(mmc, opcode, NULL))
> +                       tuning_sample_flag |= (1 << sam_phase);
> +               else
> +                       tuning_sample_flag &= ~(1 << sam_phase);
> +       }
> +
> +       best_clksmpl = dw_mci_get_best_clksmpl(tuning_sample_flag);
> +       if (best_clksmpl < 0) {
> +               dev_err(host->dev, "All phases bad!\n");
> +               return -EIO;
> +       }
> +
> +       dw_mci_hs_set_timing(host, mmc->ios.timing, best_clksmpl);
> +
> +       dev_info(host->dev, "tuning ok best_clksmpl %u tuning_sample_flag %x\n",
> +                best_clksmpl, tuning_sample_flag);
> +       return 0;
> +}
> +
> +static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
> +                                       struct mmc_ios *ios)
> +{
> +       int ret;
> +       int min_uv = 0;
> +       int max_uv = 0;
> +       struct dw_mci_slot *slot = mmc_priv(mmc);
> +       struct k3_priv *priv;
> +       struct dw_mci *host;
> +
> +       host = slot->host;
> +       priv = host->priv;
> +
> +       if (!priv || !priv->reg)
> +               return 0;
> +
> +       if (priv->ctrl_id == DWMMC_SDIO_ID)
> +               return 0;
> +
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +               ret = dw_mci_set_sel18(host, 0);
> +               if (ret)
> +                       return ret;
> +               min_uv = 2950000;
> +               max_uv = 2950000;
> +       } else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               ret = dw_mci_set_sel18(host, 1);
> +               if (ret)
> +                       return ret;
> +               min_uv = 1800000;
> +               max_uv = 1800000;
> +       }
> +
> +       if (IS_ERR_OR_NULL(mmc->supply.vqmmc))
> +               return 0;
> +
> +       ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> +       if (ret) {
> +               dev_dbg(host->dev, "Regulator set error %d: %d - %d\n",
> +                       ret, min_uv, max_uv);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static const struct dw_mci_drv_data hi3660_data = {
> +       .init = dw_mci_hi3660_init,
> +       .set_ios = dw_mci_hi3660_set_ios,
> +       .parse_dt = dw_mci_hi6220_parse_dt,
> +       .execute_tuning = dw_mci_hi3660_execute_tuning,
> +       .switch_voltage  = dw_mci_hi3660_switch_voltage,
> +};
> +
>  static const struct of_device_id dw_mci_k3_match[] = {
> +       { .compatible = "hisilicon,hi3660-dw-mshc", .data = &hi3660_data, },
>         { .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
>         { .compatible = "hisilicon,hi6220-dw-mshc", .data = &hi6220_data, },
>         {},
> @@ -155,6 +461,11 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
>  {
>         const struct dw_mci_drv_data *drv_data;
>         const struct of_device_id *match;
> +       struct reset_control    *rst;
> +
> +       rst = devm_reset_control_get(&pdev->dev, NULL);
> +       if (!IS_ERR(rst))
> +               reset_control_reset(rst);
>
>         match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
>         drv_data = match->data;
> --
> 2.11.0
>
