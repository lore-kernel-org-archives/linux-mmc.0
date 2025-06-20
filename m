Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013031.outbound.protection.outlook.com [40.107.44.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500A625;
	Fri, 20 Jun 2025 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390251; cv=fail; b=WpxLyrpn8pbHdlrAd508+FjhjaUhwANiMgUOPNy1iKGyEtO8P2HG+OaVp90hsqZkhgHTi2ARgsZ37yLaT4Y8JKSLAARDIcRgT0j+jaRCuDdhFX8ZV7fEdNgg0Xt9RzFKmjAm0PlSci1KNseNyNqm6DU/c5oryrwoirh6nl+Bx1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390251; c=relaxed/simple;
	bh=nc7I19kEr12P/fTjc/dD5nSpIMM0aHjP3E3kfZywYWg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pmmOEsEwRcC1LtCy1HlZHDLAwtx3In4SJl6NaVPdD1Dm1KqCfz4DKWfQM0P6XTwy3yaUQPAXqGuOoaXd5eMsJ/rACrxCTiYDIPed6hJTpwa757Z7KxWvFBacp6pVJoMdqCTlyP8dCVxmYe2Y3A04GlItB2CH0UjFzxPturSt0sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wyb/XM+I; arc=fail smtp.client-ip=40.107.44.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wyb/XM+I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftWfcZ8RG8dnhKkAh6wKHwbxvwmDhKfEp8gWqSHqJpFOUsvAPmJYBFJHyu+9JjfbB/nyqqxeh7y2SCwVixWfkIQ8WU2ciYdxSbbI8/1DGs4xuEp+BVDlx3/zGCXs6wFva/t21D5RGbnYCQPHD5ani+m0POSUczITv0Rts3+c65U3ZCHtgKUgpiaXz1bpqFJizHLL1C1XrQCKKb4EHKIBZFK5bFPfX0jlfAW16wEDQrcyv4l8XgijOMX2IXkPf6yX3SJckgVj1lGQmjieAWCtORXW8nG98XLEIBCW9hplrueWI86UgGCjDp/sKYjd4LWP9qg8fzE/C5NtBOnmzyyz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fM1EYN95jnE5oIT9MkDi0LAobjvYRTY6iDEpl2z2ms=;
 b=kAaUQkFettWujC988sVT4fBxZu/Ws7/f1MudyegKCglrnHgkfb2QlKIeZvKxZge9ypgEI/Ju0+FPbOriCm6RAOF5EL60u7AHm+XNOFJxGCnYfxw94IVt4v3usD2ve2S8uWAsJGyE5sMKRQw5L0gh7AS1rbQYtHcl42u4nc4fyvYlCknyivMduFA4GiVCSX8YpHhrl7RRYGeR5L1WJLxPQiUFRGaWRl1igW87Iy7V8YAg0TULi/nFPtRuhw+QLHIJki8U0Im6yueq4SpE92v1wq80ygJSILbcqa/TRNo4mUJgoYYqjueSt7pDbk2mzbHntc39/sTIIVGSJNSh9c6Cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fM1EYN95jnE5oIT9MkDi0LAobjvYRTY6iDEpl2z2ms=;
 b=Wyb/XM+Iudf4c5MCEqGGYsypCSb1ZtIDXIxaJ8OeTvY69iAKKOxzjmuCU+vG5LjPHB/Rpq2v6tkQNS9zJtf/s1iwaCwq3NFSKzmKH5ImM3swejZr4rZI9xsIoyw9keJCNXCl5JCl94K6t5G56HW8HIIHCyv+mTKvBD1BC50XJTKdKVxIG+DuNwV8+/pg1/r0nXDE+RU4ADSCXpqCKgSd1Nfojf+ZZUqqE9Z/vugCO9fRwydQTtu6abKMRT74dPeX16ij4Ty3T4QWSJNFQBhZF8uvAKdSU6rSNyjiBG7WH5ZgHUzfctC+66xns/kpbtqjeNZnSc3aLIC2vr7lMT/QcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SE1PPF50B2D80A0.apcprd06.prod.outlook.com (2603:1096:108:1::415) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 20 Jun
 2025 03:30:43 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::710a:6dd4:e9a6:59a7]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::710a:6dd4:e9a6:59a7%4]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 03:30:43 +0000
