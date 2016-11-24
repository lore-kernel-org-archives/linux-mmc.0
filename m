From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 6/10] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Thu, 24 Nov 2016 20:41:07 +0800
Message-ID: <dd230463-04f6-df31-7056-1a185eb6cfc7@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <0390e7a05b6163deabb545f93729ea615eeaaee2.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52599 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936137AbcKXMlz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 07:41:55 -0500
In-Reply-To: <CAPDyKFpqPSqiEi=0UW5LoZmy+y-KHm9nbcGKBSy3RzchdLU9cA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Romain Perier <romain.perier@free-electrons.com>

Hi Ulf,

On 2016/11/24 18:43, Ulf Hansson wrote:
> On 31 October 2016 at 12:09, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Ziji Hu <huziji@marvell.com>
>>
<snip>
>> +static int xenon_emmc_signal_voltage_switch(struct mmc_host *mmc,
>> +                                           struct mmc_ios *ios)
>> +{
>> +       unsigned char voltage = ios->signal_voltage;
>> +
>> +       if ((voltage == MMC_SIGNAL_VOLTAGE_330) ||
>> +           (voltage == MMC_SIGNAL_VOLTAGE_180))
>> +               return __emmc_signal_voltage_switch(mmc, voltage);
>> +
>> +       dev_err(mmc_dev(mmc), "Unsupported signal voltage: %d\n",
>> +               voltage);
>> +       return -EINVAL;
> 
> This wrapper function seems unnessarry. It only adds a dev_err(), so
> then might as well do that in __emmc_signal_voltage_switch().
> 
     Sure. Will merge it back to __emmc_signal_voltage_switch().

>> +}
>> +
>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                                            struct mmc_ios *ios)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       /*
>> +        * Before SD/SDIO set signal voltage, SD bus clock should be
>> +        * disabled. However, sdhci_set_clock will also disable the Internal
>> +        * clock in mmc_set_signal_voltage().
> 
> If that's the case then that is wrong in the generic sdhci code.
> What's the reason why it can't be fixed there instead of having this
> workaround?
> 
    In my very own opinion, SD Spec doesn't specify whether SDCLK should be
    enabled or not during power setting.
    Enabling SDCLK might be a special condition only required by our SDHC.
    I try to avoid breaking other vendors' SDHC functionality
    if their SDHCs require SDCLK disabled.
    Thus I prefer to keep it inside our SDHC driver.

>> +        * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>> +        * Thus here manually enable internal clock.
>> +        *
>> +        * After switch completes, it is unnecessary to disable internal clock,
>> +        * since keeping internal clock active obeys SD spec.
>> +        */
>> +       enable_xenon_internal_clk(host);
>> +
>> +       if (priv->emmc_slot)
>> +               return xenon_emmc_signal_voltage_switch(mmc, ios);
>> +
>> +       return sdhci_start_signal_voltage_switch(mmc, ios);
>> +}
>> +
>> +/*
>> + * After determining which slot is used for SDIO,
>> + * some additional task is required.
>> + */
>> +static void xenon_init_card(struct mmc_host *mmc, struct mmc_card *card)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       u32 reg;
>> +       u8 slot_idx;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       /* Link the card for delay adjustment */
>> +       priv->card_candidate = card;
>> +       /* Set tuning functionality of this slot */
>> +       xenon_slot_tuning_setup(host);
> 
> This looks weird. I assume this can be done as a part of the regular
> tuning seqeunce!?
> 
    It is our SDHC specific preparation prior to tuning, rather than a
    standard step in spec.
    Thus I leave it inside our driver.

