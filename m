From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/3] mmc: add a card-event host call-back
Date: Fri, 7 Dec 2012 21:42:01 +0800
Message-ID: <20121207134158.GA30468@S2100-06.ap.freescale.net>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:57673
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030216Ab2LGNPQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 08:15:16 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

On Tue, Dec 04, 2012 at 04:51:28PM +0100, Guennadi Liakhovetski wrote:
> In a recent thread [1] an extension to the slot-gpio MMC API, adding a 
> host call-back for card detection events, has been proposed. This 
> extension shall be used by the SDHCI driver to reset the host if the card 
> is ejected during a running request. These patches add such a call-back.
> 
For the series,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

