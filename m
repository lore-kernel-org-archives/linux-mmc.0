From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH 0/3] mmc: omap_hsmmc: sdio irq am335x.
Date: Mon, 19 Nov 2012 22:42:56 +0100
Message-ID: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:53838 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752314Ab2KSVn3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 16:43:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: david.vrabel@csr.com, daniel@zonque.org, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Here 2 patches enabling sdio irq on beaglebone and one bug fix. 

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
--
 arch/arm/boot/dts/am335x-sue-s800.dtsi |    1 +
 drivers/mmc/host/omap_hsmmc.c          |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 include/linux/platform_data/mmc-omap.h |    1 +
 3 files changed, 97 insertions(+), 14 deletions(-)



