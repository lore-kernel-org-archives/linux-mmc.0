Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86564F93B3;
	Fri, 18 Sep 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741242; cv=fail; b=nFYynohBNn0rRg8/hq2w5Bys3+OGjVNvl2mbvRJgYg6Q2aT/wxv4BlnVwDNrOwLPHABb+2EsUqBzVW1UsLNWv4ImYwE737xdrcEkAwCXpNFX8ov0Y7jKxB62lfsYBim8/1lHmhNabYWNJT44wKGPi22BQihRAJ/PmddS7LVEmB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741242; c=relaxed/simple;
	bh=XMP8ISUuG05HrPV1AP8qXpwOCCDbgnItU8XMefQ3ljg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CMlkzjWTyCuwP5NvdV8cibIuaTcxS/UuI7UDBU3wYCay0ikFlUP/GOXTX1hUvTqt1nN6lKttmy8yMYNqkCSwfw4ahtTjlp+HOLYqbFRNhZnWdFa49aPgaijxNUMTqu7vrxGc4Z4aM+J6rE430gE5qqYfWFQjw4+ScOT4X4lRPY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KQGLcJHq; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KQGLcJHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoSZjKhX8lNCvSoTNLlC+4wBacbNrdH+Gzuj0ZCiOQYEz7f8g0WraGMukNexNLxnmbiADTe10MUIdha33kyh+K4jx5ykRmPoWVlVzz2ARxh2gHl9S5GxvAH1QizH40GN0aF9E5MxiY0EeX1EFJSzNWThFNSA54tt+vSjVWSI7zEkKQw4AfbCaFp1ky3ra4Y+bkpSZrvroLDgbxAPgzmm72BN/yfXFVpwu33XmygdZBkoM9Ocw+4RLa+2mrdhMY2SDGSG4R7Qn6OX9H2BTKdYcvYyhinMjRpmi7VDwRY6fU/MuYhTjKeY8nk7s4MbZlUW3VzsueTLZLeYgAhYT8UaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQaoEpECvfJ1h9hh6NDCSdgXRm9Y0HTSbAFA0HeY8oI=;
 b=CqqCBF44xh2Jd2qRymhiB3CGYOHCC7WWCCyRbXIuZ7WpjRsLF7RKytYbgXCtrFQGi+8nRKeaas+Ksdkxz2/LioK4XdpxRzbr8QLdlvdokPVcwi/wTzOdLe399jjMuWjTTyLjdBNsJ7nbzaIZTpSAUIrA/mHOz8KIujfVAOwFw6tM/QoKfhiL3LIQqSWlhbDu6MPPFnomSZrd2WDUOyBXzACgiRh2DUKg/zA2xWp7n65dgoG6mGeEpnxhg+qZiOY0OHG4XPvLLl2DJ8XisWb678hO6DWLx5pi4b8LuyE472cq7EB6na5WW6MLPQK6d9n4LRnVcphyLu8HLoXAqrXcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQaoEpECvfJ1h9hh6NDCSdgXRm9Y0HTSbAFA0HeY8oI=;
 b=KQGLcJHqEPhE+BdenVLDsgOYdoH6p9+cuADlblWyiWy6zykkaOjAf58Jb/lcH6kGZaR+ru6ayozK0Com20DepfGZ/bg8aRD4t6X64zAV4+UTxbletyNmTf/fOp5+N89X2TvqbTya7Jvnr5xoz7onqUnu/m5s5YcEmdg2Nc4BhZi3Dd1+5+X5j7EbiaIJKC0SvIxtZPMJmuXkJ88qkUL9+85T8cZkMo1X1AP6qhoA8tkFh1dfM1/Rlz2LK0WmJ0AOR9haUxvR+gRk9LcE91GtQvT3kfhue5eBfg3URGlF9BMxKyuGHifQ9IHc3rjxVwvRXrJV9dxav9zhJ20c4Oj1jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by ZR6PR04MB296659.eurprd04.prod.outlook.com (2603:10a6:910:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:20:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:20:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <kees@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: use assign_bit() where applicable
Date: Fri, 18 Sep 2026 22:18:04 +0800
Message-ID: <20260918141810.3023069-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|ZR6PR04MB296659:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a916dc-b648-4563-3bb2-08df159002d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7nHo9sgCGe4lSa+AtRpFnFHtGdhNUmI4Baeue81imH8z6f/1MSScPRBL6lL3dS8PK526cQN90+SEn791BikTqHnB++VHfM9lE7caJ0V6oZ9DBxy2N+YOMItfVorbSEj8plK1EeL9EMOIZ7li5ni8BD4IDzWQ2HEg+95o02pz6lExXvtR8VwXgg5BBcbFQcBPJoOm0vvQss+GQQ6uzGG9BQ31EpBFIzGBLAyheajRY6p1rgI1O4+PWq+dINmsgpF0/Fi0Idt5RkOfiPw0ZQVSfgk9AEwjIH6KSf7ti7WGI01aQAoh/0x8UlSgP+AnlNt2q2U64GRmmGtzR2lYBetX1Bbc1tIPrKsCC3I8SdwoGwGicC/tKe19gMSEqGJzQwGMj8TyGUbCL5EbTGAxY5g1A0Z63g8f9l2IRgr5eLxgvKe0LMelOXNAJ/WYJk13P4y/NqocJmYqfyfh59zwXbfKLq2Klr7cD6q8tgj6kJN8Mq4Csor1m69FY+kHQRAxsKOoxZ4pYeEEDEj8kvV1VpcxI9C97R9z6kpdtqnk0CATN95rNFNhtnespNYw0Et16wmC9CnETTyhqvOLgvcdffOgilWSucG2gi6hYySdPkHwYHvTKiiIdo3c2ore0344x/qmZIskkjToiigzNroeoEMVVSvUb4ynW6ZIfej2XM/Q/Dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWWfDz2DcN6xbbKjbWrZeMfxAI+BMp+bmcc/jbd9QcFgVp4zT2FUx7jwf2KO?=
 =?us-ascii?Q?ZGEM1UZ1EHD0y3xoCa1DHaMgFgyMZLA0yyQs9ODN16JC2M7u+u0DrymYU5Dq?=
 =?us-ascii?Q?5HDHLap6QpC/WZ3SHb3/hmxHSAP4wHMvo6ZovjM7WXgiEWYCXTTgraElNEaD?=
 =?us-ascii?Q?FMYrvdGy81DIqwpyM3LluvRhSGiVLDnEvtXUSmXwKZcjFISBUe/ztPoXgwf0?=
 =?us-ascii?Q?q2SdeXvqhAOP/9+1e8PjgTVyCZfL4SKqEBiHsEkM6QfnRcZ0xp48THH5zJn/?=
 =?us-ascii?Q?usdy/TE7ozNn4IbVCgACBwEHP0qEBr2k/2ljffYdi4kEJ6Bm0eGtQZTBrb9K?=
 =?us-ascii?Q?2b+6bVXQMVMwRpgPLM3MHy+/e3mWAV2pNHV2hMJQNTis1q1izmb/FqV2Pq+t?=
 =?us-ascii?Q?RMYgElaTBAG9rX+S0LIszFWGmGx1sA+CgpbNmebIqAiCSwYXGZu4EzuSiRn8?=
 =?us-ascii?Q?0tw90PupEVB03rkRWnPedgB7DCCqPWTH4m4Jg7UCw5QxRPcv7VaFXle5fr38?=
 =?us-ascii?Q?yJ0meZbG5wIYbjB0kxowOKHL2PoNYHG6B92gpcODpbBp87lJrUXiUj48RrLQ?=
 =?us-ascii?Q?stfGJaHXtmNpNWzKzWlRncVLgKWnP0kXdQxpSMop6sxpD2cv3XpSBvPMtJXC?=
 =?us-ascii?Q?+U1HW1WDVoy39EO5dh7YWDP7kI/uA1tM16MzgNBqis0pOjqhdx6ZrbY0iw3S?=
 =?us-ascii?Q?kCoSWwYaJeL7LjS9Y7GM4pYpbJYo+6GvV7R7MxsgilufuB8JlNEi8vI093q8?=
 =?us-ascii?Q?KMgiqQNsPdFxmtOk2iGBkpXvWnKhgEEgfqHltlj5AXzlNu4pbXvYWy1sjFRv?=
 =?us-ascii?Q?u/CDdJ7u65BwoJoGZ4q4Kif8I1QyLOf7mxXHiKsKNs/J8j2OmbFBZ6KGLWsn?=
 =?us-ascii?Q?qK6/QUtBckS70sI1R3g5lSZjkiW3Vkypc9DaV5JNdhQLveTStU8Ue4C9zssA?=
 =?us-ascii?Q?3fC1AXg7H7F9X/7n7sFGdmDZ0iqBtc/PnbZYskg5tBogkI4fUNCSZkYF/MzT?=
 =?us-ascii?Q?BF7EuRzDoSFccuLxdxHJT5rfeKelBKSscMk5b0nfhJYMstrZGNqzLz8dork1?=
 =?us-ascii?Q?kGuKc3sTNlchD15n0dT2NIOLl5QSMNg0NZgnjQFiA5WXnI3UnWZWrJSF+B/F?=
 =?us-ascii?Q?eKsfn9HyrlXsAMHXiDCwrEn/sQyxhVRek6fRe54yYV91QF3OL5N/Wf1lad7K?=
 =?us-ascii?Q?5Jli5OaERgUYkPxd6rm3kcpc5h+F8qRHdMystSArPJ5sxW0y0Obf5bF27uJc?=
 =?us-ascii?Q?1GyIfceeQD7hPwNmLNZYHzkvmIXug6RJ/ej6hNNpNKkXr3ns7hQfpRmXbGVo?=
 =?us-ascii?Q?3h75PmVH3beJaC7DcUJzJxbqZ6P9WbnSmQxH/bgqmWL4dMNzhhmMbfEdmaCc?=
 =?us-ascii?Q?QZFiYSh/teJl0hunJpX6tvHad9v8FlI68VyciigeX3KqfzOamHEEpp+kVVkv?=
 =?us-ascii?Q?UrDbFb10aq0I9z+F6mCuUY/KTZuJkuiW+bTLUuk+wI5vG2/aB74dJC84IZL/?=
 =?us-ascii?Q?DJDCq7Uhz6xSFDIDti36lCjcj3KXaxWd4bDzDnDQAtRbSYUF0+zVizJAKmFd?=
 =?us-ascii?Q?sUtYu2eHdzRu9cGm2rOZNyx7LDxcmNRYXZlySskkzqM+KLH8ygkj8o+d421x?=
 =?us-ascii?Q?unkmf7Lg/Hna8iAMeJanWqV80OliWlLbdn75cHF6V/vYbhlGYLKVwdcYldmv?=
 =?us-ascii?Q?sZnXjVLUfBDz3mpRrNl4zwv8av4E+bilEC/bpAQEDP6ZrrUzdDFTgAtj2Cqx?=
 =?us-ascii?Q?lMV2gXKr/Jq+PfTefXr9YKn0vVHQzVBrJR/wujpJ/JSd+k8fNZHG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a916dc-b648-4563-3bb2-08df159002d0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:20:37.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpSFmZDvl/akutr8OD0dlfbADbXxInIYjlaUvUEKR3wtGHrXP1rLM2Ffr9ljiWuCm7qDHv5+SfgjOnJAjeqtan9f+Ss4Mgz0WLq8URK/PTTUSzILwME+KhkL57BDFRNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB296659

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Done with Coccinelle semantic patch and manual fixups.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/host/atmel-mci.c | 5 +----
 drivers/mmc/host/ushc.c      | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 8f4df250a77a..98933be5f174 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1677,10 +1677,7 @@ static void atmci_detect_change(struct timer_list *t)
 
 		spin_lock(&host->lock);
 
-		if (!present)
-			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
-		else
-			set_bit(ATMCI_CARD_PRESENT, &slot->flags);
+		assign_bit(ATMCI_CARD_PRESENT, &slot->flags, present);
 
 		/* Clean up queue if present */
 		mrq = slot->mrq;
diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index 7e8af5a06ac9..410e5bb62752 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -388,10 +388,7 @@ static void ushc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct ushc_data *ushc = mmc_priv(mmc);
 
-	if (enable)
-		set_bit(INT_EN, &ushc->flags);
-	else
-		clear_bit(INT_EN, &ushc->flags);
+	assign_bit(INT_EN, &ushc->flags, enable);
 }
 
 static void ushc_clean_up(struct ushc_data *ushc)
-- 
2.51.0

