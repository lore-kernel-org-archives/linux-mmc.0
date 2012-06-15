From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Fri, 15 Jun 2012 09:19:45 +0530
Message-ID: <CAKLKtze-TtrC89hbyQn3KcyBRdiMMTJdeo5899tddioqOJxp1w@mail.gmail.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com>
	<CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com>
	<CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com>
	<CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com>
	<CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39084 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2FODtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 23:49:46 -0400
Received: by gglu4 with SMTP id u4so1999318ggl.19
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jun 2012 20:49:45 -0700 (PDT)
In-Reply-To: <CAFEEs1=Ft5pM4NZbA3xUgRwqbY=ycz4ChJ35OLtY_fyRHVk1ww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, ulf.hansson@stericsson.com, subhashj@codeaurora.org, per.forlin@stericsson.com

On 15 June 2012 00:36, Per Forlin <per.lkml@gmail.com> wrote:
> Hi Saugata,
>
> I can have a go and test it. But first I would like to bring up 3
> concerns that I have with this patch.
>
> 1. This patch should be sent to cc-stable in order to repair the bug
> introduced in 3.4

I shall sent it out today.

> 2. Is the bus_ops for poweroff_notify really necessary since only mmc
> use it?

This was recommended in the review from Ulf. If it is not adding to a
bug, I propose to keep it this way. Otherwise, we will be going in
circles :-)

> There are already bus_ops for suspend/resume,
> power_save/power_restore and remove. It feels like it would be
> possible to address poweroff_notify internally from mmc.c from theses
> bus_ops. I would be nice to add this feature without having to touch
> core.c.
>
> For instance. Call mmc_suspend() from mmc_remove()
> +++ b/drivers/mmc/core/mmc.c
> @@ -1302,7 +1302,7 @@ static void mmc_remove(struct mmc_host *host)
> + =A0 =A0 =A0 __mmc_suspend(host, true);
> =A0 =A0 =A0 =A0mmc_remove_card(host->card);
>
> @@ -1347,7 +1347,7 @@ static void mmc_detect(struct mmc_host *host)
> -static int mmc_suspend(struct mmc_host *host)
> +static int __mmc_suspend(struct mmc_host *host, bool remove)
>
> @@ -1356,7 +1356,8 @@ static int mmc_suspend(struct mmc_host *host)
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> =A0 =A0 =A0 =A0if (mmc_can_poweroff_notify(host->card) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_=
DURING_SUSPEND)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_=
DURING_SUSPEND ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remove)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_poweroff_notify(host, MMC_=
PW_OFF_NOTIFY_SHORT);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_card_can_sleep(host))
>
> @@ -1372,6 +1373,11 @@ static int mmc_suspend(struct mmc_host *host)
> +static int mmc_suspend(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 return __mmc_suspend(host, false);
> +}
> +
>
> Calling mmc_suspend from mmc_remove() has another advantage since it
> may issue SLEEP (CMD5) before the card is removed and power off. This
> is recommended by eMMC Vendors in order to shutdown the eMMC safely t=
o
> prevent data corruption. When the platform shuts down the power to th=
e
> eMMC will be turned off no matter what.

May be for MMC-4.41 cards this approach can be taken. For MMC-4.5, it
has to be power OFF notify when the power is removed. Lets do it for
another patch, since the intention of this patch is to fix the issues
around power OFF notify.

>
> 3. About the sleep and awake issue. This is not really related to
> poweroff_notify() as I see it. I would recommend to use CMD 0 to
> re-init the card safely after sleep in this patch. Then you could sen=
d
> out a sleep/awake patch that address this separately. =A0This would a=
lso
> make #1 easier, send patch to cc-stable. Adding save/restore IOS is a
> new feature and should not be sent to the cc-stable list. What do you
> think?

The problem in sending CMD0 without power OFF notify is possibility of
some data loss in MMC-4.5 devices.


>
> BR
> /Per
>
> On Thu, Jun 14, 2012 at 5:15 PM, Saugata Das <saugata.das@linaro.org>=
 wrote:
>> On 14 June 2012 20:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Hi Girish,
>>>
>>> On 14 June 2012 15:21, Girish K S <girish.shivananjappa@linaro.org>=
 wrote:
>>>> On 14 June 2012 18:43, Per Forlin <per.lkml@gmail.com> wrote:
>>>>> Hi Girish and Suagata,
>>>>>
>>>>> I have run some regression tests with this patch on our board (ux=
500
>>>>> family) running suspend and resume of the eMMC 4.41 device.
>>>>>
>>>>> The two patches I have looked at are:
>>>>> 1. "mmc: core: Fix PowerOff Notify suspend/resume" (merged)
>>>>> 2. " MMC-4.5 Power OFF Notify Rework"
>>>>>
>>>>> With only patch #1 the eMMC doesn't power up after in resume() af=
ter
>>>>> being suspended. The eMMC doesn't respond at all after suspend. I=
t's
>>>>> not powered up.
>>>>> Running tests with #1 and #2, the card is powered up but it doesn=
't
>>>>> wake up after CMD5. Commands that arrive are after resume/CMD5
>>>>> timeouts. I even tried by increasing the awake timeout to 5 secon=
ds
>>>>> but i didn't help.
>>>>>
>>>>> The eMMC on my board successfully suspends and resumes with patch=
 #1
>>>>> and #2 if waking up the card using CMD0 (mmc_card_init()) instead=
 of
>>>>> CMD5.
>>>>>
>>>>> Have anyone else seen the same issue?
>>>>> Have this patch been verified on a board together with eMMC 4.41 =
that
>>>>> supports card power off.
>>>> This rework patch is still under progress. we are modifying it. In=
 our
>>>> earlier discussions subhash has posted the
>>>> same issue and a solution for this. =A0we should save ios context =
before
>>>> sleep and restore ios before awake. soon rework patch will be
>>>> posted with the above recomenedded solution.
>>>>
>>>
>>> I think the best solution is to always do mmc_card_init when doing
>>> resume, it will be nice a simple.
>>
>> Note that, with power OFF notify (MMC-4.5), there will be some pendi=
ng
>> operation with the MMC controller. If we do mmc_card_init after
>> suspend, then there could be some data loss.
>>
>> I =A0have passed to Per the latest patch (Subhash reported that it i=
s
>> working). I shall forward to you as well. Lets solve the issue. If y=
ou
>> can work around, without mmc_card_init after suspend, then you are
>> most welcome to update the patch :-)
>>
>>
>>> Otherwise it will be somewhat tricky to keep track of what state we
>>> are in, and if the ios should be restored or not.
>>>
>>> Finally, I would be glad to help out in posting an updated version =
of
>>> this patch, if that OK with you?
>>>
>>> Kind regards
>>> Ulf Hansson
