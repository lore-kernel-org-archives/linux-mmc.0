Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5558AC48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FDA613DB
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFOKqf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:46:35 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:61089
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231374AbhFOKqe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:46:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auGojrSxVlFmkMZNXCP6zYaSkGbP/tzb9kiKvSGfIl7jJcSoBLH1XTxfmBRHFbuVYoT80rs4FlFYEM1qAhbeA4iKZQZVCNxSkRAAjj+5pIYp8Rz8WigWDr/IpbG4p+V8Rfph5gkNkq53mK7ifW67fWD+JhdhN1kQesOavHX2gQ2ghHQQ+IhEvd6foJh4oQZOduqgOU/ed/LTVGcwTgzC38klQubldjOFZlp6tkSeamFupnInCFrFK9DMGB6j2TKXh/MAf3l4SbRrVwSLbZ7gNiBwqopuHSM4w+dh2OV7Tcs/yY5nd7Y8lpBMd9idNib6A4mssvF8aRna2RGQMKP21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVuBGQum2Iz/QL0uncgH37Zy3FPAUec+G/7MqD7vj2Q=;
 b=f7Y/6GFDW5ZaSB2o78U9cGMG7Rt2hXoFoLrlviCE9Uo8mja3gO9WHFcamsf/3/6dn17aCSLjJeOKizDLGU0X5ObrNP7PzeYGY4V74XXeLqaIhJZKp8t1QlxuIg+xSZFLlpo1RUvZM/99h9gFHzn82apFIn7RB9V/IeRrSjy5RaBU1iauI2qptF4GgGrOrIESMybR1ykFOCnlaeGFNea99xD+K3GjWtXSfnkiY2kOO8gk4HFkn2WIj/zjZD3qn6NDdEfSIpj+Tjqg4UZK8bBWeqbnCu2N+cu/3Nt2zNPA7NFlGflc2HD1FNmPoScGMAukVRq6dZ587+ZAlCZywdmDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVuBGQum2Iz/QL0uncgH37Zy3FPAUec+G/7MqD7vj2Q=;
 b=p2TBsw4ymlaoL2F0Yf8FnYzduTXjJXVA+DDLpdYbyz6RpIQIW7PxpYPx7qRkdB70FYiEq1ifzQXcfIinPspItkMgPAUQOvFJkMvj7YoG7t3+MuayUjYPdY4RD64IYLmh1w2XijihihFSliS0mi1nXXTCONevN78OvTD2S5PJouA=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 SN6PR02MB4766.namprd02.prod.outlook.com (2603:10b6:805:92::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Tue, 15 Jun 2021 10:44:27 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::76) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 10:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:44:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:44:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:44:27 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49383 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6YU-0002XZ-O9; Tue, 15 Jun 2021 03:44:26 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C4F6A1222B3; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/7] mmc: sdhci-of-arasan: Add "SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk.
Date:   Tue, 15 Jun 2021 16:13:52 +0530
Message-ID: <1623753837-21035-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 757522c9-adf8-462f-ac2e-08d92fea8c5f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4766:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4766698560BBF4B51A6B89E1C1309@SN6PR02MB4766.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1boD7rt+5hBX1MabtXu6IKpnkjwBoYo289XIRA4DEHuXhaNY8Cik7InvUoUWslCqFvfNY/+eu5cWarZ/iDETXCybG7sdzjIVp7YEk455IVam7fkqbkcR/tQyvAfw1xHndnLiPNV/ykBfx+R3Z/IDndhMQej53+IHvC65w25ORh9DrXzmM1gNnYUYxjxnp+r6g7tSdVL6EbAe9qspsd8Z14UgvBjX5IKGllxnd6IB4SsPhFAMku4f5fO3dZ+mJI/RCG6JtyQuZyhg2q3JJAi2p2QbjjsRhizpUR2bFCNFeIa5+qRYg9h/KSgj5Bu8lqR3ZtDlMZjhQR5NkoOvFh+MF021zaLNn5NsBVlXDaOLoLIICd90fatj64BS12h+fy2m5iwEicwHIuJhUi0T8o+kOBN/TgJfX8AbMnB7ez4UyT2otprVM7+bLs4OTcNfQf13V3pPVzvMeecxp90vtg2O4uRIdo5wxQgnoAd+SQdLa8MVZlWnbX68Z42qhwSWPXaKz4D1nTQZz9x9RVHKeGONFAauYC5l5MCR6eYB3rWOmk0LGn10GdIIyTyfZuVq3UI2stQoSyw77Fd/vBQ9ni6P2A+7Bc1EPRgbmsK/Me2QIjuMxMT+Tk9fQD328czrWQadwNIRsUGUn3aBksRJOmkdVJBcmCuIDV+fOQsvGNNZ+7POYGJO3NO8KvIbf+IK4wVt
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(396003)(376002)(36840700001)(46966006)(36860700001)(82740400003)(83380400001)(186003)(2906002)(356005)(47076005)(82310400003)(54906003)(8676002)(70586007)(4744005)(7636003)(70206006)(2616005)(4326008)(110136005)(6266002)(478600001)(107886003)(44832011)(426003)(36756003)(36906005)(316002)(42186006)(336012)(26005)(8936002)(5660300002)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:44:27.2659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757522c9-adf8-462f-ac2e-08d92fea8c5f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4766
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Arasan controller supports AUTO CMD12, this patch adds
"SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk to enable auto cmd12
feature.
By using auto cmd12 we can also avoid following error message
"Got data interrupt even though no data operation in progress"

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index fc3e41c..b13e719 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1616,6 +1616,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			arasan_zynqmp_execute_tuning;
 
 		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_CLOCK_25_BROKEN;
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 	}
 
 	arasan_dt_parse_clk_phases(dev, &sdhci_arasan->clk_data);
-- 
2.1.1

