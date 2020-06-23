Return-Path: <SRS0=5biu=AE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF19C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2848120776
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 13:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ozbYJ0dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgFWNef (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:34:35 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:45121
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732616AbgFWNef (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Jun 2020 09:34:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9GG1NyI6WMtE2Hl9BUh9UeAJd7ZqEHvyaBQl5qHGQzI1FbTedkHSBM5d+VOiBCAACp2EpldAWxB2asbLoyFbWnzC47aIFfYR2vsocNd2frrt4KI3PlLBO+ENcaB2Z4TS2pjbtfoUai8X/6G/9RIhbyu8nogOwEFjHlO/V4n6lE3EA/8pGlsKPOf5kXcgnWIMfTJVwmdAmPXxSWGOITzYhPWLzdNWB7nq/JMUQu4jLPx66ZkyGWFG4yh2wfTf7UHBJNCFEdO9Bxt/zIiQEix0zTtZS0HLO0T69X1QJB/4XN4QdrJChqHqq2CDzXusgiX5zqCXXgR9oNUvjiFcjHeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDxamDF/moxkEaZGQvhjYbbTsUXZMOKillh/xW7cEVI=;
 b=kak4yktmOG0IP9MF7Ox4Prus82dv3lQNjE1DK44nEwYfV/5QBXwQHxRFF8na0DzGGGUBmVku4dlXFaaNzmzl1oHrhh5aupWb2lSiKa1qskY72EI56aG99DuEU4wn6czebJxV73HDfQrSNcdE0ZEJzM6sHVW4Cdprp6ZIxLyskzEXn6wLvPjf1pNXxahbKS25lYaBbg5WWQhT5wkOVwEcw4Gzwx05/H5M5AEKp7D4wywyUIf+qRykEDVL7k/58E8SDzexY+7CFYQ09RJWebtwk5RDXS1Pp8juNMLF7VOpGiZJEmU1g+39Lfoe3R81NkiQYOP6lfWjKPfLLpIzOwT6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDxamDF/moxkEaZGQvhjYbbTsUXZMOKillh/xW7cEVI=;
 b=ozbYJ0dZHrpif/XYdhxOMMNdnnqE28oEN/uXZAnDYnQyaQ0MJoRYq02XfT3ZqaG+PrR6H2l93pI8qkTQo3Gze8KWsUF4q+mLJThgIaaAtI1V+mzOoIoWANdxmQLj4+mHO/V8bi4t7NWlZZrERIsbC0d2UVYTvu3SfkrT+Xq8t0Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) by
 DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Tue, 23 Jun 2020 13:34:32 +0000
Received: from DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::f51a:1689:5079:c01b]) by DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::f51a:1689:5079:c01b%11]) with mapi id 15.20.3109.027; Tue, 23 Jun
 2020 13:34:32 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, rrangel@google.com,
        nehal-bakulchandra.shah@amd.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: sdhci-acpi: For amd device set driver type as MMC_SET_DRIVER_TYPE_A
Date:   Tue, 23 Jun 2020 19:03:27 +0530
Message-Id: <20200623133347.4598-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::25) To DM5PR12MB1337.namprd12.prod.outlook.com
 (2603:10b6:3:6e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G4.dlink.router (122.171.36.38) by MA1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:34:24 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.36.38]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a04825e-3573-4beb-4003-08d8177a2964
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28098424AF0C17698AB02563F8940@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v82p10kRJhs3hjNigKGN3Yb6ZuI3J8RwJDD+RlC8VME+yPdY8Q99JmoiZl5UkTJn/in5L9VMppHniHWJpIC3wvglQnOKyIaczqtUIHF1TIk6f3j9oOvgpVSMbqaMCDeln8WckJc1eEobSm2UpchZR2i1u2po6ZoZhumnudefPgrRyuRamqkoQKfujD9D62MXlsdX7QfeBehU2c2MbIFDjGzDP8itvB/TqahZrRlUTk46mx4/rU1qtaHE/wC8Txvna43QaEdjLQ6/bt1YWkhKTDCODRKXi4gR1a194T0QtH866Br3Hx9yISm3R8bOUw1TNC4ejPK4m4zpgm7aa5+uyKoFSqlay3zYhv2IO/BbWy072y8JbxtpO/Zz3N54Kvwg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(44832011)(8936002)(1076003)(8676002)(36756003)(5660300002)(86362001)(54906003)(4744005)(66946007)(66476007)(83380400001)(2906002)(2616005)(956004)(316002)(66556008)(52116002)(6486002)(109986005)(4326008)(6506007)(478600001)(26005)(16526019)(186003)(6512007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B/QpJz/RqeYG8t2uuC5TYluuRgqFktMHmLFKLpJWiQBDgQHM6D/iTgYgVSlLc3DiOsq6ZrkIR7fk3MIheOuKeZUuNiUWMVuXEdIDgrpsXkA+nw6j/hvGVlakQiwbyjc1trYtN6W1E3mFkeb3mV3kJlbU/kRNdforaoe91k7RDMijsdtblVLIlc/oHz2LN5PTCXnKiVp4eJa9iRj3lbx8hkXZ3hQaDWyX8YRvVQ7L9sVIFEIxW/o/YnInoc/jxbv15bkcC4AMSVHeKRCnXybrkuiNR0GgsI5Uo9FfueW1JnOWUpduSLh0N6W2ofHNyNsrsvllD1I8o36RL728rrCsVU0n03j5wiPz2c5m2XLg50kf96SKv5O7GgVTrQ+oHDjtW9iBFnyv085xUokPHG8UE3rps4nCEYXVmtUEtiPpPvq4RQ1X0MswrmAViM6Iz481HrnIplOGOUuds1XCTEGyEMlvDTbxUobLFE3h0m4Yafg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a04825e-3573-4beb-4003-08d8177a2964
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:34:32.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoL1IZMDHbX/ezNZSAhFElA9KnJ/i/AkSNKigbAUn1L/yBpPENYREN9s28m+hL4j5BC1ADwG8o+zpeYrmQKCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

HS400/HS200/eMMC HS doesn't have Preset Value register.
Hence, sdhci_set_ios function overrides the value set by fmw to
SDHCI_CTRL_DRV_TYPE_B.
This patch sets drv_type to MMC_SET_DRIVER_TYPE_A
so that host_control2 register gets updated with the required
strength value.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index d8b76cb8698a..48ecbd0b180d 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -542,6 +542,7 @@ static int amd_select_drive_strength(struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
 				     int card_drv, int *drv_type)
 {
+	*drv_type = MMC_SET_DRIVER_TYPE_A;
 	return MMC_SET_DRIVER_TYPE_A;
 }
 
-- 
2.20.1

