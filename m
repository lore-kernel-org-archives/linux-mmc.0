From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Thu, 4 Oct 2012 13:46:02 +0200
Message-ID: <CAPDyKFr4jny9E7u7vD1O-ULVv1qQC8GQXU_D+ja3vca+SwGRTQ@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<87k3v7i7zk.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43577 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab2JDLqF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Oct 2012 07:46:05 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so4132074wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Oct 2012 04:46:03 -0700 (PDT)
In-Reply-To: <87k3v7i7zk.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

Hi Chris,

On 3 October 2012 23:03, Chris Ball <cjb@laptop.org> wrote:
> Hi Ulf,
>
> On Thu, Sep 13 2012, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> This patch fixup the broken suspend sequence for eMMC
>> with sleep support. Additionally it reworks the eMMC4.5
>> Power Off Notification feature so it fits together with
>> the existing sleep feature.
>>
>> The CMD0 based re-initialization of the eMMC at resume
>> is re-introduced to maintain compatiblity for devices
>> using sleep.
>>
>> A host shall use MMC_CAP2_POWEROFF_NOTIFY to enable the
>> Power Off Notification feature. We might be able to
>> remove this cap later on, if we think that Power Off
>> Notification always is preferred over sleep, even if the
>> host is not able to cut the eMMC VCCQ power.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> CC: Girish K S <girish.shivananjappa@linaro.org>
>> CC: Asutosh Das <asutoshd@codeaurora.org>
>
> I gave this patch a try on a board with an eMMC 4.41, but it didn't
> resolve the crash that I see.  After applying the patch, I still see:
>
> [   25.191917] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> [   25.319299] mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
> [   25.335054] PM: Device d4281000.sdhci failed to suspend: error -110
> [   25.341461] PM: Some devices failed to suspend
>
> and the suspend aborts.  If I modify mmc_card_can_sleep() to always
> return false, the suspend completes without errors, so I know that
> something in the sleep code is responsible for my crash.

This patch restores the sequence for how the sleep sequence is
executed, before the poweroff notify patches was merged at all.
So in principle I guess the problem for sdhci has been there for quite
a while, unless some patch in the sdhci driver has screwed something
up recently.

>
> Any suggestions?  Perhaps it's a different bug in the eMMC sleep code.

Well, actually there is not so much that can be wrong in the sleep
code in the protocol layer. I believe we need to debug the sdhci
driver, to see what happens during the suspend operation instead.

The sleep code from the protocol layer is requesting sdhci to run a
request (sleep cmd and "deselect" cmd). This request is not data
requests but cmd requests. Due to the prints from you log it indicates
that sdhci believes that there are an ongoing data request to handle.
This is not the case, so I think the sdhci has screwed up something.

Although, I am not an sdhci expert, so just guessing. :-)

Kind regards
Ulf Hansson
