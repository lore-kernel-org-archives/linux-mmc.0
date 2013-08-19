From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci: request irq after sdhci_init() is called
Date: Mon, 19 Aug 2013 09:58:17 +0100
Message-ID: <20130819085817.GR23006@n2100.arm.linux.org.uk>
References: <1373006335-31239-1-git-send-email-shawn.guo@linaro.org> <20130819083357.GA26883@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41958 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3HSI60 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 04:58:26 -0400
Content-Disposition: inline
In-Reply-To: <20130819083357.GA26883@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Mon, Aug 19, 2013 at 04:33:59PM +0800, Shawn Guo wrote:
> Hi Chris,
> 
> Can you please queue this patch for 3.12?

I already reported this months ago - it's caused because the SDHCI
initialization code is broken.  It plays at separating out the
"alloc+init" from the "add" but doesn't get it right, because it does
a whole swathe of initialisation at the "add" stage.

This pretty much makes it impossible to use the generic GPIO slot detect
stuff with SDHCI, and why I have no motivation what so ever to convert
the dove sdhci support over to the generic GPIO stuff.

SDHCI basically needs its initialisation stuff rewritten to conform to
the "get everything initialised at alloc time" approach.
