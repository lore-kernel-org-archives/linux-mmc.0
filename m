Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF48C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 03:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbhLCEBi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Dec 2021 23:01:38 -0500
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:19776
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231266AbhLCEBi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Dec 2021 23:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVQ/eje67rC76g05guj5gVQ8hpWO79xfWXinvdtJY/JtWgfwm/4AiVeTLx05DYvUGZ2rULUGzViHrK8fUD7VTxXkC6ixU56ZfDhvHr09JBWwVuDjLxnB4xbm0YjXpwduOgQgrjO4/e6TpaOP6W3+k8xEPJG2/hF80WS7W6pdo55d+bAZNwF+20GFB7vYUv0dz8lgWqGQ5FyEfdKWESQ8fCGH+tUn4irUB0+GBEww4JCR45Q8FyS5R8RccPYjHg4gUvDCBl4mLMZvkUtnKYL697vYQy8rd31ojKBQ+++OfcsWf0XYbC8BgZWSHIF4hRuIGbTp5pEpvjrk2K8FyMnFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjBUjYKZLeizGUlgUWhWEWvl+o7wULOM+GlYlV83nlc=;
 b=cYh4a2YMcRNa3cSE9tiIHPmVsxf3zhyqs7oEuPVe5XFNSQzjFJ5AeOTIwoarkJTJ0r1tUo43qED0TUPaAGDgunqfixxUoxHcUMhNILo213LGMfc4znjeEHE19UahumVrNzEmEswSIcfffuj+WtkFG75MUl8cMK0gEPXxxitQX8WqeB9CjlDwGQHXcCP/zOwsWHJZfeYIDC6CQHRZYGZoycJToeughJOA94UJo7m6H33Bwy1YY1xqztXBGWSz4XZeudSP1yUI0z6jIWm2dUtRyOW4eVntWF6Kzx+JfVbsPb9SDbsQ9jFP0QyBp9TLvb57ZR8V7xMzxhyZ/PKiSFLTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjBUjYKZLeizGUlgUWhWEWvl+o7wULOM+GlYlV83nlc=;
 b=Qwm3BvW8G7nrRsUht/KARf/E4H2iUtDghyCb1yhO9z1O6H8eDUev5tSM7wDbx8fMKgFaPvy48j/AByNNNHwIkPQNVQYipCIPJHiJpvuc1FgtwArDXl9QOOqGIho9DByIrK+OXzUv47yT5ywLan8LzOI/lWcDr/XcykR7uprHmF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4443.namprd16.prod.outlook.com (2603:10b6:208:342::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:58:13 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::d867:83af:5891:8dff]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::d867:83af:5891:8dff%8]) with mapi id 15.20.4713.027; Fri, 3 Dec 2021
 03:58:13 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V1 1/2] mmc:sdhci-pci-o2micro: Change implementation of tuning for SDR104 and HS200 mode
