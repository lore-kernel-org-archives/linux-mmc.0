Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D8C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 03:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhLCEBk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 23:01:40 -0500
Received: from mail-mw2nam08on2115.outbound.protection.outlook.com ([40.107.101.115]:4684
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231266AbhLCEBk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Dec 2021 23:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHk8OT57CxZzQmRtyF+fmQBy0d9dFHBV2+CtGdCcUb+zqB3l0yu/dopaaejv7RB3Na7w4J9Dn7AOFVg1ffId+KTBGiiopbOg+yHNdR+UeqVUZsL3PMbxboWDEWtPy9v4ic+c8lc3/Q5Z+Zqu03zHX37KqsAL65wmZW4J3pLUs0IfhqL1pHUaaQSJVhtAbQCDph/PKBMsHySuhqZbFgyeV7cYMA1Txq0aZv+yWpSGRsHrtxEdHZSPTkwUoW8pxy7juK/J/KqaOWiPxyawv/ajddTnSlrqm81FKongwF8lkTH/nBP/1PmqHfru1KMXNiAi3NfeLlknGmxzzDbHlRd2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyHif4U7NCYif4EevF9nuQj9xQojF+jwkBTZ1jdjKFY=;
 b=SaamsKn2hcD0JKb7qGo2AAi25ZLglCU06pzm1dKmEUmbZt+7fMmmL4B10IOMgAWTO+OrXvQ96GmBUydKwktR9SKaCaMD/sxFsK1freMsnZ6NT8lFkuVC9Bn/JJFnW3XYEIKa6TtcF7kXasvp71KTuupigtp2Hby5En5edqn7stCH9ojxrIK/MG41sEWnEFukYj8Z8hFmSlal1M19I6urJQk5+JVT+7AaYwxjqrjQ28EZcRqHhngno01geW0cZU00QMIPppMzkIeMFn2OCHb+ZQ8dYWcQSyoSNcuc3LA2oZtMlue4nRvdFXvVk/vGhhWpkYwqkHAUVk/HvP8b9JvEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyHif4U7NCYif4EevF9nuQj9xQojF+jwkBTZ1jdjKFY=;
 b=W8RtFx5xfVM74MxrO1ouum+HYcAjmYSQcy6CAn5BqAs8ErkFjTYTiIk2yWFVvdTgy10J8qQW+H8xVEfEv4Yd9fPSam6/wKG2Hz7U89tqSpId1c1r3bYI7sG05X+C66+wopolduLWpF/jTcSWc0R16T+E4brcpIc+MRX6mQKw95E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4443.namprd16.prod.outlook.com (2603:10b6:208:342::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:58:16 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::d867:83af:5891:8dff]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::d867:83af:5891:8dff%8]) with mapi id 15.20.4713.027; Fri, 3 Dec 2021
 03:58:16 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V1 2/2] mmc:sdhci-pci-o2micro:Change implementation of setting corresponding PLL frequency according to card mode