From: Li Dong <lidong@vivo.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Li Dong <lidong@vivo.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	luhongfei@vivo.com
Subject: [PATCH v1] mmc: Convert ternary operator to str_write_read() helper
Date: Fri, 20 Jun 2025 11:30:16 +0800
Message-Id: <20250620033018.87920-1-lidong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SE1PPF50B2D80A0:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6436f7-1f69-4978-02e0-08ddafaad61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkrF5rAGElMC0Jw8sYdHEahMryMUvr6SBzFeLSM5jz3epqWzgyNil9IoO+HH?=
 =?us-ascii?Q?a+PF7lDHkmnVDXQy3lwFupYFoHjEQmA61M44C9LsCUHXhtMh9c+zWBiQgqZ2?=
 =?us-ascii?Q?Ml+Fv1/WXoDxed8RYbq2dLyckIH4evswKwWQklaW0eZDHd1UE0GktMT/5WjN?=
 =?us-ascii?Q?s0PHtDz9pB/YUkOOEEeBwmx5bdH0sT/1KDnJDxS4ZKrZYW9RGRzhrmLx18C1?=
 =?us-ascii?Q?q5YE87fQnSc0ik8gMRKUUFvxMe8FCp6BT2cWpZMWGNfImeZlwHOu52CMmEXp?=
 =?us-ascii?Q?EHgj1nCJyBxrtGfXDytzMUq03LNuokcpsLZtS8jlK0bzVxzl1yrESJ33zrJn?=
 =?us-ascii?Q?xpLzgGipuKgKgy7qG9j6eGNml3QzwpF13HPrf41yGtHFZLsLE2qT525Ns9pt?=
 =?us-ascii?Q?whzJ2pgy7y2FN/BF0r8lF9I5s+xVWAdSUCJW9w6yZJfW+bYjDu0Dg776k2+G?=
 =?us-ascii?Q?7BUMhT1fzvGe05a7xFiQtCOErST9xuRbJ378ofrhzKTKs4JVMtaiIK0paTlu?=
 =?us-ascii?Q?f/Bnnj3K7URBYsc79CoFLdT8b58fWtQq5THWEhRBk/0cG6XVmNO1/kEpSIv2?=
 =?us-ascii?Q?4CuJRWqB8ScWAaWrRIFPNVANPb2Wj+CFplYJTqzEVd3LhmuR0UIyzgPoatFq?=
 =?us-ascii?Q?T0A0HkQUByAqfRDICZm/zoNda6dKCmHAw/TSJVTuYRQKLbwXe9BlFNVuDE1H?=
 =?us-ascii?Q?uwEe6PBD78KBd82YnQBNoAPMtAc4nRdlS1LH9hs/ikAY/zF51Pz7DAevUk0t?=
 =?us-ascii?Q?WoN/ge00XMTGaNwqd/d5lvbgWkfZZeqIFKeSygJK1R8oXQcub3e0tYZkCyzY?=
 =?us-ascii?Q?S9YVd4dacsQD8XfxQxte6LwAo2f/3NGs6/bOrXnNL8VClF21m/6mku7P2qSX?=
 =?us-ascii?Q?hI9tG4q2I2HTDlciNKm7IZxp1P0lhyOPkjVHk0LYOhR5HgMaa/NkiRVKipqX?=
 =?us-ascii?Q?xBqRBRKBIQk3zjZbv6gRxFSg8AXm53TG1OXOUv7qlP2IVigmDBcKvlZW9ICV?=
 =?us-ascii?Q?AVMmcyAGE3e3+laqaCiPo2QLb093FC6hayE6xYdfQSRCn89siPPIiR5bpoTx?=
 =?us-ascii?Q?8+GfEYlLjgVDCX68OIxxPmDbpb8KlM6FMj+MptaQmz5mv1bY0lg8sG0BrA8w?=
 =?us-ascii?Q?myYwxo1os66qWfEa7o4strFPO6FZWG+hg/8Rm16PIah4PELAXchiubuVg0dX?=
 =?us-ascii?Q?ca3l1oekEWNuv6upBWGoFP16EuVHg10mRTL1qPArPy511R/QALumhNJ3i7TJ?=
 =?us-ascii?Q?9C/iLP2C6ptunYzCQrcNskaukx/95mSNSts2Do0U9fBe4S5iCrcx6ADKPQt7?=
 =?us-ascii?Q?74DN0SpA2r0MijEPlYn68oTeQzk3WbhNleZewnP4THWxtmK88lEAIAfrt5UR?=
 =?us-ascii?Q?MiXnT/To3oNkYPYU4IOnjXT+CvqyuQVHLijPBq8grTHcfbCUZJTYoD+Su5Vl?=
 =?us-ascii?Q?7uNV0c4JpIMZ0xPAwxijrcT943XeuVUPz6SmT8xm7ZJxj4Z3YqRgzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXTZONB4yOXEx1sgfc06JUqhZmUz4yH8vCf1DHr37HAwGUdRJFjrG3AtWxpx?=
 =?us-ascii?Q?53igsy9DT5mIEJvhD3PTymfnnjfWFht/SteHP7t3ezK++Knp+t2d14zie2ko?=
 =?us-ascii?Q?4+a9zF4zjhyzjV4wmPRBvaAOctd9z+m6qtqHhdwc1rwcGTDONXk452GLad5A?=
 =?us-ascii?Q?j4tY3pbPRgNqHS2KJYgI1+LW9RvHJIQmk3TWnwTdSnkG/A6/Z66v7HyG9HwU?=
 =?us-ascii?Q?zmkI7wB4LMJ2ARAMaCzjlowGBIfnxaD/qse7iMsCvMrz6M5axOMSH+nK3zBa?=
 =?us-ascii?Q?W0UCdv9NVjyps0i0XZSmtFgXLsRlOU3H9CxLR2f2LwlDr3Bf5PmBvDWxLZ8y?=
 =?us-ascii?Q?cCrVw2BXUcAwngwb6L5xMUeI3kvVRhgLQF2d3OPiHIj2IE7g7N0b/KgikfDE?=
 =?us-ascii?Q?weP5UZjnJDa5vvChW2Gijs5aQQ8Dvcy9AXLnxsdPVCDyy/z8YalQtzhNayWq?=
 =?us-ascii?Q?DM02Fgpjk1YzOL2sCpCINBBmvVPcAQ23rq0ufXwaeD0pc33wBhBBLiDHCNqv?=
 =?us-ascii?Q?Sik0dRB/utryvL1IBNiusqTx+dCxP4XPQtE1dBcs1qGMTIMFJyIqCWmNo3Jp?=
 =?us-ascii?Q?AHVN64LokdTQJJmHfAQNnIthMKvPOCnzKCWoDAxNdJtoTf4CYcW1Cwakf1st?=
 =?us-ascii?Q?UjNMV2zo9qjUYICixqDu3R7NGuGR5nWZwGepnPp/7NUZF3DLdt28eOFAvR9A?=
 =?us-ascii?Q?NrS760+HUm4XTUjmepbJxMB3QxbMBpTrN6o5crGm0XNVCDHZPaP17f2Aox2j?=
 =?us-ascii?Q?zgi0gvjNVtY6BwNnAzpMp3WkAv7FuwzilrjK25lztFNKFeh0hB4cCvmddAlW?=
 =?us-ascii?Q?6cgdhic4sbZrJTIiClAf7BRYihykVu7a1Zy7KRfAXnYqlxHEkOd7FgewDFaj?=
 =?us-ascii?Q?mkSfAIxLhrpmxRVMwlC4qaN/7+swIm12gjJ6bd+DZf6muHmHmkV/W5f1PD/y?=
 =?us-ascii?Q?sIoVbaO09yYHWjauluXjG9+6Vil7P0quPRjLEBgV94igiXq/pEavjiul58tB?=
 =?us-ascii?Q?IAvBhV+foqh1hRRJ0VsEKvKr8dzBeiWM/e8n6rmkDt6ezfR0JKNqeIwm3SpP?=
 =?us-ascii?Q?pFlNKTxkH4Pe2x6oxGudbrSdtscfj80OQ6aUQ8Zc8QI1lSs1Hdjl9MJLC+QM?=
 =?us-ascii?Q?OL0sQOz2A8zEBviw8sK8XSKzLf/dhhz//lBtR/kAYnB0W7WINOJnXLiZmnjp?=
 =?us-ascii?Q?lANwXCSA5lR7Zp9GXNqJitorTOPxeIbkY9+zmKBlPl+NuXeHwm+1MyUgcI4x?=
 =?us-ascii?Q?Qc0PywDqx+o+mxIHlWoumbfuL2uhxO7/b2W5L3thDqgg2fga5M5miFwkmZVe?=
 =?us-ascii?Q?F48r5o8Og5eycDRBs/abDOSQAbYKrxTPu6mqDRPxR7XbfiS7qvwbDqYUUiT2?=
 =?us-ascii?Q?OytWxOXsrq1qDZb1VC5EDA+DKPZgIRu8ksWMpZIvc75xtEJjR3d1fRNeZ3WF?=
 =?us-ascii?Q?yz43f07wpD6F2/rQ5QUjq9F33jITPsKxcHsNdCOi1t6tygO66Gm8y2wdWU3C?=
 =?us-ascii?Q?cINd2WqXASVYaAbCNbP+aY1GLGpAiaNUj/2qk2MdiRn2Ak3oy7C/NFrTAFGm?=
 =?us-ascii?Q?8VmXr5M1jXGYYaZLsR5U7zcXr/aFp8VazxCncPfn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6436f7-1f69-4978-02e0-08ddafaad61c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 03:30:43.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqdk6owcqmUQsvVBZy5Qd7UjhB4g88zo5nDSSst6DPQCggPLwCYqbSjAIyl9vinBGWc0tSWnENET8mqtOEA6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF50B2D80A0

Replace direct ternary condition check with existing helper function
str_write_read() to improve code readability and maintain consistency.

Signed-off-by: Li Dong <lidong@vivo.com>
---
 drivers/mmc/host/mmc_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 47443fb5eb33..0a1098140dc0 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -27,6 +27,7 @@
 #include <linux/spi/mmc_spi.h>
 
 #include <linux/unaligned.h>
+#include <linux/string_choices.h>
 
 
 /* NOTES:
@@ -774,7 +775,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	unsigned		n_sg;
 	bool			multiple = (data->blocks > 1);
 	bool			write = (data->flags & MMC_DATA_WRITE);
-	const char		*write_or_read = write ? "write" : "read";
+	const char		*write_or_read = str_write_read(write);
 	u32			clock_rate;
 	unsigned long		timeout;
 
-- 
2.34.1

