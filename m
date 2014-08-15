From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: set_uhs_signaling is initialized twice
 differently
Date: Fri, 15 Aug 2014 13:52:08 +0100
Message-ID: <20140815125208.GA19855@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1408093958-26058-1-git-send-email-peter.griffin@linaro.org>
 <20140815094707.GW30401@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:50535 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaHOMwN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Aug 2014 08:52:13 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so2285970wgh.5
        for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2014 05:52:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140815094707.GW30401@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, zhangfei.gao@marvell.com, prakity@marvell.com, patches@linaro.org, lee.jones@linaro.org

Hi Russell,

> > This happened in
> > commit 96d7b78cfc2f ("mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function")
> > commit a702c8abb2a9 ("mmc: host: split up sdhci-pxa, create sdhci-pxav3.c")'
> 
> This is exactly why named initialisers should always follow the
> declaration order in the structure definition.
> 
> It also helps avoid git merge to properly resolve two additions of
> the same member (possibly with a conflict) rather than just adding
> both.

Ah yes that makes a lot of sense. I will send a V2 in a moment, as the line I
removed now means that it's not in order with the structure definition.

regards,

Peter.
