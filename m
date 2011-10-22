From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Sat, 22 Oct 2011 06:32:32 -0400
Message-ID: <m24nz171vj.fsf@bob.laptop.org>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49660 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab1JVKcq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Oct 2011 06:32:46 -0400
In-Reply-To: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	(Andrei Warkentin's message of "Fri, 21 Oct 2011 18:44:36 -0700
	(PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org

Hi,

(Andrei, looks like your mails are being hard line wrapped around 100 cols.)

On Fri, Oct 21 2011, Andrei Warkentin wrote:
> What does power locking do that force_ro currently doesn't achieve?

The power-lock is used to go read only until the next time power is
reset, even if the kernel later asks for r/w.  This is used on some
devices such as the HTC Desire Z/G2 as a security mechanism -- the
bootloader switches to power r/o just before running the kernel, so
the kernel itself can't modify the boot kernel image.

.. except it can, because the G2 hackers worked out how to glitch the
eMMC's power rail using a kernel module that hits a GPIO, making it come
out of r/o, and managed to make the MMC layer cope with the device
needing reinit without crashing userspace.  But you get the idea.

> The permalocking brick-potential (more like paper-weight-potential) is
> IMO unacceptably high that something like this is just accessible via
> a sysfs attribute. This is exactly why the boot partitions were put
> under force_ro, so that some poor sap wouldn't end up nuking the boot
> partitions (with obvious consequences), and permalocking seems even
> nastier.

I agree.  Does anyone have an argument for including either of these?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
