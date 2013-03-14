From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] mmc: mxcmmc: add mpc512x SDHC support
Date: Thu, 14 Mar 2013 22:52:57 +0000
Message-ID: <201303142252.57951.arnd@arndb.de>
References: <1363279254-22351-1-git-send-email-agust@denx.de> <1589714.JH7YyAvXz1@wuerfel> <20130314191332.44ca64c9@crub>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50785 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab3CNWxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 18:53:04 -0400
In-Reply-To: <20130314191332.44ca64c9@crub>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thursday 14 March 2013, Anatolij Gustschin wrote:
> I wanted to avoid additional levels of indirection and function calls
> on i.MX. If something like
> 
> static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
> {
> #if IS_ENABLED(CONFIG_PPC_MPC512x)
>         return in_be32(host->base + reg);
> #else
>         return readl(host->base + reg); 
> #endif
> }
> 
> is acceptable, I'll use it.

I think that's ok. A single #ifdef around the four functions might be
nicer though. You could also use ioread32_be on powerpc and write it
like

static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
{
	if (IS_ENABLED(CONFIG_PPC_MPC512x))
		return ioread32_be(host->base + reg);
	else
		return readl(host->base + reg); 
}

> > Does mpc512x have no clock management? I think it should still
> > work without modifications if CONFIG_HAVE_CLK is disabled.
> > In that case, devm_clk_get() will return NULL and we don't
> > error out here.
> 
> It does have some clock management (a platform clock driver) and
> the platform selects CONFIG_HAVE_CLK. But we do not have "ipg"
> and "per" clocks on that platform, but "sdhc_clk" instead.

As Sascha said, they should really use the same name, although it's
possible that neither sdhc_clk nor ipg is a good name here.

	Arnd
