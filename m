From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Wed, 24 Nov 2010 17:35:16 +0000
Message-ID: <20101124173516.GA24487@void.printf.net>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com> <20101119214002.GA19272@void.printf.net> <20101119215333.GB19272@void.printf.net> <20101120123553.GA11936@pengutronix.de> <20101120182423.GA31030@void.printf.net> <06A44983-1A70-4715-86AF-66C08DD381C0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40624 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab0KXRfU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Nov 2010 12:35:20 -0500
Content-Disposition: inline
In-Reply-To: <06A44983-1A70-4715-86AF-66C08DD381C0@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Philip,

On Sun, Nov 21, 2010 at 11:17:09AM -0800, Philip Rakity wrote:
> a) QUIRK removed for 8 bit support since platform issue - not quirk
> b) platform Flag defined for sdhci-pxa.c and plat-pxa
> c) comments added to sdhci.c on usage

Thanks very much, I'll plan on sending this to Linus tomorrow, along
with the rest of my .37 queue, unless there are any more review
comments from anyone.

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=15ec44611904be0dcc97b84c29fbf964e5e2b36f

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
