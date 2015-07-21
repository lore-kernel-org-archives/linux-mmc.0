From: Suneel G <suneelgarapati@gmail.com>
Subject: Re: [PATCH V3 0/8 RESEND] Add password protected lock/unlock support
 for SD/MMC
Date: Tue, 21 Jul 2015 21:22:42 +0530
Message-ID: <CAOZ77oherV7nmw6Kuir0YzNCuJNEb91y5PRkWpoP1n4=NiGtGA@mail.gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com> <CAPDyKFrhHLykG5xSfo204Yh-z4-8RAhkh5S40Gb--4HkQ6KS9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34651 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809AbbGUPxX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 11:53:23 -0400
Received: by oigd21 with SMTP id d21so84544085oig.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 08:53:22 -0700 (PDT)
In-Reply-To: <CAPDyKFrhHLykG5xSfo204Yh-z4-8RAhkh5S40Gb--4HkQ6KS9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Al Cooper <alcooperx@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Petri Gynther <pgynther@google.com>

Hi Ulf Hansson,

One use case is whenever any host controller tries for specification
compliance or certification, there are defined test cases for each
spec version.
If mmc/sd subsystem can validate most of them, if not all, out of
tree, it would be of great advantage for users.

I have performed recently this compliance testing for v3.0 host spec
and found some features missing like lock/unlock, register
programming, erase etc.

These patches should defintely help linux get compliant atleast for SD
Host Spec.

Defined Host Controller Test Specification is available from SD Card
Association. www.sdcard.org

Hope this helps,

Regards,
Suneel

On Tue, Jul 21, 2015 at 7:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
>
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
>
> From a power management point of view I think that would be preferred,
> as else you might be leaving a locked card powered forever.
>
>>
>> The user space software needed to test this new feature
>> is available on GitHub at:
>> https://github.com/alcooper/mmc-password-utils
>> See the README for a detailed description of the user space layer
>> and how to use this feature.
>
> Really nice that you maintain such utility. If this feature enters
> mainline, it would nice to merge this into Chris' mmc-utils.
>
>>
>> Changed for V3:
>>   - Ported the V2 patch set submitted Aug. 2013 to the latest mainline
>>     (v4.1-rc4).
>>   - Created a GitHub project for the user space layer.
>>   - Change the lock command (CMD42) to round up the data buffer
>>     size to 512 for SD but leave exact size for eMMC based on the
>>     SD and eMMC specs.
>>
>>
>> Changed for V2:
>> The V2 changes were not functional and were just general cleanup.
>>   - Use stub functions to reduce the number of CONFIG ifdefs.
>>   - Add static to a few functions that were local.
>>   - Use pr_warn instead of pr_warning.
>>   - Improve a few variable names and messages.
>>
>>
>> Abbas Raza (1):
>>   According to SD Physical Layer Specifications: Locked cards respond to
>>     (and execute) all commands in the "basic" command class (class 0),
>>     ACMD41, CMD16 and "lock card" command class. Thus, the host is
>>     allowed to reset, initialize, select, query for status, etc., but
>>     not to access data on the card.
>>
>> Al Cooper (7):
>>   mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
>>   mmc: lock: Add low level LOCK_UNLOCK command
>>   mmc: lock: Add function to unlock a password locked card
>>   mmc: lock: Add card lock/unlock maintenance commands
>>   mmc: lock: Change SD init functionality to handle locked SD cards
>>   mmc: lock: Prevent partition table read for locked cards.
>>   mmc: lock: Change MMC init to handle locked cards.
>>
>>  drivers/mmc/card/block.c   |  14 ++++
>>  drivers/mmc/core/Kconfig   |   8 +++
>>  drivers/mmc/core/core.c    | 120 +++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/core.h    |  14 +++-
>>  drivers/mmc/core/mmc.c     | 123 ++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/mmc_ops.c | 150 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/mmc_ops.h |  13 ++++
>>  drivers/mmc/core/sd.c      | 161 +++++++++++++++++++++++++++++++--------------
>>  include/linux/mmc/card.h   |   6 ++
>>  9 files changed, 560 insertions(+), 49 deletions(-)
>>
>> --
>> 1.9.0.138.g2de3478
>>
>
> This is just an initial review and before I spend more time going into
> the details, I want to understand *why* we want this feature. Could
> you elaborate on what use cases you see and whether you already know
> someone actively using this?
>
> From a code quality point of view, it overall looks okay, but let me
> get back to the details once we discussed the above a bit.
>
> Moreover, I would like to encourage other MMC developers to give there
> overall opinion about this feature.
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
