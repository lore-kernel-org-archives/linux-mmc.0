From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
Date: Mon, 25 Mar 2013 16:02:29 +0100
Message-ID: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51523 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab3CYPCi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 11:02:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Hello,

this patch add support for the cd-inverted and non-removeable property (as
defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
custom imx28 board.

This series applies to Chris Ball's cjb/mmc-next branch.

regards,
Marc Kleine-Budde


