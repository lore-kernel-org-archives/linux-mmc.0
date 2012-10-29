From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 29 Oct 2012 17:49:22 -0400
Message-ID: <87vcdtosnx.fsf@octavius.laptop.org>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
	<20121015103725.GQ21164@n2100.arm.linux.org.uk>
	<20121015104456.GR21164@n2100.arm.linux.org.uk>
	<87txtdq90y.fsf@octavius.laptop.org>
	<20121029214307.GH21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53386 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933029Ab2J2Vt1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 17:49:27 -0400
In-Reply-To: <20121029214307.GH21164@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 29 Oct 2012 21:43:07 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,

On Mon, Oct 29 2012, Russell King - ARM Linux wrote:
> Anyway, here's a replacement patch, updated against my cubox tree but
> lacking the cubox gpio changes for it.  Un-tested through: (a) I can't
> test this on its own on the cubox, (b) I don't have a separate dove
> tree to test it against and my disk space is all but out at the moment
> for yet another build tree...

Compile-tested and pushed to mmc-next, and I'll submit it for 3.7 if
I get a Tested-by from someone like Sebastian (CC'd), or for 3.8 if I
don't.  (I'll add sdhci-pltfm API rework to my TODO list, too.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
