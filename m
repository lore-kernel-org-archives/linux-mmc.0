Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A6C61DA4
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 02:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCGCqy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Mar 2023 21:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCGCqx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2023 21:46:53 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56FA69059;
        Mon,  6 Mar 2023 18:46:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6419824E287;
        Tue,  7 Mar 2023 10:46:49 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 10:46:49 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 7 Mar 2023 10:46:48 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 2/2] mmc: starfive: Add initialization of prev_err
Date:   Tue, 7 Mar 2023 10:46:46 +0800
Message-ID: <20230307024646.10216-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307024646.10216-1-william.qiu@starfivetech.com>
References: <20230307024646.10216-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a incremental updates to fix a bug that prev_err is uninitialized.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reported-by: Dan Carpenter <error27@gmail.com>
---
 drivers/mmc/host/dw_mmc-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index 40f5969b07a6..dab1508bf83c 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -51,7 +51,7 @@ static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
 	struct dw_mci *host = slot->host;
 	struct starfive_priv *priv = host->priv;
 	int rise_point = -1, fall_point = -1;
-	int err, prev_err;
+	int err, prev_err = 0;
 	int i;
 	bool found = 0;
 	u32 regval;
-- 
2.34.1

