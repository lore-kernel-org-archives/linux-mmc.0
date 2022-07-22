Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104DC43334
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jul 2022 07:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiGVHZD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiGVHY7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2022 03:24:59 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0667D33343;
        Fri, 22 Jul 2022 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0XohY
        BRikB8/6sXDjRE0wVub5cSWVvlneePJic88d7Q=; b=oFvxFL+yTLh7AwKMqu8Mx
        7YgUiyxoSzMvHF/vtBDatmAJjGLchJ8qmox79CA2Sfpo/Zv33wToCXcXJTFxltBJ
        ET6QpTO6L2j6ImnpEwhF9MMmmL3C43ItT4cDMukWA8sXqAWyZoPHyBXQWcPvzqof
        k1aKhxg16VJsoYYl07VTPU=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgDn9aW9UNpiXNUXPw--.19829S2;
        Fri, 22 Jul 2022 15:24:47 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] mmc: sdhci-acpi: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 15:24:43 +0800
Message-Id: <20220722072443.72471-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDn9aW9UNpiXNUXPw--.19829S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr45Jr4fuF47uw1UGFg_yoWfJrb_CF
        y5C397uF48CFWvgw18K3ySvry8ta98urs7Xr1FgrW3uw1rX3yUXa1vvr1kXr15WrWjkFZx
        Cw15Xw1fCw1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuYLyJUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwBGZFWB0jtN2AAAs1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 4cca4c90769b..bddfaba091a9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	 *       in reading a garbage value and using the wrong presets.
 	 *
 	 *       Since HS400 and HS200 presets must be identical, we could
-	 *       instead use the the SDR104 preset register.
+	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
 	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
-- 
2.25.1

