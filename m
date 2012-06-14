From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Thu, 14 Jun 2012 20:45:51 +0530
Message-ID: <CAKLKtzemhRFjtd6RK_XYzo2fwyGRvoDN=TmB=A4LLQJcPcKwNg@mail.gmail.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAFEEs1=nTZpc1WOhg1RFBNSwg5R-QqryDEr=VwHbNgEY8Vj1Fg@mail.gmail.com>
	<CAGxe1ZHvv5gNi05nO4g5dRmjUprmbGMipJeQbxavwrC=UEQ1Xg@mail.gmail.com>
	<CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51624 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2FNPPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 11:15:51 -0400
Received: by yenl2 with SMTP id l2so999945yen.19
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jun 2012 08:15:51 -0700 (PDT)
In-Reply-To: <CAPDyKFrg68zsH4NZ-nLscLX67=Uws9boKHzjSZwb77sntaf7AQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Per Forlin <per.lkml@gmail.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, ulf.hansson@stericsson.com, subhashj@codeaurora.org, per.forlin@stericsson.com

On 14 June 2012 20:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Girish,
>
> On 14 June 2012 15:21, Girish K S <girish.shivananjappa@linaro.org> w=
rote:
>> On 14 June 2012 18:43, Per Forlin <per.lkml@gmail.com> wrote:
>>> Hi Girish and Suagata,
>>>
>>> I have run some regression tests with this patch on our board (ux50=
0
>>> family) running suspend and resume of the eMMC 4.41 device.
>>>
>>> The two patches I have looked at are:
>>> 1. "mmc: core: Fix PowerOff Notify suspend/resume" (merged)
>>> 2. " MMC-4.5 Power OFF Notify Rework"
>>>
>>> With only patch #1 the eMMC doesn't power up after in resume() afte=
r
>>> being suspended. The eMMC doesn't respond at all after suspend. It'=
s
>>> not powered up.
>>> Running tests with #1 and #2, the card is powered up but it doesn't
>>> wake up after CMD5. Commands that arrive are after resume/CMD5
>>> timeouts. I even tried by increasing the awake timeout to 5 seconds
>>> but i didn't help.
>>>
>>> The eMMC on my board successfully suspends and resumes with patch #=
1
>>> and #2 if waking up the card using CMD0 (mmc_card_init()) instead o=
f
>>> CMD5.
>>>
>>> Have anyone else seen the same issue?
>>> Have this patch been verified on a board together with eMMC 4.41 th=
at
>>> supports card power off.
>> This rework patch is still under progress. we are modifying it. In o=
ur
>> earlier discussions subhash has posted the
>> same issue and a solution for this. =A0we should save ios context be=
fore
>> sleep and restore ios before awake. soon rework patch will be
>> posted with the above recomenedded solution.
>>
>
> I think the best solution is to always do mmc_card_init when doing
> resume, it will be nice a simple.

Note that, with power OFF notify (MMC-4.5), there will be some pending
operation with the MMC controller. If we do mmc_card_init after
suspend, then there could be some data loss.

I  have passed to Per the latest patch (Subhash reported that it is
working). I shall forward to you as well. Lets solve the issue. If you
can work around, without mmc_card_init after suspend, then you are
most welcome to update the patch :-)


> Otherwise it will be somewhat tricky to keep track of what state we
> are in, and if the ios should be restored or not.
>
> Finally, I would be glad to help out in posting an updated version of
> this patch, if that OK with you?
>
> Kind regards
> Ulf Hansson
