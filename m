From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/8 RESEND] Add password protected lock/unlock support
 for SD/MMC
Date: Tue, 25 Aug 2015 14:04:37 +0200
Message-ID: <CAPDyKFqMKJaY_=QMx_jmb=fiFv+Xwqiqj8XMvmOf3e8_J_Lf5Q@mail.gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
	<CAPDyKFrhHLykG5xSfo204Yh-z4-8RAhkh5S40Gb--4HkQ6KS9A@mail.gmail.com>
	<CAOGqxeVAUHYzgZmax4vq-VovufZ5EKvpA+PWFa=-C87Xn1hK4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36466 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbbHYMEi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:04:38 -0400
Received: by iodv127 with SMTP id v127so182978975iod.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:04:37 -0700 (PDT)
In-Reply-To: <CAOGqxeVAUHYzgZmax4vq-VovufZ5EKvpA+PWFa=-C87Xn1hK4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Petri Gynther <pgynther@google.com>

[...]

>>
>> I lot have happened since 2006 and I don't know the history to why
>> this was rejected. Was it just that nobody cares to review it or
>> something else?
>
> It was never rejected, it just didn't get enough review interest.

Okay, I will do my best to make sure we get consensus in how to proceed then.

[...]

>>
>> The rootfs issue makes this a bit complicated to handle. I think this
>> can be simplified, perhaps by allowing user-space to trigger a
>> mmc_rescan() to be run for a particular mmc host.
>
> The "unlock_retry" attribute in sysfs allows user-space to trigger an
> unlock retry
> for a locked card.
>
>>
>> From a power management point of view I think that would be preferred,
>> as else you might be leaving a locked card powered forever.
>>
>
> Since a locked device is allowed to come up partially, all the power management
> seems to work correctly. I tested suspend and verified that the power to the SD
> card was turned off. This should also allow the eMMC SLEEP_AWAKE command
> (CMD5) to work on locked eMMC devices.

I see your point, I just feel it's becoming complex and fragile.
Still, it seems this feature is important also for non-removable cards
and these are only enumerated once during the boot.

I need to think a bit more on this.

[...]

>>
>> This is just an initial review and before I spend more time going into
>> the details, I want to understand *why* we want this feature. Could
>> you elaborate on what use cases you see and whether you already know
>> someone actively using this?
>
> The reason I added this functionality is for the Settop Box industry. There's a
> trend to use SD cards for Time-Shift-Buffering of video and it's nice
> to be able to
> lock the card to prevent the SD card and it's video from being used in another
> system. There are a few very big Settop Box companies interested in doing this.
> SanDisk is now creating a special class of SD card, called a Video Buffer Card,
> with extended write cycles just for this purpose. SanDisk is also extending the
> CMD42 (LOCK_UNLOCK) command and expects to have the extensions in the
> next version of the SD Physical Layer Specification.
>
> The other use would be to allow a user to password protect their SD card to keep
> sensitive information safe.
>
>
> As far as others currently using the patches, I got the following
> email last year:
>
> | Y Garcia <ygarcia@imagikcorp.com>
> |
> | 6/19/14
> | to me
> |
> | Hi Alan,
> |
> | I successful built the kernel with SD/MMC lock support and I also
> included keyutils package in rootfs but now I need
> |
> | a user space script or helper example to deal with password and
> "keyutil" utility.
> |
> | Can you be so kind to once again give me a hint on this regard?
> |
> | I've been study/searching without any luck.
> |
> |
> | Regards,
> |
> | Thanks in advance for your support.
> |
> | Yamil.
>
> I also got an email about 2 years ago asking if it was OK to use the
> my first version of the patchset, but I can't find the email.
>
> Also, the last patch in the set I submitted was from  from Abbas Raza
> <Abbas_Raza@mentor.com> who must be doing something with the patches
> to have found the issue.
>

Thanks for the info. I am okay going forward with this patchset,
though I think it's a bit late (my fault) for 4.3. Could you perhaps
repost once 4.3 rc1 is out!?

Kind regards
Uffe
