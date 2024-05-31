Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2104.outbound.protection.outlook.com [40.92.107.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877FC8E9;
	Fri, 31 May 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164914; cv=fail; b=F86AP8BIo0Ug8STgy9DXD+/gUK1RK8gvbXfX81zPy2nYrrs+PMq3FgRvtomDmA9AxMw30zWAoIFlTAIY+grxPYehEt5YL+ntsFFVIOmsIZAbybRJqqrtGTHxJkvhAYLt42ZU+mjYH8yKMtIdjG73cBTboD8scbEocWpo4pBmKgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164914; c=relaxed/simple;
	bh=+9Jce2dLDeXLhhqSxnAUbRhpWxBtm+ZaX2iMJc0hCbI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=foV6QqfOmrLXEo+DXHDfGfIuU2joJ9jdNHYLqoktQ/x/Eu3r7dfIzfxgWpa8D+k0SzCg0L23RJp+nEUx2QsIKiRmKHHO6FSnsI7hA4+jlEzjUkJImJQXz1aJMoVnMkfpBq/cL0t8X+bFX1TJ20YQigZvrEyBI+HeQiyYpth0pr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WXo5Xiwe; arc=fail smtp.client-ip=40.92.107.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WXo5Xiwe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Zn/hQaVHxSipnbr00uLmtFzQ+iMqqxPVvhQpo8su8HRAjqWJ8GKwjPYZKhepVQtcBLoHZh38vmETii5fxOfGff7oRPDeUgTt2t5hSjsdeFhVC9QtyekIJE1sOMBOoR2IH/zujxLzVhc74rp3mhGxMEXpROMpBSL1B6Dv9kYLs8OHuEj2aXVrbgqMenzbq+rTCyppmlQnLPLtBWgxiXLHYJtZpCBYU+IDD3KEK2HYYF9gxia+M0m3wUNOLMbzsK/ehcgP/EYRMsFd4SPEMC6iz9Gl1mKAHCRK12jsfRmPWHNxRJUG3lW0vzfIuBOxGO4nwLnLbNYl2E2aMD5f5Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXDM6K1q07Y0YEG3v7e4sMLZaimXnNRlrxgIfUo3Jz0=;
 b=M+X89p9kqWvX7CzmxTNX5K494QoFaxL5cfX0sj/fcpqLT0eYCiB/LEb4pEw3KRKReFImxyfw+h8gVVKH9HBwQEAxC/2Qfkx/sTH1IycelejFxJlNSnqncMIRzb6dciUiCgJuJSFv3iq3NaAiLtRHppQs5fk57GTMb7dEvid+YZ+Ju4z952c97hCZD3ggkzHj3B9uuLcqZJ0XrwPSE68lD1550uV1QQzufxSEYs69WtnalkJCOgoD88byPWeSevQAyvMeFyK4V8FCUZI9t/1k/vMuWFPsxBJ7tJ88S6Za6c09UYOYddzNu9/h+3BhcnWF9KMmxx8c7Y6XdxEbnpb/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXDM6K1q07Y0YEG3v7e4sMLZaimXnNRlrxgIfUo3Jz0=;
 b=WXo5XiweXVRWqFPCTz5TGnd38MWFjtUGfXYFzJuSjDLwrA7mrS46atfpIZzeaST4Lp+3va1D1QC/XnHwsoDUsHq2uShJfHJXR6UxeeyNjSY3OYdVihZB5EHnpBxE0aGwHn/yKw8QXLC1qTLpUCat6ivfKOyBf0582v50H9ueUfW1E51i0hrmxsUkvIKW4KBS3BurSnW+tOdT2DX6YUttkH7weQxpu6ImNLLn7VQOo2JCyErL47BDnasyC3BDZFgwJpG68lNhddmtlvTgpsqDmQKnsIIvNiZC46+QoN5RqhlpqeGn7zOjot7QdnUNbN22mHju0Flzy2JvVrfoU7gPWg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by JH0PR01MB5730.apcprd01.prod.exchangelabs.com
 (2603:1096:990:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 14:15:09 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7611.030; Fri, 31 May 2024
 14:15:09 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Use inverted-wp quirk for CV18xx and SG200x SoCs
Date: Fri, 31 May 2024 14:13:47 +0000
Message-ID:
 <SEYPR01MB42219753E4388009470D958DD7FC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IwscU5nAj36b8MDnCsjlyLkRp3XA+8qZ]
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240531141347.36159-1-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|JH0PR01MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fc49d1-a1b2-4037-071b-08dc817c1418
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	3Ikpjy56z4n5JN/YJhOu6SQroYrQaIiBypM+FzlBuOQ925YKXQ0I9mSjrZ3IA38XomKt7auJKeGakFU9VM7h+iEt3WfHBkItFP+0UVUBNeool3sbUxJ3jDSrQpNJpBPqO/2/ls6m3FOE/IitLvew+DpBgfoooY7rfDSEl7t7hYnjCBmwS3ETs5MPayeABQt55nQhh2EKp/zuww/XBctY9y32UwL+06qS97pDh847wNQWXrJyumExEKijfKduiGFOz3NkC8Skvo5hghng53F5rYJqm3qrAWoA8KIX3cIAt5aaHjWOPsNG4FmCqzI74F9y/Ett7ETwl2JlcV63x7mY5RMyGuNjkz9MNhrTSmsVKP9YZO8mU7VxvIga3RzwSPCLegfGU9GQvI+46y0V9IddP7FuMyAov+d/xXfkykR/8Ork3/wHScKIkJn4I6ZXE8DcdREe5+j+aU461B6vpLD7a7M1ejNCtPZAVk7TRZZTC5KaeOzZLY5sbkHJ93u0uBaDXuLE0ZwCCjnslTATPDYfZPFMdt6nHeop5MUflU+F5CLL+O+DITv1AASdBBu+xJMyBwz0m9pF24/DeKwYpnO24hbvx8LP79XG3Yc0Wl/FrdELBegi68wiYsp0n0itIpon
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByaGaYUewRUDT3/dLb6RMdUhkwQPhZukrzyiV9/9yBSbXPSk7TDeOJRrc+bV?=
 =?us-ascii?Q?8wovMA6g6z6znQ5PIHnEODhDFDXz6kUu7cv6bIMTdZw2STsau9DNS/Nz99mN?=
 =?us-ascii?Q?Nm/ut79s0JHL872glfSimJj8JGB1qbFuO7cd/M0ULmIQl5R47KFm1aYPxULK?=
 =?us-ascii?Q?K33gmopLzOd48cg//WxqIXhiGNhaapt0DbRUh4MALZL3NRCihdEeIwRmlZ27?=
 =?us-ascii?Q?EpWu37i+DBBqCxDXEA1DHrkb7BZFHRCYMU5TUoqrvz8oPpDau3t+8yBUE0eK?=
 =?us-ascii?Q?3CV0hDRkBEIzo+UhFyY6gZgDK4ZLLnApmtpewFkIQqVtjIyklEcZ4QeQHgzY?=
 =?us-ascii?Q?UBZletlo/dbz1lVbPcTP5FffiF7ZHloIAiKua4BdSad/7pHDl7maxnm+fGTT?=
 =?us-ascii?Q?oQPg+/Cgs5cIkCfnxDsq9ZP3qVo/AhqDOuKI69QJRhqTjNYHn9Wf3VldQNIZ?=
 =?us-ascii?Q?hSiJCi7RFjOQGVnO9ToI6rgwngTbrYUkghhF+hR4XKb4q5SU6HQLJ3EF0h1c?=
 =?us-ascii?Q?Gs7TgJrXszB9vdBCTcPSOoU1XgCEXwZ7QSLvKkC9Ggqd6+p2gITWuE7G4Teb?=
 =?us-ascii?Q?W2YI2OoW2P6QdG1GcA/dJgWou40Smjm2ikHaukxk9VTEIGNChUg01rW4FZxi?=
 =?us-ascii?Q?qtuZLkf1OME6X/hwBwNqyMYPJrQBubYbyEqZvsLhejG0MKQ2p5Nem4ujjiTA?=
 =?us-ascii?Q?4cfYljTXZcQ/8RCfHOq2L1u1tGrSlBWRlfCozngp1GHqsmri7fimgzY8lpyg?=
 =?us-ascii?Q?J7doyOqVkvF6ps9wCMfkP7Zu1B4J8UW1Swrz2M0Ttmwvzf1sCkn4xSIb9+F2?=
 =?us-ascii?Q?K5xylrSOMf2e4T2Sst3/wdI8Qu5UB8/BZxtD+thnV3L+nuq2hx3ThA/RJAn/?=
 =?us-ascii?Q?ro8InHrjCVsOEj7SnbEN9tPoI7fgO5/mGc7U+SS7+diHTFZaEtDiTWk/F1Qx?=
 =?us-ascii?Q?rIXj1bU2KSgMOdmxCGO7S2INjDpEDwMtsOdKeQn+o11vBRQRXuSHyzDj6pnG?=
 =?us-ascii?Q?YmaAuVpDQLQCUYnm5YjiOqVIVhHl1seGz4ZMobuntV7H7otVlNioV5RJfl/G?=
 =?us-ascii?Q?4bnH5nvy4pQibTyN9EHP9wPDG84FvTqZEuXEeg4jW7IFyOUy7ria4DGimIJW?=
 =?us-ascii?Q?mpMz1nTP7lmd6URooc985IyPsmjTO9lZg6S4J0gRKi0HKXlYFRrhKg155EW5?=
 =?us-ascii?Q?SgJJi5mlINpw3LCjIh39pJodHcA/1J7ZgV0zDf9+XhT5WmmDdOqTOhsngh4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc49d1-a1b2-4037-071b-08dc817c1418
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 14:15:09.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5730

MMC controller integrated in Sophgo CV18xx and SG200x SoCs has an
inverted write-protect flag, causing SDCards misdetected as read-only.
So set SDHCI_QURIK_INVERTED_WRITE_PROTECT to make write protection work
correctly.

Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 39edf04fedcf..62b7f28de54f 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -962,7 +962,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 
 static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
 	.ops = &sdhci_dwcmshc_cv18xx_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-- 
2.45.1

