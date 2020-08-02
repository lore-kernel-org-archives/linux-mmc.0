Return-Path: <SRS0=tOmi=BM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27203C433DF
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Aug 2020 07:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEED207DF
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Aug 2020 07:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MSEWqFr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgHBHBU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:01:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34790 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgHBHBU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Aug 2020 03:01:20 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07271IVm058084;
        Sun, 2 Aug 2020 02:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596351678;
        bh=8+gEs3KZgnLAa3nDsFEplrJEf4aVbPq8rbpBMuuwthE=;
        h=From:To:CC:Subject:Date;
        b=MSEWqFr0ef/mVjpB+Tfg5e+iB/gVpE7lSr8KhTto1IoMQyPnF5jOUky/EAPX5SS6N
         7ZdKBLACKGqtnMFpaX38//Q2sGTZ89Ipx1EI6zzPIYKXBxP4JQYXdmFHHHWANUwT8T
         uwDEn/XnufYTx8tlhPTHqTuOGpvREj7Vhtcb0ObM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07271IVU029937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Aug 2020 02:01:18 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 2 Aug
 2020 02:01:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 2 Aug 2020 02:01:17 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07271EhL124525;
        Sun, 2 Aug 2020 02:01:15 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <ulf.hansson@linaro.org>
Subject: [PATCH] dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's J7200 devices
Date:   Sun, 2 Aug 2020 12:31:14 +0530
Message-ID: <20200802070114.9624-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add binding documentation for mmc host controllers present on
TI's J7200 SOC

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
index 6d202f4d9249..b49cbfdd679f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -12,6 +12,8 @@ Required Properties:
 			"ti,am654-sdhci-5.1": SDHCI on AM654 device.
 			"ti,j721e-sdhci-8bit": 8 bit SDHCI on J721E device.
 			"ti,j721e-sdhci-4bit": 4 bit SDHCI on J721E device.
+			"ti,j7200-sdhci-8bit": 8 bit SDHCI on J7200 device.
+			"ti,j7200-sdhci-4bit": 4 bit SDHCI on J7200 device.
 	- reg: Must be two entries.
 		- The first should be the sdhci register space
 		- The second should the subsystem/phy register space
@@ -33,7 +35,9 @@ Required Properties:
 	  These bindings must be provided otherwise the driver will disable the
 	  corresponding speed mode (i.e. all nodes must provide at least -legacy)
 
-Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
+Optional Properties (Required for ti,am654-sdhci-5.1,
+				  ti,j721e-sdhci-8bit,
+				  ti,j7200-sdhci-8bit):
 	- ti,trm-icp: DLL trim select
 	- ti,driver-strength-ohm: driver strength in ohms.
 				  Valid values are 33, 40, 50, 66 and 100 ohms.
-- 
2.17.1

