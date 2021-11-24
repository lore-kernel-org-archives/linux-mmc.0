Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4BC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhKXStX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhKXStW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 13:49:22 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09549C061746;
        Wed, 24 Nov 2021 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=lPi+Knpu85ApFKN1hCgex6IK5JO2TM11yYvM5Cw66/Q=; b=pZP9IxWd/ronCKzZ+PMeU7SeDb
        J0PgruqxPg5J0wP8UiFl/ObTGFJUEkvsJZwCn3pvNkMcpFu79fHmpwbQQVm/SXblTukYf6XuyNrIZ
        jp+mBzUgKVmLQmUegOlYbGBDPTa2U0ewI6JsKnQuz4VmHdNKHNR4/oqBnq+m962kiQBZhV/6b4zrV
        0DWX7VcW27BpT7S4JitKKQixs3CwcAJCaqDEL3nPwq3Mm7Mn1LJQqleOwsNNhxDUoWhaP/ssXJLKI
        +IqHtxtJGaeD1+4TPVRc+vg3Cj+vKFP66rntQ8Fg1AwLqM6cddZr/dWsvSgDpUqqzFUwLUAFPdzWX
        EbBYb7SA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mpxHV-00007s-A6; Wed, 24 Nov 2021 18:46:09 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] mmc: dw_mmc: add common capabilities to replace caps
Date:   Wed, 24 Nov 2021 18:45:59 +0000
Message-Id: <20211124184603.3897245-2-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
References: <20211124184603.3897245-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The caps field depends on the mshcN alias ID but for some devices this
is unnecessary as the capabilities are the same for all instances
sharing the same compatible.

Add a common_caps field for this case which updates the host's
capabilities without needing the mshcN alias ID.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc.c | 3 +++
 drivers/mmc/host/dw_mmc.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 195f2b2434b0..f2a14a434bef 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2856,6 +2856,9 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	if (host->pdata->pm_caps)
 		mmc->pm_caps = host->pdata->pm_caps;
 
+	if (drv_data)
+		mmc->caps |= drv_data->common_caps;
+
 	if (host->dev->of_node) {
 		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
 		if (ctrl_id < 0)
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index ce05d81477d9..771d5afa3136 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -550,6 +550,8 @@ struct dw_mci_slot {
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @num_caps: number of capabilities specified by @caps.
+ * @common_caps: mmc subsystem specified capabilities applicable to all of
+ *	the controllers
  * @init: early implementation specific initialization.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
@@ -562,6 +564,7 @@ struct dw_mci_slot {
 struct dw_mci_drv_data {
 	unsigned long	*caps;
 	u32		num_caps;
+	u32		common_caps;
 	int		(*init)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-- 
2.34.0

