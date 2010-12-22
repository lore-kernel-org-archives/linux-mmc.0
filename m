From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/3 v2] Add SDHCI driver for Tegra
Date: Wed, 22 Dec 2010 02:01:08 -0600
Message-ID: <1293004871-1918-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:53485 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LVIBh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 03:01:37 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

This is the second version of the SDHCI driver for tegra. I moved it
over to a sdhci-pltfm variant, which turned out to be feasible -- at
least as long as the platform_data is never required by sdhci-pltfm and
can be used by the sub-driver.

I also did away with wone of the quirks, since based on current testing
it seems to no longer be required. If needed it can be reintroduced in
some way or other later on instead.

The one remaining quirk is of the kind that can be moved entirely into
the driver, and I will look at doing so when I get around to cleaning
up other quirks together with it. Until then, at least we have one more
bit left to allocate. :-)


Thanks,

-Olof

