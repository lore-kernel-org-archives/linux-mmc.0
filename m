From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap mmc: extended to pass host capabilities from
 board file
Date: Thu, 23 Sep 2010 16:08:20 -0700
Message-ID: <20100923230819.GS4211@atomide.com>
References: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50970 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0IWXIV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 19:08:21 -0400
Content-Disposition: inline
In-Reply-To: <1284562163-2828-1-git-send-email-s-ghorai@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Sukumar Ghorai <s-ghorai@ti.com> [100915 07:41]:
>   wires variable is renamed, extended and this single variable to be used to
>   pass the platform capabilities, e.g DDR mode. Also removed the hardcoded
>   value was using as bus-width.

This looks like a nice clean-up, I'll queue this via the omap
patches.

Regards,

Tony
