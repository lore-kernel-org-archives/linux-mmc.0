From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 09:22:53 +0200
Message-ID: <4FDAE2CD.6090703@stericsson.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org> <CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com> <CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com> <CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com> <CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com> <CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com> <CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:44042 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752264Ab2FOHYB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 03:24:01 -0400
In-Reply-To: <CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, Per FORLIN <per.forlin@stericsson.com>

On 06/15/2012 05:49 AM, Saugata Das wrote:
> On 15 June 2012 00:36, Per Forlin<per.lkml@gmail.com>  wrote:
>> Hi Saugata,
>>
>> I can have a go and test it. But first I would like to bring up 3
>> concerns that I have with this patch.
>>
>> 1. This patch should be sent to cc-stable in order to repair the bug
>> introduced in 3.4
>
> I shall sent it out today.
>
>> 2. Is the bus_ops for poweroff_notify really necessary since only mmc
>> use it?
>
> This was recommended in the review from Ulf. If it is not adding to a
> bug, I propose to keep it this way. Otherwise, we will be going in
> circles :-)

Moreover it seems close related to sleep, which is implemented with 
bus_ops. So I would say, keep as is. We might change later, then both 
sleep and poweroff_notify together.

>
>> There are already bus_ops for suspend/resume,
>> power_save/power_restore and remove. It feels like it would be
>> possible to address poweroff_notify internally from mmc.c from theses
>> bus_ops. I would be nice to add this feature without having to touch
>> core.c.
>>
>> For instance. Call mmc_suspend() from mmc_remove()
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1302,7 +1302,7 @@ static void mmc_remove(struct mmc_host *host)
>> +       __mmc_suspend(host, true);
>>         mmc_remove_card(host->card);
>>
>> @@ -1347,7 +1347,7 @@ static void mmc_detect(struct mmc_host *host)
>> -static int mmc_suspend(struct mmc_host *host)
>> +static int __mmc_suspend(struct mmc_host *host, bool remove)
>>
>> @@ -1356,7 +1356,8 @@ static int mmc_suspend(struct mmc_host *host)
>>         mmc_claim_host(host);
>>         if (mmc_can_poweroff_notify(host->card)&&
>> -               (host->caps2&  MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND)) {
>> +               (host->caps2&  MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND ||
>> +                remove)) {
>>                 err = mmc_poweroff_notify(host, MMC_PW_OFF_NOTIFY_SHORT);
>>         } else {
>>                 if (mmc_card_can_sleep(host))
>>
>> @@ -1372,6 +1373,11 @@ static int mmc_suspend(struct mmc_host *host)
>> +static int mmc_suspend(struct mmc_host *host)
>> +{
>> +       return __mmc_suspend(host, false);
>> +}
>> +
>>
>> Calling mmc_suspend from mmc_remove() has another advantage since it
>> may issue SLEEP (CMD5) before the card is removed and power off. This
>> is recommended by eMMC Vendors in order to shutdown the eMMC safely to
>> prevent data corruption. When the platform shuts down the power to the
>> eMMC will be turned off no matter what.
>
> May be for MMC-4.41 cards this approach can be taken. For MMC-4.5, it
> has to be power OFF notify when the power is removed. Lets do it for
> another patch, since the intention of this patch is to fix the issues
> around power OFF notify.

I agree with you Saugata, the exact same sequence as in suspend can not 
be used. The reason is simply that we do not want to consider 
MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND for doing poweroff_notify here, 
as we want in suspend.

Leave this to be fixed in a separate patch instead.

>
>>
>> 3. About the sleep and awake issue. This is not really related to
>> poweroff_notify() as I see it. I would recommend to use CMD 0 to
>> re-init the card safely after sleep in this patch. Then you could send
>> out a sleep/awake patch that address this separately.  This would also
>> make #1 easier, send patch to cc-stable. Adding save/restore IOS is a
>> new feature and should not be sent to the cc-stable list. What do you
>> think?
>
> The problem in sending CMD0 without power OFF notify is possibility of
> some data loss in MMC-4.5 devices.

I don't see the problem here. You will be sending power OFF notify when 
you can. The only difference is when you "wake" the device from sleep 
mode. Instead of using CMD5, which may work is some cases and in some 
cases not (without restoring ios). So using CMD0 as common way of waking 
up from suspend should be fine. Unless I missed something of course. :-)

Kind regards
Ulf Hansson
