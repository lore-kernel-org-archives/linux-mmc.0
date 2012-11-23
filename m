From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
Date: Fri, 23 Nov 2012 20:14:27 +0800
Message-ID: <20121123121422.GA26168@S2100-06.ap.freescale.net>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
 <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
 <20121123083117.GA25754@S2100-06.ap.freescale.net>
 <20121123085726.GK5764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:11778
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754959Ab2KWLsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Nov 2012 06:48:18 -0500
Content-Disposition: inline
In-Reply-To: <20121123085726.GK5764@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Nov 23, 2012 at 08:57:26AM +0000, Russell King - ARM Linux wrote:
> Does this work with the sdhci stuff?

Honestly, I'm not sure, but I guess it does, since I have seen
sdhci-pxav3 driver using the helpers.  Anyway, I'm going to adopt
the helpers for sdhci-esdhc-imx driver to find it out.

Shawn

