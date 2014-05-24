From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: adding aliases to mmc ... again
Date: Sat, 24 May 2014 07:10:25 +0200
Message-ID: <20140524051025.GH15686@pengutronix.de>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
 <537E22E3.3010601@wwwdotorg.org>
 <20140522182134.GD15686@pengutronix.de>
 <537E4EAF.5000309@wwwdotorg.org>
 <20140523092359.GG15686@pengutronix.de>
 <537F70F1.8010608@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaEXFK3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 24 May 2014 01:10:29 -0400
Content-Disposition: inline
In-Reply-To: <537F70F1.8010608@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de

On Fri, May 23, 2014 at 10:01:53AM -0600, Stephen Warren wrote:
> On 05/23/2014 03:23 AM, Sascha Hauer wrote:
> ...
> > Speaking of which my preferred solution is another one. As a bootloader
> > developer it really annoys me that I don't have the possibility to tell
> > the kernel to boot a particular device. What I really want to do is to
> > pass a devicetree phandle to the kernel for the rootfs (Or a device path
> > for the EFI/ACPI guys). This would solve a whole lot of problems here.
> 
> Why not implement a root= kernel cmdline option that provides exactly that?

That's the plan, yes. This will take some time though. To make this work
we'll need bindings devices which are normally autoprobable (MMC, USB).
UBI would need a binding. We'll need bindings for DOS/GPT partitions.
I expect some opposition there...
At least for USB bindings already exist that just have to be
implemented.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
