Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2CC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A5961AF7
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhKPTFw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbhKPTFv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2021 14:05:51 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA8AC061570;
        Tue, 16 Nov 2021 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=sD33PGmKEFg2lgudOlt/ckkVm4Bclu2oHhDV+vr313w=; b=om0H6GArX9eyqCRkNXRAN6WK3+
        KOtqS4n9+lawsWjbTma/Xd+ATk+6xGbEgP6ujN6tXA9EDkScYzQ7DaiRgPNV/0bWjUdIscrKSa3xu
        WdlnQLCVouRcgvyqw7/VERhkKCj0hPZ0a9Hx9JlERpQN6KXhkmKul/hHubFClOMNw++xmv/AadZD5
        dZsEY4A70BEiM04cbANPMOAyT23nsnjteMtce4o3kUjHvaCw/M8XedKolNKjMby/wuNj8Ak+SeD5U
        im9psvHy526OoTI66P+N/0lJPO/0NltsAKsjhSvRr3QaOFcr3TNoTQKuOCOBUNp7idFQeoqHF2uHh
        7Om1zWuQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mn3jG-00031A-Rd; Tue, 16 Nov 2021 19:02:50 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
Subject: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
Date:   Tue, 16 Nov 2021 19:02:44 +0000
Message-Id: <20211116190244.1417591-3-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211116190244.1417591-1-john@metanate.com>
References: <20211116190244.1417591-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The standard stem for MMC aliases is "mmc" and this is used by the MMC
core to set the slot index.

Use this in preference to the non-standard "mshc" stem when setting the
controller ID to avoid needing two aliases for each MMC device in order
to cover both the core and dw_mmc-specific functionality.

The old "mshc" lookup is kept for backwards compatibility.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 37af1245304b..6ffaa354410a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -112,7 +112,11 @@ int dw_mci_of_alias_get_id(struct dw_mci *host)
 	if (WARN_ON(!host->dev->of_node))
 		return 0;
 
-	ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+	ctrl_id = of_alias_get_id(host->dev->of_node, "mmc");
+
+	/* Compatibility fallback for old device trees. */
+	if (ctrl_id < 0)
+		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
 
 	if (ctrl_id < 0)
 		ctrl_id = 0;
-- 
2.34.0

