From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: core: HS DDR switch, don't change timing before
 checking status
Date: Wed, 22 Mar 2017 09:41:28 +0100
Message-ID: <CAPDyKFqJA-Tj=Q+-gR+gOUNokzN0QpxHBgaEVqOGtCWiXt6Bzw@mail.gmail.com>
References: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com>
 <20170310142117.6060-1-ludovic.desroches@atmel.com> <CAPDyKFqpX3ZQSxiZsMyei9K0v9eSqVSBC89_U2=VtokGSqtFfA@mail.gmail.com>
 <20170317163311.vhhcwgr2asjxuoh7@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35018 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933802AbdCVJKO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 05:10:14 -0400
Received: by mail-vk0-f43.google.com with SMTP id r69so9247875vke.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 02:10:12 -0700 (PDT)
In-Reply-To: <20170317163311.vhhcwgr2asjxuoh7@rfolt0960.corp.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, nicolas.ferre@microchip.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>

On 17 March 2017 at 17:33, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> On Fri, Mar 17, 2017 at 04:14:18PM +0100, Ulf Hansson wrote:
>> On 10 March 2017 at 15:21, Ludovic Desroches
>> <ludovic.desroches@atmel.com> wrote:
>> > From: Ludovic Desroches <ludovic.desroches@microchip.com>
>> >
>> > The commit e173f8911f09 mmc: core: Update CMD13 polling policy when
>> > switch to HS DDR mode in addition to fix the management of CRC error,
>> > changes the place where the DDR52 timing is set.
>> >
>> > Before this commit, the sequence was:
>> > - set width to 8 with MMC_HS timing
>> > - send the switch command
>> > - check the status
>> > - set width to 8 with MMC_DDR52 timing
>> > - send the switch command
>> > - check the status
>> > Now:
>> > - set width to 8 with MMC_HS timing
>> > - send the switch command
>> > - set width to 8 with MMC_DDR52 timing
>> > - check the status
>> >
>> > It may lead to get an error when checking the status with some devices.
>> >
>> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>> > ---
>> >  drivers/mmc/core/mmc.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 0fccca0..b837148 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -1062,7 +1062,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>> >                            EXT_CSD_BUS_WIDTH,
>> >                            ext_csd_bits,
>> >                            card->ext_csd.generic_cmd6_time,
>> > -                          MMC_TIMING_MMC_DDR52,
>> > +                          0,
>> >                            true, true, true);
>> >         if (err) {
>> >                 pr_err("%s: switch to bus width %d ddr failed\n",
>> > @@ -1106,6 +1106,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>> >         if (err)
>> >                 err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>> >
>> > +       if (!err)
>> > +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>> > +
>> >         return err;
>> >  }
>> >
>> > --
>> > 2.9.0
>> >
>>
>> We had other reports for similar problems. The following change fix
>> those issues, have you tried this out?
>>
>> [PATCH] mmc: core: Restore parts of the polling policy when switch to HS/HS DDR
>> https://patchwork.kernel.org/patch/9515239/
>
> I did the test with next and the behavior is the same.
>
> mmc0: Invalid UHS-I mode selected
> mmc0: switch to bus width 8 ddr failed
> mmc0: error -110 whilst initialising MMC card
>
> It seems the root cause is to perform mmc_set_timing before mmc_switch_status.

Okay, I see! This sounds a bit weird.

As you know, the CMD6 has been a problematic historically, mostly
because of busy detection issues. We have now tried to make the code
more robust in __mmc_switch() and its friends.
That said, before considering to apply your fix, I would really like
us to investigate this a bit more, to make sure we find the correct
solution and of course to avoid regressions for other cases.

Recently reported issues [1] that was observed for sdhci-esdc-imx,
which has been fixed now, can be summarized in these two issues:

*) Only 3.3V I/O voltage DDR mode was supported by the SoC. Still the
mmc core tried to set 1.8V, which caused errors when switching to HS
DDR mode.
-> To fix this, we invented MMC_CAP_3_3V_DDR [2] and a corresponding
DT binding ("mmc-ddr-3_3v"). Hosts/SoCs, that supports only 3.3V DDR
mode, should set this.

**). Changing host's timings couldn't be done while the card was busy,
because of internal limitations by the sdhci-esdhc-imx controller. The
consequence was that the following CMD13 command (to get the switch
status), returned the error code -110, perhaps similar to your case.
->To fix this, we decided to move the update of the host's timing, to
after we verified the card isn't being busy [3].


>From your description to the problem you encounter, I would recommend
the following debug steps to try to understand what really goes on.
1.
Check if the 3.3V DDR issue is applicable for your case as well, and
fix it if it is.

2.
Both sdhci-esdhc-imx and sdhci-of-at91, don't have
MMC_CAP_WAIT_WHILE_BUSY set. However, both sdhci variants are using
the ->card_busy() host ops (assigned to sdhci_card_busy()), which
triggers __mmc_switch() to call mmc_poll_for_busy() when it switches
to HS DDR mode (CMD6). Could it be that sdhci_card_busy() isn't
working properly for sdhci-of-at91? This could lead to that that
mmc_poll_for_busy() believes the card isn't busy, while it actually
is.

To check whether theory 2 stands, I would explore these debug alternatives.
*) Remove the assignment of ->card_busy() in sdhci.c, which makes
mmc_poll_for_busy() to use CMD13 polling instead. If this works, it
would be useful to know how many times a CMD13 is sent to find out
when card moves out of busy state.
**) While using ->card_busy(), I would just add some simple debug
prints in mmc_poll_for_busy() to prints its return values.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/9514583
[2]
https://www.spinics.net/lists/linux-mmc/msg41967.html
[3]
https://patchwork.kernel.org/patch/9515239
