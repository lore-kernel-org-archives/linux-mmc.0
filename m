From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 00/03] sDMA driver descriptor autoloading feature [version 5]
	and omap hsmmc driver adaptations
Date: Mon, 1 Mar 2010 16:55:10 +0530
Message-ID: <618f0c911003010325t337bb0f4o67e2cb3b2484d767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:39980 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0CALZL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Mar 2010 06:25:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This patch series is introduction of new sDMA feature: descriptor
autoloading (v5)
       and its adoption by omap hsmmc driver.
Previous thread (v4 of sDMA patch, without hsmmc adoptions) is here:
http://patchwork.kernel.org/patch/66690/
Current version(s) based on for-next branch, 7b97f3ed. Tested on omap4430 sdp.

Venkatraman S (3):
     MMC:  prevent race between dma  and hsmmc callback
     sDMA: descriptor autoloading feature [version 5]
     MMC: omap hsmmc adaptation of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  269 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  162 ++++++++++++++++----
 3 files changed, 571 insertions(+), 30 deletions(-)
