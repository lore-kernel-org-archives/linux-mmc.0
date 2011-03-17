From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/7] mmc: support sdhci-esdhc-imx as an OF device
Date: Thu, 17 Mar 2011 14:22:38 -0600
Message-ID: <20110317202238.GF12824@angua.secretlab.ca>
References: <1300112759-3495-1-git-send-email-shawn.guo@linaro.org>
 <1300112759-3495-6-git-send-email-shawn.guo@linaro.org>
 <20110315195926.GB20845@angua.secretlab.ca>
 <20110316143915.GE11658@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54546 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab1CQUWm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 16:22:42 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so3200753iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2011 13:22:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316143915.GE11658@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, nicolas.pitre@linaro.org, devicetree-discuss@lists.ozlabs.org, linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org

[cc'ing linux-mmc to continue this discussion]

On Wed, Mar 16, 2011 at 10:39:16PM +0800, Shawn Guo wrote:
> On Tue, Mar 15, 2011 at 01:59:26PM -0600, Grant Likely wrote:
> > On Mon, Mar 14, 2011 at 10:25:57PM +0800, Shawn Guo wrote:
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > dt support can be added directly to sdchi-pltfm.c drivers now.  There
> > is no longer any need to use sdhci-of-core.c any more.  For an
> > example, see the patch titled "of/tegra: add sdhci device tree
> > handling" in my devicetree/test branch.
> > 
> I mentioned this a little bit in the cover letter of the patch set
> as below.
> 
> "This patch set is to support sdhci-esdhc-imx as an OF device.  As
> there is already powerpc based esdhc OF support, it chose to add OF
> support for imx esdhc driver in a different way from what sdhci-tegra
> did."

I should read your descriptions more carefully.  :-)

> The tegra approach you made was one of the two options I had, and I
> happened to love the another more, as it consolidates the eSDHC OF
> driver for Freescale MPCxxx and i.MX family.

Heh, I don't dispute the value of merging code.  However, with this
approach it means that DT and non-DT imx platforms will be using
different drivers for the same device.  Given the choices, I'd
rather see the imx driver used in both DT and non-DT situations
instead of sharing code with the powerpc version.  I've learnt the
hard way that it is just too painful having two drivers for the same
hardware; particularly when the only difference is the method used to
probe them.

Actually, what I'd *really* rather see is the powerpc code migrated
over to sdhci_pltfm.c, and then have the imx compatible value added to
it.  I'll make sure to get some help from the Freescale powerpc folks
to test any patch you produce to that end.

g.