>> +
>> +       slot_idx = priv->slot_idx;
>> +       if (!mmc_card_sdio(card)) {
>> +               /* Clear SDIO Card Inserted indication */
> 
> Why do you need this?
> 
> If you need to reset this, I think it's better to do it from
> ->set_ios() at MMC_POWER_OFF.
> 
    This field indicates SDIO card and controls async interrupt feature
    of SDIO in our SDHC.
    This async interrupt feature is enabled when SDIO card is inserted.
    It should be disabled if SD card is inserted instead.

>> +               reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +               reg &= ~(1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>> +               sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
>> +
>> +               if (mmc_card_mmc(card)) {
>> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
>> +                       if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))
>> +                               mmc->caps |= MMC_CAP_1_8V_DDR;
>> +                       /*
>> +                        * Force to clear BUS_TEST to
>> +                        * skip bus_test_pre and bus_test_post
>> +                        */
>> +                       mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>> +                       mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
>> +                                     MMC_CAP2_PACKED_CMD;
>> +                       if (mmc->caps & MMC_CAP_8_BIT_DATA)
>> +                               mmc->caps2 |= MMC_CAP2_HS400_1_8V;
> 
> Most of this can be specified as DT configurations. Please use that instead.
> 
> More importantly, please don't use the ->init_card() ops to assign
> host caps. If not DT, please do it from ->probe().
> 
    Sure. Will try to use DT instead.

>> +               }
>> +       } else {
>> +               /*
>> +                * Set SDIO Card Inserted indication
>> +                * to inform that the current slot is for SDIO
>> +                */
>> +               reg = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +               reg |= (1 << (slot_idx + SLOT_TYPE_SDIO_SHIFT));
>> +               sdhci_writel(host, reg, SDHC_SYS_CFG_INFO);
> 
> So this makes sence to have in the ->init_card() ops. The rest above, not.
> 
>> +       }
>> +}
>> +
>> +static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +       if (host->timing == MMC_TIMING_UHS_DDR50)
>> +               return 0;
>> +
>> +       return sdhci_execute_tuning(mmc, opcode);
>> +}
>> +
>> +static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
>> +{
>> +       host->mmc_host_ops.set_ios = xenon_set_ios;
>> +       host->mmc_host_ops.start_signal_voltage_switch =
>> +                       xenon_start_signal_voltage_switch;
>> +       host->mmc_host_ops.init_card = xenon_init_card;
>> +       host->mmc_host_ops.execute_tuning = xenon_execute_tuning;
>> +}
>> +
>> +static int xenon_probe_dt(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct mmc_host *mmc = host->mmc;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       int err;
>> +       u32 slot_idx, nr_slot;
>> +       u32 tuning_count;
>> +       u32 reg;
>> +
>> +       /* Standard MMC property */
>> +       err = mmc_of_parse(mmc);
>> +       if (err)
>> +               return err;
>> +
>> +       /* Standard SDHCI property */
>> +       sdhci_get_of_property(pdev);
>> +
>> +       /*
>> +        * Xenon Specific property:
>> +        * emmc: explicitly indicate whether this slot is for eMMC
>> +        * slotno: the index of slot. Refer to SDHC_SYS_CFG_INFO register
>> +        * tun-count: the interval between re-tuning
>> +        * PHY type: "sdhc phy", "emmc phy 5.0" or "emmc phy 5.1"
>> +        */
>> +       if (of_property_read_bool(np, "marvell,xenon-emmc"))
>> +               priv->emmc_slot = true;
> 
> So, you need this because of the eMMC voltage switch behaviour, right?
> 
> Then I would rather like to describe this a generic DT bindings for
> the eMMC voltage level support. There have acutally been some earlier
> discussions for this, but we haven't yet made some changes.
> 
> I think what is missing is a mmc-ddr-3_3v DT binding, which when set,
> allows the host driver to accept I/O voltage switches to 3.3V. If not
> supported the  ->start_signal_voltage_switch() ops may return -EINVAL.
> This would inform the mmc core to move on to the next supported
> voltage level. There might be some minor additional changes to the mmc
> card initialization sequence, but those should be simple.
> 
> I can help out to look into this, unless you want to do it yourself of course!?
> 
   Yes. One of the reasons is to provide eMMC specific voltage setting.
   But in my very own opinion, it should be irrelevant to voltage level.
   The eMMC voltage setting on our SDHC is different from SD/SDIO voltage switch.
   It will become more complex with different SOC implementation details.
   Unfortunately, MMC driver cannot determine the card type yet when eMMC voltage
   setting should be executed.
   Thus an flag is required here to tell driver to execute eMMC voltage setting.

   Besides, additional eMMC specific settings might be implemented in future, besides
   voltage setting. Most of them should be completed before MMC driver recognizes the
   card type. Thus I have to keep this flag to indicate current SDHC is for eMMC.

>> +       else
>> +               priv->emmc_slot = false;
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-slotno", &slot_idx)) {
>> +               nr_slot = sdhci_readl(host, SDHC_SYS_CFG_INFO);
>> +               nr_slot &= NR_SUPPORTED_SLOT_MASK;
>> +               if (unlikely(slot_idx > nr_slot)) {
>> +                       dev_err(mmc_dev(mmc), "Slot Index %d exceeds Number of slots %d\n",
>> +                               slot_idx, nr_slot);
>> +                       return -EINVAL;
>> +               }
>> +       } else {
>> +               priv->slot_idx = 0x0;
>> +       }
>> +
>> +       if (!of_property_read_u32(np, "marvell,xenon-tun-count",
>> +                                 &tuning_count)) {
>> +               if (unlikely(tuning_count >= TMR_RETUN_NO_PRESENT)) {
>> +                       dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
>> +                               DEF_TUNING_COUNT);
>> +                       tuning_count = DEF_TUNING_COUNT;
>> +               }
>> +       } else {
>> +               priv->tuning_count = DEF_TUNING_COUNT;
>> +       }
> 
> To make the code a bit easier...
> 
> Maybe set "priv->tuning_count = DEF_TUNING_COUNT" before the "if", and
> instead have the of_property_read_u32() to update the value when set.
> 
   Yes. You are correct.

