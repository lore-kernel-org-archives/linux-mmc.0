Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C3C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 06:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABD42468F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 06:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HsYiqFZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgKRGWE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:22:04 -0500
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:37127
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgKRGWD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Nov 2020 01:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnyjGRm7kM0gqSunZyyHze9pPXtA10t7RBU1nfCJi+XW6h5Hm6Ha9/Dr/PHkH54M74Mw41rmRxa0oEmlQRSsBX2W5C60DHl9Qq9AYZcBNL0PvaPBwYkM8DOG19wTPNyJL/AK860//pT+xjte1X1+H+6UfVEBJGVHeZ4NMw0sUa3o604O4mf1Frt4WSGLrnQkc91f3KLOA+DF/p7yyT40nHW0FMW7OCtE3NQyrHF7594b1TpSH28ghyoS5hSLUB8KaUud4JZeW+86fKNYdQT1h0Y9ot6SZdtAUgXQjzi9aeXBkpHsxBZWsJ2HYqpXS5FiwM7wAubn0sVO7YBrd/4rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYHMhHFztwXUvmgcYBTWt2g3LwrpD40XBslgW2us4+8=;
 b=g/KmlvS2n4WsXuSUVl6GFK8M6hDjd4fuge8Tg7phy1S1iCCcHeJJcnXT3AMBDH6RPCPiAtIWteh0/rxD8nH+1uWnBfpuDGF6fUlinjQQLceDaU/EFCPE3JQDBb+nGo7R1Ll/6Wtdt15sw6AeKLOkBI+S4FpRQRmFMj69QmhSHN0BW530/59eEEPqpa/koooqSLfz7zZBFMAl5rugJgZ0H7hUZfkJMltcnkiyNlQljBhmVMqdZmMH1cV5/6M/DREJq9TfenO2bNFNaYL7+ZilIIx25dSI84qgba+sNwoeyf+5qeYroEd1WAkBzLQnKcKauKTEPplsqNLSmqw/tweVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYHMhHFztwXUvmgcYBTWt2g3LwrpD40XBslgW2us4+8=;
 b=HsYiqFZhfki2KPNDkXiK8NvEs2IJWcZsNAM6WJaqP9vGQqlzxdgarB49iA0C0lmEZt3z/ZbhbdFRIWkbH6GIay2riJpooSwz9I55Q2RwzlW243kGmDEITtV0F24U1m/nW/4pLgOQ3UDz8lYfHSeHq9Edw1USQf6Sqtq8qd69ZnE=
Received: from CY4PR08CA0048.namprd08.prod.outlook.com (2603:10b6:903:151::34)
 by MWHPR02MB3183.namprd02.prod.outlook.com (2603:10b6:301:62::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 18 Nov
 2020 06:21:59 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::1b) by CY4PR08CA0048.outlook.office365.com
 (2603:10b6:903:151::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 06:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Wed, 18 Nov 2020 06:21:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 22:21:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 17 Nov 2020 22:21:38 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=35149 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kfGqX-0005Yk-Tg; Tue, 17 Nov 2020 22:21:38 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1AF20121375; Wed, 18 Nov 2020 11:51:37 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
Date:   Wed, 18 Nov 2020 11:51:35 +0530
Message-ID: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ecaf41-cfed-4a56-cad6-08d88b8a4139
X-MS-TrafficTypeDiagnostic: MWHPR02MB3183:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3183CD7D0AAF85E4A54C20E5C1E10@MWHPR02MB3183.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsbovSU5rs6mjLCZGqvgplE6uHrxG4usiWCv+C80Riz0+ZYXfAXagACsva8TQUATpuzDJTJpvZO2BCdctiiHMFC67KnPBJAzI5ERpNRQ20X0LBeYFB6KyPiyKVxDd0tmETY7jQYo1gw0aGLW+GVMFrsdnenzL+z2wclGGIh5MhG8Awx5ECz73BOH7tDprs/Fjabc3Qvog/3ZebPv/BsgKDC4xNrNc5WxburQx/QNRiVU8uVh83sq0NEJ7y4pJWUnDRKmzOmzi0yEu2B0z8pLHoSebpjY/o+f1U5+aFNAyRjRhZj4f1TB67Q1w0iyZm/yKZkEhkP7ae77hG0OEjVTs9lwNRh9ZC90zBhAeoxmkSSvsILyuQeovlcVLGNjFUR/g73MvNtMfmq2NeHP2ahZZSyqYoavnX8CN7CdKmuNdhs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(46966005)(6266002)(83380400001)(8936002)(8676002)(4326008)(107886003)(110136005)(54906003)(36756003)(42186006)(478600001)(82310400003)(36906005)(356005)(316002)(82740400003)(70586007)(44832011)(26005)(70206006)(426003)(7636003)(186003)(2906002)(5660300002)(2616005)(336012)(47076004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 06:21:58.8355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ecaf41-cfed-4a56-cad6-08d88b8a4139
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3183
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Driver should be able to handle optional pinctrl setting.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 829ccef87426..f788cc9d5914 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -135,6 +136,8 @@ struct sdhci_arasan_clk_data {
  * @clk_ops:		Struct for the Arasan Controller Clock Operations.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
+ * @pinctrl:		Per-device pin control state holder.
+ * @pins_default:	Pinctrl state for a device.
  * @quirks:		Arasan deviations from spec.
  */
 struct sdhci_arasan_data {
@@ -149,6 +152,8 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	struct pinctrl	*pinctrl;
+	struct pinctrl_state *pins_default;
 	unsigned int	quirks;
 
 /* Controller does not have CD wired and will not function normally without */
@@ -1619,6 +1624,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto unreg_clk;
 	}
 
+	sdhci_arasan->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(sdhci_arasan->pinctrl)) {
+		sdhci_arasan->pins_default =
+			pinctrl_lookup_state(sdhci_arasan->pinctrl,
+					     PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(sdhci_arasan->pins_default)) {
+			dev_err(&pdev->dev, "Missing default pinctrl config\n");
+			ret = PTR_ERR(sdhci_arasan->pins_default);
+			goto unreg_clk;
+		}
+
+		ret = pinctrl_select_state(sdhci_arasan->pinctrl,
+					   sdhci_arasan->pins_default);
+		if (ret) {
+			dev_err(&pdev->dev, "could not select default state\n");
+			goto unreg_clk;
+		}
+	}
+
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "arasan,sdhci-5.1")) {
-- 
2.17.1

