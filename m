Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA08C48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C046137D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhFOKqL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:46:11 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:39617
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231570AbhFOKqJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmVJbEvHUHJKSYLWp8RisuVzeC5OatUGtxETMdrxb7/mKDSSQhxUUlhOT6P+zASLjsGciVfhrx0PgxLz7gAURYczpkmpVCBhOaAGOxA9crdoJQLi/NChRNFT3eoaa6/bMQnfGzfl0+w+SkDcrt4r4paAtSN7zPym7CKJkU43uNg5q5RbWMkwvy5mpKEzhzSaM2ez3gaasp7BU9rthFEZRlTyFAJmvJBb8y+R+2QlKcZwSDz8YHhqj6p917rb2kSfkJxkUY554kAJy7Z8DvXjsGY4Wt4NTfuFJgQMNbXcB95Ty3Zb4FMyf0rY6xO7ULcRdMb1XMXQU/LQyedQwDKnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5I9MOv9ksl0PUeFCntPW8DiuzK5sCbJvgAJBgHPN3g=;
 b=fXXduIljPjF0jCo0kWUu3yWLaP7uDeCOHgs0j5dmuQPMLVh1QWlk3rJwxa1+70tLeo5yoOhx5KNWink/NJugtKSmbvSzkJoiwjZP4puc6SJ1why30ip4aLHZJz9a0qJyqUJcoUNbXApNZMQWCmWpWGKmVTnv+L2cjIGVH3kSvzMw6vYFaaBexSYu0u0X1reh3olY3Y4GzF483YloT7BrEVkB5L6A3LuGncr7paTJ7wHiqkHm0UrD1YhzirP5jXho0h/uuwNYl3uYtagdx6AkMPCOIlQef5T8tmXMEKmVRIyg6a8+L0xZiMPY5OUnsR03dC77NCSZ7TOyIv4Z+oEUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5I9MOv9ksl0PUeFCntPW8DiuzK5sCbJvgAJBgHPN3g=;
 b=nuAUd12yHWWVdTuK3JAqwy5GZhwiHz1EZT4SEfdpUBVz71dkUgw7AR3yM9cOc8ywRwsROTAfGNiqthtYEBQHA3AVTA0FEWWI9GNBzE/6XYn7f6exW8rGyWHmU/g4IORQoEWLVIaLxMdVM/5yGCVe2FGJu+kL3B2Yq/AMxSp/PSY=
Received: from DM5PR19CA0041.namprd19.prod.outlook.com (2603:10b6:3:9a::27) by
 MN2PR02MB5904.namprd02.prod.outlook.com (2603:10b6:208:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 10:44:01 +0000
Received: from DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::a7) by DM5PR19CA0041.outlook.office365.com
 (2603:10b6:3:9a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 15 Jun 2021 10:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT047.mail.protection.outlook.com (10.13.4.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:44:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:44:00 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:44:00 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49373 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6Y4-0008GQ-Hd; Tue, 15 Jun 2021 03:44:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BC51212225A; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/7] sdhci-of-arasan driver updates for ZynqMP platform
Date:   Tue, 15 Jun 2021 16:13:50 +0530
Message-ID: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb85e66-4909-45a6-2e64-08d92fea7cea
X-MS-TrafficTypeDiagnostic: MN2PR02MB5904:
X-Microsoft-Antispam-PRVS: <MN2PR02MB59047C06199653EAD99713ADC1309@MN2PR02MB5904.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB2oOPdJyCoKOf0I3w/JKA4GXYT0W09nUZGxU9MewZ2OpZEZ2EncooomxniRF5n17w42Zhkrom4E0HLCG0gwLK8paXtXVqcgTARhUi+qTbJ3g2M1FPdzJf2OpfRUvJssdl84MLHqvMecJhck0ekM9YJPBgUpsdd7QLjssLHCSsJSF1tEMaFBvoCgR6feEOrTk/Sa1QCwHFvxnl4MpImtt69ysTTqMF0StMubrrJx3RBYjI2zKbfFTXKRdMqA5dcZlayfmsyACnFp0eJ/+e/0/FtyOk9YVDJxGXlHfGwrGfFsKpOQzn/UrlAbVsRSXQ8McXL6W5AoGBKIBYzb7DPbXyrkaD9OsSe4W1n4zekqnk00cK7QT3wTKRlvipHuv/k4tv7/SmWRepgSsuMmsZJLtQVoLKoTks8tDCo6s2UU40tUaWoeNRNTlvngcDD0Gop5dcVZspKuTHP9Xlcf7y4H4ZGRJNrkKhMkCo+WpjixZ5dt4wFbii1gcf5OYKqdpRZ6gYcGkdUAEjOPs6BHAb0A4PsbDdJu06xOvgiByQTDii/crwYJFy5an/Mg9z6DoLWWjf6sPRZkMM2IpHRjd5eVgIyLuCb6aaTn8AQzwKMGRnxJlxkOLU555rwrgj9NkDERQT5WvMV9Q7j39WZA6hM1QqxS4Z6Tz0Q65s66+4MzvI4EVTty7J6tqj8lPEBV+OJz
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(36840700001)(46966006)(7636003)(426003)(36860700001)(70206006)(478600001)(110136005)(36906005)(6666004)(82740400003)(54906003)(83380400001)(8676002)(2616005)(356005)(5660300002)(36756003)(44832011)(70586007)(186003)(336012)(47076005)(2906002)(4326008)(82310400003)(26005)(107886003)(4744005)(42186006)(316002)(8936002)(6266002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:44:01.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb85e66-4909-45a6-2e64-08d92fea7cea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5904
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series has some bug fixes for sdhci-of-arasan driver with
respect to ZynqMP platform. This series also has some code style changes
in the driver.

Manish Narani (6):
  mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
  mmc: sdhci-of-arasan: Add "SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk.
  mmc: sdhci-of-arasan: Skip Auto tuning for DDR50 mode in ZynqMP
    platform
  mmc: host: sdhci-of-arasan: Check return value of non-void funtions
  mmc: host: sdhci-of-arasan: Use appropriate type of division macro
  mmc: host: sdhci-of-arasan: Modify data type of the clk_phase array

Sai Krishna Potthuri (1):
  mmc: arasan: Fix the issue in reading tap values from DT

 drivers/mmc/host/sdhci-of-arasan.c | 51 ++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

-- 
2.1.1

