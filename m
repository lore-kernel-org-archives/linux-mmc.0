Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F9C63697
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DAF2344C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kkeM12mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKPGPs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 01:15:48 -0500
Received: from mail-eopbgr760045.outbound.protection.outlook.com ([40.107.76.45]:47041
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgKPGPs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 01:15:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALvZvbKzqXuD8EYokRIYJhqZJX1Fpif+SJQtTJVtBVYv98RutPwhZFbNjJcmU+qxy6KCagPfocpbW95R8ddh+ysq6qBpT96zW8Bl5NBJ2q6zKViNgSzPOL70fML48dgKt3ght2hfcsMLXGy54vd/RQ3er3+vZRRRMXRINh2F0Il7zlgWBESHfbboWfu8E3jpJPs6XwcqLyn/cfz+Jh6kFl7Q9puPO2chpfUvyX5QllcfoBJTX/H3Ndz0kSy0fSDChjaAA/AEbrS+gX4tuzF7VC9C3hXrycxWikzitqTYBkGuBp7HL5sLy5yQAEvR0LDX1RSqj8JDlJ6rbUwGmgnCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x00KdmMIsg/dPwgAFp/Xd5Lq1B+3I3mFeW1BxVaVQQ=;
 b=mthyz1B5yom2Y3dUshhlYBVvpaUVkmYnHJrK1CK+Wh5UGNs4B6APFSgXyzOZh4KzhRYeAXrVX4oTnu40YZGfc5TgIgxsQjQXwXr7jfn3YAwtybLW9OkKQZY3/o5e0SQICL0BXQH86k/y3qYrmm3eV1ArBWspHDSdUOFXJGwvlMgZqe78bmE2BUPHKopwOH/WAF9oQ2EQgmT6lu0QSXuoi54Evm4Kjv+12ncwoGIF3X6uc1uovGsDeiNGBTcedoSRxRNWZ4wkySehiVCs8N1QveSNeumN8PZZrv1EiZp2/1HmQIxVmoUFhtN0DaZmrcjxMO0gDo8NuIrxqt6xWe6jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x00KdmMIsg/dPwgAFp/Xd5Lq1B+3I3mFeW1BxVaVQQ=;
 b=kkeM12mtKGama1MXWB/gOkB7mGiNePlGMSUaIGVF39kiX8Ao9KWHuw/J5YJgrtfsV9aRxHu20Anz6Nri3tFUD7vPEBFNNhg20OvnPeS8mnHYUF2yMKhMgs8DqnCxe/4FvflgHitjaSifZW3fsqJoJc5NKRPVWAPyxeTs8udUXgo=
Received: from CY1PR07CA0016.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::26) by BL0PR02MB5492.namprd02.prod.outlook.com
 (2603:10b6:208:8c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 06:15:45 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:e400:c60a:cafe::14) by CY1PR07CA0016.outlook.office365.com
 (2a01:111:e400:c60a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 06:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 06:15:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 15 Nov 2020 22:15:43 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 15 Nov 2020 22:15:43 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=44807 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keXni-0007IV-Ln; Sun, 15 Nov 2020 22:15:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B4E7A12109C; Mon, 16 Nov 2020 11:45:28 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 1/2] mmc: sdhci-of-arasan: Use Mask writes for Tap delays
Date:   Mon, 16 Nov 2020 11:45:26 +0530
Message-ID: <1605507327-106818-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
References: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 425d1b62-13ed-41fd-53f8-08d889f70d62
X-MS-TrafficTypeDiagnostic: BL0PR02MB5492:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5492FC21F8867BDB67861613C1E30@BL0PR02MB5492.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rz7KE22aI12qEtH8keC+oKcF8AlVOHYazdxs0bpK3qomRz0K5W9yXwQ5SJMKiMxGTs/6ylDYVT7cIZJWvOZFNPKfH/gFy+TR1iaDMJUfbebd4r0glFuMv1eZ6Sp8Iu11q5sv/K+2KzvVwQnbdK6LZcHRvZ863pM8ytD2a4oF86wM59igNHTUhb98EEv8vJ8xAj1YD736bQigbaP0gA/y5cZpEaCSkOsba9NVxOgBugL9E1KyyhADDAIIQs2dOdFIC+frT3c+miqbUbexMuuEKtAGx3cSlDm9YEbLSgA5Cx7NPlDtYfzBz1/lvOXKW3IQ1/uG3oA8nHbVudo1rXlN17AYpVsb8zVH3RuZ9lRI/DiQmIOmKFgGVB6cX96m0hX6E4Ic/9mc7W6EaeIJQgDqH9Z7Ajig4UgW6qLR8VbJzg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(46966005)(8676002)(2906002)(336012)(8936002)(107886003)(4326008)(6266002)(26005)(186003)(2616005)(426003)(44832011)(36756003)(47076004)(82740400003)(356005)(7636003)(5660300002)(70586007)(70206006)(36906005)(82310400003)(316002)(42186006)(54906003)(110136005)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 06:15:44.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425d1b62-13ed-41fd-53f8-08d889f70d62
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5492
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Mask the ITAP and OTAP delay bits before updating with the new
tap value for Versal platform.

Fixes: 1a470721c8f5 ("sdhci: arasan: Add support for Versal Tap Delays")
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
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

