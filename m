From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 35/38] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
Date: Wed, 23 Apr 2014 20:09:09 +0100
Message-ID: <E1Wd2Xd-0003we-7P@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46536 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932508AbaDWTJL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:09:11 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Olof Johansson <olof@lixom.net>

The shared of parse function fills in common options for capabilities,
etc, but it needs to be called from each driver that wants to make use
of it. dw_mmc was missing the call.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/dw_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cced599d5aeb..a2c12ebb376e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2140,6 +2140,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	slot = mmc_priv(mmc);
 	slot->id = id;
 	slot->mmc = mmc;
-- 
1.8.3.1

