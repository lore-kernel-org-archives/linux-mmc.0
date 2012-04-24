From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API
 implementation
Date: Mon, 23 Apr 2012 17:17:20 -0700
Message-ID: <20120424001719.GF3739@atomide.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47242 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2DXARY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 20:17:24 -0400
Content-Disposition: inline
In-Reply-To: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

* Russell King <rmk+kernel@arm.linux.org.uk> [120423 09:09]:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested on 770, n800, 2430sdp, n900, zoom3 and blaze:

Tested-by: Tony Lindgren <tony@atomide.com>
