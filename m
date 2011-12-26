From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend
 operations
Date: Mon, 26 Dec 2011 10:35:17 +0530
Message-ID: <4EF8008D.5060502@linaro.org>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4ED4F4C4.2020805@samsung.com> <87zkfckvve.fsf@laptop.org> <loom.20111219T110819-762@post.gmane.org> <m239c9z8mk.fsf@bob.laptop.org> <4EF7D3DE.5060907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42442 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1LZFFX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Dec 2011 00:05:23 -0500
Received: by iaeh11 with SMTP id h11so18336718iae.19
        for <linux-mmc@vger.kernel.org>; Sun, 25 Dec 2011 21:05:22 -0800 (PST)
In-Reply-To: <4EF7D3DE.5060907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org

Hi Jaehoon,

On 12/26/2011 07:24 AM, Jaehoon Chung wrote:
> Hi Tushar.
>
> I also tested this patch with Samsung-SoC.
> But i didn't find the below message
> "mmc0: Timeout waiting for hardware interrupt."
>
When the primary filesystem is on SD/MMC card, I need to select 
following config options for the system to go to sleep. Is it in anyway 
the reason of conflict?

CONFIG_MMC_UNSAFE_RESUME=y

I modified my test-case to use a ramdisk instead and use a script to 
mount/unmount the filesystem on MMC card. In that case also I get the 
above error for some time - around 30s. After that, it behaves normally 
(mounting/unmounting etc.)

$ echo mem > /sys/power/state
[   18.825000] PM: Syncing filesystems ... done.
[   18.830000] Freezing user space processes ... (elapsed 0.00 seconds) 
done.
[   18.835000] Freezing remaining freezable tasks ... (elapsed 0.01 
seconds) done.
[   18.855000] Suspending console(s) (use no_console_suspend to debug)
[   18.865000] wake enabled for irq 292
[   18.865000] wake enabled for irq 301
[   18.865000] wake enabled for irq 302
[   18.865000] wake enabled for irq 303
[   18.865000] wake enabled for irq 304
[   18.865000] wake enabled for irq 305
[   18.890000] PM: suspend of devices complete after 26.491 msecs
[   18.890000] PM: late suspend of devices complete after 0.829 msecs
[   18.890000] Disabling non-boot CPUs ...
[   18.895000] IRQ80 no longer affine to CPU1
[   18.895000] CPU1: shutdown
[   18.895000] Enabling non-boot CPUs ...
[   18.905000] CPU1: Booted secondary processor
[   18.905000] Calibrating delay loop (skipped) already calibrated this CPU
[   18.905000] CPU1: Unknown IPI message 0x1
[   18.905000] CPU1 is up
[   18.905000] PM: early resume of devices complete after 0.745 msecs
[   18.910000] s3c-i2c s3c2440-i2c.0: slave address 0x10
[   18.910000] s3c-i2c s3c2440-i2c.0: bus frequency set to 97 KHz
[   18.910000] usb usb1: root hub lost power or was reset
[   18.935000] wake disabled for irq 301
[   18.935000] wake disabled for irq 302
[   18.935000] wake disabled for irq 303
[   18.935000] wake disabled for irq 304
[   18.935000] wake disabled for irq 305
[   18.935000] wake disabled for irq 292
[   19.070000] PM: resume of devices complete after 160.084 msecs
[   19.180000] Restarting tasks ... done.
/ $ [   29.200000] mmc0: Timeout waiting for hardware interrupt.
[   39.220000] mmc0: Timeout waiting for hardware interrupt.
[   49.240000] mmc0: Timeout waiting for hardware interrupt.
[   59.260000] mmc0: Timeout waiting for hardware interrupt.
[   59.260000] mmc0: card e624 removed
[   59.330000] mmc0: new SDHC card at address e624
[   59.335000] mmcblk0: mmc0:e624 SD04G 3.69 GiB
[   59.340000]  mmcblk0: p1

> I didn't understand what is that differ with previously code?
> (just using dev_pm_ops..)
>

I could not find any dev_pm_ops related implementation in sdhci-s3c.c. 
Are there some other patches that I am missing on v3.2-rc6? Or any 
specific config settings that I need for this to be working?

> Thanks,
> Jaehoon Chung
>
> On 12/25/2011 11:29 AM, Chris Ball wrote:
>
>> Hi,
>>
>> On Mon, Dec 19 2011, Tushar Behera wrote:
>>>>>> Now that the driver is using dev_pm_ops the suspend operations in the
>>>>>> platform_driver structure won't get called so don't need to be there,
>>>>>> and certainly shouldn't be the same function as dev_pm_ops since the
>>>>>> signatures are different.
>>>>>>
>>>>>> Signed-off-by: Mark Brown<broonie<at>  opensource.wolfsonmicro.com>
>>>
>>> On Origen board (based on EXYNOS4210), the primary filesystem is on a
>>> SD/MMC card. When tested with v3.2-rc6 kernel, the system doesn't resume
>>> properly.
>>>
>>> After resume, it keeps printing following message and the filesystem never
>>> comes up.
>>>
>>> mmc0: Timeout waiting for hardware interrupt.
>>>
>>> If this patch is reverted, the system is able to mount the filesystem
>>> successfully.
>>>
>>> Am I missing something?
>>
>> Mark/Jaehoon?  This looks very bad.
>
>>
>> - Chris.
>
>


-- 
Tushar Behera
