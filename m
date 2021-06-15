Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6507CC48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445B36115B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFOKrR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:47:17 -0400
Received: from mail-bn1nam07on2079.outbound.protection.outlook.com ([40.107.212.79]:3812
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhFOKrR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIW+ikb7X2D0COR6O1FfuiOa/xwWOouVmiUs3XYeJxkTxd9Ffv4U9MfpZUvmGuZ/J8/0P745/Xnze1f1EBdCk44wpix0psgLqd182CMgSFPt7hPxjS+f6/2g+ZKo6VSH9ISu0zlltFV+yLmYvdTb1Ixf1/i1kdZIrD1aaS4Rwvb+PjioPS51Fh/8vsLspEuoNYNYpwQExp37b+1XPgyqBoS2Pi5iH2unTe9N0enw8nuOPRKwrcF1exeRkYIccdgswYjU8CEWonv2f/1AdD9lCUh2uQLxYuf6DLIJf4HOf4W7AGQ3a5gX1XxD5yKPRrqs+mM2fzsjwruyd8IZM+087g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/X8zKCxDl0F6JjqNWYyfnkEY7MErM2FR9FD1EBp5sw=;
 b=QDDO4A97IvkImfQzwcnMtWG4H4HiLklJ673H2xzXiZBsX3VbbYNcoRWuXrvZ8rCTONF4VMI3BzTvhpr0UEpGVAqhSkthVKWUg6mSw+IF4bqC+VUFNL65ZRri5D6LQ0iJoumxEzqOQHiIPYIVYL0KFTGDLJHzHzohaOxCaz8SErfrb8Q7lgWUTiBYkEzVhMjbYtOthvHiUbs33Cxn8PcqnWirRQwIjNmMOGRzUHiAIxlX+1lXpEZgtwajBiKCptYlX/Dkz0Dc/4iOJ5+q2mkd5zEqKBAgSyIm5fa7CiJ1jd4mD+fiyY8GDdNAZLKolpFGOy/nzDlCxp3BNjuEgx5kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/X8zKCxDl0F6JjqNWYyfnkEY7MErM2FR9FD1EBp5sw=;
 b=g8Ir1y6c0dalAyDvFCOSpQMz0/hw2zbcuNGAENY6yinhrBSKwAZrSy4NHu9gHyRjiL+cRSuHhJkhEqF0UQW7Wlh0m6B+9imVRqtHBZTBU4A9mzrNICGDNGERU9aeVy98PDMX+1Oj4MaYIK0E7fhztVN7xK2wWIdwaYBbpkW+8fQ=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by CH2PR02MB6491.namprd02.prod.outlook.com (2603:10b6:610:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 10:45:11 +0000
Received: from BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::38) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 10:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT056.mail.protection.outlook.com (10.13.2.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:45:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:45:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:45:06 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49393 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6Z8-0008QQ-1f; Tue, 15 Jun 2021 03:45:06 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D84E51222C8; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 5/7] mmc: host: sdhci-of-arasan: Use appropriate type of division macro
Date:   Tue, 15 Jun 2021 16:13:55 +0530
Message-ID: <1623753837-21035-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb594fb2-7a52-433b-103f-08d92feaa69c
X-MS-TrafficTypeDiagnostic: CH2PR02MB6491:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6491BAC559327B8053688533C1309@CH2PR02MB6491.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nw4CTZAF6GkAZf0vap7tBgdEqZDlzOiGcxEN1ygENHzz8T/ZL436+nTLUaksMHpeTgnMiUPuw11hXRPRfmq+nmZd6AqUxdbTSZcGL7HFzLWFig3tyJ+ZW6yn0nkABj81dwTKDSd/KsL9GOwKomCCKHh5z1zWio1qOp8aGttv1jtDKY2dZ5wsVptq3s7hsN9K1EdUrIHEsOHmbnSfWMfpocejFe3XiVYcysvpLi58rwCo6APc60/9nKmeTS3t1ZFZjLmfxANw4XJYKA5CP9UGef7VdevYySL67Oi5MlpYHcT/AUrlrPCrH+UQrlkkoubcY4VtrPtFyY5PcOqfc/gwcaEvpSAF1yMJTVhKqk0tuhw/K7IEiDfj7EShtCB/KDAVnyxoQDaJfXStHCEKKtmLSm5MiTQWiVB4p236vsP1qLj6KvGUlnKo81zMDnCkxLbde5CDVUjLZ6C4dJvWhI5na8aHvUDF9QVbfrL+dH+AepFigLIFtiB5m7YeAFxII45gZsBrecLEwRmB/XnJrhr6LDO8GbaAF9qaYFkXvcvNAV0L2CNd+15LQjUa1LSi+l9PmNS6oD17KM6HH5d0JWoTyYdvKyEipRJLOnOWZRu3KIV+HeAIUD8YwaubEPCos9a4YjEM/Hok+1xWk8I/ipzRMKJhywUG5DSafK8/Iz7BEjdMqHpSORcE2OGZ1U43Ix4T
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(46966006)(36840700001)(8676002)(70206006)(6266002)(478600001)(8936002)(2616005)(5660300002)(36906005)(4326008)(70586007)(107886003)(110136005)(316002)(36756003)(54906003)(42186006)(7636003)(186003)(82740400003)(2906002)(6666004)(47076005)(336012)(36860700001)(44832011)(82310400003)(83380400001)(356005)(426003)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:45:11.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb594fb2-7a52-433b-103f-08d92feaa69c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6491
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The division macro DIV_ROUND_CLOSEST takes int values as the argument.
However the code here uses unsigned int values for this, which is
causing the values comparison with 0 as always true. We can use
DIV_ROUND_CLOSEST_ULL instead for the same.

Addresses-coverity: ("result_independent_of_operands")
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 98671a3..510d8fc 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -984,7 +984,7 @@ static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
 		sdhci_arasan->soc_ctl_map;
-	u32 mhz = DIV_ROUND_CLOSEST(clk_get_rate(pltfm_host->clk), 1000000);
+	u32 mhz = DIV_ROUND_CLOSEST_ULL(clk_get_rate(pltfm_host->clk), 1000000);
 
 	/* Having a map is optional */
 	if (!soc_ctl_map)
-- 
2.1.1

