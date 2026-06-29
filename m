Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68707402420;
	Mon, 29 Jun 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724651; cv=fail; b=uQYP0FW3JDEEJE8CYhxY7BGC6toj+KzspXEaaKtuhEHzHMp9GK8lhLgy4fsRkwiCGoPAJKjxxIBVl+QUd3Bjj0lrYXJFv1OpEEqy8bKhyPSOeLhP57LABd2zN2SjYIS3G94EXdJEolhFztiw4wzlC3sy3amS5jA96I5ufVls8/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724651; c=relaxed/simple;
	bh=7a5Z/DBVLlrLMnFzmrkqFa/EVrgBvOwAl7IDTV+xi0g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dhwwdEMqCXDGR3r7OG64HRhhWY3AaCibcGMHPAQSDcalhOG0dUh/L7JAjtLI9iM2XeON/zKPDDm8CNUCaKz0OtCshAUsixjqc7clx6aYdiEBvIcIxuBS1Bb0yhKzx4zxEkYkVON96iaOKzonsaCr0TFBj26goLKvMEh+7VUBTFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o/aIp5ZY; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o/aIp5ZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLTTB8eH4E1d4x6tbePRK+9ucbFH9OUgERb8C7wGpRfXhELQ6Cltisk0YgqOGrnIumHMaY//1AGv48yaJwC04IEW+w5V3QxYFr2Ui4Dydlp9qfWeENkCLD8qfWq+E3K25T0GSUXgltzovjHnnMqCCxYDhw73g+WW06TEcZtY/J3Zzq81TDI+GR/Xtuhi3+HKkebvvQRLPiD2DF3vDrsHo7fkgKWMSqeiLCkAm9jPcRd13MJZuVKTezPfsZOjWt8d8/lqzq3mjkc/WbX96nMooiHCzAsgDaY9t3k+GRuLq/3Bih7vhBURWoh8fqkxgzzmNpzq4TOXr5LJ9bEBJeBDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbOojHOzJbbsjYydMNlLuhjwQ2CtT3mDjKCe3P49hxQ=;
 b=oqNvybTdwYmoyaSS/KYCw5BcWJDkJTw571dvQvKUXlyYvz7NmBfD4E1MxjBACxs3a+ogGnXW1K5QT/bfxBHfnMMhsIVo/dM3AUGn+DT4dG8S5MHsAQqJLmrPwuoVMCZX1zZRWnQnTNu2XZb6dRa6I3zglfJ2JHOKRIUL6qz5RQ9OsrWiQJB+k6cotT5ZbIu+9U4senq4urP62ewk1YuhGuRNlDMWKhQinkJZTZlWL3W9G2c9UOE2yirHJAWBC9MA0oFKC1zbYiiyJlUIJ99zdJVMILwSldYIbvZKpicXVts0lfXziUe+snlRkz7v5Xy44D1p412a4Yla0tjNUIjXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbOojHOzJbbsjYydMNlLuhjwQ2CtT3mDjKCe3P49hxQ=;
 b=o/aIp5ZYBOw1f0l3JXDO4pf3738FrCcytZK4Z889skYldreZ5a/kQXH5PG5g7wFs/S58bS14Be7sF8ps3PgW2Vl4tmU7Vtn13jVnI38SkJaFaXB5zrPnWzTtNcIN/hz3F+aEJGX/U5gttsBty910z/NAKkzYG3C6na1Xe53V5gEtQtSDRNsQWFGC0TrtqGWUrcNcNwIv9quJ+O67N6gYyRsP3rBBNQxhNEF2z+8ZrN9ytV6LMMjmralPkGlQ7WrzFEqz/vROKpkTud0ektmnozSzUlLEKZTou9WA79gzh/qluIX8J9tcaOm0M+HaCHNaPWTwfoMwVKrGu3Dht+bUnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI0PR04MB12663.eurprd04.prod.outlook.com (2603:10a6:800:342::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:26 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:26 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
Date: Mon, 29 Jun 2026 17:19:47 +0800
Message-Id: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI0PR04MB12663:EE_
X-MS-Office365-Filtering-Correlation-Id: 0205bfc4-800d-402b-67f5-08ded5bf3c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|19092799006|6133799003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1u6VrlCcdxoA+p9qy2e67jjby6JatnJEdyw3mJ5FENkuspxMfWPkD6nzgUXoBv7MuV3uwmoPAVe4HA6TJjUwTNmjVqVRrZFdZY7kYjibMgKTSmvbpW5uYE2lUIjpJCS9uRIruKrI+6BCQZ8GXCBnO5sp/6+EJinUVytj3jDG53C6ZRKNHMMUlkAV1cwER4wZ+JarREIec5VBNIluFGKh+qwW5hlgcfLOOd9P+bCGcgAQ059/BhAkeJqF92gqMxfT6kLpi+l61fFtWnSgFYJcQrqwWbKBA4QPccFQ1OZ+4oGvjTzIv7eYWVUgUFiCh6AKfheCZGsKe0YnKWdrQ9xA/ENG/ItgbSwfZVnQsQhnZpwzRcZl7e1gfxDxX4Umfoc6GFKITQF/iRUVB88LM0D/eSrKtn4CTed7Qh3DT68P9473UeRcIFaFVrXM8ZrWsbV1UCE+GZnSefoE2q3YNAwutajWyAo7FfevF5faZB5Oe6YeqEVh7bcEs+6y5uHav0y7QqzywQnZNt2JyQ0bN/lLSkuj8Fx9WreTawAWveGKr/k6o4SaoKc97fGeMcUh5GjYo9gSpWB9f/jY+fsELM85aumjeLyd1QbeWGLpXb2oIDBjCN+Rx4Na5fOg9TjLQcUzFOiSVka/UJZkz/8rNYz20bBYV58WMm22zDdHF3d2ZaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(6133799003)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywz9fpa3FbRRI+K3roaGCV5pru4A0YetzX6C83f8Vr9BeYdv/HrZNCdBQWqo?=
 =?us-ascii?Q?VTQAtublkUvnrmfL4dJVMRwX5mLBuvnxA9V+bYCXwdwf0TwWh8btFt9h+hX4?=
 =?us-ascii?Q?ZB/Z0LVHUPIFcCTid36qWd6MbtdRw1FRmnFdDluIan+B3Nm706/MryENYXiU?=
 =?us-ascii?Q?jYCM2Bo0Dx++Avhw7NHs9sO4hgjO5BqA/wLYmXTiw5DWPJs+o8ZvQWoRyej7?=
 =?us-ascii?Q?WglU0tlpfecauTPbOdeqXwC5XcWUl/cSgoomZnHTCKaSNDdqYRsn7QJ4M3Fu?=
 =?us-ascii?Q?hvasZVq3oAkYv62WxEqokx4ndt5/4hAifShdQ4nFEl022OkwzX1c10L7DAjQ?=
 =?us-ascii?Q?LviUbsl28o2A1oLIRKsdGGk2h2kYUhq95/UWLkT8qNgX2V6HkUyM4zIu9nne?=
 =?us-ascii?Q?CqQSHVgHlw/KPptePxmQ5C81N4jxD2QlbzNVTtZ0lAULGXCKSB1rhTFHVZ0+?=
 =?us-ascii?Q?oY9qi2b0t7Ionnmspg15ZnSjT9XNOOgdR/jE3SBXTZU/FviWd1TTl7D9Y6Wq?=
 =?us-ascii?Q?bbvEiafh2IZ6sdBXWo1sBxtXwlz3RX3ZcfDH5ZgfPeDTIYInaRAcgKIGnR7N?=
 =?us-ascii?Q?uNzeVFzwJXjj5op1Lzd2OBUapZSdEDeB77lF0mGdotmQwhUXtVMK+nkcUC/e?=
 =?us-ascii?Q?tVlMTjx4MHv1IeoHVoEVPV+28Yol7ES2VTEy05I0OhgpOYDgsqpG/PKtsUkx?=
 =?us-ascii?Q?okJ9uML93kRBjstrKPWCfZSprptSzw/me5lno+zLHRvgqF9nYgqSlEO8gVFE?=
 =?us-ascii?Q?HPYit+59TS0DE31muBDgbzIgRb5wTTb/dQe3x+9Ibzst0HHBPngbRYsAJb1p?=
 =?us-ascii?Q?yMTbN3Ucf00joV3N7V2DRPsGx9/jnXjebe1hAHC4A7YwAiT+O89Mv5PEuPtr?=
 =?us-ascii?Q?EOLwcjsO+tw82AW/og8a1AbljzLJ4uFZ2tWtyzEOOKjnQRHRuQLWihXZJOXw?=
 =?us-ascii?Q?GOBK7FVbC3NPrtx/zLW6SIFHpv3g6sV+6nIdjMvkpUW+2dFUN9YkhIzy9lkt?=
 =?us-ascii?Q?NSCK5yg9HXwrGDJaXVDzcnMuSHBVMwB51KHmUHcsnHKvxsKzdGYnUFxmJo0K?=
 =?us-ascii?Q?e08pMBnLBNYmLqPY2NMYxsFompHXdZnH3U6p2sNUs572P5Ux5fshrdSr40wV?=
 =?us-ascii?Q?51JE7UKIegRNfRmARpLVWaEPnzJol0F8Y1NCXUuzpKBTz5AAuEIs0MM+cKee?=
 =?us-ascii?Q?pL6vL/Depe7qhfh96YF7NOq48J88WXqQprEB3hAG+sJDNJv6iJRnZgHdu2UJ?=
 =?us-ascii?Q?QUlpQayy4y0Z9X7v469E7Wn9PasNIB+WQGLVU6gchEdJhLPmxbnrJdXQz+9k?=
 =?us-ascii?Q?a2LR5Unos1gglhtVNFw1zHeMZS7ieGhG141RR1cn2OZ1QB04x/vprqrsguCL?=
 =?us-ascii?Q?J45TfS0mjulkpdzadmiM6TXE4/XmIY5lN1d93AnQKyT+qyrLZPY7OYzxkth8?=
 =?us-ascii?Q?wBOgK7hATE6KGQ7ah0gjx7HFDKkUWqOPOHM+/w2jS3c38XMcXcSeJ5Y7L7Er?=
 =?us-ascii?Q?K3pTOOwXZzuZk0T6VJXUrhImEvwbykTt8oxu/m8RaNsnda8XFFgR+U8SjImE?=
 =?us-ascii?Q?WnKKECzM/6spuQsS363HPBVtC1hKjEh3gVc9Hh0IEiWdf4gzkfGUBaSyHJjq?=
 =?us-ascii?Q?oabm9lsvwA+kJB0hNhHassg+tuBupQoNYTSyiRIqbFsPzAZsJ5B9oNotSEN/?=
 =?us-ascii?Q?GME9BgAPV/MDtXNm1eE8RHW3yxi8Dacb+wSF/Yz2IEv4IW53dH8qC7Z51jCT?=
 =?us-ascii?Q?xMQl13eeUT19vzi8c+pvZkpo9PXZurup0yZDuHh+aAtjXkJxEdH3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0205bfc4-800d-402b-67f5-08ded5bf3c49
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:26.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMR5Fu+HV4R2fqO1cJy1l2Ajfh5R5vMSEJmyLLevS9+QTUmn7Me9ltRYxj62ElFdfMbeu1xYdEphnI2pIFRKAfEQkvhTnMazlLU3yw7MnHLrb4+nbIWzmLOY4Va2BALF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12663

From: Luke Wang <ziniu.wang_1@nxp.com>

This series fixes several suspend/resume issues in the sdhci-esdhc-imx
driver, primarily affecting SDIO devices (e.g., WiFi).

Issues fixed:
- Tuning delay values not saved/restored for out-of-band wakeup devices
- DLL override lost after resume for DDR modes
- Pinctrl not restored before DDR_EN is set, causing CRC errors
- Unhandled interrupt during resume causing "nobody cared" warning
- Various error handling issues in suspend/resume paths

Changes since v2:
- Patch 3: Updated commit message to explain the SoC IP integration
  detail about internal loopback path change when switching pinctrl
  from GPIO to USDHC function (per Bough Chen suggestion)
- Patch 5 (v2): Split into three separate patches (5/6/7) so each
  patch fixes one problem (per Frank Li suggestion)

Luke Wang (7):
  mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
    for tuning save/restore
  mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
  mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
    resume
  mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
    interrupt
  mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
  mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
  mmc: sdhci-esdhc-imx: fix resume error handling

 drivers/mmc/host/sdhci-esdhc-imx.c | 75 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 24 deletions(-)

-- 
2.34.1

