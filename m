From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: let the mxcmmc driver use the dmaengine API
Date: Wed, 12 Jan 2011 11:09:55 +0100
Message-ID: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1ALKKC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 05:10:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

This saves us several ifdefs and also adds mxcmmc DMA support for the
i.MX31 processor.

Sascha

Sascha Hauer (1):
      mxcmmc: use dmaengine API

 drivers/mmc/host/mxcmmc.c |  172 +++++++++++++++++++++++++--------------------
 1 files changed, 97 insertions(+), 75 deletions(-)


