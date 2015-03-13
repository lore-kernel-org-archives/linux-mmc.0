From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Add a timeout for sending CMD11
Date: Fri, 13 Mar 2015 13:38:17 -0700
Message-ID: <CAD=FV=VcaW3eG49ASWxVV4YgUjiex77Z4ShJV0RJLYh2FEPMsw@mail.gmail.com>
References: <1425943101-11976-1-git-send-email-dianders@chromium.org>
	<5502C7CB.3010504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34638 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbCMUiS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 16:38:18 -0400
Received: by iecsl2 with SMTP id sl2so124664160iec.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 13:38:17 -0700 (PDT)
In-Reply-To: <5502C7CB.3010504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Addy Ke <addy.ke@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Andrew Bresticker <abrestic@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandru Stan <amstan@chromium.org>

Jaehoon,

On Fri, Mar 13, 2015 at 4:19 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Doug.
>
> This patch is a right process. Just i wonder something.
>
> On 03/10/2015 08:18 AM, Doug Anderson wrote:
>> In the Designware databook's description of the "Voltage Switch Normal
>> Scenario" it instructs us to set a timer and fail the voltage change
>> if we don't see the voltage change interrupt within 2ms.  Let's
>> implement that.  Without implementing this I have often been able to
>> reproduce a hang while trying to send CMD11 on an rk3288-based board
>> while constantly ejecting and inserting UHS cards.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c  | 26 ++++++++++++++++++++++++++
>>  include/linux/mmc/dw_mmc.h |  2 ++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 47dfd0e..d259662 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1020,6 +1020,15 @@ static void __dw_mci_start_request(struct dw_mci *host,
>>
>>       dw_mci_start_command(host, cmd, cmdflags);
>>
>> +     if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>> +             /*
>> +              * Databook says to fail after 2ms w/ no response; give an
>> +              * extra jiffy just in case we're about to roll over.
>> +              */
>> +             mod_timer(&host->cmd11_timer,
>> +                       jiffies + msecs_to_jiffies(2) + 1);
>
> What's "plus one"?

I tried to briefly describe it in the comment above with the "in case
we're about to roll over".  ...but more detail...

* I expect HZ to be something like 100.  ...so a jiffy will be 10ms.
2ms will be rounded up to 1 jiffy.

* It's entirely possible that we're about to roll over jiffies.  That
is, we might make the mod_timer call when we're 1 nanosecond away from
moving from 999 to 1000 jiffies.  We'll still read "jiffies" as 999
and add "msecs_to_jiffies(2)" to get 1000 jiffies.  ...but then it
will roll over and we'll make the call mod_timer(1000) when jiffies is
already 1000.  That means that we really got a 1ns delay--not so good.

...if we add the extra 1 jiffy then we'll probably really delay for
10-20ms, but that should be fine in this case.


If I misunderstood the above, please correct me.

>> +     }
>> +
>>       if (mrq->stop)
>>               host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
>>       else
>> @@ -2158,6 +2167,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>               /* Check volt switch first, since it can look like an error */
>>               if ((host->state == STATE_SENDING_CMD11) &&
>>                   (pending & SDMMC_INT_VOLT_SWITCH)) {
>> +                     del_timer(&host->cmd11_timer);
>> +
>>                       mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
>>                       pending &= ~SDMMC_INT_VOLT_SWITCH;
>>                       dw_mci_cmd_interrupt(host, pending);
>> @@ -2571,6 +2582,18 @@ ciu_out:
>>       return ret;
>>  }
>>
>> +static void dw_mci_cmd11_timer(unsigned long arg)
>> +{
>> +     struct dw_mci *host = (struct dw_mci *)arg;
>> +
>> +     if (host->state != STATE_SENDING_CMD11)
>> +             dev_info(host->dev, "Unexpected CMD11 timeout\n");
>
> If Unexpected CMD11 timeout, can it do  just" return"?
> Well, I think Unexpected CMD11 timeout is an rare case.

Duh, of course.  I'm happy to respin this or I'm happy if you want to
just add a "return;"  Please let me know.

-Doug
