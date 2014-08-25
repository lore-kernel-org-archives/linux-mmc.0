From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/3] mmc: dw_mmc: Support voltage changes
Date: Mon, 25 Aug 2014 10:31:14 +0200
Message-ID: <CAPDyKFo4fEppn21ani_p_t2Z-hhafAFRVSA2nPr9fed3iS8Q_A@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<1408715272-13833-3-git-send-email-yuvaraj.cd@samsung.com>
	<CAPDyKFrATFrvVNmrt8bxrKZ_4Wea00R7VUKvyJQp-FQUTJghsA@mail.gmail.com>
	<CAD=FV=WAKXV4MuqybN4ypA+2tr1m6CP6=9_O+sYYe_-GYiy7SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WAKXV4MuqybN4ypA+2tr1m6CP6=9_O+sYYe_-GYiy7SA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2014 22:38, Doug Anderson <dianders@google.com> wrote:
> Ulf,
>
> On Fri, Aug 22, 2014 at 8:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>> From: Doug Anderson <dianders@chromium.org>
>>>
>>> For UHS cards we need the ability to switch voltages from 3.3V to
>>> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
>>> dw_mmc needs a little bit of extra code since the interface needs a
>>> special bit programmed to the CMD register while CMD11 is progressing.
>>> This means adding a few extra states to the state machine to track.
>>>
>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> ---
>>> changes since v1:
>>>         1. Added error message and return error in case of regulator_set_voltage() fail.
>>>         2. changed  dw_mci_cmd_interrupt(host,pending | SDMMC_INT_CMD_DONE)
>>>            to dw_mci_cmd_interrupt(host,pending).
>>>         3. Removed unnecessary comments.
>>>
>>>  drivers/mmc/host/dw_mmc.c  |  134 +++++++++++++++++++++++++++++++++++++++++---
>>>  drivers/mmc/host/dw_mmc.h  |    5 +-
>>>  include/linux/mmc/dw_mmc.h |    2 +
>>>  3 files changed, 131 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index aadb0d6..f20b4b8 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -29,6 +29,7 @@
>>>  #include <linux/irq.h>
>>>  #include <linux/mmc/host.h>
>>>  #include <linux/mmc/mmc.h>
>>> +#include <linux/mmc/sd.h>
>>>  #include <linux/mmc/sdio.h>
>>>  #include <linux/mmc/dw_mmc.h>
>>>  #include <linux/bitops.h>
>>> @@ -234,10 +235,13 @@ err:
>>>  }
>>>  #endif /* defined(CONFIG_DEBUG_FS) */
>>>
>>> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
>>> +
>>>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>>  {
>>>         struct mmc_data *data;
>>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>>> +       struct dw_mci *host = slot->host;
>>>         const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>>         u32 cmdr;
>>>         cmd->error = -EINPROGRESS;
>>> @@ -253,6 +257,31 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>>>         else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>>>                 cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>>>
>>> +       if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>>> +               u32 clk_en_a;
>>> +
>>> +               /* Special bit makes CMD11 not die */
>>> +               cmdr |= SDMMC_CMD_VOLT_SWITCH;
>>> +
>>> +               /* Change state to continue to handle CMD11 weirdness */
>>> +               WARN_ON(slot->host->state != STATE_SENDING_CMD);
>>> +               slot->host->state = STATE_SENDING_CMD11;
>>> +
>>> +               /*
>>> +                * We need to disable clock stop while doing voltage switch
>>> +                * according to Voltage Switch Normal Scenario.
>>> +                * It's assumed that by the next time the CLKENA is updated
>>> +                * (when we set the clock next) that the voltage change will
>>> +                * be over, so we don't bother setting any bits to synchronize
>>> +                * with dw_mci_setup_bus().
>>> +                */
>>
>> I don't know the details about the dw_mmc controller, but normally a
>> host driver is expected to gate the clock from it's ->set_ios
>> callback, when the clk frequency are set to 0.
>>
>> Could you elaborate on why dw_mmc can't do that, but need to handle
>> this from here?
>
> Let's see, it's been a while since I wrote this...
>
>
> So dw_mmc has a special feature where the controller itself will
> automatically stop the MMC Card clock when nothing is going on.  This
> is called "low power" mode.  I'm not super familiar with other MMC
> drivers, I get the impression that this is a special dw_mmc feature
> and not common to other controllers.  I think other drivers have
> aggressive runtime PM to get similar power savings.

I see.

I am familiar with such "low power" mode features, there are certainly
other controllers supporting such as well. My experience tells me,
it's hard to get things right for all corner cases. The voltage switch
behaviour is just one of these, then you have SDIO irq etc.

Instead of using the controller HW, yes you may implement clock gating
through runtime PM in the host driver.

>
> The dw_mmc auto clock gating can wreck total havoc on the voltage
> change procedure, since part of the way that the host and card
> communicate is that the host is supposed to stop its clock when it
> gets to a certain phase of the voltage switch sequence.  If the
> controller is stopping the clock for us then it can confuse the card.
>
> The dw_mmc manual says that before starting a voltage change you must
> turn off low power mode.  That's what we're doing here.
>
>
> The comment above refers to the fact dw_mci_setup_bus() will
> unconditionally turn low power mode back on for us when called with a
> non-zero clock.  If dw_mci_setup_bus() might be called with a non-zero
> clock during the voltage change then this would be disaster (low power
> mode would be back on!).  ...but the clock will always be zero during
> the voltage change and when it's finally non-zero then it's the last
> stage of the voltage change and we can go back to low power mode.
>
>
> Possibly the above was not super clear from the comment (even for
> those familiar with the oddities of dw_mmc).  If you want me to try to
> rewrite the comment, let me know.

I appreciate an updated comment, it's nice to know what goes on. :-)

Kind regards
Uffe
