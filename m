From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 1/3] mmc: mxs-mmc: add cd-inverted, non-removable and broken-cd
Date: Wed, 10 Apr 2013 11:13:42 +0200
Message-ID: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59335 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936027Ab3DJJNw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Apr 2013 05:13:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org

Hello,

this patch add support for the cd-inverted, non-removeable and broken-cd
property (as defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver.
Tested on a custom imx28 board.

This series applies to Chris Ball's cjb/mmc-next branch.

Changes since v2:
- add Hector Palacios's patch "[PATCH 3/3] mmc: mxs-mmc: add broken-cd property"

Changes since v1:
- add Shawn's Acked-by
- fixed typo in [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
  (tnx Chris)

regards,
Marc Kleine-Budde

