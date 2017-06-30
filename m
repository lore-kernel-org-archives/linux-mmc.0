From: Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v4] mmc: dw_mmc-k3: add sd support for hi3660
Date: Fri, 30 Jun 2017 21:27:34 +0800
Message-ID: <CAFGCpxxsKtcSh4zjiZwf4zAbKPXvPTFxBO1HZ0bfj+jbRhVvYw@mail.gmail.com>
References: <20170613072522.42923-1-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36296 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdF3N1g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jun 2017 09:27:36 -0400
Received: by mail-yw0-f175.google.com with SMTP id a12so926731ywh.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jun 2017 06:27:35 -0700 (PDT)
In-Reply-To: <20170613072522.42923-1-liwei213@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: liwei <liwei213@huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, wsa+renesas@sang-engineering.com, hkallweit1@gmail.com, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Li Wei

I have some minor comments to your patch.

> On Tue, Jun 13, 2017 at 3:25 PM, liwei <liwei213@huawei.com> wrote:

First of all, please modify author part. It is recommended to use "Li
Wei", instead of what you are using now "liwei". If you are using git
format-patch, send-email, please modify your
~/.gitconfig

Add a proper [user] section.

For an existing commit, you can modify the author information by running
git commit --amend --author="xxx"



> Add sd card support for hi3660 soc
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>
>
> Major changes in v3:
>  - solve review comments from Heiner Kallweit.
>    *use the GENMASK and FIELD_PREP macros replace the bit shift operation.
>    *use usleep_range() replace udelay() and mdelay().
>
> Major changes in v4:
>  - solve review comments from Jaehoon Chung.
>    *move common register for dwmmc controller to dwmmc header file.
>    *modify definitions type of some register variables.
>    *get rid of the magic numbers.
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 313 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h    |   2 +
>  2 files changed, 315 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index e38fb0020bb1..c63e91ab775e 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -8,6 +8,8 @@
>   * (at your option) any later version.
>   */
>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mmc/host.h>
> @@ -28,7 +30,38 @@
>  #define AO_SCTRL_SEL18         BIT(10)
>  #define AO_SCTRL_CTRL3         0x40C
>
> +#define DWMMC_SDIO_ID 2
> +
> +#define SOC_SCTRL_SCPERCTRL5    (0x314)
> +#define SDCARD_IO_SEL18         BIT(2)
> +
> +#define SDCARD_RD_THRESHOLD  (512)
> +
> +#define GENCLK_DIV (7)
> +
> +#define GPIO_CLK_ENABLE                   BIT(16)
> +#define GPIO_CLK_DIV_MASK                 GENMASK(11, 8)
> +#define GPIO_USE_SAMPLE_DLY_MASK          GENMASK(13, 13)
> +#define UHS_REG_EXT_SAMPLE_PHASE_MASK     GENMASK(20, 16)
> +#define UHS_REG_EXT_SAMPLE_DRVPHASE_MASK  GENMASK(25, 21)
> +#define UHS_REG_EXT_SAMPLE_DLY_MASK       GENMASK(30, 26)
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
> +       int ctrl_id;
> +       u32 cur_speed;
>         struct regmap   *reg;
>  };
>
> @@ -38,6 +71,41 @@ static unsigned long dw_mci_hi6220_caps[] = {
>         0
>  };
>
> +struct hs_timing {
> +       u32 drv_phase;
> +       u32 smpl_dly;
> +       u32 smpl_phase_max;
> +       u32 smpl_phase_min;
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
> @@ -66,6 +134,10 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
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
> @@ -144,7 +216,243 @@ static const struct dw_mci_drv_data hi6220_data = {
>         .execute_tuning         = dw_mci_hi6220_execute_tuning,
>  };
>
> +static void dw_mci_hs_set_timing(struct dw_mci *host, int timing, int smpl_phase)
> +{
> +       u32 drv_phase;
> +       u32 smpl_dly;
> +       u32 use_smpl_dly = 0;
> +       u32 enable_shift = 0;
> +       u32 reg_value;
> +       int ctrl_id;
> +       struct k3_priv *priv;
> +
> +       priv = host->priv;
> +       ctrl_id = priv->ctrl_id;
> +
> +       drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
> +       smpl_dly   = hs_timing_cfg[ctrl_id][timing].smpl_dly;
> +       if (smpl_phase == -1)
> +               smpl_phase = (hs_timing_cfg[ctrl_id][timing].smpl_phase_max +
> +                            hs_timing_cfg[ctrl_id][timing].smpl_phase_min) / 2;
> +
> +       switch (timing) {
> +       case MMC_TIMING_UHS_SDR104:
> +               if (smpl_phase >= USE_DLY_MIN_SMPL &&
> +                   smpl_phase <= USE_DLY_MAX_SMPL)
> +                       use_smpl_dly = 1;
> +       case MMC_TIMING_UHS_SDR50:
> +               if (smpl_phase >= ENABLE_SHIFT_MIN_SMPL &&
> +                   smpl_phase <= ENABLE_SHIFT_MAX_SMPL) {
> +                       enable_shift = 1;
> +                       break;
> +               }
> +       }

In this line, I saw extra trailing whitespace. Please fix it.



> +
> +       mci_writel(host, GPIO, 0x0);
> +       usleep_range(5, 10);
> +
> +       reg_value = FIELD_PREP(UHS_REG_EXT_SAMPLE_PHASE_MASK, smpl_phase) |\
> +                               FIELD_PREP(UHS_REG_EXT_SAMPLE_DLY_MASK ,smpl_dly) |\
> +                               FIELD_PREP(UHS_REG_EXT_SAMPLE_DRVPHASE_MASK,drv_phase);


In this line, I saw extra trailing whitespace. Please fix it.

> +       mci_writel(host, UHS_REG_EXT, reg_value);
> +
> +       mci_writel(host, ENABLE_SHIFT, enable_shift);
> +
> +       reg_value = FIELD_PREP(GPIO_CLK_DIV_MASK, GENCLK_DIV) |\
> +                               FIELD_PREP(GPIO_USE_SAMPLE_DLY_MASK,use_smpl_dly);
> +       mci_writel(host, GPIO, (unsigned int)reg_value | GPIO_CLK_ENABLE);
> +
> +       /* We should delay 1ms wait for timing setting finished. */
> +       usleep_range(1000, 2000);
> +}
> +
> +static int dw_mci_hi3660_init(struct dw_mci *host)
> +{
> +       mci_writel(host, CDTHRCTL, SDMMC_SET_THLD(SDCARD_RD_THRESHOLD,
> +                                                               SDMMC_CARD_RD_THR_EN));
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
> +       /*A clock cycle is divided into 32 phases,

An extra trailing whitespace is in the above line too. Please fix it.

> +       *each of which is represented by a bit, finding the optimal phase.
> +       */

The comment style here is very strange. You should add a ' ' between
'/*' and the comment. Like this:

/* A clock cycle

-Guodong


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
> +       int smpl_phase = 0;
> +       u32 tuning_sample_flag = 0;
> +       int best_clksmpl = 0;
> +
> +       for (i = 0; i < NUM_PHASES; ++i, ++smpl_phase) {
> +               smpl_phase %= 32;
> +
> +               mci_writel(host, TMOUT, ~0);
> +               dw_mci_hs_set_timing(host, mmc->ios.timing, smpl_phase);
> +
> +               if (!mmc_send_tuning(mmc, opcode, NULL))
> +                       tuning_sample_flag |= (1 << smpl_phase);
> +               else
> +                       tuning_sample_flag &= ~(1 << smpl_phase);
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
> +               dev_err(host->dev, "Regulator set error %d: %d - %d\n",
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
> @@ -155,6 +463,11 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
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
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index ce347361f3dc..7cdcafda8eec 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -319,6 +319,8 @@ struct dw_mci_board {
>  #define SDMMC_DSCADDR          0x094
>  #define SDMMC_BUFADDR          0x098
>  #define SDMMC_CDTHRCTL         0x100
> +#define SDMMC_UHS_REG_EXT      0x108
> +#define SDMMC_ENABLE_SHIFT     0x110
>  #define SDMMC_DATA(x)          (x)
>  /*
>  * Registers to support idmac 64-bit address mode
> --
> 2.11.0
>
