From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/2 v4] Add SDHCI driver for Tegra
Date: Sat,  1 Jan 2011 18:32:17 -0600
Message-ID: <1293928339-19373-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:52177 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab1ABAco (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 1 Jan 2011 19:32:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Here we go again. Just a couple of minor changes to the 8-bit code, i.e.
allow boards to pass in which slots are actually wired 8-bit.

Changes since v1:
        * Rewrote for sdhci-pltfm

Changes since v2:
        * Whitespace fixes
        * Changed order of test in get_ro
        * 8-bit support
        * Set gpio directions

Changes since v3:
        * Add platform structure member for 8bit capabilities


