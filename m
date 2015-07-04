From: Paul Mansfield <paul-kernel@mansfield.co.uk>
Subject: Re: mmc driver read/write detect problem with Baytrail tablet
Date: Sat, 4 Jul 2015 18:59:12 +0100
Message-ID: <CAGwpYoeJtM1+iLn6QVrai5D9BWBM5zF-2rHd7EswAZ1dRN-TUA@mail.gmail.com>
References: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
 <CAGwpYoez+2DVLxs6Hd_zqoF7UZ8D_WvrKiPTwvdP-VYxQTnzBQ@mail.gmail.com> <CAOGqxeWzuvrkkdXB9upUFbn_ws7k_hMkFY+RwCN1NBmABd0VfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34571 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbGEKQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jul 2015 06:16:52 -0400
Received: by wifm2 with SMTP id m2so5865309wif.1
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jul 2015 03:16:51 -0700 (PDT)
In-Reply-To: <CAOGqxeWzuvrkkdXB9upUFbn_ws7k_hMkFY+RwCN1NBmABd0VfA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 2 July 2015 at 13:40, Alan Cooper <alcooperx@gmail.com> wrote:
> On Wed, Jul 1, 2015 at 6:11 PM, Paul Mansfield
> <paul-kernel@mansfield.co.uk> wrote:
>> On 1 July 2015 at 14:24, Alan Cooper <alcooperx@.......> wrote:
>>> There is a WRITE PROTECT signal from the card socket to the host
>>> controller that may not be connected. You can try booting the kernel
>>> with "sdhci.debug_quirks=0x10000". This tells the driver that the WP
>>> signal is inverted.
>>
>> thanks.
>> won't that cause the dock's SD card slot to switch from being writable
>> whilst making the internal one writable?

> Yes, that will cause the SD dock to be read-only for read/write cards,
> but this is a quick way to tell if this is the problem.

Ok, I tried the quirks mode kernel option and it solves the problem of
making the microSDHC card slot writable, yay!

Interesting, it didn't break the dock's SDHC card slot and make it
read-only, so I would guess that's connected using a USB bridge; that
comes out as mmcblk2

And neither did it break the eMMC in the tablet, that's writable too,
so again a great result.

Is the "sdhci.debug_quirks" command line flag available without full
debugging on?

Now the only obstacle remaining is that grub can't see the internal
memory card slot, so I guess I will need to have a small boot
partition in the eMMC.

At the moment I've made the tablet triple boot. With rEFInd on the
eMMC's EFI partition and the SDHC card EFI partition, the UEFI
firmware offers me both devices as a boot option. Windows is in the
eMMC, along with a small linux install, then a full install in a
partition in the SDHC card.

Each EFI partitions' grub-efi finds its relevant linux installation
(it seems grub-efi patches the bootable program since the grub menu
and modules lives in the ext4 linux partition).


sorry for the brain dump but I thought it would be useful for anyone
else treading this
