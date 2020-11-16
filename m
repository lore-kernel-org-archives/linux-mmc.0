Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DBC4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FD1221F9
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lqIWoEu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgKPGPl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 01:15:41 -0500
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:8831
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgKPGPk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 01:15:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6+K4QjuQX25TewrLNdAoYiQZ4Wk0HoMYzGMLAmVJKln2miv00BrxYP3Uq1doIWA2gH9OCI6mjYLIDl31B2Ar1wJI/xQkiBNZ0cCN+i+Mv1PK9dVO1N17dJNgvGmPm/v9HJascrdYd3ghFjCpXrCafDw1GukvBmrokiYiTDDSibaqNM0FV8TNdIMZDivln+7LqIW7XRLJGdI1UF2JkqmOjWuIjI4l9Fex9tD06fE876aAWeJkc4UBcgRh8opyRPzG4avuS2Q+9ZZkZ7x1GnH/pnZdqeJw6DqvBozbJlSxGZq26I8+mpajF52ycRtAsBZCQ4fMivNZr7paeJFfA5qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/rZFkA1ReZQJq1MrU7AyU031CP0ONooe6o9MpuNwrE=;
 b=iH5zlvaYzBPyL/FlgNSlEoJILox8dKB7LSQ+Bkviddrrg2Z8GaQ2V2TvUMGVWzJCGXL6XQ26R6PHuvctXXHRWaR2NgOczrXwxzDe2X0yfOuzdZXh/tIPfhgS0F1CJ5VTuWMiSWxRiGXmU0t7NTE5ziQiLPsw53b4B4G31QRiWJvUnr0Wp5FBCNb0BzExIT609Y2AbmSxZ3iOlsu3ryMBM7PfX+zHiLMCN3yfZYz4joTCD5yhQiTXEX20is/tuGq9axhaEL1pDFbavex25JoAemhSgees/5sRQooZh2unutcaZLT1fGzj8aA3nby+l8gzwDz+09u2OGN6W2NN/4cGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/rZFkA1ReZQJq1MrU7AyU031CP0ONooe6o9MpuNwrE=;
 b=lqIWoEu09Q9pQoPpJ9TH9FOugw2tr6JqPLe0GMROKWTBaYWb7L4l9gXxzlubamGfKcsMC+uRNIF0/MiFl1Iqoj8putvAyfYo7lK/Rfs1chYS7MdMnDMD8zLb9hjBOhH08j8av8SNUrVDyWYkCzG8KT3OMZG7s+wRwH/gIpCy7iw=
Received: from CY4PR22CA0080.namprd22.prod.outlook.com (2603:10b6:903:ad::18)
 by BY5PR02MB6755.namprd02.prod.outlook.com (2603:10b6:a03:205::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 06:15:37 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::1f) by CY4PR22CA0080.outlook.office365.com
 (2603:10b6:903:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 06:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 06:15:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 15 Nov 2020 22:15:30 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 15 Nov 2020 22:15:30 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=44780 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keXnV-0005Al-HB; Sun, 15 Nov 2020 22:15:29 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id AF60E121191; Mon, 16 Nov 2020 11:45:28 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/2] Bug Fixes to Tap Delay code in SDHCI Arasan driver
Date:   Mon, 16 Nov 2020 11:45:25 +0530
Message-ID: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1522600-cf54-45d0-9a05-08d889f70895
X-MS-TrafficTypeDiagnostic: BY5PR02MB6755:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6755758BAE12B855B789AA57C1E30@BY5PR02MB6755.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVcd8vZQ9QLAM75QHxNGn1p1lBFIsMAreZpa3vP9Gc0qX3vBCNFLlWCMXe3Q3W7XZLRXXCbbnZETKcC9XDGjelg3Gb8LeXXTxZlbgIBPKonrLZtTSukfwML9nGS1aIQloRWFoopSqMmT+muOVY7JmnQnOPsQkwtYTscraNaf5Io52f5G8mfevEm9L+9ambhQztC5PWWEXEkELqo4L0twx8i7Se3krg32LYefX+xF0DL7N00/E84SVs/5j4Y+X+iitNQnlec/omZdZNeynbMUv/JvoXlGCwnzsTr6B63kF3ATHe05odBxlQFyfsoqTYtaGoM7BBCpjbV2R0yTRpZmVFos51XntAeiImeeFUmf+yjb2EnBlEA3gj8e9LNrsPu98n7D5TDaMICnINq+0VkMSWZuD/C51DExkr2AQcHUliY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(376002)(396003)(46966005)(4744005)(186003)(2906002)(82310400003)(47076004)(26005)(478600001)(356005)(82740400003)(5660300002)(44832011)(2616005)(336012)(70586007)(110136005)(54906003)(107886003)(42186006)(8936002)(36906005)(7636003)(6266002)(4326008)(316002)(8676002)(426003)(70206006)(6666004)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 06:15:36.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1522600-cf54-45d0-9a05-08d889f70895
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6755
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set consists a couple of minor bug fixes for SDHCI Arasan
driver. The fixes are for tap delay programming where in some cases
tuning is failing for some of the SD cards.

Manish Narani (2):
  mmc: sdhci-of-arasan: Use Mask writes for Tap delays
  mmc: sdhci-of-arasan: Issue DLL reset explicitly

 drivers/mmc/host/sdhci-of-arasan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.17.1

