From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] mmc: omap_hsmmc: release correct resource
Date: Fri, 20 Apr 2012 15:23:07 -0700
Message-ID: <20120420222305.GI21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36689 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab2DTWXJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Apr 2012 18:23:09 -0400
Content-Disposition: inline
In-Reply-To: <E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

* Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
> res can be one of several resources, as this variable is re-used several
> times during probe.  This can cause the wrong resource parameters to be
> passed to release_mem_region().
> 
> Get the original memory resource before calling release_mem_region().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
