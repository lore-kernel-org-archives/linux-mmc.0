From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: zoom: wl1271 slot is MMC_CAP_POWER_OFF_CARD
Date: Mon, 6 Dec 2010 15:50:41 -0800
Message-ID: <20101206235041.GT8345@atomide.com>
References: <1290815964-30088-1-git-send-email-ohad@wizery.com>
 <20101128023924.GA6019@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63437 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0LFXut (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 18:50:49 -0500
Content-Disposition: inline
In-Reply-To: <20101128023924.GA6019@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Luciano Coelho <luciano.coelho@nokia.com>

* Chris Ball <cjb@laptop.org> [101127 18:29]:
> Hi,
> 
> On Sat, Nov 27, 2010 at 01:59:24AM +0200, Ohad Ben-Cohen wrote:
> > This patch complements ed919b0 "mmc: sdio: fix runtime PM anomalies by
> > introducing MMC_CAP_POWER_OFF_CARD" by declaring MMC_CAP_POWER_OFF_CARD
> > on the ZOOM's wl1271 mmc slot.
> > 
> > This is required in order not to break runtime PM support for the wl1271
> > sdio driver.
> > 
> > Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> 
> Looks good.  Tony, feel free to take this for .37 through your tree.
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>

OK will merge thanks.

Tony
