Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1FEC4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AB5208C7
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YF60FAUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKPIdT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:33:19 -0500
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:65441
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbgKPIdT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xru2Q+xyyZxMllMd8d1cUuhf0Hb5HoG78PPjCox/QwrDcUuUzRijwAZfbmXaDKLf2HrbN2YyfufW7/6W/HJMaQ05nH3WsWhzWewA259RDeELBTpiuMgQDzSdvcDX/zclK0z1lMVUkRHXKLTL6TCwXcZMKlSje5bhmAEowl69V4sCc3gkD5ALQbP1KzeBudCqFZpZDAEc56ye4Rb/mf4FYCKdsCzSsp9mY3oQFSqHnOPtsmXOfvE/KVaydsRRwQdK5jXfW+SVRQUzaQthpSY+f8/QvsQ1Fhr3FUJl+yLpJfRffVIqvMTU+jowo2/KE3zhXOm0zRZ7mBPsd80K3DaAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2QySNCICxOQy3S9ksfipCrmUWMNV3S9uousmOclyUE=;
 b=Ozl677TozIZPROH3uM5YkVABezMBZqmVUMei0kAlzlenTVUn3IPNhjdasEKxYQ1PG5tSFD5ZwH1jJwwdoWCTeDgLAYCN0Wio77g4XSuqTnafH4ZPjwq+iceBtQzQpdoM6Xp7oJQdj+BSWUTZ7a3zG2i5HC+jfbiKqhBSlNhSQm3A9/OJ0Ix7bK+a5qlCngccru0LWIvmr9iR53+JwDQspCjCaKvreFeqjI37d53RL4+HNVNQvprnYLMvdo70aNnVjf/xj8xy0OBqJSNesPriSwknaMWp087NMXvC9Zegr8GIDvS7H5/15tvGS7X6R+kUcOU1dWXRA3Pmr3Gr13w3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2QySNCICxOQy3S9ksfipCrmUWMNV3S9uousmOclyUE=;
 b=YF60FAUPv9CJhfK2NfLw4H6eaaDRz8aox4QBAEAULXJz3jT0pfHojti64DGdNJv3ui7F1NcuFibFaD+4fEiGgOZlfSX2sz/A4cGjsBfV2sYDx14KNjBn6n/JVFOoujRlz6MYplnr2ZAatG1zDLJg6TAG2Cyy2p5v8ASgwQ5ZWkQ=
Received: from BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27)
 by CY4PR02MB2855.namprd02.prod.outlook.com (2603:10b6:903:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 08:33:16 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::1) by BL0PR02CA0086.outlook.office365.com
 (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 08:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 08:33:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 00:32:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 00:32:49 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=51129 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keZwO-0002Tr-7e; Mon, 16 Nov 2020 00:32:48 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 68BA112109C; Mon, 16 Nov 2020 14:02:47 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 0/3] Bug Fixes to Tap Delay code in SDHCI Arasan driver
Date:   Mon, 16 Nov 2020 14:02:42 +0530
Message-ID: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79b9a4c3-e72a-4150-e362-08d88a0a439e
X-MS-TrafficTypeDiagnostic: CY4PR02MB2855:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2855B2D9EB99373E48F7B9CFC1E30@CY4PR02MB2855.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbCwgWMLIT4mHwPNfCMu3W6yC+0eOjJlEJt6nXEC1dgmJTt3xW11FR1BLDlPvAm4h4RboTb04TiVqQo7GKxbDV3Ihprx3WQWBShmrJgAQQPx/WH6woqSNbfKrnuGXTKH4MUiUnz1I8AnhpKP0PXu41CdaiYIYsQ0cLGXsY8Owhcu9uBZ4Es+gRnHB8sg2zxQdsmY4oevTLBMOAWekKpymDTFdribr9lbRDHtMFQ7E4+5X9R4+n0a4sq9HL/3JoqF5BflxGMvEdg74EVekeHK+bn+X/xz5nV6ugOfi2VHC22nhub0Aa9V6A9I+fKEVqMqy4UlwFy+RrcSL+X/mdko/Dg30UBoBODhGDxfKOIHw0K8kGwh1tl5708q5V+aF9UBVDVueAEpcXNoLoqJjA5soqt5r1kjtx8yaDJYMnuoIJmJT5Cxz/BXChxsB1xaGrO3QGovl8+Yk39p6osqiFhsI92GVK77wnIvGn+Bxn+538WtsnCbRBhlm4uBuJCpWmM+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(46966005)(7636003)(356005)(82740400003)(26005)(70586007)(47076004)(8676002)(36756003)(107886003)(6266002)(70206006)(336012)(426003)(5660300002)(4744005)(316002)(42186006)(966005)(478600001)(110136005)(2616005)(44832011)(54906003)(4326008)(36906005)(83380400001)(186003)(8936002)(82310400003)(6666004)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:33:15.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b9a4c3-e72a-4150-e362-08d88a0a439e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2855
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set consists a couple of minor bug fixes for SDHCI Arasan
driver. The fixes are for tap delay programming where in some cases
tuning is failing for some of the SD cards.

Changes in v2:
	- Fixed the eemi_ops call issue by replacing to an API call
	  directly
	- Merged https://lore.kernel.org/patchwork/patch/1336342/
	  with this series of patches

Manish Narani (3):
  mmc: sdhci-of-arasan: Allow configuring zero tap values
  mmc: sdhci-of-arasan: Use Mask writes for Tap delays
  mmc: sdhci-of-arasan: Issue DLL reset explicitly

 drivers/mmc/host/sdhci-of-arasan.c | 51 +++++++++++-------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

-- 
2.17.1

