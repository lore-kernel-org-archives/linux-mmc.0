Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035D345744;
	Wed, 27 Aug 2025 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287363; cv=fail; b=RxP7qKONq2cAezNBTEqLmekkVytywr4wxMTAAzIDAs6Ktkz1Wqbe0uyf7du7CidMFYCtV1RdjmNN0Yjiwt2f/f/YM9RS4UCa+rpusWcyzHIWcbiPcwRA+GNGWaT+9ux/rcITfHg/8m40uFoCmPzFm5x/UlSpZDL3FTeokdF5r1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287363; c=relaxed/simple;
	bh=uyWRlrYXWvxkGswa1bju7Tt4Q9q/NfpHxAfyHywRFtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MchnuRVJjQblJ7Lh6m238u/NUCRBUW4ndD6zBdTaX2dzdVLhpl+yLl+M2YchFs0j8slLdWuvBL6HQw+KaIPSY9XxE3j4JWZ3On+aKOtDLSWKm0au05dDTuJ544h36HXwHjjuBVQ/IRxMjQ8a9EIg+ZEEXDSy2naLNNiR4xUdRQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UU3yo7dc; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UU3yo7dc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWLWzWIfSjVHa2pUGPXzeVfxwROblfqj0709VRByvHeqBDIcdtaYaE/8NNNJzmj7dtKMFLF90c9eS/OvjVkhlxfk21oW5ES2BZBui/dWZ+4WMnokUeta/vCnWX14o25tw5rv2V6/sO6IgfLFJqblUu9LzfXjcdhKS+9WcyUwCK2NhEUg2YGCT1mXSP3lY2qFOj5U11+//9Gjf2PmDnOb4k81we5s9l64tCK8HYlJNf87zwKronL/w9N09QEFtxlJQrYH7jwpxV1quQY5piaeLVoF3uDB3D8sqcAN8C4tWmocbdKrNUJyFW03FZ++HvW8yb8nabm3Y5nXwmT3zXrMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A00T5RhzZJdphe1GwbbLRbxU3NzIa2DAUr7SMJE1a1g=;
 b=agn/B8ekWMLSop7xeoIZHjqvQtnXYjMB8R6uJmTuKuy//vonrllP5/yKI9ic1mKvbsAjJjH+PHApCQA+RuC3CN+AePfP4obHLkZXfP9yxsZTbFY6YBKfngGAL0w9P09BIblWuVOPiYS+goyfCoCRoXOVNOm78hrLOo4GJiNDs2/tCBt76QvUP1HKTJaBbyiClDeDR6lrpZYHpefXwkidSn0vxYLv/AIg5Au8LKJlLqr8CWx7yhS4gypSwV6PX5AEvpbpmFm6eMIBBxt5yW83u6szrG3dPSMUbztjX2qRKwbojZQZ2eovWRiQdynfHAnmbj7/GJRZbmzJDIqpIaLEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A00T5RhzZJdphe1GwbbLRbxU3NzIa2DAUr7SMJE1a1g=;
 b=UU3yo7dcWNoesg5PSn4NgrqYsH8JSeNxHOLrMe4bFPikVDOUsOeochVeH4eNhe/9ixKybEca9rhf3zNgtX78KxNcgATW8vKdJv0zKqH7O1GyOyAJ+EXXkX/I+tn1Rk+NHmNIJM/hEw3dfEQfha6MFewr/iPfhIuJ/qUZLW2EvtkDixHKJZvE1h38nWAPSo/dTeFJdSAIsc1DXaTXPurRC1yYhuRmuzr2NylWhsfTnmrPKaCmW7rV2Txi7B5wAfCaFp13Jm05wtpTZ8rhI4whjUmDl6XjDkrLocBjUWHuCeUSIRoVrlqVMAMpKPPrnSYaND9zta3AvrTaiywxuWZK0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR0601MB5656.apcprd06.prod.outlook.com (2603:1096:820:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Wed, 27 Aug
 2025 09:35:57 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:35:57 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Avri Altman <avri.altman@wdc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 1/2] mmc: rtsx_pci: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 17:35:25 +0800
