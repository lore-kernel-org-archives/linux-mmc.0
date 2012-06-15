From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 14:04:45 +0530
Message-ID: <CAKLKtzc6WQnhXur-jpWHpRWguyMWsTU1o9zbn-39M8Y+ot8HrA@mail.gmail.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com>
	<CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com>
	<CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com>
	<CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com>
	<CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com>
	<CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com>
	<4FDAE2CD.6090703@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62576 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2FOIeq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 04:34:46 -0400
Received: by gglu4 with SMTP id u4so2101406ggl.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jun 2012 01:34:45 -0700 (PDT)
In-Reply-To: <4FDAE2CD.6090703@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "patches@linaro.org" <patches@linaro.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, Per FORLIN <per.forlin@stericsson.com>

On 15 June 2012 12:52, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> On 06/15/2012 05:49 AM, Saugata Das wrote:
>>
>> On 15 June 2012 00:36, Per Forlin<per.lkml@gmail.com> =A0wrote:
>>>
>>> Hi Saugata,
>>>
>>> I can have a go and test it. But first I would like to bring up 3
>>> concerns that I have with this patch.
>>>
>>> 1. This patch should be sent to cc-stable in order to repair the bu=
g
>>> introduced in 3.4
>>
>>
>> I shall sent it out today.
>>
>>> 2. Is the bus_ops for poweroff_notify really necessary since only m=
mc
>>> use it?
>>
>>
>> This was recommended in the review from Ulf. If it is not adding to =
a
>> bug, I propose to keep it this way. Otherwise, we will be going in
>> circles :-)
>
>
> Moreover it seems close related to sleep, which is implemented with b=
us_ops.
> So I would say, keep as is. We might change later, then both sleep an=
d
> poweroff_notify together.
>
>>
>>> There are already bus_ops for suspend/resume,
>>> power_save/power_restore and remove. It feels like it would be
>>> possible to address poweroff_notify internally from mmc.c from thes=
es
>>> bus_ops. I would be nice to add this feature without having to touc=
h
>>> core.c.
>>>
>>> For instance. Call mmc_suspend() from mmc_remove()
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1302,7 +1302,7 @@ static void mmc_remove(struct mmc_host *host)
>>> + =A0 =A0 =A0 __mmc_suspend(host, true);
>>> =A0 =A0 =A0 =A0mmc_remove_card(host->card);
>>>
>>> @@ -1347,7 +1347,7 @@ static void mmc_detect(struct mmc_host *host)
>>> -static int mmc_suspend(struct mmc_host *host)
>>> +static int __mmc_suspend(struct mmc_host *host, bool remove)
>>>
>>> @@ -1356,7 +1356,8 @@ static int mmc_suspend(struct mmc_host *host)
>>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>> =A0 =A0 =A0 =A0if (mmc_can_poweroff_notify(host->card)&&
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_POWER_OFF_V=
CCQ_DURING_SUSPEND)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_POWER_OFF_V=
CCQ_DURING_SUSPEND ||
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remove)) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_poweroff_notify(host, MM=
C_PW_OFF_NOTIFY_SHORT);
>>> =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_card_can_sleep(host))
>>>
>>> @@ -1372,6 +1373,11 @@ static int mmc_suspend(struct mmc_host *host=
)
>>> +static int mmc_suspend(struct mmc_host *host)
>>> +{
>>> + =A0 =A0 =A0 return __mmc_suspend(host, false);
>>> +}
>>> +
>>>
>>> Calling mmc_suspend from mmc_remove() has another advantage since i=
t
>>> may issue SLEEP (CMD5) before the card is removed and power off. Th=
is
>>> is recommended by eMMC Vendors in order to shutdown the eMMC safely=
 to
>>> prevent data corruption. When the platform shuts down the power to =
the
>>> eMMC will be turned off no matter what.
>>
>>
>> May be for MMC-4.41 cards this approach can be taken. For MMC-4.5, i=
t
>> has to be power OFF notify when the power is removed. Lets do it for
>> another patch, since the intention of this patch is to fix the issue=
s
>> around power OFF notify.
>
>
> I agree with you Saugata, the exact same sequence as in suspend can n=
ot be
> used. The reason is simply that we do not want to consider
> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND for doing poweroff_notify here=
, as we
> want in suspend.
>
> Leave this to be fixed in a separate patch instead.
>
>
>>
>>>
>>> 3. About the sleep and awake issue. This is not really related to
>>> poweroff_notify() as I see it. I would recommend to use CMD 0 to
>>> re-init the card safely after sleep in this patch. Then you could s=
end
>>> out a sleep/awake patch that address this separately. =A0This would=
 also
>>> make #1 easier, send patch to cc-stable. Adding save/restore IOS is=
 a
>>> new feature and should not be sent to the cc-stable list. What do y=
ou
>>> think?
>>
>>
>> The problem in sending CMD0 without power OFF notify is possibility =
of
>> some data loss in MMC-4.5 devices.
>
>
> I don't see the problem here. You will be sending power OFF notify wh=
en you
> can. The only difference is when you "wake" the device from sleep mod=
e.
> Instead of using CMD5, which may work is some cases and in some cases=
 not
> (without restoring ios). So using CMD0 as common way of waking up fro=
m
> suspend should be fine. Unless I missed something of course. :-)
>

CMD0 is a reset. I expect with power OFF notify enable, the eMMC
device will postpone some control information update to its internal
non-volatile memory (e.g. some data structures which are kept in the
controller buffers and not stored in NAND). If we do a CMD0, then the
eMMC device will be reset and we may lose some data. In addition to
that, doing complete card initialization will increase the wakeup time
(for 4.4 devices).

Till now, we have done complete card initialization during resume and
not done a real resume. I am not sure, if this patch is exposing some
host drivers issue now. So, please check the drivers as well.


> Kind regards
> Ulf Hansson
