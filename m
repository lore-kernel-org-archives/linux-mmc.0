From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: omap_hsmmc: sdio: issue with generic wakeup IRQ handling
Date: Thu, 25 Feb 2016 03:02:50 +0530
Message-ID: <CAC3a_SDH3zspEAUHkGN0qCBKQZBdnhmei2Rqw2Md=7R2iXostA@mail.gmail.com>
References: <20160218182750.GA5948@c50.bag.software> <CALtMJEBdXLef8AJ1-8Txmg2iS413bVV7cpQSb+nL5M7jN_QYzw@mail.gmail.com>
 <20160219141135.GA14354@c50.bag.software>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34810 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbcBXVdM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2016 16:33:12 -0500
In-Reply-To: <20160219141135.GA14354@c50.bag.software>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org

Hi,

On Fri, Feb 19, 2016 at 7:41 PM, Vishal Thanki <vishalthanki@gmail.com> wrote:
> Hi Andreas,
>
> On Thu, Feb 18, 2016 at 10:31:04PM +0100, Andreas Fenkart wrote:
>> Hi Vishal,
>>
>> I remember there was a problem with IRQ, but can't remember on top of
>> my head. Meanwhile this might be some pointer:
>>
>> diff --git a/drivers/net/wireless/mwifiex/sta_ioctl.c
>> b/drivers/net/wireless/mwifiex/sta_ioctl.c
>> index a6c8a4f..67587c2 100644
>> --- a/drivers/net/wireless/mwifiex/sta_ioctl.c
>> +++ b/drivers/net/wireless/mwifiex/sta_ioctl.c
>> @@ -517,6 +517,17 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
>>         adapter->hs_enabling = true;
>>         mwifiex_cancel_all_pending_cmd(adapter);
>>
>> +       /* if the MMC host is already in suspend it will not detect SDIO irq
>> +        * and we might run into response timeout. By claiming the MMC host we
>> +        * wake it up, which is sufficient to detect a pending IRQ
>> +        */
>> +       {
>> +               struct sdio_mmc_card *card = adapter->card;
>> +               sdio_claim_host(card->func);
>> +               printk("+++ poll mmc host for IRQ +++\n");
>> +               sdio_release_host(card->func);
>> +       }
>> +
>>         if (mwifiex_set_hs_params(mwifiex_get_priv(adapter,
>>                                                    MWIFIEX_BSS_ROLE_STA),
>>                                   HostCmd_ACT_GEN_SET, MWIFIEX_SYNC_CMD,
>
> I tried this code change but that did not help. I saw that the code
> change is in a function called mwifiex_enable_hs(), which only gets
> invoked by mwifiex_sdio_suspend(); which is why I think it is not having
> any effect. Because when I run the command to scan the channel list
> (i.e. iw dev wlan0 scan), the system is not in suspend state. And I
> noticed (by adding prints in omap_hsmmc.c for suspend and resume
> callbacks) that during the "scan" command, the suspend routine gets invoked
> for HSMMC but it never gets resumed (may be due to the missed wakeup
> IRQ) from mwifiex and the command times out.
>

Is there any other suggestion for mwifiex that I should try out? Or
is there any way in omap_hsmmc to specify the wakeup interrupt
type (IRQF_TRIGGER_LOW) while using generic wakeup IRQ
mechanism. I could not find it, but I may be missing something.

Thanks,
Vishal

> Thanks for your help.
>
> Vishal
>
>
>>
>> 2016-02-18 19:27 GMT+01:00 Vishal Thanki <vishalthanki@gmail.com>:
>> > Hi,
>> >
>> > On a custom built am335x based board, I am facing an issue mwifiex wifi
>> > module which is connected to host via SDIO interface. I am using kernel
>> > version 4.4.
>> >
>> > The problem is related to the wifi "ext_scan" command getting timed out
>> > over SDIO. This was working with old kernel (v4.0), but does not work on
>> > kernel v4.4. I found the following commit is responsible for this
>> > behavior.
>> >
>> > =================================
>> > 5b83b2234be6733cfe22036c38031b2c890b3db8
>> >
>> > mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq
>> >
>> > We can now use generic wakeirq handling and remove the custom handling
>> > for the wake-up interrupts.
>> > =================================
>> >
>> > There is no wifi issue if I revert the above mentioned commit on kernel
>> > v4.4.
>> >
>> > I see that before this commit, the wakeup IRQ handler was registered
>> > within the omap_hsmmc.c itself with additional IRQF_TRIGGER_LOW flag.
>> > But with the introduction to dev_pm_set_dedicated_wake_irq(), the
>> > generic wakeup IRQ handler is registered which does not take the
>> > IRQF_TRIGGER flag. I am not sure if that is the issue, but I added that
>> > IRQF_TRIGGER_LOW flag in dev_pm_set_dedicated_wake_irq() while
>> > registering a threaded IRQ handler, I could see the problem disappears.
>> > However, this change is causing the infinite interrupts because the of
>> > level triggered interrupt is not handled in generic wakeup IRQ handling
>> > code (as it was done specially in omap_hsmmc.c code earlier).
>> >
>> > I am not much familiar with MMC/SDIO driver and I am not sure how to fix
>> > this behavior. So any guidance would be really helpful.
>> >
>> > Thanks,
>> > Vishal
