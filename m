From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and
 board data
Date: Thu, 8 Mar 2012 23:51:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203082348200.26656@utopia.booyaka.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-5-git-send-email-rnayak@ti.com> <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com> <20120224184859.GN18185@atomide.com> <20120309054608.647473E0901@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51966 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab2CIGvG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 01:51:06 -0500
In-Reply-To: <20120309054608.647473E0901@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Thu, 8 Mar 2012, Grant Likely wrote:

> Yes, absolutely use separate compatible values.  It is always important
> to be specific as to the silicon implementing the IP.

In that case, it is probably best to use the full chip name in the 
compatible string, e.g., omap2420 or omap2430 rather than just "omap2".  
Particularly in the case of "OMAP3," which is a largely meaningless group 
these days with AM33xx, OMAP34xx, OMAP36xx, and AM3517, many of which are 
quite different from each other...


- Paul
