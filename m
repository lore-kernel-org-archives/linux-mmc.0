From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: query card presence from cd-gpio before asking SDHCI
Date: Mon, 14 Jan 2013 14:05:14 -0500
Message-ID: <87y5fvtwk5.fsf@laptop.org>
References: <1355210622-9753-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42548 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757472Ab3ANTFa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jan 2013 14:05:30 -0500
In-Reply-To: <1355210622-9753-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Tue, 11 Dec 2012 15:23:42 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org

Hi Shawn,

On Tue, Dec 11 2012, Shawn Guo wrote:
> Call mmc_gpio_get_cd() to query card presence from cd-gpio before
> asking SDHCI.  The rationale behind this change is that flag
> SDHCI_QUIRK_BROKEN_CARD_DETECTION is designed for SDHCI controller to
> tell that SDHCI_PRESENT_STATE is broken, and it should be used for this
> case only.  So when cd-gpio is being used, the controller should set
> the flag to tell that SDHCI_PRESENT_STATE is not available.
>
> However, the existing code will skip checking cd-gpio as long as flag
> SDHCI_QUIRK_BROKEN_CARD_DETECTION is set.  Change the querying order
> between cd-gpio and SDHCI to support the rationale above.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
