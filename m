From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT 03/11] mmc: omap_hsmmc: remove private DMA API
 implementation
Date: Thu, 7 Jun 2012 10:04:58 -0700
Message-ID: <20120607170456.GF12766@atomide.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17207 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab2FGRFC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jun 2012 13:05:02 -0400
Content-Disposition: inline
In-Reply-To: <E1ScaYb-0003tZ-Pb@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [120607 04:11]:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