Date:   Thu,  2 Dec 2021 19:57:59 -0800
Message-Id: <20211203035759.2183-2-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203035759.2183-1-fred.ai@bayhubtech.com>
References: <20211203035759.2183-1-fred.ai@bayhubtech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
Received: from DESKTOP-G2V7PLK.localdomain (2001:b011:4001:97c5:5199:8767:2528:dc2d) by HK2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:202:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Fri, 3 Dec 2021 03:58:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51331a9a-6667-4e8e-955f-08d9b6112253
X-MS-TrafficTypeDiagnostic: BL3PR16MB4443:
X-Microsoft-Antispam-PRVS: <BL3PR16MB444391E0B481BE9AF0EE153F996A9@BL3PR16MB4443.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0jsreOmMRvpjKwm7Kp5DkpUoRYAzWMN5Gcz35plT5555MQ2jMFe8z4Yi/0D12/4FpJGJ3uZrnFtlPfStCXyeNdPmeY7P+fgEGyN6hlQulM5K8Q6ohDjVCA8XzMgYs47e2elhU3BAzCw1RcgBpafqmOT3CoCt5Fb9rty8f7gmTo4wUPxyPShV6O3va9avsei1Q//0qOWDf/0VzMrIztr8QqrjkFCngAGpE8CFqdjvAndeRJnlosfeci5sMBjQC2LjvsMvP88f83m0O8yBGGl6rgJi1C3fJwWkw8Vh3cLdFyEvYB2PLxOsReljZPXsUOunjDje1Z0YvAVIPhpO5ZTYSvYwvYRbx3NgNfRRAoUk++KZUKwF389/NlL4YlK1EvoAzvaWwqZXtpG/QGOkJGsX/+ll+mR6ByzwhtQepLwbzn2e+5gb/FOmriRXr6KQUl2u3y8udspDFZOTKDD8eELDzNWm5AaiArNBANMtXM3Q8A4FQNtxJKF/I75q8FsxMuk26/se3IKMjZQIw2Z/TP1xnoFLFuM2mPnv9bktPKpAJZbCO8He0ieIMQabuVo82xDhfEfQ/lV3aEdUzVp5SiUswlV4bBAiq+rKxWaOCYcJEk43SJMfu5c+L6wjM5qbR/G81i3Gn8miycQenL3Vh2Sig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(107886003)(1076003)(83380400001)(8936002)(6506007)(38100700002)(66556008)(316002)(186003)(66946007)(4326008)(52116002)(66476007)(508600001)(6666004)(2906002)(36756003)(8676002)(6512007)(6486002)(2616005)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZIEhHaqkjsenKunaG2Q1i+FAzd6hzjmPdIGNcxFqtFPx4jBzXJUTtkNfXaQ?=
 =?us-ascii?Q?3P3dSGPzRQgawe3Ac9IfwGOh7VHTBvn+nzxuAwhnVPgCINm0VG3FFHTTr0A/?=
 =?us-ascii?Q?+Mvcq4HBy/61zMiAFMKYi0NYmYdJHcOqCIOzOz6uAC32A4I+Eod3QgMKRzut?=
 =?us-ascii?Q?kRcyrwJsYaSjJzDehhg78ndL5Y7hn//qeDf/jCT210VcSlF/utHJAwgUAXhh?=
 =?us-ascii?Q?iiKlzjJQUaoD1hJHe1BlFjB3seenl4tQWJfD2a8laiUzkg0qSPonDbjLDFnf?=
 =?us-ascii?Q?RAFTOx4s9IAL0zo9Iamh2+tJt+tPPUWAoyo8G36yIyc42q+7yhe5a5yW7K8q?=
 =?us-ascii?Q?IiGGj97Q5witTznZsa7PMbi34Y105pB3Tt0ZVwolzFMtf3gjd1OJLcSzjVzm?=
 =?us-ascii?Q?dtQSHHMc+LAPR+aBZbgX42sq+dAJXieZt5+sZ76FRXT+xplem5JW2irTR+1T?=
 =?us-ascii?Q?o34wC3g8GydXqRETw3tYQ6MHWi7OUAZFEAJmOQu1vL+9A4YnArdTRiCiWZ36?=
 =?us-ascii?Q?mH48N+x3+9BsouLxwc7tY0nhVLhbwNgRQUhV3uOj8o+1//FdKBR4Ey84mHxM?=
 =?us-ascii?Q?UcQOUuNEFiLeCQ7qZ+pXLhNKNGqDLxU1Idu0uuuMv4VlEDTrG+ev9M0McbZe?=
 =?us-ascii?Q?G1x3UWvwhIw3O2bY59pzjANLX0+M0AaB1v61yuZQTbXDIkVeFNG1vvFJNAVe?=
 =?us-ascii?Q?ZjPqFNc6OAV8VcUWwi71cl/2SeRliIiyJ9lrkOvgtS4Vbr+OjIkI4xI7abBk?=
 =?us-ascii?Q?7FbNuRJytKec437nWHhUYZ8sj1H9A6y+5NxufU0ciS0wqFICFKux3tbiLOlr?=
 =?us-ascii?Q?4PEm9EBI1KRZ36EfFK4nPSLHPqXbWwLzn5MlKvrJIZ0REoLUE195415dBoUi?=
 =?us-ascii?Q?61Jm4jpM2bdizVFb+JRVwyqKahmH6/UgzNRRDpKKvPt9z9exPDhYFunQ2tbg?=
 =?us-ascii?Q?RD7rntMxknIi14E1dV4yGBgApKQS1KA6/ezSIpKK4OvnkhlORNQFaol8PT6+?=
 =?us-ascii?Q?whUTXOQLkQHEE/JDAi6MwbpeXhIn+qhYBTQg8mlo2JRpfF3VZ10yakus1nV7?=
 =?us-ascii?Q?oh7kFlrMExOMH8pmOVjboJUjHLZbZm3ytQ+xSWyB9WekVbnOQwCYdmPVC6jC?=
 =?us-ascii?Q?lZilRQhr54BzEdhGvDjmHdtx9uAxI/qg1wZsxkCbSqUuP/ZOe1/PTEQw/RTq?=
 =?us-ascii?Q?BmKgBjDzzWJIPQBMbtqpbbiatufkK76PFdAprjCNDKmAvpmu73ECNYeQ7DuF?=
 =?us-ascii?Q?orDGrZy0IvNi2nwXdR5VuE4Qzsd8h89eKcvbGyUarbQDq3iQIR76a+3qJSPF?=
 =?us-ascii?Q?NZJfd1x49HuBERxFOj+d6ShDNae7nKMq1rZ8TZ+vJDd7KGoKi1U7lGroiVzw?=
 =?us-ascii?Q?BDxvE1752JbhV5jatOZt1uuq+9B+qhqvnsr/TT+F70r+cmcaaTHcnsqC6e4W?=
 =?us-ascii?Q?JJXASad51zu8C3SukRgllxAyf2e3+NYBN14B+80WW/vqQDeB+snG2ilqEn1u?=
 =?us-ascii?Q?gtoLS65yZrJaq6iUq/eMZgYCsCG6ujRKqht+fWIWhhdl66LnjCKb6wpYWLCB?=
 =?us-ascii?Q?ydNk77NlJ3UTzbP+1tSBJ3Ds8DlEILFyOvPv2NbQfC837LeA4UvfzYez+ftR?=
 =?us-ascii?Q?VM9xsSwE0iTeeSuAVp/stCiQehMwTChRKAJ+Galc/LWaZqWhug+anyfTnEWX?=
 =?us-ascii?Q?fgQcUEe06YttRZhI59EXrKeLK6M=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51331a9a-6667-4e8e-955f-08d9b6112253
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:58:15.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOjRFMGqUkdXi10a6fRHONa8+Riwy2sIoLLpTNdwsezWwFvbBitF0QrDyCsW3VGVLX2Q9KtCcXF2LMRSa1X+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4443
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

1.SDR104 card mode PLL frequency is 0x2c28.
2.SD2.0/SDR50 card mode PLL frequency is 0X2510.

Signed-off-by: fred<fred.ai@bayhubtech.com>

change in v1:
When SD2.0/SDR50 card mode,driver need to set PLL frequency 0x2510.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index bac3f0f8185b..32a8ef874efa 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -568,9 +568,17 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
+		/*SDR104 card mode PLL frequency value is 0x2c28*/
 		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
 			o2_pci_set_baseclk(chip, 0x2c280000);
 
+	} else {
+		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
+
+		/*SD2.0,SDR50 card mode PLL DMDN value is 0X2510*/
+		if ((scratch_32 & 0xFFFF0000) != 0x2510000)
+			o2_pci_set_baseclk(chip, 0x25100000);
+
 		/*If not SDR104 card mode, set 0x354 value 0*/
 		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
 		scratch_32 &= ~(1 << 16);
-- 
2.32.0

