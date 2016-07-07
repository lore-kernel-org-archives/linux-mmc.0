From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH V3 0/8] Add password protected lock/unlock support for
 SD/MMC
Date: Thu, 7 Jul 2016 01:15:25 +0000
Message-ID: <HK2PR06MB0548B827206958C00CD2EDCDD83B0@HK2PR06MB0548.apcprd06.prod.outlook.com>
References: <1432077074-8422-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:16157 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751186AbcGGBPb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jul 2016 21:15:31 -0400
In-Reply-To: <1432077074-8422-1-git-send-email-alcooperx@gmail.com>
Content-Language: ja-JP
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "pgynther@google.com" <pgynther@google.com>

Hi,

> From: Al Cooper
> Sent: Wednesday, May 20, 2015 8:11 AM
> To: ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; pgynther@google.com
> Cc: Al Cooper <alcooperx@gmail.com>
> Subject: [PATCH V3 0/8] Add password protected lock/unlock support for SD/MMC

This patch set is quite old, but do you have any update for upstreaming of this patch set?
Our team would like to use this function on our platform.
So, if possible, we would like to apply this function on upstream.

Best regards,
Yoshihiro Shimoda

> This set of patches adds support for password protected locking
> and unlocking of MMC and SD devices. It uses the LOCK/UNLOCK command
> (CMD42) available in both the MMC and SD command sets.
> 
> Some of this code was based on a patch set submitted in 2006 by
> Anderson Briglia "Add MMC Password Protection (lock/unlock)". This
> patch set never made it into mainline.
> 
> By default, a card with no password assigned is always in "unlocked"
> state. After password assignment, in the next power cycle the card
> switches to a "locked" state where only the "basic" and "lock card"
> command classes are accepted by the card. Only after unlocking it with
> the correct password can the card be used for normal operations like
> block I/O.
> 
> Password management and caching is done through the "Kernel Key
> Retention Service" mechanism and the sysfs filesystem. Two new sysfs
> attributes were added. The "lock" attribute is used to lock, unlock,
> assign a password, clear a password and force erase a card. The
> "unlock_retry" attribute is used to retry an unlock that failed
> during boot because the rootfs was not yet available with the password.
> 
> The user space software needed to test this new feature
> is available on GitHub at:
> https://github.com/alcooper/mmc-password-utils
> See the README for a detailed description of the user space layer
> and how to use this feature.
> 
> Changed for V3:
>   - Ported the V2 patch set submitted Aug. 2013 to the latest mainline
>     (v4.1-rc4).
>   - Created a GitHub project for the user space layer.
>   - Change the lock command (CMD42) to round up the data buffer
>     size to 512 for SD but leave exact size for eMMC based on the
>     SD and eMMC specs.
> 
> 
> Changed for V2:
> The V2 changes were not functional and were just general cleanup.
>   - Use stub functions to reduce the number of CONFIG ifdefs.
>   - Add static to a few functions that were local.
>   - Use pr_warn instead of pr_warning.
>   - Improve a few variable names and messages.
> 
> 
> Abbas Raza (1):
>   According to SD Physical Layer Specifications: Locked cards respond to
>     (and execute) all commands in the "basic" command class (class 0),
>     ACMD41, CMD16 and "lock card" command class. Thus, the host is
>     allowed to reset, initialize, select, query for status, etc., but
>     not to access data on the card.
> 
> Al Cooper (7):
>   mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
>   mmc: lock: Add low level LOCK_UNLOCK command
>   mmc: lock: Add function to unlock a password locked card
>   mmc: lock: Add card lock/unlock maintenance commands
>   mmc: lock: Change SD init functionality to handle locked SD cards
>   mmc: lock: Prevent partition table read for locked cards.
>   mmc: lock: Change MMC init to handle locked cards.
> 
>  drivers/mmc/card/block.c   |  14 ++++
>  drivers/mmc/core/Kconfig   |   8 +++
>  drivers/mmc/core/core.c    | 120 +++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h    |  14 +++-
>  drivers/mmc/core/mmc.c     | 123 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.c | 150 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.h |  13 ++++
>  drivers/mmc/core/sd.c      | 161 +++++++++++++++++++++++++++++++--------------
>  include/linux/mmc/card.h   |   6 ++
>  9 files changed, 560 insertions(+), 49 deletions(-)
> 
> --
> 1.9.0.138.g2de3478
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
