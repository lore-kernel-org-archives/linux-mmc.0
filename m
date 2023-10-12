Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB234CDB482
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Oct 2023 18:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379689AbjJLSm5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Oct 2023 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379655AbjJLSm4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2023 14:42:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911483
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2023 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697136175; x=1728672175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45/Ciz8VdPSGdX9h+9KVm/i9xjLN4xJH/3wVSIKHjJQ=;
  b=MC5oc1j92x/KtLIgSJuUt2/vneSFcdaVny0Nje6yNvoOyfRTswN6cVpo
   7NKgsQX0bam35o1o/ZXP9K3gTsgR+wYW5SddYPsn6XIw19vH+gclB6I7u
   H/VaCGqZAHuGT9miKJEKx4ZIbLelOXXxT5StyJitIo+K3esoDTw5EFnOk
   6IW7sblDgq4HBQPDswo2rOlcmmV0KS0wQf77UL8bwcap8zkG9o8tWm2Lp
   KjnxsA4YdDYkuSsS4R83oMiwqmRkqBdDKFu4K02iec3y/bzujVKkbtd+/
   wqu27ULtzJrybVatfvHVLob5C045bRfU3VGe+5ouMbaBohQGEP2ZxJw7c
   w==;
X-CSE-ConnectionGUID: 0c6+A0NxSuWHMI1vLDNCLw==
X-CSE-MsgGUID: B42BGwHPRc+P1z7wAyMhKA==
X-IronPort-AV: E=Sophos;i="6.03,219,1694707200"; 
   d="scan'208";a="351770288"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2023 02:42:54 +0800
IronPort-SDR: i/hpPEacQqo9sZAXlHSlGLl2BS41DuzfzEL1tl/wHWvk8PY39DyChb6AH2vw+wLhKAdxTIQ+Au
 SWlZmF3d5LgBbSCt312IA+WWvF5MEJRce7v29vBZZDGI7xOVTi0w5sdlzGPgy4Khz5TVEVIbLq
 7CrXs+SiZQuyQeIattS2M8BtRZtX0dr09+CyjStbImRUGgvCqU4zn470AXCgliVTSCSxP511KM
 9N2yFtR6OsX2OveMoIzFDfO8Hd/kZmGHzcLGS6hEerwTO5xSIEbeD5bawcpARUZaTM9Ny3TUFs
 1w8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 10:55:02 -0700
IronPort-SDR: f2F1YAk8w+P/sel3vxI2Z3p2xqV5Kq2WqtV3ViB6+okCFlOluwPor5WRNHOs10kbfruL2Zo5wk
 SFUgLfZmf+FKweF4+XvL3CzxcUlH/DbiWVffBTPJQlwbPdYtlK7Ir3ChK4N6nh8x+sghJS8vqj
 pK5TQzZJ0dUaUVHp4sTK7GCss/i7uwse+9QuYJQWAwC4xgupXUl7s2JhAnvGXPnVJQ4Z79Ml90
 aLGzrWaJSjo6394qFaWtPIjqVDseKpFZpM65hOS70V3kiymEArchM95G2RlQ3MkuYbJDo8sNwU
 Odw=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2023 11:42:53 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/3] mmc: host: sdhci-msm: Apply SDHCI_QUIRK2_FFU_ACMD12
Date:   Thu, 12 Oct 2023 21:40:41 +0300
Message-Id: <20231012184041.1837455-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012184041.1837455-1-avri.altman@wdc.com>
References: <20231012184041.1837455-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I encounterd this issue while testing fwup on HP Chromebook x2, qualcomm
based QC-7c, code name for board - strongbad.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/host/sdhci-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..78a658c22d03 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2339,7 +2339,8 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_FFU_ACMD12,
 	.ops = &sdhci_msm_ops,
 };
 
-- 
2.42.0

