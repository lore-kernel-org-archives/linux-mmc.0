From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK
Date: Tue, 19 Apr 2011 18:14:44 -0400
Message-ID: <m31v0xq46j.fsf@pullcord.laptop.org>
References: <1303235057-4745-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45379 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab1DSWKe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2011 18:10:34 -0400
In-Reply-To: <1303235057-4745-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	(Mark Brown's message of "Tue, 19 Apr 2011 18:44:17 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, patches@opensource.wolfsonmicro.com, linux-mmc@vger.kernel.org

Hi Mark,

On Tue, Apr 19 2011, Mark Brown wrote:
> Commit 373e6a (mmc: sdhci: R1B command handling + MMC_CAP_ERASE) moved the
> handling of SDHCI_QUIRK_TIMEOUT_USES_SDCLK from sdhci_calc_timeout() to
> sdhci_add_host(). This causes division by zero errors on at least the S3C
> SDHCI controller as the quirk implementation needs host->clock set to work
> but host->clock has not been set when sdhci_add_host() is called.
>
> Fix this by backing out that portion of the change, the clock may vary at
> runtime anyway. It does occur to me that we may want to move the quirk to
> where we set the clock but this seems more invasive and I'm concerned
> about undesirable side effects.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for catching this, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
