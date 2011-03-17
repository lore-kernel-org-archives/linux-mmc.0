From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Wed, 16 Mar 2011 23:18:58 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3D22D24@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-3-git-send-email-arindam.nath@amd.com>
 <DCE85B90-4759-4CA1-987B-9512CD959E0E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:12893
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750822Ab1CQETJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 00:19:09 -0400
In-Reply-To: <DCE85B90-4759-4CA1-987B-9512CD959E0E@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Thursday, March 17, 2011 3:09 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; subhashj@codeaurora.org;
> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v2 02/12] mmc: sd: add support for signal voltage
> switch procedure
>
>
> Hi Arindam,
>
> was getting kernel crash on SD card -- fix is below
>
> Philip
>
> On Mar 4, 2011, at 3:32 AM, Arindam Nath wrote:
>
> > Host Controller v3.00 adds another Capabilities register. Apart
> > from other things, this new register indicates whether the Host
> > Controller supports SDR50, SDR104, and DDR50 UHS-I modes. The spec
> > doesn't mention about explicit support for SDR12 and SDR25 UHS-I
> > modes, so the Host Controller v3.00 should support them by default.
> > Also if the controller support SDR104 mode, it will also support
> > SDR50 mode as well. So depending on the host support, we set the
> > corresponding MMC_CAP_* flags. One more new register. Host Control2
> > is added in v3.00, which is used during Signal Voltage Switch
> > procedure described below.
> >
> > Since as per v3.00 spec, UHS-I supported hosts should set S18R
> > to 1, we set S18R (bit 24) of OCR before sending ACMD41. We also
> > need to set XPC (bit 28) of OCR in case the host can supply >150mA.
> > This support is indicated by the Maximum Current Capabilities
> > register of the Host Controller.
> >
> > If the response of ACMD41 has both CCS and S18A set, we start the
> > signal voltage switch procedure, which if successfull, will switch
> > the card from 3.3V signalling to 1.8V signalling. Signal voltage
> > switch procedure adds support for a new command CMD11 in the
> > Physical Layer Spec v3.01. As part of this procedure, we need to
> > set 1.8V Signalling Enable (bit 3) of Host Control2 register, which
> > if remains set after 5ms, means the switch to 1.8V signalling is
> > successfull. Otherwise, we clear bit 24 of OCR and retry the
> > initialization sequence.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > ---
> > drivers/mmc/core/sd.c     |   37 ++++++++++-
> > drivers/mmc/core/sd_ops.c |   32 ++++++++++
> > drivers/mmc/core/sd_ops.h |    1 +
> > drivers/mmc/host/sdhci.c  |  148
> +++++++++++++++++++++++++++++++++++++++++----
> > drivers/mmc/host/sdhci.h  |   18 +++++-
> > include/linux/mmc/host.h  |   10 +++
> > include/linux/mmc/sd.h    |    1 +
> > 7 files changed, 229 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index b3f8a3c..3e82599 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -408,6 +408,7 @@ struct device_type sd_type = {
> > int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> > {
> >        int err;
> > +       u32 rocr;
> >
> >        /*
> >         * Since we're changing the OCR value, we seem to
> > @@ -427,10 +428,25 @@ int mmc_sd_get_cid(struct mmc_host *host, u32
> ocr, u32 *cid)
> >        if (!err)
> >                ocr |= 1 << 30;
> >
> > -       err = mmc_send_app_op_cond(host, ocr, NULL);
> > +       /* If the host can supply more than 150mA, XPC should be set
> to 1. */
> > +       if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC_300 |
> > +           MMC_CAP_SET_XPC_180))
> > +               ocr |= 1 << 28;
> > +
> > +       err = mmc_send_app_op_cond(host, ocr, &rocr);
> >        if (err)
> >                return err;
> >
> > +       /*
> > +        * In case CCS and S18A in the response is set, start Signal
> Voltage
> > +        * Switch procedure. SPI mode doesn't support CMD11.
> > +        */
> > +       if (!mmc_host_is_spi(host) && (rocr & 0x41000000)) {
>
> getting kernel crash -- change code to
> > +       if (!mmc_host_is_spi(host) && (rocr & 0x41000000) ==
> 0x41000000) {
>
> need both bits set -- if one bit is set code is true.

This was already pointed out by Zhangfei, and it will be fixed in V3.

>
>
> > +               err = mmc_start_voltage_switch(host);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> >        if (mmc_host_is_spi(host))
> >                err = mmc_send_cid(host, cid);
> >        else
> > @@ -827,11 +843,26 @@ int mmc_attach_sd(struct mmc_host *host)
> >        }
> >
> >        /*
> > +        * If the host supports one of UHS-I modes, request the card
> > +        * to switch to 1.8V signaling level.
> > +        */
> > +       if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> > +           MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> MMC_CAP_UHS_DDR50))
> > +               host->ocr |= (1 << 24);
> > +
> > +       /*
> >         * Detect and init the card.
> >         */
> >        err = mmc_sd_init_card(host, host->ocr, NULL);
> > -       if (err)
> > -               goto err;
>
> change
> > +       if (err == -EAGAIN) {
> > +               /*
> > +                * Retry initialization with S18R set to 0.
> > +                */
> > +               host->ocr &= ~(1 << 24);
> > +               err = mmc_sd_init_card(host, host->ocr, NULL);
> > +               if (err)
> > +                       goto err;
> > +       }
>
> to
>         if (err) {
>                 if (err == -EAGAIN) {
>                         /*
>                          * Retry initialization with S18R set to 0.
>                          */
>                         host->ocr &= ~(1 << 24);
>                         err = mmc_sd_init_card(host, host->ocr, NULL);
>                 }
>                 if (err)
>                         goto err;
>         }
>
>
> was getting kernel crash when init failed and host->card was NULL

