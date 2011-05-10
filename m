From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Tue, 10 May 2011 22:36:30 +0200
Message-ID: <20110510203629.GB8726@opensource.wolfsonmicro.com>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
 <20110509202325.GD16919@n2100.arm.linux.org.uk>
 <20110509203612.GC21323@opensource.wolfsonmicro.com>
 <20110510220214.916621d1.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51200 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751137Ab1EJUgZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2011 16:36:25 -0400
Content-Disposition: inline
In-Reply-To: <20110510220214.916621d1.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

On Tue, May 10, 2011 at 10:02:14PM +0200, Antonio Ospite wrote:

> So, I am going to remove the ifdefs anyway but use IS_ERR_OR_NULL();
> how does that sound? Am I still missing anything?

Looks good to me.

> Or changing the regulator_get() stub to return an error (-ENOSYS?) might
> be worth it?

No, the whole point of stubbing out the API is that it allows most
consumers which just do simple enables and disables to run without
needing to worry if the regulator API is compiled in or not.