>> +
>> +       if (of_property_read_bool(np, "marvell,xenon-mask-conflict-err")) {
>> +               reg = sdhci_readl(host, SDHC_SYS_EXT_OP_CTRL);
>> +               reg |= MASK_CMD_CONFLICT_ERROR;
>> +               sdhci_writel(host, reg, SDHC_SYS_EXT_OP_CTRL);
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static int xenon_slot_probe(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       u8 slot_idx = priv->slot_idx;
>> +
>> +       /* Enable slot */
>> +       xenon_enable_slot(host, slot_idx);
>> +
>> +       /* Enable ACG */
>> +       xenon_set_acg(host, true);
>> +
>> +       /* Enable Parallel Transfer Mode */
>> +       xenon_enable_slot_parallel_tran(host, slot_idx);
>> +
>> +       priv->timing = MMC_TIMING_FAKE;
>> +       priv->clock = 0;
> 
> What are these used for?
> 
    During card initialization, our SDHC PHY setting depends on current
    timing and SDCLK frequency.
    priv->timing and priv->clock will be used in PHY setting later.
    It can be considered as a clean-up.
    Anyway, it does look ugly. I will improve them after our PHY setting
    passes your review.

>> +
>> +       return 0;
>> +}
>> +
>> +static void xenon_slot_remove(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       u8 slot_idx = priv->slot_idx;
>> +
>> +       /* disable slot */
>> +       xenon_disable_slot(host, slot_idx);
>> +}
>> +
>> +static int sdhci_xenon_probe(struct platform_device *pdev)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host;
>> +       struct sdhci_host *host;
>> +       struct clk *clk, *axi_clk;
>> +       struct sdhci_xenon_priv *priv;
>> +       int err;
>> +
>> +       host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
>> +                               sizeof(struct sdhci_xenon_priv));
>> +       if (IS_ERR(host))
>> +               return PTR_ERR(host);
>> +
>> +       pltfm_host = sdhci_priv(host);
>> +       priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       xenon_set_acg(host, false);
>> +
>> +       /*
>> +        * Link Xenon specific mmc_host_ops function,
>> +        * to replace standard ones in sdhci_ops.
>> +        */
>> +       xenon_replace_mmc_host_ops(host);
>> +
>> +       clk = devm_clk_get(&pdev->dev, "core");
>> +       if (IS_ERR(clk)) {
>> +               dev_err(&pdev->dev, "Failed to setup input clk.\n");
>> +               err = PTR_ERR(clk);
>> +               goto free_pltfm;
>> +       }
>> +       clk_prepare_enable(clk);
> 
> Check error code.
> 
>> +       pltfm_host->clk = clk;
> 
> Why not assign pltfm_host->clk immedately when doing devm_clk_get(),
> that would make this a bit cleaner, right?
> 
	Yes, of course.

>> +
>> +       /*
>> +        * Some SOCs require additional clock to
>> +        * manage AXI bus clock.
>> +        * It is optional.
>> +        */
>> +       axi_clk = devm_clk_get(&pdev->dev, "axi");
>> +       if (!IS_ERR(axi_clk)) {
>> +               clk_prepare_enable(axi_clk);
>> +               priv->axi_clk = axi_clk;
>> +       }
> 
> Same comments as for the above core clock.
> 
	OK. 
