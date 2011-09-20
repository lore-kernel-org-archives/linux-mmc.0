From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
 bindings
Date: Tue, 20 Sep 2011 10:59:33 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B732161E@HQMAIL01.nvidia.com>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
 <201109201943.29510.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:17953 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1ITR7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2011 13:59:46 -0400
In-Reply-To: <201109201943.29510.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Arnd Bergmann wrote at Tuesday, September 20, 2011 11:43 AM:
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

Chris applied them to the mmc-next tree:

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

which appears to be temporarily at:

git://dev.laptop.org/users/cjb/mmc

-- 
nvpublic

