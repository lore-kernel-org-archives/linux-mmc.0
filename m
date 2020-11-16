Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28ACC4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAA9208C7
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AMjTGiqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKPIdd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:33:33 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:13990
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbgKPIdd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iid6mOdYG1Cs4dkJHupFLy1LWrpI1hozhx+/LK0XQzBoXxls2BkNkheZYGCrWtC7FBQKMcBgzgdVBC/giyBFvGD0/fwtX7NSMgboaNQNkhM2qQgFgRuX7obiYn0P9GmE/ltiutRVnrBT9H2f33qrv1+Z8r2fJqt6tNXHvtRZyN3Oz6dwWOyA0lu+4oRhi0HisGbGPQn7imbqRbs2HWyO6Td+Ht6UqsEQovSgeGN+LBiParGNYK9iXpaa8FDA97Bnynud4xF0KW/gXBYEdYHIK/XUg3lTEa9U3KYMnXvNUWOmyg+yGnR1BGKM1hqilP+XB+m8HsVT83yHuUs9oVPx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSTrBvusM1nmYanNfV/4Dk4JcEKizyWgTXqNQpmk0wo=;
 b=PcPz89sRVnyylJqhmunze/NoCzSvVNrA8m90KFGnhd5wCEpLq/vSddtZfMMU+59AXJgNIzZ+wb/YF1KgH9qzWCXvLRnD2E/ngD0u2i6WNe9lkjzVyGoiauPY9EzV+lC7hOELPTF0jPY7ZVj/922kweVRZyBeKns40hinwsZaWO68k3660OTqxwpUW5WIc3g08gNJbd9LlAbDdV6Ii24aWx3Fz+ruAifYfot1QeIERS7e7+1d6d+MLSGEGtqjiSN0USoKw6FlgQUxudVJ0IpFmYMNBG7XYW0/1nI7Zt/NqLUgka3yyAO/6FVL50/q2iNZH3oPjeKiUAcFBVfpWvlVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSTrBvusM1nmYanNfV/4Dk4JcEKizyWgTXqNQpmk0wo=;
 b=AMjTGiqcQptCGGhmNMjOwrz+h2kY6Hp2uzDq1Z4h4toLXhEJleWd0C7/wb6lTZsJDN10EiXkjMhnz1pGqlU7zBqpVw+GDozHFWGKRhevV1aZEIp2iPW7JZWgGX4y2hQfe3l1Oittp+dLDc+HyqUt+z1EqiSDuvVDDV+NlDeGMnI=
Received: from SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) by DM5PR02MB3750.namprd02.prod.outlook.com
 (2603:10b6:4:af::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 08:33:29 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::f) by SN4PR0601CA0003.outlook.office365.com
 (2603:10b6:803:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 08:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 08:33:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 00:33:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 00:33:15 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=51158 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keZwo-0002Vl-HV; Mon, 16 Nov 2020 00:33:14 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 717751211D2; Mon, 16 Nov 2020 14:02:47 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH v2 2/3] mmc: sdhci-of-arasan: Use Mask writes for Tap delays
Date:   Mon, 16 Nov 2020 14:02:44 +0530
Message-ID: <1605515565-117562-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
References: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab22d09-7adf-469a-db9c-08d88a0a4ba0
X-MS-TrafficTypeDiagnostic: DM5PR02MB3750:
X-Microsoft-Antispam-PRVS: <DM5PR02MB375034D1A950D2F12DFDCA5FC1E30@DM5PR02MB3750.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CptzD8NM62/G1NrV6wRshggV8b7e8Ozo4E2GElk4pmxldDfyU3AV6vWdAVWiLaeq4BI2ND6Dza23XvZmwHPkDEs19+05mXKyUE0OtEgswlhwVF0i51Tag46PWuzu4LJElT+UCQ7NyM5VWHvbqE4k3KTQA5ruIhMHUgCkY9+vnMCHyhHwdsCBMnYDxT2PAFAx/5QTF1eXqEn1MtyMeFhDd1e9n9CnKvaBA49DM+s9uGcss8l1aYvKF0sltrvnOA9LbGYi0i/1csBM6mUcrRsnp7enbBmsPBe7M0sFgNDxvQ35GLYtteQYHUSV1gArJhMtm5Qq2LCwzRcbx7Sw6CSx6LMyJE+YNgdpNHzJoZZSCX6ncg8upBTQA/QYbvxudzQqT5lxhnyqxz5Gp+We7iqk2WbZ6wKd1SOMUVb2Imz1YkM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966005)(2906002)(8676002)(6666004)(26005)(186003)(70206006)(110136005)(316002)(42186006)(70586007)(36906005)(54906003)(8936002)(36756003)(7636003)(82310400003)(5660300002)(44832011)(4326008)(478600001)(6266002)(107886003)(2616005)(336012)(47076004)(82740400003)(426003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:33:29.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab22d09-7adf-469a-db9c-08d88a0a4ba0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3750
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Mask the ITAP and OTAP delay bits before updating with the new
tap value for Versal platform.

Fixes: 1a470721c8f5 ("sdhci: arasan: Add support for Versal Tap Delays")
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 100621e55427..3ec5ecad637c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -30,7 +30,10 @@
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
 #define SDHCI_ARASAN_ITAPDLY_REGISTER	0xF0F8
+#define SDHCI_ARASAN_ITAPDLY_SEL_MASK	0xFF
+
 #define SDHCI_ARASAN_OTAPDLY_REGISTER	0xF0FC
+#define SDHCI_ARASAN_OTAPDLY_SEL_MASK	0x3F
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
 #define VENDOR_ENHANCED_STROBE		BIT(0)
@@ -755,6 +758,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 		regval = sdhci_readl(host, SDHCI_ARASAN_OTAPDLY_REGISTER);
 		regval |= SDHCI_OTAPDLY_ENABLE;
 		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
+		regval &= ~SDHCI_ARASAN_OTAPDLY_SEL_MASK;
 		regval |= tap_delay;
 		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
 	}
@@ -822,6 +826,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
 		regval |= SDHCI_ITAPDLY_ENABLE;
 		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
+		regval &= ~SDHCI_ARASAN_ITAPDLY_SEL_MASK;
 		regval |= tap_delay;
 		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
 		regval &= ~SDHCI_ITAPDLY_CHGWIN;
-- 
2.17.1