>> +
>> +       err = xenon_probe_dt(pdev);
>> +       if (err)
>> +               goto err_clk;
>> +
>> +       err = xenon_slot_probe(host);
>> +       if (err)
>> +               goto err_clk;
>> +
>> +       err = sdhci_add_host(host);
>> +       if (err)
>> +               goto remove_slot;
>> +
>> +       return 0;
>> +
>> +remove_slot:
>> +       xenon_slot_remove(host);
>> +err_clk:
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +       if (!IS_ERR(axi_clk))
>> +               clk_disable_unprepare(axi_clk);
>> +free_pltfm:
>> +       sdhci_pltfm_free(pdev);
>> +       return err;
>> +}
>> +
>> +static int sdhci_xenon_remove(struct platform_device *pdev)
>> +{
>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xFFFFFFFF);
>> +
>> +       xenon_slot_remove(host);
>> +
>> +       sdhci_remove_host(host, dead);
>> +
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +       clk_disable_unprepare(priv->axi_clk);
>> +
>> +       sdhci_pltfm_free(pdev);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id sdhci_xenon_dt_ids[] = {
>> +       { .compatible = "marvell,xenon-sdhci",},
>> +       { .compatible = "marvell,armada-3700-sdhci",},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>> +
>> +static struct platform_driver sdhci_xenon_driver = {
>> +       .driver = {
>> +               .name   = "xenon-sdhci",
>> +               .of_match_table = sdhci_xenon_dt_ids,
>> +               .pm = &sdhci_pltfm_pmops,
>> +       },
>> +       .probe  = sdhci_xenon_probe,
>> +       .remove = sdhci_xenon_remove,
>> +};
>> +
>> +module_platform_driver(sdhci_xenon_driver);
>> +
>> +MODULE_DESCRIPTION("SDHCI platform driver for Marvell Xenon SDHC");
>> +MODULE_AUTHOR("Hu Ziji <huziji@marvell.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>> new file mode 100644
>> index 000000000000..4601d0a4b22f
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-xenon.h
> 
> I don't think you need a specific header for this, let's instead just
> put everthing in the c-file.
> 
    Some definitions inside this file will also be referred in PHY setting in
    sdhci-xenon-phy.c.
    Thus I put all the definitions together into a header file.

>> @@ -0,0 +1,142 @@
>> +/*
>> + * Copyright (C) 2016 Marvell, All Rights Reserved.
>> + *
>> + * Author:     Hu Ziji <huziji@marvell.com>
>> + * Date:       2016-8-24
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + */
>> +#ifndef SDHCI_XENON_H_
>> +#define SDHCI_XENON_H_
>> +
>> +#include <linux/clk.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/of.h>
>> +#include "sdhci.h"
>> +
>> +/* Register Offset of SD Host Controller SOCP self-defined register */
>> +#define SDHC_SYS_CFG_INFO                      0x0104
>> +#define SLOT_TYPE_SDIO_SHIFT                   24
>> +#define SLOT_TYPE_EMMC_MASK                    0xFF
>> +#define SLOT_TYPE_EMMC_SHIFT                   16
>> +#define SLOT_TYPE_SD_SDIO_MMC_MASK             0xFF
>> +#define SLOT_TYPE_SD_SDIO_MMC_SHIFT            8
>> +#define NR_SUPPORTED_SLOT_MASK                 0x7
>> +
>> +#define SDHC_SYS_OP_CTRL                       0x0108
>> +#define AUTO_CLKGATE_DISABLE_MASK              BIT(20)
>> +#define SDCLK_IDLEOFF_ENABLE_SHIFT             8
>> +#define SLOT_ENABLE_SHIFT                      0
>> +
>> +#define SDHC_SYS_EXT_OP_CTRL                   0x010C
>> +#define MASK_CMD_CONFLICT_ERROR                        BIT(8)
>> +
>> +#define SDHC_SLOT_OP_STATUS_CTRL               0x0128
>> +#define DELAY_90_DEGREE_MASK_EMMC5             BIT(7)
>> +#define DELAY_90_DEGREE_SHIFT_EMMC5            7
>> +#define EMMC_5_0_PHY_FIXED_DELAY_MASK          0x7F
>> +#define EMMC_PHY_FIXED_DELAY_MASK              0xFF
>> +#define EMMC_PHY_FIXED_DELAY_WINDOW_MIN                (EMMC_PHY_FIXED_DELAY_MASK >> 3)
>> +#define SDH_PHY_FIXED_DELAY_MASK               0x1FF
>> +#define SDH_PHY_FIXED_DELAY_WINDOW_MIN         (SDH_PHY_FIXED_DELAY_MASK >> 4)
>> +
>> +#define TUN_CONSECUTIVE_TIMES_SHIFT            16
>> +#define TUN_CONSECUTIVE_TIMES_MASK             0x7
>> +#define TUN_CONSECUTIVE_TIMES                  0x4
>> +#define TUNING_STEP_SHIFT                      12
>> +#define TUNING_STEP_MASK                       0xF
>> +#define TUNING_STEP_DIVIDER                    BIT(6)
>> +
>> +#define FORCE_SEL_INVERSE_CLK_SHIFT            11
>> +
>> +#define SDHC_SLOT_EMMC_CTRL                    0x0130
>> +#define ENABLE_DATA_STROBE                     BIT(24)
>> +#define SET_EMMC_RSTN                          BIT(16)
>> +#define DISABLE_RD_DATA_CRC                    BIT(14)
>> +#define DISABLE_CRC_STAT_TOKEN                 BIT(13)
>> +#define EMMC_VCCQ_MASK                         0x3
>> +#define EMMC_VCCQ_1_8V                         0x1
>> +#define EMMC_VCCQ_3_3V                         0x3
>> +
>> +#define SDHC_SLOT_RETUNING_REQ_CTRL            0x0144
>> +/* retuning compatible */
>> +#define RETUNING_COMPATIBLE                    0x1
>> +
>> +#define SDHC_SLOT_EXT_PRESENT_STATE            0x014C
>> +#define LOCK_STATE                             0x1
>> +
>> +#define SDHC_SLOT_DLL_CUR_DLY_VAL              0x0150
>> +
>> +/* Tuning Parameter */
>> +#define TMR_RETUN_NO_PRESENT                   0xF
>> +#define DEF_TUNING_COUNT                       0x9
>> +
>> +#define MMC_TIMING_FAKE                                0xFF
>> +
>> +#define DEFAULT_SDCLK_FREQ                     (400000)
>> +
>> +/* Xenon specific Mode Select value */
>> +#define XENON_SDHCI_CTRL_HS200                 0x5
>> +#define XENON_SDHCI_CTRL_HS400                 0x6
> 
> For all defines above:
> 
> All these defines needs some *SDHCI* prefix. Can you please update that.

    Sure. Will add prefix for all of them.

> 
>> +
>> +struct sdhci_xenon_priv {
>> +       /*
>> +        * The bus_width, timing, and clock fields in below
>> +        * record the current setting of Xenon SDHC.
>> +        * Driver will call a Sampling Fixed Delay Adjustment
>> +        * if any setting is changed.
>> +        */
>> +       unsigned char   bus_width;
>> +       unsigned char   timing;
> 
> These two are not used. Please remove.
> 
    The above two variables will be used in PHY setting
    in sdhci-xenon-phy.c.
    Could you please help review them in next patch?

>> +       unsigned char   tuning_count;
>> +       unsigned int    clock;
> 
> "clock" isn't used, please remove.
> 
    It will be accessed in PHY setting in sdhci-xenon-phy.c.
    Could you please help review it in next patch?

>> +       struct clk      *axi_clk;
>> +
>> +       /* Slot idx */
>> +       u8              slot_idx;
>> +       /* Whether this slot is for eMMC */
>> +       bool            emmc_slot;
>> +
>> +       /*
>> +        * When initializing card, Xenon has to determine card type and
>> +        * adjust Sampling Fixed delay for the speed mode in which
>> +        * DLL tuning is not support.
>> +        * However, at that time, card structure is not linked to mmc_host.
>> +        * Thus a card pointer is added here to provide
>> +        * the delay adjustment function with the card structure
>> +        * of the card during initialization.
>> +        *
>> +        * It is only valid during initialization after it is updated in
>> +        * xenon_init_card().
>> +        * Do not access this variable in normal transfers after
>> +        * initialization completes.
>> +        */
>> +       struct mmc_card *card_candidate;
> 
> Not activley used in this change, please remove and let's discuss it
> in the next step.
> 
   This varible will be accessed in PHY setting in sdhci-xenon-phy.c.
   I would like to discuss about it in PHY file. Could you please help
   review it in next patch?

   Thank you.

Best regards,
Hu Ziji

>> +};
>> +
>> +static inline int enable_xenon_internal_clk(struct sdhci_host *host)
>> +{
>> +       u32 reg;
>> +       u8 timeout;
>> +
>> +       reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
>> +       reg |= SDHCI_CLOCK_INT_EN;
>> +       sdhci_writel(host, reg, SDHCI_CLOCK_CONTROL);
>> +       /* Wait max 20 ms */
>> +       timeout = 20;
>> +       while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>> +                       & SDHCI_CLOCK_INT_STABLE)) {
>> +               if (timeout == 0) {
>> +                       pr_err("%s: Internal clock never stabilised.\n",
>> +                              mmc_hostname(host->mmc));
>> +                       return -ETIMEDOUT;
>> +               }
>> +               timeout--;
>> +               mdelay(1);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>> --
>> git-series 0.8.10
> 
> Kind regards
> Uffe
> 
