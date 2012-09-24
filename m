From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci: sdio wakeup and free_irq
Date: Sun, 23 Sep 2012 23:25:19 -0400
Message-ID: <m3d31cdrvk.fsf@pullcord.laptop.org>
References: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36372 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917Ab2IXDYd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Sep 2012 23:24:33 -0400
In-Reply-To: <CADz5_gLLTY6ibBSZCHfYFfJ9Uz15zVu41hm19pQ_FCgBqhsmEw@mail.gmail.com>
	(Kevin Liu's message of "Fri, 21 Sep 2012 17:20:56 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Sep 21 2012, Kevin Liu wrote:
> Can latest code support sdio wakeup?

Yes, it should work.  OLPC has been using it in production with
libertas_sdio for several years.

> I see at last of sdhci_suspend_host, irq will be freed. But if the irq
> is used for wakeup system like sdio wakeup irq? Then system can't be
> woken up.

free_irq() is just removing the handler while the stack is suspended, it
isn't stopping your hardware from waking up the system.  Your hardware
needs to be programmed to wake the system if the SDIO IRQ fires; many
SoCs will do this as long as the SDIO is in 1-bit data width mode (which
doesn't require the card clock to be powered).  We turn on 1-bit mode if
MMC_PM_KEEP_POWER is set in host->pm_flags.

The driver (libertas, mwifiex) is responsible for setting host->pm_flags
if it wants the SDIO to stay powered during the next system suspend.

Once the hardware wakes up the system, we'll register the handler again,
it will fire because the line is still raised, and we'll handle it the
normal way.  The card isn't reinitialized if MMC_PM_KEEP_POWER is set.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