Message-Id: <20250827093530.416071-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827093530.416071-1-liaoyuanhong@vivo.com>
References: <20250827093530.416071-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR0601MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a080f9-b04f-43ce-022c-08dde54d1ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RtEfZz+25o5QIbp2L55Xtb6KNchMNfM3fPVNNswyJzIsEQgT4JqxmUljhXyN?=
 =?us-ascii?Q?N5UQCUXk8YwMb2xpuczs36H0cyf+ej5jg7gXrO0WaxE0/E2lOuLGMEq5MmP+?=
 =?us-ascii?Q?TTXdMhQGzsbR1c1muEBEbMmNR2F4K7AWy0nqJkQIUdc2Nn5tAISGGJVfbpio?=
 =?us-ascii?Q?er5LCVEzvZ4QfC+G6sBKu9U8wjHiWQZmdgGaMmUOloVIxtPk0A9rykR6dg0m?=
 =?us-ascii?Q?ZXkx244IewdhY8FsBfP+5k+c0xoKGokVD2pwvvJIujgRewsMDhPC1W+onNQ1?=
 =?us-ascii?Q?HDk/4VQ5aSJrm+UuHrXmuVO/YKeSETqW5uH0rMxTxvoXINd+cQ7cCOc7NOV/?=
 =?us-ascii?Q?G/VO9RIDduKi3RxRU5fIaJcGnPHV5kYQLT/KQEdZpbO99A0DyBnMVFS2a4ZA?=
 =?us-ascii?Q?CqrlGBaIUAiEGPUJPr8PqtthljNsrfmTXe+fPRG7FcxoBvQ0tyzPmypecepG?=
 =?us-ascii?Q?H0mjUyMtVw4N8X4qQR1sOJqrTQZiI2pRMxHOxCwFN/CQFS3zDs+wBTiSOo/E?=
 =?us-ascii?Q?VAR5yePA/5akLEQ9wSWpi8NiZQGydZPltfgy8a2IcoyHA0pWZp/nvb9l6emh?=
 =?us-ascii?Q?G1wFzawMMHRgvVD4nvnBkvlG/uT+d9FbWokRl0afTArj5shXPh/jskZsEnoz?=
 =?us-ascii?Q?nMKMqF9tLeKLdrcUE4pRusxWsatiVQl8IdjgVtf0/cy0Doo9eSpk/cicaddm?=
 =?us-ascii?Q?w+D+CUGdMgHIJPqWg0zyI4AZX/R1J+BVaKVCuX3Y9Z3hHlp/7EpE6NFifAIQ?=
 =?us-ascii?Q?jPor/fzt6nKqRXxojWJHeDjfIW8Con0XpTHq92CFrmzKqtwj4k339MWPzyY6?=
 =?us-ascii?Q?EfFqhn1c/vnfImNXWxGxmT3+RWFz9BbykKrTKTftMxJkdy327iC/4ZKsN7j5?=
 =?us-ascii?Q?bfxxrR828e/nyMZ0xJU54XK2Vm+dxJe+0Gxwqco4gXiBRzJUr8F3SYHk/dxG?=
 =?us-ascii?Q?bVHNMglX4BOlee6xOSOidh+ob52prdbSYXqb6nMOz8GMy3Wb37SbJtDZeflG?=
 =?us-ascii?Q?y1rUqTxNllsHifMXHt5X2f0dn31AUWDGrcFEJ2/9jO+TSdOsdnVK+HwkSFBz?=
 =?us-ascii?Q?gfVpO/YFvhQbwaAOP+9VSA47ovs4EQzMXFuICapm6hSzrAQyYckRjHZeEqpp?=
 =?us-ascii?Q?Ijt+REm4GUd69tF+CnuUfJij0dmviuXbO6K+5xSQyS1hFIrwIo7eLnNsl3O2?=
 =?us-ascii?Q?rEe0YRwCALq515wsnql/npsnFER16hTruHaDJlPCQwUQhcQ9bNEbrmzKRmuo?=
 =?us-ascii?Q?S8tloZD+xSBxhwurvHTuq8bIEdWK9Uj0q6hEWb8CDu00DBmib9SuYdx6Ceyw?=
 =?us-ascii?Q?/wSU1ia/LIm3bubntrfiVi0nyaQA+3CAzQS8k6v2FMm0cj7IarKy+n07fXDN?=
 =?us-ascii?Q?MyQPHVI6Zj44JQ896Pe1XFW9BR8YZIK+30OxEU0IwoWr8L3aHHDmHb5v07gm?=
 =?us-ascii?Q?Dlx84dGtMwOZgPifpV3ZnnBXynPKuKWLrwny6dNLMqoI0oK1uu2RRlHtIeTu?=
 =?us-ascii?Q?6nU4w0Eslfo6SEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0V7EyOMD2nh4smfhcgGOh23Em/ffBekZcckXfS5Mzclrr78y3drCangfWgEq?=
 =?us-ascii?Q?Ftzw5Xh6r/qIWfvrVz53B0o8lPOS3Ey56j0wacUUeIO4z4/dqpHYqmeUneGc?=
 =?us-ascii?Q?4G7fkThm5EIR4dunkFdX3M5SrVT81NIasYH1VW9n4x+wmWxSPJT4pm6vkX4z?=
 =?us-ascii?Q?XqB/7XRc6fVvat5x03G2cPW3UQfETxPenHSaPagV1Z+rfIgzDuSSLWUjVAOo?=
 =?us-ascii?Q?MoWjIcBE9EbrGcTRIy3CBk+yjpCe2DavSK960olxSb/Tv8XpVypBDqiuhuY/?=
 =?us-ascii?Q?FsYTRnpCfXA1pOkvPXamebO7PPvpJy77dCyDlr4tsO6dYOjiN1jSwMNJapW4?=
 =?us-ascii?Q?rGcp9K8ORExxoI0tojWM4obE5kglpoApCeY/kNx1QC4zxAvzEfq6iU1SCTqg?=
 =?us-ascii?Q?3IynwWMP+MAkrwCuytnIDkBOYwdpW8Hhf/tkj7XQPssGEI3FyJkjsBT56Kc4?=
 =?us-ascii?Q?kVmD7KzQqttgGyObrJDbQHs8s/k98uOxJ1SkZdCrQnoX6SGPoIkT22nVyfpZ?=
 =?us-ascii?Q?1RM8nsLe5FhNBEri7M0d3VhKbLQ+M7WR3q4AnAHPOjUjPu5vZNkuBA9DJHcM?=
 =?us-ascii?Q?twoSBaPldTjJIHwbbt1vzhCIfOQNsEEVuRP5Vft/3QZIPmHp6NfPMfyVMF7f?=
 =?us-ascii?Q?9Dob/hMAvgEGC8A12awyhvWuP6L3tivb85sYxPG4R1JYgsRTVR5JFUy11gaS?=
 =?us-ascii?Q?5ZZ/qO2eGccE0f1NMWyFo2zhsm7TspaZMf0vrV7KlEVP4aPkkV+ei4c0hgXY?=
 =?us-ascii?Q?zt+7wrVmorb9mo35h0H2g9BpnEh2Z+6rQ4WA0NCAjYRyjSMMiwA8tr2YTVo3?=
 =?us-ascii?Q?OeH0Yd3597Ldm6IlQumaptJ0suE5MhrMaxozMjMZs+GlHM8AwtT409kLmL6r?=
 =?us-ascii?Q?Dj6/Eddve+gTePU0NReMdXdtRCsMkgLgJBnD6JdpbnH0xWliS1EqxZsABzNX?=
 =?us-ascii?Q?JuZA+mpiE5NrcEi6mrCGomoBweBCjW/b15ukzGpUV4MbislsJvjSDpEOMWtK?=
 =?us-ascii?Q?YcBXV6saGUwB04P604GjSay0maB/F2PBWbpYzZ4LAFIyEWMqhIkIQVhS0zg3?=
 =?us-ascii?Q?mLsfOOE8EAGZJwNXvmKymLxr8d0efRHsJYTnvvR/yU2KLNEEZZbmyw37BGzV?=
 =?us-ascii?Q?Y6sBdVS883xqhR+F/C3hLOMMeCVTZkFttKM4hBenu3JygNpCVOR2GiUKnX2t?=
 =?us-ascii?Q?GrbnoimTE+4hZrzPZheFYMMBcL26jj72ZkU6UehGUNu2cNoN4KuXGRh5l8xP?=
 =?us-ascii?Q?7Qc+P/6XTVIhLVWHEfjvtTiT6xrT+YgSoPi2TxgOL1shxdIthQFMYyGv6m/U?=
 =?us-ascii?Q?DZhfSbc4aMNi9Y9BjcxgDvDMThK43CFG8Di/7CHr0Y1/N4L+5OVo9FX1ZEAU?=
 =?us-ascii?Q?e7F6MLUG6Rvb8tUQFBZ159g6I8ZsE8US8GwJJ5sah7O0HKK4zCHknrouL3un?=
 =?us-ascii?Q?X1r2/QUFsCqYA49xB2CCI+gTecjdu1FWeiObBlNWn7VMICF0GHyfT4y/i33R?=
 =?us-ascii?Q?yg2q/3w5HRz/Z45HKXZ4sNikfondMR12CD8WsaY97XB/uNaCyPXgmo9Io9qQ?=
 =?us-ascii?Q?LMKOxPQm43oGVNzpDX4Q9Hco5ZM2buKM6XKoNFcT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a080f9-b04f-43ce-022c-08dde54d1ff1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:35:56.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl+wQIOqBUKzZ8U35tcaWOiy4qT29IrU09UUpEUluMRIgvcr1ySQ/4Ptyb2c3FT/kpQmAFNsue8OSGCvIQOJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5656

Remove redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index dc2587ff8519..65d40ea9ce93 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1122,7 +1122,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	host->initial_mode = (ios->clock <= 1000000) ? true : false;
+	host->initial_mode = ios->clock <= 1000000;
 
 	host->clock = ios->clock;
 	rtsx_pci_switch_clock(pcr, ios->clock, host->ssc_depth,
-- 
2.34.1

