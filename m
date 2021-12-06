Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC7C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Dec 2021 13:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbhLFNSz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Dec 2021 08:18:55 -0500
Received: from mail-dm6nam10on2124.outbound.protection.outlook.com ([40.107.93.124]:64960
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244194AbhLFNSz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Dec 2021 08:18:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiPjad1lOd1pHFTNuu8SUuUNfsw2aScCiwcj9jCrcQ1S3634mjkw0TUsa4JWnqgFA6jZVYeKQCRPVJL49IQm9luHxV8WGyzKLFwn7PkzECY+Gf3cFqzTz+diRZ61i2FKgjO0g3dlyhI0B3YVZV6311JBT19ogJUGOh0VHu7aV/un3GhUfy0JgHSgD49uOb4Rq0ZOPFnWuM5gfovA3l/7Qm4mXevvebYKkiVdkyzxqE0Rrlikm1i/aWhrpkPDuG9HxpP9CcDwGHuvU5hTOkYyO2hb3EpxiNf4Rgqz87BR5crv2QjxwJBKi26Ydakq7ZDowdJ+8FlNLZvf/qQqG2ypCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ATPgGlrpikQP4WUr+7+KgAjCGlZ7hIPLBopTjk69E=;
 b=F9yZQLKEmw0RKkpcJIdtm4DIbzvZOLNDollI/gQHYPX7BjByLzOmARP2S5diOnlL55UNdkgbYooxLdkoH+Szzwxo1+GF2hrh+j/vZFjKTJw+hKoQvF85f9QBoI6apzVHnL5SmUiQd8/Ae9No0khKYqwaBv+r1UBsC9Ys0t/UMwWn2hrInEdMsUGrnwyrs//lYpifv4QRq9ELtFQgFoHqUMfgsk40RyixKKX7xu1rtni0ub6c+kC5qqV6oGDij0N4n8E4LIKgPhOn/y4RMYlUEvyTsadzvhKryiTx1CDzWFycfxVShTqIPcXJv8KAetkIg+xjOCFWhfklGKF6DF8e8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ATPgGlrpikQP4WUr+7+KgAjCGlZ7hIPLBopTjk69E=;
 b=HLRlHUD7f2OLdFC3tPyGh3Cy9r7OzWfuKQNrc6yxjhC7EzLTIAm+sTITbRBhJJx0g0OucL/tw1rPPa3GsxA5dt/OMV0LPd6FHm0ekkAdaI4mzq/8v4eChSSNhfaaOloreoA/GlVPBTX3ZnjLDmk4oDxaMrwk/qXkVpQwTzoXoxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4369.namprd16.prod.outlook.com (2603:10b6:208:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 13:15:25 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 13:15:25 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [[PATCH V2] 2/2] mmc:sdhci-pci-o2micro:Change implementation of setting corresponding PLL frequency according to card mode
Date:   Mon,  6 Dec 2021 05:15:07 -0800
Message-Id: <20211206131507.411-2-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206131507.411-1-fred.ai@bayhubtech.com>
References: <20211206131507.411-1-fred.ai@bayhubtech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
Received: from DESKTOP-G2V7PLK.localdomain (2001:b011:4001:932d:e9b0:3414:63d3:c2c2) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 13:15:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0c929e4-e227-45ee-ff17-08d9b8ba7715
X-MS-TrafficTypeDiagnostic: BL3PR16MB4369:EE_
X-Microsoft-Antispam-PRVS: <BL3PR16MB43696C0F7021CAE6A94B78C2996D9@BL3PR16MB4369.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDnpx/ou+32TdZgWQAf9Gd0+llbgk+0Bmemp+mvwCeGBqgvA64N1oWwLuu0DMhdAvl8fQ+wYRo9mwuyHwWfKHwCRiJV70u8ZmykXDOWGwTpE1SqJtGwN3rUzBuOByz7CO2Ngmh69RFDNT9Fs1zFOuc1mN1lurYGaxrRjhjSkRheMmspf4GfNCeRenTiz1H1Q6HlalEyzCXU6mluUI7Js64I9pyZURMdDDicMCwksvHoaMEGb/8EQiNEnR7UJMJjEPpzo2OTb7adQffQRJegEElFy1azTsO9Zl8Ed45dObCrAcxmkqpPCy1rBasw7El0B2cZNGKEACFCsJYUns+SvmhTxCO9tRnfnokmJwqk1CVEStcRcKddRAKCiFsQ6wPbYIsg6XC5T8llOoLfzo/HEQb0B1WXwFM8m/VXwzSzIXq6N/j2sRtP2aPG+vo8yPTfYIFAqCpvyXqljqHuhbc8ocy9dYT1tDlPw2hx7bO/LbugE3H8tt4l+++p3jg7Knanx+3ZD/4HSYjHzA3+QkbRNLrCBfdlM8/6HJgd9qhlJukGK8gbCy/mn+a7a/b+pDrYUkebb1QNzVqON4eCfIqdc537ce4yt/38vdMdOv6ppZmaOPfIZT5zi5UeRA4/ZumjpgdUe2vzCupnzFJ7bv3C+Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(376002)(396003)(136003)(346002)(1076003)(2616005)(5660300002)(2906002)(186003)(6506007)(8676002)(6512007)(8936002)(316002)(6486002)(36756003)(86362001)(38100700002)(508600001)(83380400001)(66476007)(66556008)(66946007)(107886003)(4326008)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEFvXjNWPLqDQuF/Y9+s5MZbsczy9FzEiamW0z4v4DhzKeYG4riZXiW45NCs?=
 =?us-ascii?Q?SfJGvsKzXH+lH1MpIzNTUq4TgqCX18SpJV4Ra25YmPY3oZJURjAg2cB1cilx?=
 =?us-ascii?Q?Ckv1UPhAAehVIb2YdpHqSyWy4g/KaYr7l1A4OblFCEleocJLQL9K6AmO7ekA?=
 =?us-ascii?Q?LY2PT7TYOTYUiCAMEbVrQE/47sF4ts0dtpRCl9p2fK/qRjGEtiBy/BgnFQDM?=
 =?us-ascii?Q?PATlBSUDQ0NV0XnQOJcjq8w4Z2U8dULCRXaqLoWm9AoBocsvsWfAcg5Xih8X?=
 =?us-ascii?Q?MtOql1rXWbkxbwAsHkL4YqQgEh4ICA3BFuE0MuDt8Lg5+LugDwlUFd2ts5PP?=
 =?us-ascii?Q?xSjq1uTibC4UGXzJBMDAP0oRFrRt7Eum0I7Ef+X2cS/beMs51W67vI6sDC5t?=
 =?us-ascii?Q?NZHKlRzPVmNi8Jiw6kuF/YOmgCHw/0/K7dBjH2o8tKnuefbUOfgJVdUnt+TS?=
 =?us-ascii?Q?JnFhSHnCKYw1cVDPGo8UyAS/uH8VPMW97Z4zEBB5hVmWRg/9vmN2fKG8cGzw?=
 =?us-ascii?Q?T88uFLWLzT0d4plFzZ4x/oMptoyk/aRWUt28BurgklcSQPYug497VeJqRTzS?=
 =?us-ascii?Q?cRD5ZO/kRUeqdJPJrggLQPi+gS29qU88qp5M6GysaZ9oKYxOvDpo/w6ZB6vG?=
 =?us-ascii?Q?UFLkFfq2gch2pHRaxNeMBjf0p0RISQQeWM9pSTgtR7ui6GeD52WCL8O8szIQ?=
 =?us-ascii?Q?xn3odNRNTo3vIdGYHmK4ghYGR8tJ5zbPO60ALxr4ot10s4qcJ2jqeo4F+vG0?=
 =?us-ascii?Q?Gz/XpR9prYUy/cmLGNm/Xyf7XZa9+CdG56InbBO0f5XQLSZhVaQybV2CMtD5?=
 =?us-ascii?Q?nqHOCuoMK/sRk/YXxnu/2SksujPQbDGueiiKU3yZffqiX75k+ShIIkKbadxY?=
 =?us-ascii?Q?glGllKgUfBN5QCZUewOiYNZeVvf7pMIQrYonvohz6QgJF9nFGF08fyIegTn/?=
 =?us-ascii?Q?r7P8o+byLSiEcCIEKAk1T9/N9ohPffyuN2EPr6M/OztnDZbPsOJufYlwFeLO?=
 =?us-ascii?Q?nZkrFaT9jZ32GHCrN++qZgOzUInL6oHTGF5TGufGooUeLhN+DZQR8/Knq/Vr?=
 =?us-ascii?Q?FRrQQIToSZQdC9d8Saq+hcFVqEvOgEl1a48ePWMR8WbSO/SQ43yVzQb+eS8c?=
 =?us-ascii?Q?FD6iU8vDSanAPEjIr/Iws9/ZpSFHG8zIxzIL1/+rGU3EIbSrF1njRNBqb4X2?=
 =?us-ascii?Q?dd83taYQFYxkqlp8yIddgyNlhcRXIeOuMx6tue4YjhyliHJ/DZnAR1gcB2mS?=
 =?us-ascii?Q?C8ZcAZi1OIXgWeiw731cXPYGCjSGSOWyBGZUfZqOdT6ub7IGwijoFOumb7nk?=
 =?us-ascii?Q?8nGzu9//ajaZpzBG+CIwvJl/NORtKZgMJJWi5I1PuwwcRl29M20fGH/BgsJD?=
 =?us-ascii?Q?0k61vSH+RfhQCTdJA4vLb4OWP1Fpu7gdP02STjsCZSfOPEKlNOlOpxC8uzCG?=
 =?us-ascii?Q?jyhSVa1b6qEjJn8bYSQdWlpbOe3bhdDJC5G2N/hYzm9wRipSVVS8emUJMfOn?=
 =?us-ascii?Q?2IZhOApEu1nMSbeT5Wd1FDzT3Zt1U5GBaSUk3iust4TUouvsyqawQG5kQGln?=
 =?us-ascii?Q?86EUb59jy9BQZUn+vKf1VOOAa7TFMpsVRE+gKhIWBMa8xZt0VBGKBxMtTpb0?=
 =?us-ascii?Q?1EayCdcT/Ah5Jq4QAMn4oxmNdvGfzUvz0+wv4cweJ7q7PJAVHNsN0hj17JSE?=
 =?us-ascii?Q?mi8ZGLxwfOg8vUfJYEUrVY226h0=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c929e4-e227-45ee-ff17-08d9b8ba7715
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:15:25.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt+PkdmTZCcZSQvIYpKFPEkWngow9ZxFaNx2NF/Rv0LynVjxewaWx1SslScIK0OIuIGGIr1AvlurvwZwpepdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4369
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "fred.ai" <fred.ai@bayhubtech.com>

Driver will set PLL frequency by different card mode
1.SD2.0 and SDR50 card mode base clock frequency is 208MHz
2.SDR104 card mode base clock frequency is 200MHz

Signed-off-by: fred.ai <fred.ai@bayhubtech.com>

Change in V2:
---
After SD2.0 or SDR50 card initlization, driver will select base clock frequency 200MHz
by setting PLL frequency value 0x2510.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 98c1a17eb619..4d79fda10dcb 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -569,8 +569,16 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
+		/* SDR104 card mode PLL frequency value is 0x2c28 */
 		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
 			o2_pci_set_baseclk(chip, 0x2c280000);
+
+	} else {
+		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
+
+		/* SD2.0,SDR50 card mode PLL frequency value is 0X2510 */
+		if ((scratch_32 & 0xFFFF0000) != 0x2510000)
+			o2_pci_set_baseclk(chip, 0x25100000);
 	}
 
 	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
-- 
2.32.0