Zhangfei mentioned this one too. Will be fixed.

Thanks,
Arindam

>
> >
> >        mmc_release_host(host);
> >        err = mmc_add_card(host->card);
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index 797cdb5..8a23e2e 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -146,6 +146,38 @@ int mmc_app_set_bus_width(struct mmc_card *card,
> int width)
> >        return 0;
> > }
> >
> > +int mmc_start_voltage_switch(struct mmc_host *host)
> > +{
> > +       struct mmc_command cmd;
> > +       int err;
> > +
> > +       BUG_ON(!host);
> > +
> > +       /*
> > +        * If the host does not provide signal voltage switch
> procedure, we
> > +        * set S18R to 0, and then retry initialization sequence.
> > +        */
> > +       if (!host->ops->start_signal_voltage_switch)
> > +               return -EAGAIN;
> > +
> > +       memset(&cmd, 0, sizeof(struct mmc_command));
> > +
> > +       cmd.opcode = SD_SWITCH_VOLTAGE;
> > +       cmd.arg = 0;
> > +       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
> > +               return -EIO;
> > +
> > +       err = host->ops->start_signal_voltage_switch(host);
> > +
> > +       return err;
> > +}
> > +
> > int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
> > {
> >        struct mmc_command cmd;
> > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > index ffc2305..3cfba59 100644
> > --- a/drivers/mmc/core/sd_ops.h
> > +++ b/drivers/mmc/core/sd_ops.h
> > @@ -20,6 +20,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32
> *scr);
> > int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> >        u8 value, u8 *resp);
> > int mmc_app_sd_status(struct mmc_card *card, void *ssr);
> > +int mmc_start_voltage_switch(struct mmc_host *host);
> >
> > #endif
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 8914a25..5487a0b 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -85,6 +85,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> >        printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr:
> 0x%08x\n",
> >                sdhci_readw(host, SDHCI_COMMAND),
> >                sdhci_readl(host, SDHCI_MAX_CURRENT));
> > +       printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\n",
> > +               sdhci_readw(host, SDHCI_HOST_CONTROL2));
> >
> >        if (host->flags & SDHCI_USE_ADMA)
> >                printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x |
> ADMA Ptr: 0x%08x\n",
> > @@ -1337,11 +1339,70 @@ out:
> >        spin_unlock_irqrestore(&host->lock, flags);
> > }
> >
> > +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host;
> > +       u8 pwr;
> > +       u16 clk, ctrl;
> > +       u32 present_state;
> > +
> > +       host = mmc_priv(mmc);
> > +
> > +       /* Stop SDCLK */
> > +       host = mmc_priv(mmc);
> > +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +       clk &= ~SDHCI_CLOCK_CARD_EN;
> > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +       /* Check whether DAT[3:0] is 0000 */
> > +       present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +       if (!((present_state & SDHCI_DATA_LVL_MASK) >>
> SDHCI_DATA_LVL_SHIFT)) {
> > +               /* Enable 1.8V Signal Enable in the Host Control2
> register */
> > +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +               ctrl |= SDHCI_CTRL_VDD_180;
> > +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > +
> > +               /* Wait for 5ms */
> > +               usleep_range(5000, 5500);
> > +
> > +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +               if (ctrl & SDHCI_CTRL_VDD_180) {
> > +                       /* Provide SDCLK again and wait for 1ms*/
> > +                       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +                       clk |= SDHCI_CLOCK_CARD_EN;
> > +                       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +                       usleep_range(1000, 1500);
> > +
> > +                       /*
> > +                        * If DAT[3:0] level is 1111b, then the card
> was
> > +                        * successfully switched to 1.8V signaling.
> > +                        */
> > +                       present_state = sdhci_readl(host,
> SDHCI_PRESENT_STATE);
> > +                       if ((present_state & SDHCI_DATA_LVL_MASK) ==
> > +                            SDHCI_DATA_LVL_MASK) {
> > +                               return 0;
> > +                       }
> > +               }
> > +       }
> > +
> > +       /*
> > +        * If we are here, that means the switch to 1.8V signaling
> failed. Stop
> > +        * power to the card, and retry initialization sequence by
> setting S18R
> > +        * to 0.
> > +        */
> > +       pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
> > +       pwr &= ~SDHCI_POWER_ON;
> > +       sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > +
> > +       return -EAGAIN;
> > +}
> > +
> > static const struct mmc_host_ops sdhci_ops = {
> >        .request        = sdhci_request,
> >        .set_ios        = sdhci_set_ios,
> >        .get_ro         = sdhci_get_ro,
> >        .enable_sdio_irq = sdhci_enable_sdio_irq,
> > +       .start_signal_voltage_switch    =
> sdhci_start_signal_voltage_switch,
> > };
> >
> >
> /**********************************************************************
> *******\
> > @@ -1799,7 +1860,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> > int sdhci_add_host(struct sdhci_host *host)
> > {
> >        struct mmc_host *mmc;
> > -       unsigned int caps, ocr_avail;
> > +       u32 caps[2];
> > +       u32 max_current_caps;
> > +       unsigned int ocr_avail;
> >        int ret;
> >
> >        WARN_ON(host == NULL);
> > @@ -1822,12 +1885,15 @@ int sdhci_add_host(struct sdhci_host *host)
> >                        host->version);
> >        }
> >
> > -       caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps
> :
> > +       caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host-
> >caps :
> >                sdhci_readl(host, SDHCI_CAPABILITIES);
> >
> > +       if (host->version >= SDHCI_SPEC_300)
> > +               caps[1] = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> > +
> >        if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> >                host->flags |= SDHCI_USE_SDMA;
> > -       else if (!(caps & SDHCI_CAN_DO_SDMA))
> > +       else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
> >                DBG("Controller doesn't have SDMA capability\n");
> >        else
> >                host->flags |= SDHCI_USE_SDMA;
> > @@ -1838,7 +1904,8 @@ int sdhci_add_host(struct sdhci_host *host)
> >                host->flags &= ~SDHCI_USE_SDMA;
> >        }
> >
> > -       if ((host->version >= SDHCI_SPEC_200) && (caps &
> SDHCI_CAN_DO_ADMA2))
> > +       if ((host->version >= SDHCI_SPEC_200) &&
> > +               (caps[0] & SDHCI_CAN_DO_ADMA2))
> >                host->flags |= SDHCI_USE_ADMA;
> >
> >        if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
> > @@ -1892,10 +1959,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >        }
> >
> >        if (host->version >= SDHCI_SPEC_300)
> > -               host->max_clk = (caps & SDHCI_CLOCK_V3_BASE_MASK)
> > +               host->max_clk = (caps[0] & SDHCI_CLOCK_V3_BASE_MASK)
> >>> SDHCI_CLOCK_BASE_SHIFT;
> >        else
> > -               host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK)
> > +               host->max_clk = (caps[0] & SDHCI_CLOCK_BASE_MASK)
> >>> SDHCI_CLOCK_BASE_SHIFT;
> >
> >        host->max_clk *= 1000000;
> > @@ -1911,7 +1978,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >        }
> >
> >        host->timeout_clk =
> > -               (caps & SDHCI_TIMEOUT_CLK_MASK) >>
> SDHCI_TIMEOUT_CLK_SHIFT;
> > +               (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
> SDHCI_TIMEOUT_CLK_SHIFT;
> >        if (host->timeout_clk == 0) {
> >                if (host->ops->get_timeout_clock) {
> >                        host->timeout_clk = host->ops-
> >get_timeout_clock(host);
> > @@ -1923,7 +1990,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >                        return -ENODEV;
> >                }
> >        }
> > -       if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> > +       if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> >                host->timeout_clk *= 1000;
> >
> >        /*
> > @@ -1950,21 +2017,76 @@ int sdhci_add_host(struct sdhci_host *host)
> >        if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> >                mmc->caps |= MMC_CAP_4_BIT_DATA;
> >
> > -       if (caps & SDHCI_CAN_DO_HISPD)
> > +       if (caps[0] & SDHCI_CAN_DO_HISPD)
> >                mmc->caps |= MMC_CAP_SD_HIGHSPEED |
> MMC_CAP_MMC_HIGHSPEED;
> >
> >        if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> >            mmc_card_is_removable(mmc))
> >                mmc->caps |= MMC_CAP_NEEDS_POLL;
> >
> > +       /* UHS-I mode(s) supported by the host controller. */
> > +       if (host->version >= SDHCI_SPEC_300)
> > +               mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> > +
> > +       /* SDR104 supports also implies SDR50 support */
> > +       if (caps[1] & SDHCI_SUPPORT_SDR104)
> > +               mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
> > +       else if (caps[1] & SDHCI_SUPPORT_SDR50)
> > +               mmc->caps |= MMC_CAP_UHS_SDR50;
> > +
> > +       if (caps[1] & SDHCI_SUPPORT_DDR50)
> > +               mmc->caps |= MMC_CAP_UHS_DDR50;
> > +
> >        ocr_avail = 0;
> > -       if (caps & SDHCI_CAN_VDD_330)
> > +       /*
> > +        * According to SD Host Controller spec v3.00, if the Host
> System
> > +        * can afford more than 150mA, Host Driver should set XPC to
> 1. Also
> > +        * the value is meaningful only if Voltage Support in the
> Capabilities
> > +        * register is set. The actual current value is 4 times the
> register
> > +        * value.
> > +        */
> > +       max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
> > +
> > +       if (caps[0] & SDHCI_CAN_VDD_330) {
> > +               int max_current_330;
> > +
> >                ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
> > -       if (caps & SDHCI_CAN_VDD_300)
> > +
> > +               max_current_330 = ((max_current_caps &
> > +                                  SDHCI_MAX_CURRENT_330_MASK) >>
> > +                                  SDHCI_MAX_CURRENT_330_SHIFT) *
> > +                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> > +
> > +               if (max_current_330 > 150)
> > +                       mmc->caps |= MMC_CAP_SET_XPC_330;
> > +       }
> > +       if (caps[0] & SDHCI_CAN_VDD_300) {
> > +               int max_current_300;
> > +
> >                ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
> > -       if (caps & SDHCI_CAN_VDD_180)
> > +
> > +               max_current_300 = ((max_current_caps &
> > +                                  SDHCI_MAX_CURRENT_300_MASK) >>
> > +                                  SDHCI_MAX_CURRENT_300_SHIFT) *
> > +                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> > +
> > +               if (max_current_300 > 150)
> > +                       mmc->caps |= MMC_CAP_SET_XPC_300;
> > +       }
> > +       if (caps[0] & SDHCI_CAN_VDD_180) {
> > +               int max_current_180;
> > +
> >                ocr_avail |= MMC_VDD_165_195;
> >
> > +               max_current_180 = ((max_current_caps &
> > +                                  SDHCI_MAX_CURRENT_180_MASK) >>
> > +                                  SDHCI_MAX_CURRENT_180_SHIFT) *
> > +                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> > +
> > +               if (max_current_180 > 150)
> > +                       mmc->caps |= MMC_CAP_SET_XPC_180;
> > +       }
> > +
> >        mmc->ocr_avail = ocr_avail;
> >        mmc->ocr_avail_sdio = ocr_avail;
> >        if (host->ocr_avail_sdio)
> > @@ -2024,7 +2146,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >        if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> >                mmc->max_blk_size = 2;
> >        } else {
> > -               mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
> > +               mmc->max_blk_size = (caps[0] & SDHCI_MAX_BLOCK_MASK)
> >>
> >                                SDHCI_MAX_BLOCK_SHIFT;
> >                if (mmc->max_blk_size >= 3) {
> >                        printk(KERN_WARNING "%s: Invalid maximum block
> size, "
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 223762c..95d70e6 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -69,6 +69,8 @@
> > #define  SDHCI_DATA_AVAILABLE  0x00000800
> > #define  SDHCI_CARD_PRESENT    0x00010000
> > #define  SDHCI_WRITE_PROTECT   0x00080000
> > +#define  SDHCI_DATA_LVL_MASK   0x00F00000
> > +#define   SDHCI_DATA_LVL_SHIFT 20
> >
> > #define SDHCI_HOST_CONTROL     0x28
> > #define  SDHCI_CTRL_LED                0x01
> > @@ -147,7 +149,8 @@
> >
> > #define SDHCI_ACMD12_ERR       0x3C
> >
> > -/* 3E-3F reserved */
> > +#define SDHCI_HOST_CONTROL2            0x3E
> > +#define  SDHCI_CTRL_VDD_180            0x0008
> >
> > #define SDHCI_CAPABILITIES     0x40
> > #define  SDHCI_TIMEOUT_CLK_MASK        0x0000003F
> > @@ -168,9 +171,20 @@
> > #define  SDHCI_CAN_VDD_180     0x04000000
> > #define  SDHCI_CAN_64BIT       0x10000000
> >
> > +#define  SDHCI_SUPPORT_SDR50   0x00000001
> > +#define  SDHCI_SUPPORT_SDR104  0x00000002
> > +#define  SDHCI_SUPPORT_DDR50   0x00000004
> > +
> > #define SDHCI_CAPABILITIES_1   0x44
> >
> > -#define SDHCI_MAX_CURRENT      0x48
> > +#define SDHCI_MAX_CURRENT              0x48
> > +#define  SDHCI_MAX_CURRENT_330_MASK    0x0000FF
> > +#define  SDHCI_MAX_CURRENT_330_SHIFT   0
> > +#define  SDHCI_MAX_CURRENT_300_MASK    0x00FF00
> > +#define  SDHCI_MAX_CURRENT_300_SHIFT   8
> > +#define  SDHCI_MAX_CURRENT_180_MASK    0xFF0000
> > +#define  SDHCI_MAX_CURRENT_180_SHIFT   16
> > +#define   SDHCI_MAX_CURRENT_MULTIPLIER 4
> >
> > /* 4C-4F reserved for more max current */
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index bcb793e..ad7daa3 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -117,6 +117,8 @@ struct mmc_host_ops {
> >
> >        /* optional callback for HC quirks */
> >        void    (*init_card)(struct mmc_host *host, struct mmc_card
> *card);
> > +
> > +       int     (*start_signal_voltage_switch)(struct mmc_host
> *host);
> > };
> >
> > struct mmc_card;
> > @@ -173,6 +175,14 @@ struct mmc_host {
> >                                                /* DDR mode at 1.2V */
> > #define MMC_CAP_POWER_OFF_CARD (1 << 13)       /* Can power off after
> boot */
> > #define MMC_CAP_BUS_WIDTH_TEST (1 << 14)       /* CMD14/CMD19 bus
> width ok */
> > +#define MMC_CAP_UHS_SDR12      (1 << 15)       /* Host supports UHS
> SDR12 mode */
> > +#define MMC_CAP_UHS_SDR25      (1 << 16)       /* Host supports UHS
> SDR25 mode */
> > +#define MMC_CAP_UHS_SDR50      (1 << 17)       /* Host supports UHS
> SDR50 mode */
> > +#define MMC_CAP_UHS_SDR104     (1 << 18)       /* Host supports UHS
> SDR104 mode */
> > +#define MMC_CAP_UHS_DDR50      (1 << 19)       /* Host supports UHS
> DDR50 mode */
> > +#define MMC_CAP_SET_XPC_330    (1 << 20)       /* Host supports
> >150mA current at 3.3V */
> > +#define MMC_CAP_SET_XPC_300    (1 << 21)       /* Host supports
> >150mA current at 3.0V */
> > +#define MMC_CAP_SET_XPC_180    (1 << 22)       /* Host supports
> >150mA current at 1.8V */
> >
> >        mmc_pm_flag_t           pm_caps;        /* supported pm
> features */
> >
> > diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> > index 178363b..3ba5aa6 100644
> > --- a/include/linux/mmc/sd.h
> > +++ b/include/linux/mmc/sd.h
> > @@ -17,6 +17,7 @@
> > /* This is basically the same command as for MMC with some quirks. */
> > #define SD_SEND_RELATIVE_ADDR     3   /* bcr                     R6
> */
> > #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7
> */
> > +#define SD_SWITCH_VOLTAGE         11  /* ac                      R1
> */
> >
> >   /* class 10 */
> > #define SD_SWITCH                 6   /* adtc [31:0] See below   R1
> */
> > --
> > 1.7.1
> >
>


