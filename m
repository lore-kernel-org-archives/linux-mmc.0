From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH V3 0/8 RESEND] Add password protected lock/unlock support
 for SD/MMC
Date: Thu, 30 Jul 2015 16:26:52 -0400
Message-ID: <CAOGqxeVAUHYzgZmax4vq-VovufZ5EKvpA+PWFa=-C87Xn1hK4A@mail.gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
	<CAPDyKFrhHLykG5xSfo204Yh-z4-8RAhkh5S40Gb--4HkQ6KS9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f65.google.com ([209.85.215.65]:36597 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbG3U0x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jul 2015 16:26:53 -0400
Received: by lafd3 with SMTP id d3so2395227laf.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2015 13:26:52 -0700 (PDT)
In-Reply-To: <CAPDyKFrhHLykG5xSfo204Yh-z4-8RAhkh5S40Gb--4HkQ6KS9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Petri Gynther <pgynther@google.com>

On Tue, Jul 21, 2015 at 10:04 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Al,
>
> Let me start by apologizing for the long delay in feedback.
>
> On 5 June 2015 at 19:42, Al Cooper <alcooperx@gmail.com> wrote:
>> This set of patches adds support for password protected locking
>> and unlocking of MMC and SD devices. It uses the LOCK/UNLOCK command
>> (CMD42) available in both the MMC and SD command sets.
>>
>> Some of this code was based on a patch set submitted in 2006 by
>> Anderson Briglia "Add MMC Password Protection (lock/unlock)". This
>> patch set never made it into mainline.
>
> I lot have happened since 2006 and I don't know the history to why
> this was rejected. Was it just that nobody cares to review it or
> something else?

It was never rejected, it just didn't get enough review interest.

>>
>> By default, a card with no password assigned is always in "unlocked"
>> state. After password assignment, in the next power cycle the card
>> switches to a "locked" state where only the "basic" and "lock card"
>> command classes are accepted by the card. Only after unlocking it with
>> the correct password can the card be used for normal operations like
>> block I/O.
>>
>> Password management and caching is done through the "Kernel Key
>> Retention Service" mechanism and the sysfs filesystem. Two new sysfs
>> attributes were added. The "lock" attribute is used to lock, unlock,
>> assign a password, clear a password and force erase a card. The
>> "unlock_retry" attribute is used to retry an unlock that failed
>> during boot because the rootfs was not yet available with the password.
>
> The rootfs issue makes this a bit complicated to handle. I think this
> can be simplified, perhaps by allowing user-space to trigger a
> mmc_rescan() to be run for a particular mmc host.

The "unlock_retry" attribute in sysfs allows user-space to trigger an
unlock retry
for a locked card.

>
> From a power management point of view I think that would be preferred,
> as else you might be leaving a locked card powered forever.
>

Since a locked device is allowed to come up partially, all the power management
seems to work correctly. I tested suspend and verified that the power to the SD
card was turned off. This should also allow the eMMC SLEEP_AWAKE command
(CMD5) to work on locked eMMC devices.


>>
>> The user space software needed to test this new feature
>> is available on GitHub at:
>> https://github.com/alcooper/mmc-password-utils
>> See the README for a detailed description of the user space layer
>> and how to use this feature.
>
> Really nice that you maintain such utility. If this feature enters
> mainline, it would nice to merge this into Chris' mmc-utils.

I agree and Chris has recently accepted other features I've added to mmc-utils.

>
> This is just an initial review and before I spend more time going into
> the details, I want to understand *why* we want this feature. Could
> you elaborate on what use cases you see and whether you already know
> someone actively using this?

The reason I added this functionality is for the Settop Box industry. There's a
trend to use SD cards for Time-Shift-Buffering of video and it's nice
to be able to
lock the card to prevent the SD card and it's video from being used in another
system. There are a few very big Settop Box companies interested in doing this.
SanDisk is now creating a special class of SD card, called a Video Buffer Card,
with extended write cycles just for this purpose. SanDisk is also extending the
CMD42 (LOCK_UNLOCK) command and expects to have the extensions in the
next version of the SD Physical Layer Specification.

The other use would be to allow a user to password protect their SD card to keep
sensitive information safe.


As far as others currently using the patches, I got the following
email last year:

| Y Garcia <ygarcia@imagikcorp.com>
|
| 6/19/14
| to me
|
| Hi Alan,
|
| I successful built the kernel with SD/MMC lock support and I also
included keyutils package in rootfs but now I need
|
| a user space script or helper example to deal with password and
"keyutil" utility.
|
| Can you be so kind to once again give me a hint on this regard?
|
| I've been study/searching without any luck.
|
|
| Regards,
|
| Thanks in advance for your support.
|
| Yamil.

I also got an email about 2 years ago asking if it was OK to use the
my first version of the patchset, but I can't find the email.

Also, the last patch in the set I submitted was from  from Abbas Raza
<Abbas_Raza@mentor.com> who must be doing something with the patches
to have found the issue.

>
> From a code quality point of view, it overall looks okay, but let me
> get back to the details once we discussed the above a bit.
>
> Moreover, I would like to encourage other MMC developers to give there
> overall opinion about this feature.
>
> Kind regards
> Uffe

Thanks.
Al
