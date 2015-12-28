From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Mon, 28 Dec 2015 12:47:58 -0600
Message-ID: <1451328478.18314.138.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	 <1450116253.15946.353.camel@freescale.com>
	 <CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
	 <CAPDyKFoYxM4Nv_pHCZbGzuswMCXTLyj6CYgLjYnRguscUs9LrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:52681
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752432AbbL1SsJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Dec 2015 13:48:09 -0500
In-Reply-To: <CAPDyKFoYxM4Nv_pHCZbGzuswMCXTLyj6CYgLjYnRguscUs9LrQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On Thu, 2015-12-17 at 12:30 +0100, Ulf Hansson wrote:
> [...]
> 
> > > 
> > > And I think stubs for reading SVR is quite a bad idea.  It'll make the
> > > driver
> > > build but it will silently not be able to apply SVR-based workarounds.
> > 
> > It doesn't have to be "silent", the driver can return an error (and
> > print error messages) from its ->probe() method, if the calls to the
> > GUTS driver fails.
> > 
> > Anyway, I mentioned this idea only to understand the need for
> > *optional* GUTS supports. Perhaps there is a cross SOC drivers that
> > for some platforms depends on GUTS but on others it doesn't.
> > 
> > Maybe that isn't case then!?
> 
> Can you please answer this question!?
> 
> According to the earlier versions of this patchset and from your
> comments [1], it *do* seems like the GUTS driver may be optional and
> thus stubs could address this.

I'd rather it not be optional at build time for the reason I explained above. 
 It would be too easy for users to accidentally not enable the guts driver and
miss the workaround.  Even if an error is printed it's easy to miss among all
the boot spam -- and if there's any legitimate reason to not have the driver
enabled then why would that be an "error"?  If the guts driver fails to bind
(e.g. running in a VM, or a platform the guts driver doesn't recognize) that's
another matter, but that should be handled by an error check in the guts
driver, not a build-time stub.

-Scott


