From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
 bindings
Date: Tue, 20 Sep 2011 12:07:31 -0600
Message-ID: <20110920180731.GL7781@ponder.secretlab.ca>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
 <201109201943.29510.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61798 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1ITSHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 14:07:35 -0400
Content-Disposition: inline
In-Reply-To: <201109201943.29510.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>, nicolas.pitre@linaro.org, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tue, Sep 20, 2011 at 07:43:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 September 2011, Stephen Warren wrote:
> > The bindings were recently updated to have separate properties for each
> > type of GPIO. Update the Device Tree source to match that.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > Acked-by: Olof Johansson <olof@lixom.net>
> > ---
> > I'd previously sent these to Grant assuming they'd go in his dt/next branch,
> > but perhaps these should go in through Arnd's arm-soc next/dt branch?
> > 
> 
> Which tree has the update that changed the bindings? I think it should
> go into the same one.
> 
> If it's already upstream, I can take it into the fixes branch.

Already upstream

g.

