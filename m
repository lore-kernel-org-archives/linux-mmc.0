From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Thu, 24 Nov 2016 21:34:23 +0800
Message-ID: <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

   Thanks a lot for the review.

On 2016/11/24 19:37, Ulf Hansson wrote:
> On 31 October 2016 at 12:09, Gregory CLEMENT
> <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
>> Three types of PHYs are supported.
>>
>> Add support to multiple types of PHYs init and configuration.
>> Add register definitions of PHYs.
>>
>> Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  MAINTAINERS                        |    2 +-
>>  drivers/mmc/host/Makefile          |    2 +-
>>  drivers/mmc/host/sdhci-xenon-phy.c | 1181 +++++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci-xenon-phy.h |  157 ++++-
>>  drivers/mmc/host/sdhci-xenon.c     |    4 +-
>>  drivers/mmc/host/sdhci-xenon.h     |   17 +-
>>  6 files changed, 1361 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
> 
> Can you please consider to split this up somehow!? It would make it
> easier to review...
> 
    Sure. I will try to split them into smaller pieces.

> Anyway, allow me to provide some initial feedback, particularly around
> those things that Adrian and you requested for my input.
> 
> [...]
> 
>>
>> +
>> +static int __xenon_emmc_delay_adj_test(struct mmc_card *card)
>> +{
>> +       int err;
>> +       u8 *ext_csd = NULL;
>> +
>> +       err = mmc_get_ext_csd(card, &ext_csd);
>> +       kfree(ext_csd);
> 
> Why do you read the ext csd here?
> 
   I would like to simply introduce the PHY setting of our SDHC.
   The target of the PHY setting is to achieve a perfect sampling
   point for transfers, during card initialization.

   For HS200/HS400/SDR104 whose SDCLK is more than 50MHz, SDHC HW
   will search for this sampling point with DLL's help.

   For other speed mode whose SDLCK is less than or equals to 50MHz,
   SW has to scan the PHY delay line to find out this perfect sampling
   point. Our driver sends a command to verify a sampling point
   in current environment.

   As result, our SDHC driver has to implement the functionality to
   send commands and check the results, in host layer.
   If directly calling mmc_wait_for_cmd() is improper, could you please
   give us some suggestions?

   For eMMC, CMD8 is used to test current sampling point set in PHY.

>> +
>> +       return err;
>> +}
>> +
>> +static int __xenon_sdio_delay_adj_test(struct mmc_card *card)
>> +{
>> +       struct mmc_command cmd = {0};
>> +       int err;
>> +
>> +       cmd.opcode = SD_IO_RW_DIRECT;
>> +       cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
>> +
>> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
>> +       if (err)
>> +               return err;
>> +
>> +       if (cmd.resp[0] & R5_ERROR)
>> +               return -EIO;
>> +       if (cmd.resp[0] & R5_FUNCTION_NUMBER)
>> +               return -EINVAL;
>> +       if (cmd.resp[0] & R5_OUT_OF_RANGE)
>> +               return -ERANGE;
>> +       return 0;
> 
> No thanks! MMC/SD/SDIO protocol code belongs in the core.
> 
   For SDIO, SD_IO_RW_DIRECT command is sent to test current sampling point
   in PHY.
   Please help provide some suggestion to implement the command transfer.

>> +}
>> +
>> +static int __xenon_sd_delay_adj_test(struct mmc_card *card)
>> +{
>> +       struct mmc_command cmd = {0};
>> +       int err;
>> +
>> +       cmd.opcode = MMC_SEND_STATUS;
>> +       cmd.arg = card->rca << 16;
>> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>> +
>> +       err = mmc_wait_for_cmd(card->host, &cmd, 0);
>> +       return err;
> 
> No thanks! MMC/SD/SDIO protocol code belongs in the core.
> 
>> +}
>> +
> 
> [...]
> 
>> +int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
>> +{
>> +       struct mmc_host *mmc = host->mmc;
>> +       struct mmc_card *card;
>> +       int ret = 0;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       if (!host->clock) {
>> +               priv->clock = 0;
>> +               return 0;
>> +       }
>> +
>> +       /*
>> +        * The timing, frequency or bus width is changed,
>> +        * better to set eMMC PHY based on current setting
>> +        * and adjust Xenon SDHC delay.
>> +        */
>> +       if ((host->clock == priv->clock) &&
>> +           (ios->bus_width == priv->bus_width) &&
>> +           (ios->timing == priv->timing))
>> +               return 0;
>> +
>> +       xenon_phy_set(host, ios->timing);
>> +
>> +       /* Update the record */
>> +       priv->bus_width = ios->bus_width;
>> +       /* Temp stage from HS200 to HS400 */
>> +       if (((priv->timing == MMC_TIMING_MMC_HS200) &&
>> +            (ios->timing == MMC_TIMING_MMC_HS)) ||
>> +           ((ios->timing == MMC_TIMING_MMC_HS) &&
>> +            (priv->clock > host->clock))) {
>> +               priv->timing = ios->timing;
>> +               priv->clock = host->clock;
>> +               return 0;
>> +       }
>> +       /*
>> +        * Skip temp stages from HS400 t0 HS200:
>> +        * from 200MHz to 52MHz in HS400
>> +        * from HS400 to HS DDR in 52MHz
>> +        * from HS DDR to HS in 52MHz
>> +        * from HS to HS200 in 52MHz
>> +        */
>> +       if (((priv->timing == MMC_TIMING_MMC_HS400) &&
>> +            ((host->clock == MMC_HIGH_52_MAX_DTR) ||
>> +             (ios->timing == MMC_TIMING_MMC_DDR52))) ||
>> +           ((priv->timing == MMC_TIMING_MMC_DDR52) &&
>> +            (ios->timing == MMC_TIMING_MMC_HS)) ||
>> +           ((ios->timing == MMC_TIMING_MMC_HS200) &&
>> +            (ios->clock == MMC_HIGH_52_MAX_DTR))) {
>> +               priv->timing = ios->timing;
>> +               priv->clock = host->clock;
>> +               return 0;
>> +       }
>> +       priv->timing = ios->timing;
>> +       priv->clock = host->clock;
>> +
>> +       /* Legacy mode is a special case */
>> +       if (ios->timing == MMC_TIMING_LEGACY)
>> +               return 0;
>> +
>> +       if (mmc->card)
>> +               card = mmc->card;
>> +       else
>> +               /*
>> +                * Only valid during initialization
>> +                * before mmc->card is set
>> +                */
>> +               card = priv->card_candidate;
>> +       if (unlikely(!card)) {
>> +               dev_warn(mmc_dev(mmc), "card is not present\n");
>> +               return -EINVAL;
>> +       }
> 
> That your host need to hold a copy of the card pointer, tells me that
> something is not really correct.
> 
> I might be wrong, if this turns out to be a special case, but I doubt
> it. Although, if it *is* a special such case, we shall most likely try
> to extend the the mmc core layer instead of adding all these hacks in
> your host driver.
>
    This card pointer copies the temporary structure mmc_card
    used in mmc_init_card(), mmc_sd_init_card() and mmc_sdio_init_card().
    Since we call mmc_wait_for_cmd() to send test commands, we need a copy
    of that temporary mmc_card here in our host driver.

    During PHY setting in card initialization, mmc_host->card is not updated
    yet with that temporary mmc_card. Thus we are not able to directly use
    mmc_host->card. Instead, this card pointer is introduced to enable
    mmc_wait_for_cmd().

    If we can improve our host driver to send test commands without mmc_card,
    this card pointer can be removed.
    Could you please share your opinion please?
 
> [...]
> 
> Another suggestion of a general improvement; could you perhaps try to
> add some brief information about what goes on in function headers.
> Perhaps that could help to more easily understand things.
>
   Sorry about any inconvenience. Most of the functions here are our host specific.
   It is really difficult to understand them without proper comment.
   I will add more information.

   Thank you.

Best regards,
Hu Ziji
 
> Kind regards
> Uffe
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
