Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012000.outbound.protection.outlook.com [52.101.71.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D01C36;
	Mon, 17 Feb 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790338; cv=fail; b=Ik8R0mI9xg+CzgeYskMBCTnjM+vPA4+tw+vTUb4kbYPHiFpgbqk+2JqJV++bF1qMrWuHf7i5I0bTd2SjXx/UqpXeq5VZBGF6Hb6EY4efePQTrdtLc0uLmUMT+qlXf9icio6B/wsKCFaBLqhoBme5UdfSP0Ua410HiC9kABPRIaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790338; c=relaxed/simple;
	bh=U27tK2kTS5mHLuVMZIZouig54vdI7P9Gsp3NKa2kFlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LWuhiMT/VdS8c7qwm0MrQ8wwpg7ij5z0ZuVPGDY1WFrkj5HJa/SjQSdmlyevNG28l9jTOq4xnb90Cy2qtqRNMqfOgcxSwMXA7pDnasKV9d+JVGPZ+JaWfGs1KnH9vEOJ3NVOmxEyaGXDth3v3pQnmeqlOn/cXm0Pt5kNhL9KIF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=He3CQ9ld; arc=fail smtp.client-ip=52.101.71.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="He3CQ9ld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuMWGb0ayRCyzCsxaBL6/4WqBd7sYFhmxJctgEsIvgeLbDVvV1s7qukUVo+9I11tFNLslHk0X9oMZZ5LSIK2no0pLL05UqcFp+FcbxJzgTbi5kBNSrtwI+xFUDyWHMQtrDwMkQtJv/kGiqSs0eYz5N88wPB7r0dTR1rMyMoM7bxpjrFOEYdqs3pqFkZoWx1IhsjHCt4Vrwm4AQoWKUdchZWmahizdoLlIlUH8TCOUlfXpmSGdQd9aKFc+8xkYRHC5bzSTBsOJoxLNjf8gBCK/RTxVKFhdAzvJ9/dq520jkTAGDzJ10DvqLaO8vnJwPyCGHl6/xwTTa2FcnS2AKfvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcwVoiq968IsJVaN68B7B9n/w8HN/ClzvU3K3/b5fYI=;
 b=TuWtrRNpm5BNyDOLnzKnExZj1+zXMp4qqD1hhVTadLP7hR2CHeMofBIEmIj7J3R03i5nJhGnepj5NG5C8106D1cim/UOh/AAq2MfHYCqU10R7t4q77W9wifZwlk//2xouAJjiTQTaoUVYjbgbtRRbLJDPcKZ0CNKYhUlpBvm+MJ2zY47QsQnXUtKio/EjVFFfd4kewfjww/FotjTEc53F8t/6prmEFtalzyWdf8PAwW/odzT3+L7LlAmUJuEHVFTMFl8Y1WQWrrfCwmlxQYJx1temfnbcKUY/4StGQhR+fFh7nQV2JvCMR1Kb8dgTZCNSR/r68mcM3vVuOJqaGG9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcwVoiq968IsJVaN68B7B9n/w8HN/ClzvU3K3/b5fYI=;
 b=He3CQ9ldKa0aeyv05ZZ0nGUWwuH28ovQZ7B9YrKZC42884Tr49XQvSK3mvBY2tv0tyUptc7Ga8w7brVz8kDuHVOJWLNXWfdqWChLZ2Obm2XORZmeHFZJy1YtZF03h05OPv84Cftip9Zp0Z+Ca62Z4XrhVMocdBnmgIr7m2JTs6QYAeAzV3U6Waf3EQwV4PAoVJ3vSE31OemyOjcN4hk9b9cGwPR+vPNtQtlxcStVbndljkGEaKnvWbFgskoJAKheQy8qf+2Xr+HDSyAR8zAxaFeh4b1wqZlpjZKTMWIb/C+wWhik/H74fz2mKn8du/t43HtuBBEju0GtHlPl4PrWpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by VI0PR04MB10880.eurprd04.prod.outlook.com (2603:10a6:800:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 11:05:30 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%7]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 11:05:30 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read performance
Date: Mon, 17 Feb 2025 19:06:23 +0800
Message-Id: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8574.eurprd04.prod.outlook.com
 (2603:10a6:102:215::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8574:EE_|VI0PR04MB10880:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fcf9d8-76a2-4c44-6166-08dd4f42fde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tVBsiYN+18KkciOvSMLSHm9f1W5ihVsdsKQPLRCLAa52JmIpEWl/Gb8/85S?=
 =?us-ascii?Q?8eCAdh/AnUVOD0X4da/vVLlJfh7YSLHHpgK04Tg0lwEFn+7RPkopucIWDkX8?=
 =?us-ascii?Q?eK7zeyOss7y3/nhEYdhL0GQfSDE/dXnxb4KI9YWno7FDKwhjuO+Rn8jonnw0?=
 =?us-ascii?Q?B9bI1yJo+OaJQgLTkYn3ukT5MjnMPPIpZn8CGzOc0uzi01eYKZ0BFmyZA0hT?=
 =?us-ascii?Q?rKGMfmGY3zptC55F8pFEMpA1ucZ8Gwc7V8hzmJNlib0XfPGfvop53kDNYw/K?=
 =?us-ascii?Q?9Qq9RmIbh+HeNo0VkuPEE3mo+/jop+1wUEIffN9Pm2kRwM4oHJYdJoL2B8Qu?=
 =?us-ascii?Q?4XfAWq5Et4ILuUwkeoz0w6mSZA2tLbmjToaMxcQxMOGQWxTJ3bz7zLgDN8Yv?=
 =?us-ascii?Q?WwQ00OIQ267VE13Oiic/HemppVc8B6NiM8Sz9w9MtyEllonOvauE+VDUipm3?=
 =?us-ascii?Q?0DPKTfcUCBOfB5yLLstcPElpLESKhwV9BRhTExL3lyc4xuORzt1Eb8LFBZOk?=
 =?us-ascii?Q?Cf4tKLkgEpBakba7LstTTz1CUd15A1LRvs0/drShQbYl8xJW8w6OVxftzEb2?=
 =?us-ascii?Q?y4fDYJSxBgZ31o8dfqYGIfkG6N0KZME/EFtBdoS+qEXOWGLAzSXwk+G39lM3?=
 =?us-ascii?Q?CazC1vNn7Gu5YGTwMPHhVEwRejfbPEgRBv7xhWhED3dQ/DE5G6pjuXul91vL?=
 =?us-ascii?Q?F4UQCGjTB5SU4ZJVN2W6sdUfFTzvAH1OLPum5XqKC5goSC6lya0cigYkFkvk?=
 =?us-ascii?Q?GCxff5v1Ty200KhRUKjEI1pedqcmwgkAaD2xmmxxnlaKYdc07mm2YwerKocw?=
 =?us-ascii?Q?0/pWNAebkLc/DraP0VgFOKY7+zfpQgAmFpMibEsxkQUn93d4cEv3w0PPsNY6?=
 =?us-ascii?Q?wcM/Nn7wdZW0SEbrM0mkJ7hC4BKoYclPIpZLdm3OzYHhhDvSCGvws7L7A0Yy?=
 =?us-ascii?Q?BCY395C+gB7IYJtb/9gD9DrQlj4dx8rbKqCAk46chMxlHTEyPbZgCvnF4MDm?=
 =?us-ascii?Q?IuyEObSOAh2/tiAzyBqiCte5kO5nW2Ct5tH9LUTiudhT0zWeHmSyMgj91QOd?=
 =?us-ascii?Q?Bsnfp8/0UWSJPOslsxg6N8C6rKbJgdM9TsSu0jOke1hVAORgscJRyMZaEa6K?=
 =?us-ascii?Q?2MYkRHSAbLurqiSNR3c5kXKD/siF3dYexwVPVVP8xRyUqlyxj3Uj3qpGBBv/?=
 =?us-ascii?Q?r9vE859zEz+0d/pyhIMmYe9SEdqbC3oKOJoOFbmfY0wKEQ7J5rlQb8aZ5Xof?=
 =?us-ascii?Q?SKnqDVaXI9wCObztmRyJtMqYO3TJVGRVSsrgHWk3pojcitdLi8HN8ZC6exx1?=
 =?us-ascii?Q?E2Lzeh7mVne0MLpEYdKzeEl848qRcAa2D8pA9CXr5dmMEDn4NYnfIREwRkw5?=
 =?us-ascii?Q?bNWPio3TYb1NuLOaq1yPWSmId3oioBux3FzvdwGxydvabHOcPO2ItNVzSvwy?=
 =?us-ascii?Q?Cx6+q2pMTV4GKAafxZzbCl4q8W8caePj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZ1xbakhdxfNZrZ+mXKLHOijZMkTdmoqVJn9vjRGCABiikNlV9+jxkSx42UD?=
 =?us-ascii?Q?nmrblX00PjAIxiUPp+wN1XVzM/ujE5b7mCV9WbfkJ4zhlFsmAAXIR1givx0i?=
 =?us-ascii?Q?YAtEthvIkWuTVZCMNNuhjS0Rrus/0NUQ7XPA91S5ZdpBRZAUBCooG3zPpu12?=
 =?us-ascii?Q?xaJWAVi6XitpDpRZ6xGdpQNLlmSYT6HZtnLkpEb6nqsm7lV/qirOUgoEDO0W?=
 =?us-ascii?Q?YW/Zi9DlATuQZOarxhzcy7S4YWPWp46YqoAMepb8pYPofgqeROC0HFN04TlF?=
 =?us-ascii?Q?5T/ORso9nohs1WxWXPBxYzhnvED5HQNhyY83tkB6VwCKJrWgga1XYmg/HteA?=
 =?us-ascii?Q?LHRB1LzSzkPMd487cD4F8Q3Tdzog69drQm9mxJxiH1NTjmta7A6YNP27rx3m?=
 =?us-ascii?Q?AuWH+mGorBjbTEOVoOho5rPxnj8d7obb/tKil5DXZD8614HdhRWZYWZDzo6A?=
 =?us-ascii?Q?JZfp6NOKVP5A8VhxcfL+ObZ0Il26L8SuaGK1mOkLD59nHYP+HeGUBOrSrTqq?=
 =?us-ascii?Q?3711rJKKXoOZ5ilHU1QnbS7jHs674MNekASS1pDCuNrtwcjv3BZma5Z/7JoL?=
 =?us-ascii?Q?rBPPvQujVJ3bNDUnW9ZeCagrizpyxbR4gKVGIx0eJ1ytG8aBx4O+1GopdR4Q?=
 =?us-ascii?Q?J1qNvSPuSMDyGnSBbL3JW/wBQ/JDPxlJ2sQOyFTJOMGnUtLqrp+zw4NpuiAH?=
 =?us-ascii?Q?y2mfMAhNCLVAJCEEtL5g9cB0DXAkvt6P91vYN6VeiQrQHNicigzDRC7L+P0i?=
 =?us-ascii?Q?7iy9UJbfgh9hE1FvbsRWuBXOZ3+eHh5EA87Vf0YvHwPBczH++0wGvrpfHYHw?=
 =?us-ascii?Q?qvNaXJe0gnztsD0YJKGkia0FEOMDMXaLuSgXmwEll2srIzudUaZcmvv2CoCX?=
 =?us-ascii?Q?Vw9VFQ56am6ZZprNEX4w5A9xPCxMs8XTFvwPiZvbCrESUwyVZg5mSiNGSvmq?=
 =?us-ascii?Q?ROukrSGmpai7XflGuqdA4tCNvasQmhthAp1g/Z8kjIZNNBF+Ep4QYPIOjvlK?=
 =?us-ascii?Q?z3e4pmnIiKU6nWAQCvlBVJaaT9MT4+TR8wY2oMtMOuAKFKDq9hj+NK9gTctx?=
 =?us-ascii?Q?Mm42G1WkE4LrKOUU9VHQ2ufjMQB0ywjYKbdZvJgfBQu4po2zU8FZxznIhR+9?=
 =?us-ascii?Q?XdWjOiAi/x4j6jtlO/XMuZC1F+wcx9Q48KAafG0Y23HpXN/kYab/kMzKHDtn?=
 =?us-ascii?Q?1VIpOzrATOtW/LoMA3zbiuqwexuAbOke5aFaALXHM1yxsTYa0k3D8et6iopB?=
 =?us-ascii?Q?hJSUomGSc0n5HK76jMadM/JvvOnBMbQcJ4R3MkQURZ6ZJoWdyj68kW3piJY4?=
 =?us-ascii?Q?hqQhoKb6dEQynkuvleORyd7SU5Nk5nG6tlWeGQhZBoWWN6JDPHalGCN60SNk?=
 =?us-ascii?Q?e5u0YG82p0ZEKrRpfDkC7bCjK0DVMuFzGTRgUwykw7xvQIJ+tPA9Mm8iOZ+X?=
 =?us-ascii?Q?lfpUvPzkk/heU2XnYfUUb583QF4SzV1JMtZ4UIzR4zPB4j9ypunr67FgqBwE?=
 =?us-ascii?Q?/hc7nH/i/E+xDMHHk0rkgpp//mzvhl1oETo7W0QmT2t1+FcuZAEEGcloAR8j?=
 =?us-ascii?Q?sdjcGji7zkZF0bW3k0OrhHe26NpebJeZ6USEe4it?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fcf9d8-76a2-4c44-6166-08dd4f42fde5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:05:30.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMiKPQ5mhEm8P1nD0KX54nSSEdkCnsAVSUYDIF0+7zxpgdAusKz0ZOjGdphb0/Ue6MEjbPwwKaWdn2rXDxT7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10880

From: Luke Wang <ziniu.wang_1@nxp.com>

Compared with kernel 6.1, imx8mq eMMC/SD read performance drops by about
30% with kernel 6.6.

The eMMC/SD read thread will be put to sleep until the hardware completes
data transfer. Normally, the read thread will be woken up immediately
when the data transfer is completed. However, due to a known ic bug, if
imx8mq is in cpuidle, it will take a long time (about 500us) to exit
cpuidle. As a result, the read thread cannot immediately read the next
data block, affecting the read performance.

Kernel 6.6 uses EEVDF as the new scheduler, which affects cpu scheduling
and cpuidle behavior. With kernel 6.6, the cpu which the read thread
resides has a greater probability in cpuidle (about 80%), while with
kernel 6.1, the probability is only about 20-30%. For other platforms,
this does not have a significant impact on read performance because the
cpuidle exit time is very short (for example, imx93 is about 60us). But
for imx8mq, this results in longer waits for the thread to be woken up
while reading eMMC/SD, which drops performance.

So for imx8mq, use the ESDHC_FLAG_PMQOS flag to request the cpu latency
QoS constraint. This can prevent entering cpuidle during data transfer.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff78a7c6a04c..b3bf9c171d46 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -337,6 +337,15 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
 	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
+static struct esdhc_soc_data usdhc_imx8mq_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_PMQOS
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -381,6 +390,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
 	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
+	{ .compatible = "fsl,imx8mq-usdhc", .data = &usdhc_imx8mq_data, },
 	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
 	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
 	{ /* sentinel */ }
-- 
2.34.1

