From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: add runtime pm support
Date: Sat, 15 Oct 2011 22:26:06 -0400
Message-ID: <m262jpekox.fsf@bob.laptop.org>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
	<1317645214-12316-3-git-send-email-adrian.hunter@intel.com>
	<m2aa91eoe6.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47681 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1JPC0M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 15 Oct 2011 22:26:12 -0400
In-Reply-To: <m2aa91eoe6.fsf@bob.laptop.org> (Chris Ball's message of "Sat, 15
	Oct 2011 21:06:09 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Sat, Oct 15 2011, Chris Ball wrote:
> Card insertion detection after boot no longer works (nothing new appears
> in dmesg), so I'm unable to use the reader.  Are you able to try to
> figure this out?  I'm happy to try any patches you suggest.

If I boot with a card inserted, I still see repeated "irq while runtime
suspended" messages for 80 seconds after boot, but the card *does* work.
I don't see further "irq while runtime suspended" messages during or
after I/O to the card at that point.

So, we have a problem of unexpected irqs while runtime suspended, and a
problem of broken card detection when booted without a card inserted
(on my laptop).

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
