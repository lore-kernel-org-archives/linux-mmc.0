From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 00/03 v7] sDMA descriptor loading feature and omap hsmmc
	adaptations
Date: Wed, 10 Mar 2010 19:41:21 +0530
Message-ID: <618f0c911003100611r6d256075p3ca7af3d66070efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:37056 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab0CJOLW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 09:11:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

This series was posted 10 days back
(http://www.mail-archive.com/linux-omap@vger.kernel.org/msg24713.html)
and I have received one comment, which I have fixed in this series.
Also rebased to latest 34-rc1.

Changes since v6:
 * Fixed comment alignment
 * removed incorrect whitespace alignment
 * rebased to 2.6.34-rc1

Venkatraman S (3):
     MMC:  prevent race between dma  and hsmmc callback
     sDMA: descriptor autoloading feature
     MMC: omap hsmmc adaptation of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  269 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  162 ++++++++++++++++----
 3 files changed, 571 insertions(+), 30 deletions(-)
