From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 2/3] mmc: dw_mmc: Support voltage changes
Date: Mon, 29 Sep 2014 14:49:50 +0200
Message-ID: <1722401.BdMiYKdVJ3@amdc1032>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=X_PMbovmpp4n9LXY5-9rnfcoF4D1x4wvuGOkayb7aArA@mail.gmail.com>
 <CAPDyKFqi78_s+d47_whCn+6ZhCN+KF_nqyFjnGwQSjPAPjr3iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56680 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbaI2MuE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 08:50:04 -0400
In-reply-to: <CAPDyKFqi78_s+d47_whCn+6ZhCN+KF_nqyFjnGwQSjPAPjr3iA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Doug Anderson <dianders@google.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>


Hi,

On Friday, August 29, 2014 01:43:16 PM Ulf Hansson wrote:
> On 25 August 2014 22:59, Doug Anderson <dianders@google.com> wrote:
> > Ulf,
> >
> > On Mon, Aug 25, 2014 at 1:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 22 August 2014 22:38, Doug Anderson <dianders@google.com> wrote:
> >>> Ulf,
> >>>
> >>> On Fri, Aug 22, 2014 at 8:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> >>>>> From: Doug Anderson <dianders@chromium.org>
> >>>>>
> >>>>> For UHS cards we need the ability to switch voltages from 3.3V to
> >>>>> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
> >>>>> dw_mmc needs a little bit of extra code since the interface needs a
> >>>>> special bit programmed to the CMD register while CMD11 is progressing.
> >>>>> This means adding a few extra states to the state machine to track.
> >>>>>
> >>>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
> >>>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >>>>> ---
> >>>>> changes since v1:
> >>>>>         1. Added error message and return error in case of regulator_set_voltage() fail.
> >>>>>         2. changed  dw_mci_cmd_interrupt(host,pending | SDMMC_INT_CMD_DONE)
> >>>>>            to dw_mci_cmd_interrupt(host,pending).
> >>>>>         3. Removed unnecessary comments.
> >>>>>
> >>>>>  drivers/mmc/host/dw_mmc.c  |  134 +++++++++++++++++++++++++++++++++++++++++---
> >>>>>  drivers/mmc/host/dw_mmc.h  |    5 +-
> >>>>>  include/linux/mmc/dw_mmc.h |    2 +
> >>>>>  3 files changed, 131 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >>>>> index aadb0d6..f20b4b8 100644
> >>>>> --- a/drivers/mmc/host/dw_mmc.c
> >>>>> +++ b/drivers/mmc/host/dw_mmc.c
> >>>>> @@ -29,6 +29,7 @@
> >>>>>  #include <linux/irq.h>
> >>>>>  #include <linux/mmc/host.h>
> >>>>>  #include <linux/mmc/mmc.h>
> >>>>> +#include <linux/mmc/sd.h>
> >>>>>  #include <linux/mmc/sdio.h>
> >>>>>  #include <linux/mmc/dw_mmc.h>
> >>>>>  #include <linux/bitops.h>
> >>>>> @@ -234,10 +235,13 @@ err:
> >>>>>  }
> >>>>>  #endif /* defined(CONFIG_DEBUG_FS) */
> >>>>>
> >>>>> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
> >>>>> +
> >>>>>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> >>>>>  {
> >>>>>         struct mmc_data *data;
> >>>>>         struct dw_mci_slot *slot = mmc_priv(mmc);
> >>>>> +       struct dw_mci *host = slot->host;
> >>>>>         const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
> >>>>>         u32 cmdr;
> >>>>>         cmd->error = -EINPROGRESS;
> >>>>> @@ -253,6 +257,31 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> >>>>>         else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
> >>>>>                 cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
> >>>>>
> >>>>> +       if (cmd->opcode == SD_SWITCH_VOLTAGE) {
> >>>>> +               u32 clk_en_a;
> >>>>> +
> >>>>> +               /* Special bit makes CMD11 not die */
> >>>>> +               cmdr |= SDMMC_CMD_VOLT_SWITCH;
> >>>>> +
> >>>>> +               /* Change state to continue to handle CMD11 weirdness */
> >>>>> +               WARN_ON(slot->host->state != STATE_SENDING_CMD);
> >>>>> +               slot->host->state = STATE_SENDING_CMD11;
> >>>>> +
> >>>>> +               /*
> >>>>> +                * We need to disable clock stop while doing voltage switch
> >>>>> +                * according to Voltage Switch Normal Scenario.
> >>>>> +                * It's assumed that by the next time the CLKENA is updated
> >>>>> +                * (when we set the clock next) that the voltage change will
> >>>>> +                * be over, so we don't bother setting any bits to synchronize
> >>>>> +                * with dw_mci_setup_bus().
> >>>>> +                */
> >>>>
> >>>> I don't know the details about the dw_mmc controller, but normally a
> >>>> host driver is expected to gate the clock from it's ->set_ios
> >>>> callback, when the clk frequency are set to 0.
> >>>>
> >>>> Could you elaborate on why dw_mmc can't do that, but need to handle
> >>>> this from here?
> >>>
> >>> Let's see, it's been a while since I wrote this...
> >>>
> >>>
> >>> So dw_mmc has a special feature where the controller itself will
> >>> automatically stop the MMC Card clock when nothing is going on.  This
> >>> is called "low power" mode.  I'm not super familiar with other MMC
> >>> drivers, I get the impression that this is a special dw_mmc feature
> >>> and not common to other controllers.  I think other drivers have
> >>> aggressive runtime PM to get similar power savings.
> >>
> >> I see.
> >>
> >> I am familiar with such "low power" mode features, there are certainly
> >> other controllers supporting such as well. My experience tells me,
> >> it's hard to get things right for all corner cases. The voltage switch
> >> behaviour is just one of these, then you have SDIO irq etc.
> >>
> >> Instead of using the controller HW, yes you may implement clock gating
> >> through runtime PM in the host driver.
> >>
> >>>
> >>> The dw_mmc auto clock gating can wreck total havoc on the voltage
> >>> change procedure, since part of the way that the host and card
> >>> communicate is that the host is supposed to stop its clock when it
> >>> gets to a certain phase of the voltage switch sequence.  If the
> >>> controller is stopping the clock for us then it can confuse the card.
> >>>
> >>> The dw_mmc manual says that before starting a voltage change you must
> >>> turn off low power mode.  That's what we're doing here.
> >>>
> >>>
> >>> The comment above refers to the fact dw_mci_setup_bus() will
> >>> unconditionally turn low power mode back on for us when called with a
> >>> non-zero clock.  If dw_mci_setup_bus() might be called with a non-zero
> >>> clock during the voltage change then this would be disaster (low power
> >>> mode would be back on!).  ...but the clock will always be zero during
> >>> the voltage change and when it's finally non-zero then it's the last
> >>> stage of the voltage change and we can go back to low power mode.
> >>>
> >>>
> >>> Possibly the above was not super clear from the comment (even for
> >>> those familiar with the oddities of dw_mmc).  If you want me to try to
> >>> rewrite the comment, let me know.
> >>
> >> I appreciate an updated comment, it's nice to know what goes on. :-)
> >
> > OK, how about:
> >
> > /*
> >  * We need to disable low power mode (automatic clock stop)
> >  * while doing voltage switch so we don't confuse the card,
> >  * since stopping the clock is a specific part of the UHS
> >  * voltage change dance.
> >  *
> >  * Note that low power mode (SDMMC_CLKEN_LOW_PWR) will be
> >  * unconditionally turned back on in dw_mci_setup_bus() if it's
> >  * ever called with a non-zero clock.  That shouldn't happen
> >  * until the voltage change is all done.
> >  */
> >
> > Yuvaraj: can you include that in the next patch set you send out?
> 
> Thanks! Applied for next!
> 
> I took the liberty to change to the clarified comment from Doug above.

This patch casuses a boot hang during regulators initizalization on
Exynos5420 Arndale Octa board.

The kernel config used can was posted in other thread:
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg37210.html

IOW I need to revert both

	"mmc: dw_mmc: Support voltage changes"

and

	"mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"

patches to make next branch of mmc-uh tree work on my setup.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

