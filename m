From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: adding aliases to mmc ... again
Date: Fri, 23 May 2014 10:01:53 -0600
Message-ID: <537F70F1.8010608@wwwdotorg.org>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de> <537E22E3.3010601@wwwdotorg.org> <20140522182134.GD15686@pengutronix.de> <537E4EAF.5000309@wwwdotorg.org> <20140523092359.GG15686@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50583 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbaEWQB4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 12:01:56 -0400
In-Reply-To: <20140523092359.GG15686@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de

On 05/23/2014 03:23 AM, Sascha Hauer wrote:
...
> Speaking of which my preferred solution is another one. As a bootloader
> developer it really annoys me that I don't have the possibility to tell
> the kernel to boot a particular device. What I really want to do is to
> pass a devicetree phandle to the kernel for the rootfs (Or a device path
> for the EFI/ACPI guys). This would solve a whole lot of problems here.

Why not implement a root= kernel cmdline option that provides exactly that?
