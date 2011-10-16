From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Sat, 15 Oct 2011 21:06:09 -0400
Message-ID: <m2aa91eoe6.fsf@bob.laptop.org>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
	<1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35176 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab1JPBGT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 15 Oct 2011 21:06:19 -0400
In-Reply-To: <1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 3 Oct 2011 15:33:34 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Oct 03 2011, Adrian Hunter wrote:
> Ths patch allows runtime PM for sdhci-pci, runtime suspending
> after inactivity of 50ms and ensuring runtime resume before
> SDHC registers are accessed.  During runtime suspend, interrupts
> are masked.  The host controller state is restored at runtime
> resume.
>
> For Medfield, the host controller's card detect mechanism
> is supplanted by an always-on GPIO which provides for card
> detect wake-up.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Running linux-next on an x86 ThinkPad W510 with Ricoh 1180:e832 reader,
I get a long string of these messages at boot with no card inserted:

[    7.361614] mmc0: got irq while runtime suspended
[    7.381593] mmc0: got irq while runtime suspended
[    7.401602] mmc0: got irq while runtime suspended
[    7.401617] mmc0: got irq while runtime suspended
[    7.421510] mmc0: got irq while runtime suspended
[    7.421525] mmc0: got irq while runtime suspended

Card insertion detection after boot no longer works (nothing new appears
in dmesg), so I'm unable to use the reader.  Are you able to try to
figure this out?  I'm happy to try any patches you suggest.

The full dmesg, with CONFIG_MMC_DEBUG=y, is available at:
   http://chris.printf.net/sdhci-runtime-pm-dmesg

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
