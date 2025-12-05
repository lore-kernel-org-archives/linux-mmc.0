Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994A24E4D4;
	Fri,  5 Dec 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918947; cv=fail; b=pNWMav/gx6l4iSKO4aSsSYPRnO2kdqSZcgbDDvtYKvJ45uEQI4NBvC6/76k5J4Whg575lRyyQAWBvmRDYFSV2n6VrtIQrMx90pXYRnBpyCs9pv/Xa6z194aN261zJOXGB+0EgOgB1TfEKswi9Th7UWYAXMpXj8FGjhtGm7U7AQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918947; c=relaxed/simple;
	bh=aJrWeDohndTpFfzkKiRFGbZ/QcUHCZ85faeSB8zMiNA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tJx17WUwmsxCrmjx7UtcFY4ForWeQ6xHHvjJIOvAcnjJnGUT7Nmx7YOxZ39bHcoqQKvTnD/QCVtNmRCAxGfhnMoMDFxDhq1PRFo9mu2cLwmAd+yg19J2qbxANtMH70jKeTCUBxIqhLYdgy8HrKpCPq44Ttc5uGngFvi8EI0YTgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIXvGcqY; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIXvGcqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPMdH2Ph4EDiFifM6Z9ojzv6SsJ2LgbnoEfyxGte+S1NpbSNmG9r776pxmrySRBg0uLCObzMLNYHtncMvfyjM1+VGgJxwN0mcZ9MtHkaGExhzpIQ+7oYElgr91JGxc+GxgsLRN7DKG8PGvDuYrkoipYKt0Zb/cgidaJGKEAaJZIDtH6xmDtZqgoK1WEafiUCWvvIGmZ0MXngHM+DwtIIr7P42QJYqKctEK0feznmL9ouNeHda9l+4P2wGs1VL69FHYDziPxyZc+Z15Sig25H1l8thReXQDGNhS1UJtywEx6Zqzix4U+9ZdO595KorRyQ85cQpEdSmIFfvhbW5Gcmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRDUTsAhoXIkUcHB2XQN5stHi33MogA/3RpfMgdlRBE=;
 b=k2aUlQRyO2nikQlKrdEleGik1OeJy3HZVmAYi8R4y5A7EY5NJXR/9yM/eBUNEH948zYePGIQmJS0QZ26uzRwhYfce7CzU3H1g8lkdiW+38vV0HEpPxH7VpRJ1P9423wlkGDMydISIGhcCDMaCKbqbMlo8lTfVlvQkBHlDBsvyiXuC5LtlShZiszKgGy0tdSJJbaHH0x2rQGXXaQGOQpqsBcm2ahcVhTOrNxuWKL9tHmG+2A3VSP6D5o74cpCLjMny/82vCs4ixljO2B/wZ4cJ3HCP7D0WUd4MO+TZsJ2QZ5xUW3VctZIM7vF5DherAy8PQ6jJUumFoVGlEQ5xj6yZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRDUTsAhoXIkUcHB2XQN5stHi33MogA/3RpfMgdlRBE=;
 b=XIXvGcqYnSBSV5JevYnMn8eCcIdve2QmbJnqYSBCVCqiZgl/NwCWl1CXXZBLKdGCC0aauAUXk3p40aKNLD7dqiiFrMlqORwA6y5BQ4FjLThLH+pwAyyzdhnxUcKkM7ycoJ6rVKsdXZGISyQJL87U0poBsMqP5vm6I+8ibAZyE4SlOkTUDFObfuWpCyF441jRlFLbGMmQGLsGJn49B6V0nNJ168e5N9GDc4nFJcMpZcIYHvxGRHCRz9txZu6p8i1tYYwdqDXM6mfl8ch7LO/zfoB7xCvu0baDF7SvVb76swFYy03yxTWFMePyg4d6DaZzPqf8SNZE2igEPOJwMH45mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by AMDPR04MB11555.eurprd04.prod.outlook.com (2603:10a6:20b:71d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 07:15:42 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 07:15:42 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	haibo.chen@nxp.com,
	ulf.hansson@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer completion before reset
Date: Fri,  5 Dec 2025 15:17:29 +0800
Message-Id: <20251205071729.83857-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::17) To PAXPR04MB8574.eurprd04.prod.outlook.com
 (2603:10a6:102:215::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8574:EE_|AMDPR04MB11555:EE_
X-MS-Office365-Filtering-Correlation-Id: 128c08ab-9206-4b43-00a1-08de33ce19ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dPfTznsph7dosEHiuEDNE9lpKa6EgjXcSHC4VczPloMPrrDQfOvrdHTqIRmt?=
 =?us-ascii?Q?nkqqTPogxTrpPecerh94KgbdQa1aDtmTfsTfsEK/PK6PSEg90BjW9FqRsHSK?=
 =?us-ascii?Q?CPLruWYFao3hvUSmuZw+bIYdcogiEhrdaLnzNRI0P8deB+E2v3tEVqvxUke4?=
 =?us-ascii?Q?/h8xKwzjlhWXXZtbvXxv6f2G1nvwp0R+8smqQMz2aLramhC3nEW7vD2x991q?=
 =?us-ascii?Q?FOV5QQjzTaNK4H837d3cfs3aozNCU6R1EmWivFSa44N1d6Aszrf6MBa6kCYJ?=
 =?us-ascii?Q?mCStYFuLY59F/m5G8cqbwMQ4pnBJTtaWVP+g1v0K03jrmZIJF21D/3kOBkVC?=
 =?us-ascii?Q?QGjfra/0KPi8RO7ohUV7H3NoeyeMCr+PBlKgBLuf0Ie1SV/USWfqnJr3lgK4?=
 =?us-ascii?Q?+BWMeYEMn1ofbxJQfuiN+fUjrAyeXm/rPuqI/3dKiiIHumkoEkKbGUcWcOVx?=
 =?us-ascii?Q?hyaLg/PEdhK6cnKMwzCE513b9kbRnrtHNQHBfvTQvf7vo4dHYNMnTpPqZEFK?=
 =?us-ascii?Q?jTupBlcDxbGyniva06Wj4zQtLGuOI1QgyK4TfcNYnnwmp2HaNow7LlPUIDpt?=
 =?us-ascii?Q?v1MLhfqgIXQRdRDhbtyogKFG90P0SaLV/ExweMeD30sgbU3kxTCKu5PVnRkE?=
 =?us-ascii?Q?rCddQYj2UOLCJBnFPWpIOWX+77cdKxaV0v8CLJ/mF5SOvbheZ3crUJDVxI2f?=
 =?us-ascii?Q?CKz5ywq24k7vunpsK2mDHotRnhqDTIUavtgnBJ+rjOTq4vw4PBiy36ZHhUE4?=
 =?us-ascii?Q?WNQtwhXlwkL5ECG7Idb4wEUu/L2Dxu88qMcOfdGN/3cJ1Ry3+06Ze8zvr+x/?=
 =?us-ascii?Q?jmb78joKlrsnGKQ8us7Rnq0etmA7RKtCaPXZfUdIEsqkXHplfeAhLJDHZ+lT?=
 =?us-ascii?Q?wFs69zB4xEfEqLpr8bmleZfq5obFwISNpVxbtSHg37bCYnPaQyxl6cN2mCd2?=
 =?us-ascii?Q?UcrU6CYDhypvH95TBLXtlbzGo0kQTtHfBpYcBkPV5IQRZXZioPe1Sjo9Mo6O?=
 =?us-ascii?Q?fq0iJ6N7Ix/6+XDhLoqme4BonGhrQJdnvzEDndji8xA7iMCwb1dYkWa9TlrT?=
 =?us-ascii?Q?la0sgIADB51lfeYU814kQsZpOM3EILZa5tMviWL2B2Z37fll8yOo1/9bm8oN?=
 =?us-ascii?Q?yz0/7zXIumOMTTvMhUmobvqZ5WOu7rJUhehIWbVSfpnZVZBjlMiKzQmpdYkV?=
 =?us-ascii?Q?mR2dO2mpPeQgTznAXri8pEwZlTn5IIoJwnxiGOkWUiJ3Kitdfi9QS58r92jA?=
 =?us-ascii?Q?6vzau+b+Inc7bhHRvj3touP4/XhpToW+rAxSda3Te0oq1bPEh8NtiYnrqp2r?=
 =?us-ascii?Q?nLTqJ4wgFisQy2toJqDuLNYqR2pMq1pt7PnTdacsujsNyDP1opIycnhgzedV?=
 =?us-ascii?Q?Lm4hNDLBgolmnQ0R1bCFJtecR+297YWJjqMTUzK++mTRSaDXtP69KVp1waXS?=
 =?us-ascii?Q?BHLqu23BCwfa8D32pTjAOd4gVrrWogZalPaoACG6uApt3rNafrdzrQ7TTUX/?=
 =?us-ascii?Q?B73eBrqlGRUy33zea6CNksxlDP1Cj3SlNj+n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBIWP0WxehyoDEuCkfXYmNH2i/AGoyJSEjuyqi8Ck/qtLhBNa527qfh8F/n2?=
 =?us-ascii?Q?KM1OMF9NsNlKKwLZwSbzBodhKK9tRDNea0Rc1W2BlPKmBsh4oahVNJqf5zC9?=
 =?us-ascii?Q?zrU1xql4fTMYcDOTtjDKmpROrA0TQNYuC0G9tsGrDd72BFbkP4ZtX3UcxWdY?=
 =?us-ascii?Q?cE29S8jlCLuzO6r3r/vHGIeOHw1Du+uf4PtKUa8H8YVGWNh31ivM94f9TVXf?=
 =?us-ascii?Q?TrupuceJrJXFGk0g7Fa9I8jKWgCXfZdB+/XZgZMKJkxKz6LuRX9DUS1QFVVv?=
 =?us-ascii?Q?/eM+dg9Phk17rVRArAHfGf63/jmxGVVJwixm5vE2WoqbkHamQfvKtikjbJet?=
 =?us-ascii?Q?VhN0B30xW9AJcSONf/w5yVph4Q80hgE13tpwt/+b8IPg1rz+5z5h6cqxVCdB?=
 =?us-ascii?Q?flJDC3UNtNeeu3CtankD2qxC5lXqv56JqFKXZN3NakGwwM1Rj4Q25LPAI7Tf?=
 =?us-ascii?Q?GAnaqz2yI8XSPNr7ken7dkVfAZP7CGG6QyGVYXSFvNN6mXuIOx4R4FTk/2Zx?=
 =?us-ascii?Q?SNQmp3rxKbKS+XzLxjX7MHDRgyoGmtatFngx4n1e/+7tbDq4cp/fHqwSbEe8?=
 =?us-ascii?Q?JSv1AGzunVJVU7pIbBAf8PEkCaW17FWmoa/j+KVxoNJVt+oREXaQ5czfaAf2?=
 =?us-ascii?Q?yWNUGislWR1kPtPrGu6/5dkWG3x/saN2/LEGwTIzUU1H4dpw3hegJoITBkcB?=
 =?us-ascii?Q?+of8FBIcRuByHQ/G3XhDkDXPKIs/D/RN3d78KnqUbJ5LVYbHv300llxN4KDa?=
 =?us-ascii?Q?g2fWpOMPucp7Jao/f83mqR3Od/R7HRH7QbDUuSy5uvEMKYSj/jcHloC9N8c0?=
 =?us-ascii?Q?terKFwg+nWyza63nLnQsllFaPim6Bpj9m+OCSip3/Es++CBrZN0tCkhz0ObP?=
 =?us-ascii?Q?F+K802S8nYojEpkwbFMV6IzPkNCx5p4vWLL+o6PXLlxoSahPF0+GZN5/+c20?=
 =?us-ascii?Q?AsZo9TFWbT4vwd5/385vBVDY9tc5RFR/c56BBQ/TG6RzyClE9wtzgFNCdoLy?=
 =?us-ascii?Q?6WLoMlEogVKWD8ZZNwbBvgEDRxFYB8c3a4C+/+hL+ahlGvMw8Afk7ATv/iEl?=
 =?us-ascii?Q?sZDTXdAm2ykFbZHdO35CMt1HWWCENyavXY4SlCHja+2SIk6hsRxW25W8ovye?=
 =?us-ascii?Q?DNjlTYvn8xTbH3PtVjd+p/t+5hcfPMKM8vPQv4hed2+nXlMY+5nG+Amb0rkv?=
 =?us-ascii?Q?WVzLU6r/y3VPFrhCwELc65cKQV+V/Ejg7IXTvFm4h5vxtPghwKmFIkaMvryg?=
 =?us-ascii?Q?vmTa6hLLzNzOcGtEPX1sR7H2e1RMPyep6lIdjRMmnt0hRMpONWq3ApkHaGgF?=
 =?us-ascii?Q?ImsgUy1oCehGQHNIhhK/jHktzJOcsnUkPFSb04MXdZWzkvROsGe71D1R7aRk?=
 =?us-ascii?Q?MqGXXAPIL8jL2NBH5XNK4ZqNnwdtHEpTMokTg1KgxDxbpTPd9qOLiT9RgFWb?=
 =?us-ascii?Q?8EhH5CLEG4I0rRRg4Yr0st7gATAkxiWCAtByedeFxwLVST3nD5yx/om2ecXt?=
 =?us-ascii?Q?9NenDlZaKqcHFhzdPOFwwr1x3PSJVVYg8SMvqs7/zMJxn7dIynIhHltSOAYL?=
 =?us-ascii?Q?js6x/Ev41reTZQ7uX4Fks6ylBmtMhUuhqTLALPul?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128c08ab-9206-4b43-00a1-08de33ce19ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 07:15:42.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlWfSwMxHdxLWilANNOWBMP0uHThP76KjWpEFOwjbcn7NO20LywbFcPriieqQ2HwE1SzIjDDFiIwv8UgPpbuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11555

From: Luke Wang <ziniu.wang_1@nxp.com>

On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus)
cause system hangs and reboots during manual tuning. These cards exhibit
large gaps (~16us) between tuning command response and data transmission.
When cmd CRC errors occur during tuning, the code assumes data errors even
tuning data hasn't been fully received and then reset host data circuit.

Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
make sure no active data transfers. Previously, resetting while data was
in-flight would clear data circuit, including ADMA/SDMA address, causing
data to be transmitted to incorrect memory address. This patch adds
polling for data transfer completion before executing resets.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
v2: amend commit message
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673b0f..affde1936510 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1453,6 +1453,21 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
+	u32 present_state;
+	int ret;
+
+	/*
+	 * For data or full reset, ensure any active data transfer completes
+	 * before resetting to avoid system hang.
+	 */
+	if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
+		ret = readl_poll_timeout_atomic(host->ioaddr + ESDHC_PRSSTAT, present_state,
+						!(present_state & SDHCI_DATA_INHIBIT), 2, 100000);
+		if (ret == -ETIMEDOUT)
+			dev_warn(mmc_dev(host->mmc),
+				 "timeout waiting for data transfer completion\n");
+	}
+
 	sdhci_and_cqhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-- 
2.34.1

