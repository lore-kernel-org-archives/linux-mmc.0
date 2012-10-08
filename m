From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Mon, 8 Oct 2012 09:31:02 +0200
Message-ID: <CAPDyKFpNCw9PKExfJ52uK5Vm7K6xfn+KTigwD78cx-SYy4A6VA@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<87r4pcg8x6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53853 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab2JHHbF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Oct 2012 03:31:05 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2377754wey.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Oct 2012 00:31:03 -0700 (PDT)
In-Reply-To: <87r4pcg8x6.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On 5 October 2012 18:50, Chris Ball <cjb@laptop.org> wrote:
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
> Thanks, I've merged this now.  I've got an eMMC 4.5 sample on the way
> to me, I'll help out with making sure that suspend/resume is tested.
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

Sounds great! Thanks for helping out! Juts ping me if you need some
further assistance around this.

Myself is also waiting for a eMMC 4.5 device, should probably show up
this week. I will try to test it as soon as I can.

Kind regards
Ulf Hansson
