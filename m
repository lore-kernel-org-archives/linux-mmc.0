From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
Date: Fri,  5 Apr 2013 14:47:48 +0200
Message-ID: <1365166070-9370-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43055 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161587Ab3DEMr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Apr 2013 08:47:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org, aletes.xgr@gmail.com

Hello,

this patch add support for the cd-inverted and non-removeable property (as
defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
custom imx28 board.

This series applies to Chris Ball's cjb/mmc-next branch.

Changes since v1:
- add Shawn's Acked-by
- fixed typo in [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
  (tnx Chris)

regards,
Marc Kleine-Budde

