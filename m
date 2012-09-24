From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci: sdio wakeup and free_irq
Date: Mon, 24 Sep 2012 00:47:56 -0400
Message-ID: <m38vc0do1v.fsf@pullcord.laptop.org>
References: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
	<m3d31cdrvk.fsf@pullcord.laptop.org>
	<CADz5_gJm8P=azzTsLUOJUeWo_d=vry2WFKWH93yYExVUpXYFPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54740 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183Ab2IXErK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Sep 2012 00:47:10 -0400
In-Reply-To: <CADz5_gJm8P=azzTsLUOJUeWo_d=vry2WFKWH93yYExVUpXYFPQ@mail.gmail.com>
	(Kevin Liu's message of "Mon, 24 Sep 2012 12:21:36 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Sep 24 2012, Kevin Liu wrote:
> So if the irq is disabled, then system can't be woken up.

You're assuming that the host controller IRQ is the method used to wake
up the system, but I just told you that the SDIO data line in 1-bit mode
should be used to wake up the system.  I don't know of any systems
where the host controller IRQ is used.

On the systems that I know about (e.g. MMP2, MMP3) there's an interrupt
controller and a wakeup controller (PMU).  You need to configure your
wakeup controller to pay attention to the card's data line (*not* the
host controller's interrupt line) to wake the system.  It doesn't matter
that the host controller's interrupt line is being freed, because it's
not how the system gets woken up.

After the PMU wakes us up, we re-register the IRQ line and handle
the pending IRQ there.  But the IRQ line itself isn't what wakes us.

e.g.:

#define WLAN_1BIT_MODE_IRQ 39
unsigned long mfpr;

mfpr = mfp_read(WLAN_1BIT_MODE_IRQ);
if (mmc_card_wake_sdio_irq(host->mmc))
{
        mfpr &= ~(MFPR_EDGE_CLEAR|MFPR_EDGE_RISE);
        mfpr |= MFPR_EDGE_FALL;
        mfpr |= MFPR_PULLUP_EN;
}
mfp_write(WLAN_1BIT_MODE_IRQ, mfpr);

Which platform are you working on?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
