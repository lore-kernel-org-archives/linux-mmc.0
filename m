From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/3 v3] Add SDHCI driver for Tegra
Date: Thu, 23 Dec 2010 03:27:53 -0600
Message-ID: <1293096475-19634-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:39788 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223Ab0LWJ2t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Dec 2010 04:28:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Third time is a charm?

Mostly just minor fixups this time, and addition of 8-bit support.

Changes since v1:
        * Rewrote for sdhci-pltfm
	* Dropped/moved some quirks

Changes since v2:
        * Whitespace fixes
        * Changed order of test in get_ro
        * 8-bit support
        * Setup gpio directions for inputs