Date:   Thu,  2 Dec 2021 19:57:58 -0800
Message-Id: <20211203035759.2183-1-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
Received: from DESKTOP-G2V7PLK.localdomain (2001:b011:4001:97c5:5199:8767:2528:dc2d) by HK2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:202:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Fri, 3 Dec 2021 03:58:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab2c1c18-55b6-4d7c-206c-08d9b61120a4
X-MS-TrafficTypeDiagnostic: BL3PR16MB4443:
X-Microsoft-Antispam-PRVS: <BL3PR16MB4443D22C2000ECABE64D1D86996A9@BL3PR16MB4443.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bwW17gC7nCk0iW0FbG6DRY3eT41HLjRNcCdhkcoK/ZmkwOTseZE6QsD/w3PKM17NPkVS7lcjfq7KImUvm/3Ie0EOz8BUOtHHYd0iz9bIxI49zBw6Kiarko89pAgj82CRisx9kW3aEpREcn1/ZxwNt+ydocsHTPZCZ5T7MC+oPcolTQTzuY41FvirVFI77huBiVyC204FXxwbQm2qRtzJ+Zg01MQIoIyF1acwDOXu2cz52LmFNqJVaSo/FZq/DTJHTKyx0D5a/ADXq+VjiK2omiI7cTq96IIKUNPEiopWUsNWWhiPnWDLHqlcp+n9g+1qcxWp04dKvLoeWzHBlIafxc3PCI937aNd/raZXJ3Frrypj87vnxs/KgtRHggdGV1zdk2FEJ4iWlfP/8xZJEYsVRRdDV/f6OShN1GexKXld6UCMpdrQuK4jc+N8Y9TIRZBmfbObcfnSPFvPnL2hHUQZBXaIfsvxsCbnYVJOdNbx0p3A644t7qnPQctrm2QL8gl04v76iNlhEg5dYq0aewUPoG0e/+aecpNjtET23OUmoyIHRqk4bFlotNjkifrJqhIhPk+tIgeG1tDnWFsxrXo66zIDuG1Vn77dKoEnb2WI4jyIl/yv3tYRzjKKk+pEbiYWi04HOfqzYvHmajtibC+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(107886003)(1076003)(83380400001)(8936002)(6506007)(38100700002)(66556008)(316002)(186003)(66946007)(4326008)(52116002)(66476007)(508600001)(6666004)(2906002)(36756003)(8676002)(6512007)(6486002)(2616005)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wd5dcB2OgCnABOhlxIoItjL1JnMs8n3F3pklnkUpT8D1gJKmdGm3ATysxx+m?=
 =?us-ascii?Q?/p0YNEnRKM810d1obuftolaEDUlvidqLO36V8qlr7+Lzao1dnReGZfluPrD7?=
 =?us-ascii?Q?n9su5eGLmsaD1jP3jF6IF9Q/U97IAe+CbUqSqmUHAwenrZy+LrHuiYm9L/t1?=
 =?us-ascii?Q?Zx+agz8qtIlmZ06sbwdWKa4sxLXZF5f6E8TLIzq/g+jWs2klz1HAVtqKI+Ug?=
 =?us-ascii?Q?JXKK+pfF8loDN4PoADefLtQMhE/zQDOvnXHkFYXQfmV80hbIC00IxLRdNEFZ?=
 =?us-ascii?Q?IgXryP0Nd0rYoVUIq1w6Q3Tq5n7cdoY9K25k6gPSPN7Tzjehj84U9NBKnhtv?=
 =?us-ascii?Q?hAAajvSmfAPuS24KvIrvGoFLW5Kh3u8NfAgnql0gXPpiDe1/gmfF7AVhSh9t?=
 =?us-ascii?Q?4pFDgH5u1QOCCvhNS0i6Ecd7uILf5zH4jpJ92v0WkIDDYYqai2qV/85KriFO?=
 =?us-ascii?Q?1Te3zXF1Y9J68wrXUG7eJykCkxV6rWUSH229iGFapaUkR475747yG+Z8oT/y?=
 =?us-ascii?Q?0jKZpglvydOlnE94b6TAija7Kknd90gzjp8/SBHBgpFmXrB1vJRSObKoZA9C?=
 =?us-ascii?Q?OPSBNefgUAK99SIyrV4PJ9QUN5OD4W1JvEln/u4BgpPLut1QCZgYBElBWUXt?=
 =?us-ascii?Q?zY7R6c2bHwdmTJeZQeOnO779Pu03V/BTnO6Hs0NZXUBttZviDPKET72Y6B08?=
 =?us-ascii?Q?tzeaypT/Ju6SVpMZvZ4QKcJsv8y8IoTMF0WrSj8PlRLG3799i4szwgRPoBzW?=
 =?us-ascii?Q?4AwvNBaGg8bch7PjZzNlWsYv95kmDRcI1o1b32NVW6TUPGpalVk0thOyp2EG?=
 =?us-ascii?Q?vCvLJyvkmx+EKNMF71hNCZL/Kveh2AvL87slp1C63Ca/WqDYkDbGK9w6dlnr?=
 =?us-ascii?Q?rGYJIZPOJgj2MlJ5MWkTXCtwHk7gZYNHkCDZxN4BEv11IAvVyPexVtlJUKM4?=
 =?us-ascii?Q?iHja3J/PHM5L68QIlbXs7cqcJdhj3FSoLhTXoB1jaRMPcSLDbUPkl76d7q7M?=
 =?us-ascii?Q?DXtVjNDPwFErYXjPtbvu5XEZnKcctzUkRlDGrAj6JZaVRqP4ARygOz1t+ZBO?=
 =?us-ascii?Q?qBR92usmgK9/kRGq9O1pRA9mo8TchaavRBxg4vlu/4a+i6Qhe4SvbGgEJopb?=
 =?us-ascii?Q?hPlKAntX1mUcSxMtCef+OUogf9Nva0xTFXloy4goaEYVWtHpDlbp05x5ue6R?=
 =?us-ascii?Q?9uPRO0gqVhuslYqg8AcvmJomlVkUoRE5MUly7aibgsL/w9myVrBEndJhb2Sx?=
 =?us-ascii?Q?ATMtOp+BYIR2XfHlCgYZbUQydwezcXVVaugWFRIWEJ08a92/yzTyS0Yzgtkm?=
 =?us-ascii?Q?cDCuXIHphQmISvgc6+6vXmEQeCfjRvQulxzlkYtYPgO/pK2XyxnUUa0X+Wer?=
 =?us-ascii?Q?nlk2Oh5yQWkPMoVTOT3TNboIft0Y0jHbUw9j1dwdvLQGmG72s0P5b0Bs6BVG?=
 =?us-ascii?Q?o5QElSFS2XRWLywKE9oW+TNxVarGmNM3rxuR2gqXMNoKjSqn7RyqHcH2pnX5?=
 =?us-ascii?Q?vvyaMTEsh5sjw+JeHLu1rpC7b1wYXFwPjTu/Dxi3ojjrJ6jqFwhrBn3w90qJ?=
 =?us-ascii?Q?C/dHkuan+YBi4Sl6mSenj3izRJ6nONxGErROpeADgO2PY1aO9XA+ytRmV1It?=
 =?us-ascii?Q?Fc/jlOBOXDABvB0eFymADHU6mf3poM5phs1DxFddbbYOmYVN5GCBTxIk2Tsi?=
 =?us-ascii?Q?M9U3Qcaks75KhuiHV7R4q/sk42s=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2c1c18-55b6-4d7c-206c-08d9b61120a4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:58:13.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UKUwVt4DRravIXlce9Xa2Ji8t0RW8a/WmfAJvUkjy1sFhZr2JNUID1DUI6EmT7xLZTBJp8EgYLg5XG4VD1QTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4443
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Select DLL clock of output tuning
Select fixed output tuning phase 0x9

