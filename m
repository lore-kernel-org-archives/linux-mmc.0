From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/6] mmc: kona/spear updates
Date: Fri, 28 Feb 2014 21:29:36 +0000
Message-ID: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60147 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752401AbaB1V3m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:29:42 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Christian Daudt <csd@broadcom.com>, linux-mmc@vger.kernel.org, Markus Mayer <markus.mayer@linaro.org>, Matt Porter <matt.porter@linaro.org>, spear-devel@list.st.com, Viresh Kumar <viresh.linux@gmail.com>

Chris,

Here's the latest patches for these fixups.  They've been in my build
system for a while, and allyesconfig/allmodconfig show no problems.

Probably want to get some acks/tested-bys from people before applying
these.

 drivers/mmc/host/sdhci-bcm-kona.c |   2 +-
 drivers/mmc/host/sdhci-spear.c    | 191 +++++++++++++++++++----------------------------------------------------------------
 include/linux/mmc/sdhci-spear.h   |   8 ----
 3 files changed, 45 insertions(+), 156 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
