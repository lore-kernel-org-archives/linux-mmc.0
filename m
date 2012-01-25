From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/31] ARM: amba: realview: get rid of private platform
	amba_device initializer
Date: Wed, 25 Jan 2012 10:22:02 +0000
Message-ID: <20120125102202.GU16726@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk> <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk> <20120124160044.GM19798@mudshark.cambridge.arm.com> <20120124162328.GA8517@n2100.arm.linux.org.uk> <20120124172600.GO19798@mudshark.cambridge.arm.com> <20120124214531.GB8517@n2100.arm.linux.org.uk> <20120125095800.GC21709@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60946 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2AYKWo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2012 05:22:44 -0500
Content-Disposition: inline
In-Reply-To: <20120125095800.GC21709@mudshark.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>

On Wed, Jan 25, 2012 at 09:58:00AM +0000, Will Deacon wrote:
> Sure. Which branch shall I take it against (before or after your amba
> changes)?

If it's before them, we can think about putting it in as a fix during
this -rc independently of the rest of the changes.  If it's after,
then it'll probably add a conflict.

So, it'll be much easier to have it before, and I'll update what's
necessary in the amba branch.
