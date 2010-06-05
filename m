From: Chris Ball <cjb@laptop.org>
Subject: Re: [Bugme-new] [Bug 16119] New: jmb38x recognized and works only
	if a card is plugged in during boot
Date: Sat, 5 Jun 2010 01:27:31 +0100
Message-ID: <20100605002729.GA15004@void.printf.net>
References: <bug-16119-10286@https.bugzilla.kernel.org/> <20100604162014.7635ca51.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59723 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab0FEA1f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Jun 2010 20:27:35 -0400
Content-Disposition: inline
In-Reply-To: <20100604162014.7635ca51.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, eugene.shalygin@gmail.com

On Fri, Jun 04, 2010 at 04:20:14PM -0700, Andrew Morton wrote:
> hm, I don't know who wold be the appropriate person to look into this. 
> Let's try the mailing list.

Eugene, could you please try adding:

options sdhci debug_quirks=1

to a new file named /etc/modprobe.d/sdhci-quirk.conf and rebooting?
Please include `lspci -n` and `dmesg` output in your reply.

It would also be useful to know whether you see the same problem when 
booting (say) a Fedora 13 livecd, since the link below claims that 
Fedora doesn't share this bug:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/258446

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
