From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: sdhci: sdio wakeup and free_irq
Date: Mon, 24 Sep 2012 13:54:43 +0800
Message-ID: <CADz5_g+NO1gdbfLZgqy4DYdjHZb+Wv40iFSXPDtG8a5bZz0S6Q@mail.gmail.com>
References: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
	<m3d31cdrvk.fsf@pullcord.laptop.org>
	<CADz5_gJm8P=azzTsLUOJUeWo_d=vry2WFKWH93yYExVUpXYFPQ@mail.gmail.com>
	<m38vc0do1v.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34954 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2IXFyo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 01:54:44 -0400
Received: by wgbfm10 with SMTP id fm10so2491598wgb.1
        for <linux-mmc@vger.kernel.org>; Sun, 23 Sep 2012 22:54:43 -0700 (PDT)
In-Reply-To: <m38vc0do1v.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi, Chris

2012/9/24 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Mon, Sep 24 2012, Kevin Liu wrote:
>> So if the irq is disabled, then system can't be woken up.
>
> You're assuming that the host controller IRQ is the method used to wake
> up the system, but I just told you that the SDIO data line in 1-bit mode
> should be used to wake up the system.  I don't know of any systems
> where the host controller IRQ is used.
>
> On the systems that I know about (e.g. MMP2, MMP3) there's an interrupt
> controller and a wakeup controller (PMU).  You need to configure your
> wakeup controller to pay attention to the card's data line (*not* the
> host controller's interrupt line) to wake the system.  It doesn't matter
> that the host controller's interrupt line is being freed, because it's
> not how the system gets woken up.
>
> After the PMU wakes us up, we re-register the IRQ line and handle
> the pending IRQ there.  But the IRQ line itself isn't what wakes us.
>
> e.g.:
>
> #define WLAN_1BIT_MODE_IRQ 39
> unsigned long mfpr;
>
> mfpr = mfp_read(WLAN_1BIT_MODE_IRQ);
> if (mmc_card_wake_sdio_irq(host->mmc))
> {
>         mfpr &= ~(MFPR_EDGE_CLEAR|MFPR_EDGE_RISE);
>         mfpr |= MFPR_EDGE_FALL;
>         mfpr |= MFPR_PULLUP_EN;
> }
> mfp_write(WLAN_1BIT_MODE_IRQ, mfpr);
>
> Which platform are you working on?

I'm working on MMP3 now and I ever worked on MMP2.
MMP2 used IO edge detect irq (23) to wake up sysem and the wake up
source is set to GPIO. In fact the pin is DATA 1 pin of SDIO rather
than a GPIO pin but MMP2 implement it as this.
MMP3 delete the IO edge detect irq and we use a true GPIO rather than
the DATA 1 pin to wake up system. It seems you still use MMC DAT1 pin
on MMP3 to wake up system. Then which irq do you use to wake up
system? Because MMP3 need both wake up source and irq to wake up
system.

And I think both MMP2 and MMP3 didn't fully fulfill the MMC wake up
methodology (MMC irq is not used to wake up system). I heard the SOC
will improve this on further version, which means MMC/DAT1 and MMC irq
will be used to wake up system. I'm afraid current code can't work
then.

Thanks
Kevin
