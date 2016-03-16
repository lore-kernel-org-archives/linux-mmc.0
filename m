From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: tegra: implement memcomp pad calibration
Date: Wed, 16 Mar 2016 16:04:32 +0100
Message-ID: <CAPDyKFqh5-OJueFjEC3ctC6wU5qa3efEm6otPfWoHhZpVLvjFw@mail.gmail.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
	<1456779385-18996-2-git-send-email-dev@lynxeye.de>
	<CAPDyKFp7P3H-AZWs+kQa4eufs8gSeVaU8MWhy0_L2CsPspRX0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38860 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934990AbcCPPEe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 11:04:34 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so76795107wml.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 08:04:33 -0700 (PDT)
In-Reply-To: <CAPDyKFp7P3H-AZWs+kQa4eufs8gSeVaU8MWhy0_L2CsPspRX0A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 16 March 2016 at 12:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 February 2016 at 21:56, Lucas Stach <dev@lynxeye.de> wrote:
>> The Tegra30+ SDMMC module has memcomp pads that are used to
>> automatically find and set the correct drive strength settings to
>> the sdmmc pads. The calibration needs to be manually kicked off
>> when the card signal voltage is changed, after the card clock is
>> supplied again.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>
> Thanks applied for next, with a minor trivial fixup to resolve the
> conflict when applying.

I noticed this one also caused a compile error, so I did one more
additional trivial rebase to fix it.

You should probably have look at my next branch, to make sure I
haven't screwed up.

Kind regards
Uffe

>
> Kind regards
> Uffe
>
>> ---
>> This commit allows signal voltage changes on my Tegar30 Beaver to
>> succeed, making UHS-I modes work.
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 47 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 46a6bd1..9971732 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -12,6 +12,7 @@
>>   *
>>   */
>>
>> +#include "linux/delay.h"
>>  #include <linux/err.h>
>>  #include <linux/module.h>
>>  #include <linux/init.h>
>> @@ -42,12 +43,17 @@
>>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300  0x20
>>  #define SDHCI_MISC_CTRL_ENABLE_DDR50           0x200
>>
>> +#define SDHCI_TEGRA_AUTO_CAL_CONFIG            0x1e4
>> +#define SDHCI_AUTO_CAL_START                   BIT(31)
>> +#define SDHCI_AUTO_CAL_ENABLE                  BIT(29)
>> +
>>  #define NVQUIRK_FORCE_SDHCI_SPEC_200   BIT(0)
>>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET   BIT(1)
>>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300  BIT(2)
>>  #define NVQUIRK_ENABLE_SDR50           BIT(3)
>>  #define NVQUIRK_ENABLE_SDR104          BIT(4)
>>  #define NVQUIRK_ENABLE_DDR50           BIT(5)
>> +#define NVQUIRK_HAS_PADCALIB           BIT(6)
>>
>>  struct sdhci_tegra_soc_data {
>>         const struct sdhci_pltfm_data *pdata;
>> @@ -58,6 +64,7 @@ struct sdhci_tegra {
>>         const struct sdhci_tegra_soc_data *soc_data;
>>         struct gpio_desc *power_gpio;
>>         bool ddr_signaling;
>> +       bool pad_calib_required;
>>  };
>>
>>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
>> @@ -165,6 +172,9 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>>                 clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
>>         sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>>
>> +       if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
>> +               tegra_host->pad_calib_required = true;
>> +
>>         tegra_host->ddr_signaling = false;
>>  }
>>
>> @@ -187,6 +197,17 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
>>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>  }
>>
>> +static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>> +{
>> +       u32 val;
>> +
>> +       mdelay(1);
>> +
>> +       val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>> +       val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
>> +       sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
>> +}
>> +
>>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -200,7 +221,12 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>         clk_set_rate(pltfm_host->clk, host_clk);
>>         host->max_clk = clk_get_rate(pltfm_host->clk);
>>
>> -       return sdhci_set_clock(host, clock);
>> +       sdhci_set_clock(host, clock);
>> +
>> +       if (tegra_host->pad_calib_required) {
>> +               tegra_sdhci_pad_autocalib(host);
>> +               tegra_host->pad_calib_required = false;
>> +       }
>>  }
>>
>>  static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>> @@ -270,6 +296,16 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>         return mmc_send_tuning(host->mmc, opcode, NULL);
>>  }
>>
>> +static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_tegra *tegra_host = pltfm_host->priv;
>> +       const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
>> +
>> +       if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
>> +               tegra_host->pad_calib_required = true;
>> +}
>> +
>>  static const struct sdhci_ops tegra_sdhci_ops = {
>>         .get_ro     = tegra_sdhci_get_ro,
>>         .read_w     = tegra_sdhci_readw,
>> @@ -279,6 +315,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>>         .reset      = tegra_sdhci_reset,
>>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>> +       .voltage_switch = tegra_sdhci_voltage_switch,
>>         .get_max_clock = tegra_sdhci_get_max_clock,
>>  };
>>
>> @@ -312,7 +349,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>>         .pdata = &sdhci_tegra30_pdata,
>>         .nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
>>                     NVQUIRK_ENABLE_SDR50 |
>> -                   NVQUIRK_ENABLE_SDR104,
>> +                   NVQUIRK_ENABLE_SDR104 |
>> +                   NVQUIRK_HAS_PADCALIB,
>>  };
>>
>>  static const struct sdhci_ops tegra114_sdhci_ops = {
>> @@ -325,6 +363,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>>         .reset      = tegra_sdhci_reset,
>>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>> +       .voltage_switch = tegra_sdhci_voltage_switch,
>>         .get_max_clock = tegra_sdhci_get_max_clock,
>>  };
>>
>> @@ -347,7 +386,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>>         .pdata = &sdhci_tegra114_pdata,
>>         .nvquirks = NVQUIRK_ENABLE_SDR50 |
>>                     NVQUIRK_ENABLE_DDR50 |
>> -                   NVQUIRK_ENABLE_SDR104,
>> +                   NVQUIRK_ENABLE_SDR104 |
>> +                   NVQUIRK_HAS_PADCALIB,
>>  };
>>
>>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>> @@ -402,6 +442,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>>                 goto err_alloc_tegra_host;
>>         }
>>         tegra_host->ddr_signaling = false;
>> +       tegra_host->pad_calib_required = false;
>>         tegra_host->soc_data = soc_data;
>>         pltfm_host->priv = tegra_host;
>>
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