Signed-off-by: fred<fred.ai@bayhubtech.com>

---
Change in V1:
1. Set register 0x354 bit 16 to select DLL clock
2. Set register 0x354 bit [23:20] to select fiexd output tuning phase 0x9
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 51 +++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f045c1ee4667..dfd447c1c367 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -43,6 +43,7 @@
 #define O2_SD_CAP_REG0		0x334
 #define O2_SD_UHS1_CAP_SETTING	0x33C
 #define O2_SD_DELAY_CTRL	0x350
+#define O2_SD_OUTPUT_CLK_SOURCE_SWITCH	0x354
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
@@ -304,6 +305,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int current_bus_width = 0;
 	u32 scratch32 = 0;
 	u16 scratch = 0;
+	u8  scratch_8 = 0;
+	u32 reg_val;
+	u8  dll_mode;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
 
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
@@ -322,6 +328,28 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	scratch |= O2_SD_PWR_FORCE_L0;
 	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
 
+	/*stop clk*/
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val &= ~(SDHCI_CLOCK_CARD_EN);
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
+	/*UnLock WP*/
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	//Set pcr 0x354[16] to choose dll clock ,and set the default phase
+	dll_mode = 0x9; //set default phase 9
+	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
+	reg_val &= 0xFF0EFFFF;
+	reg_val |= ((1 << 16) | (dll_mode << 20));
+	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+
+    /*open clk*/
+	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	reg_val |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
 		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
@@ -532,24 +560,29 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	if (clock == 0)
 		return;
+	/*UnLock WP*/
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	scratch &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
 	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
-
-		scratch &= 0x7f;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
-
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
 		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
 			o2_pci_set_baseclk(chip, 0x2c280000);
 
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
-
-		scratch |= 0x80;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		/*If not SDR104 card mode, set 0x354 value 0*/
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
+		scratch_32 &= ~(1 << 16);
+		scratch_32 &= ~(0xf << 20);
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH,scratch_32);
 	}
 
+    /*Lock WP*/
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+	scratch |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_o2_enable_clk(host, clk);
 }
-- 
2.32.0

