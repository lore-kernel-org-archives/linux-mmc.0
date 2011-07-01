From: Balaji T K <balajitk@ti.com>
Subject: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Fri, 1 Jul 2011 22:09:33 +0530
Message-ID: <1309538376-23260-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49330 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182Ab1GAQks (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jul 2011 12:40:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com, Balaji T K <balajitk@ti.com>

Removing the custom state machine - lazy disable framework in omap_hsmmc
to make way for runtime pm to handle host controller
power states.
This allows mmc_host_enable/mmc_host_disable to be replaced by
runtime get_sync and put_sync at host controller driver.

Enable runtime PM in omap_hsmmc

Rebased to MMC tree : mmc-next branch
Tested on OMAP4430SDP, OMAP3430SDP, OMAP2430SDP

MMC runtime patch has dependency on
[PATCH 0/6] OMAP2+: hwmod framework fixes [1]
for MMC1/MMC2 clock to get ungated after idle in OMAP4.

Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.html

Balaji T K (3):
  MMC: OMAP: HSMMC: Remove lazy_disable
  MMC: OMAP: HSMMC: add runtime pm support
  MMC: OMAP: HSMMC: Remove unused iclk

 drivers/mmc/host/omap_hsmmc.c |  365 +++++++----------------------------------
 1 files changed, 57 insertions(+), 308 deletions(-)

