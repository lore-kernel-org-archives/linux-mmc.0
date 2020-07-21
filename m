Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2586C433E4
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 01:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B53206F2
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 01:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="JWTgx1rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGUBSH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:18:07 -0400
Received: from mail-dm6nam11on2100.outbound.protection.outlook.com ([40.107.223.100]:10433
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgGUBSG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jul 2020 21:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8b4vzv07ZOrqM9Vz9dd4IlXJOpmFJOz9OPSy94Y1XrNozXY0sfh24UriDpcNi8//JVmdag7ibJGY4Z489vih4uqoSNoZaI2KPD9aYTH0H2/EfYkk9DuQnJxGcOuIm9Pj10wNxuaQdZuzDWoNysptIhs5w04Tw5E0JxL/Kw8ZcklcLUjR1kdl6il/spjLSKBnPs6u0XeJSM3Dj4z7HXdmdzfN8XAwoG72emo4vMej/yWdaL0jV62d5HXdN3KsDchAp8Je5cEBUJwGKY3+6vtEeJqI6Wtofm5nYqabMxzka0UKquWp8gwZKdASms4BR1MXOLMrYjy0Q7eEPcTaVyI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlKR2OEbzbhnuEMZNlgr/+dFFTrhJFys8wUD25f4VbA=;
 b=S+YJGjkuu6IteyGTdDnf1HhLHp/8YIHrt88MiI7mJjYZVBvnxXl9hGLJtoUNfzpCu59Y5eY+kbOndiq0BvoFwQyheA512379IvzCIIvpEFzHeaSuZWvbt/lhXtHvWhBRnSkZbRmZc0usscPL+3lpaADaRo0wGtPWRj/spGuzL2cJkaXGTngS6aPoHSnzlWg5hENx1oO9a3oEMg6jKyOfBGdTBNCmERe3UfK0iVf6CdiAwN5KfWkE61/pu/Hx6/mxucz9/3Y5pTl3cFKuAYhxubV83CNejGmbSU8kjIJbaNJxQQWXWTVzShDs18Bo63HUBCLUAlbE1X+iZaNMJy5KRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlKR2OEbzbhnuEMZNlgr/+dFFTrhJFys8wUD25f4VbA=;
 b=JWTgx1rWKlXVTzc+9z9hCrAmsu8RNigRipCvuxOPM+D0Yn+3QxMYW6qRfBO4qcJQx58oF+zMIRDAKgMVCgAWrNV2s7uliHU7xIVUovEi89rRQ68tRwS+QHT8QMiBVbdhHuYNwwChhI/+3OKoDHN0l69ywygn8o+xsTmuUcXyrFM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bayhubtech.com;
Received: from BY5PR16MB3319.namprd16.prod.outlook.com (2603:10b6:a03:186::25)
 by BYAPR16MB2453.namprd16.prod.outlook.com (2603:10b6:a03:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 01:18:03 +0000
Received: from BY5PR16MB3319.namprd16.prod.outlook.com
 ([fe80::fd57:47b2:eaeb:d004]) by BY5PR16MB3319.namprd16.prod.outlook.com
 ([fe80::fd57:47b2:eaeb:d004%5]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 01:18:03 +0000
From:   shirley her <shirley.her@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, max.huang@bayhubtech.com,
        shirley.her@bayhubtech.com
Subject: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: Bug fix for O2 host controller Seabird1
Date:   Mon, 20 Jul 2020 18:17:33 -0700
Message-Id: <20200721011733.8416-1-shirley.her@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To BY5PR16MB3319.namprd16.prod.outlook.com
 (2603:10b6:a03:186::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.36.105.184) by BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 01:18:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [209.36.105.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77fe79e-92f4-4f87-d50e-08d82d13ea58
X-MS-TrafficTypeDiagnostic: BYAPR16MB2453:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR16MB2453063ECEFAC40C97730D1C8B780@BYAPR16MB2453.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AsPr1QWGyZ/OIMH5xkkkg7JMVsNBiEhxB8CAl7uMbs8OJrB+cvaqlQVr4KchPk/xYRWT9H9lVfZjdhuPACqO9oqNjevmjd+/qodmsoEyYsoeimdxmeaqrKhBIhYrx2LVVNjgi7W/UtciD7ZvIZcSBbkIynVxcJGtWT5ml/W8Kk3yjr0khaJhv+l1Exy1EfrPz6DqlocRc0MaNAWhl3Sbr0MtKbACD+nzBBngpf0gkIAOn7fZmw09SXr62IaJ7Q3aqDOUgPhuTYB+nKO6DBD+i6ay9Z8pa+W5iGswULixdlUYGy5afFN/NY0IPTs22CXznAlVEZBAyQ8UZMVPiSumUMSrO/burr1+NdK0jV6qrj4Sr5PlhvrP8pyp7/wWJk5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR16MB3319.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(366004)(39830400003)(956004)(1076003)(36756003)(6506007)(4326008)(6486002)(6512007)(316002)(2616005)(2906002)(16526019)(186003)(86362001)(52116002)(69590400007)(107886003)(4744005)(66476007)(66556008)(6666004)(66946007)(5660300002)(8936002)(508600001)(8676002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2YtkeBrqdqu2p0dB27f+lZf8J2b6qavpv1AkVH19HitbV2ILCbpDmu85yzhMKNaGl3XQM1j1jnTI7GunZ6zE2ERG8AIoZJqbRRCiqJzmXZ1gaOfBUV/6ADGe+63OTUrDCU3MGJ+nJ+mdKdSzRkexogkaRCyDq2STqQNeBwwCuC9+YYqknZRgERGSEmlEP4kdFr8Gl6x2NR+JmWpkFp26xhUmFX7GqMmvP4aBgEnbRcOZp7hHV7Tcmb0eLmtKFQFROyO0oIF2U6IZeWBNOWOBgTM5Nw/QPBBBo/5cliexzdizPnACH4TcuZMStaudyvtgBMO2BbiOV30M74gnUYLGe4/vYUDDu69FSSexCDSGVVXCwCzRRgclTjqrCYzijmtUXEwVWuodntysHwWEKzxFzn3MkbsOF39QXqALT9Nw406NES5H+A/4wGougCWB9T4Rj0EXl+IBMsIvoUVpwxxYLEA8tEv8twp+rtF3yQ6p5JSOhVWFOE/9AZaNd0CDfluI
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77fe79e-92f4-4f87-d50e-08d82d13ea58
X-MS-Exchange-CrossTenant-AuthSource: BY5PR16MB3319.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 01:18:03.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kggi/P+JyVG7eOVo9LWeQq+rFRuUArdbZThUoHWDZuWr9UsB/8S9bvBAx84C1xoybvtbOmtM7wxj2L8F/yAK4qRQ7/ndMq2IeER00ouYGHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR16MB2453
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add bug fix for O2 host controller Seabird1

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
---
change in V1:
1. Add quriks2 and mmc->caps2 for Seabird1
2. Add get_cd support for Seabird1
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index e2a846885902..ed3c605fcf0c 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -561,6 +561,12 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
 		}
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD1) {
+			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
+			host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		}
+
 		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
 
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
-- 
2.25.1

