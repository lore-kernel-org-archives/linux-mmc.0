Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A0C2D0D4
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EA42082E
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLQLkq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:40:46 -0500
Received: from sauhun.de ([88.99.104.3]:52230 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfLQLkq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 06:40:46 -0500
Received: from localhost (p54B330AA.dip0.t-ipconnect.de [84.179.48.170])
        by pokefinder.org (Postfix) with ESMTPSA id 9789F2C2D9A;
        Tue, 17 Dec 2019 12:40:44 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 5/5] mmc: renesas_sdhi: cleanup SCC defines
Date:   Tue, 17 Dec 2019 12:40:34 +0100
Message-Id: <20191217114034.13290-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
References: <20191217114034.13290-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use increasing BIT numbers consistently and remove some superfluous
comments.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 04f502345b91..6a112454ca26 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -253,24 +253,22 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
 #define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
 
-/* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK	0xff
 
-/* Definitions for values the SH_MOBILE_SDHI_SCC_CKSEL register */
 #define SH_MOBILE_SDHI_SCC_CKSEL_DTSEL		BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSCNTL register */
+
 #define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
-#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
-#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
+
 #define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN	BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_SMPCMP register */
-#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(24) | BIT(8))
-#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
+
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT2 register */
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
+
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
-- 
2.20.1

