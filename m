From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH REPOST 1/2] mmc: tegra: use bus-width property instead
	of support-8bit
Date: Wed, 6 Jun 2012 14:56:47 +0100
Message-ID: <20120606135647.GA3423@void.printf.net>
References: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42408 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803Ab2FFN44 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 09:56:56 -0400
Content-Disposition: inline
In-Reply-To: <1338834755-6900-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Mon, Jun 04, 2012 at 12:32:34PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Update the driver to parse the new unified bus-width property introduced
> in commit 7f21779 "mmc: dt: Consolidate DT bindings", instead of the legacy
> support-8bit property.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Chris, It's probably easiest conflict-wise if I take this through the Tegra
> tree. (Note: When I posted this series before, I said there shouldn't be any
> conflicts if you take them through the MMC tree. That's probably still true,
> but unforseen future conflicts seem more likely in the .dts files in the
> second patch than sdhci-tegra.c in this patch, so the Tegra tree may make
> more sense). Since the second patch depends on the first, it's easiest if
> these go in through the same tree. Does this sound OK?

Yes, makes sense -- taking this via the Tegra tree is fine:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
