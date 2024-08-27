Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010062.outbound.protection.outlook.com [52.101.128.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6A12F5B1;
	Tue, 27 Aug 2024 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744082; cv=fail; b=u6I6W25q66myJAbeSg28mG2VJ28zs4ccuI4zHEi0e/FajJV9tvZBHnAJFt8IpVh13ZQuakN00MNI2TqmEoYKWXcu8Bxi2CcapDrAXXAXJzaB/3Tsz+Q2AYVA53FobdGFmUWUE0LJEuXy687zQCArCacCGhP9ko/EOeDo5Tw2bgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744082; c=relaxed/simple;
	bh=ABNQRMf2fGB6XHFS+RF2yaQMt9Bn7xQMBpilQu09+jk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0gBw7ObvZrYrRUgvevoDDArroejvNWJ5dGGQlx4MYMhKyOzsz9rPtiXP79zv3IednJU+xx9hiPe1apyRpiRTQAwQKmNipnTPmK4m4Mmxww5fH2BtrdqB5A42AUigNtqVpO9eEx151qOkX9n+yYUHY6x+3OLtwoPXfbeDcqUteo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GfKWJl/I; arc=fail smtp.client-ip=52.101.128.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GfKWJl/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJw7rsEP6+fGIAeD9gb9PdcDuGg5cMhuurVN65R/n/8xi+y7Nbv5o+LU0wsaG1MXa1m1Kjo4kSrrMcYrH3dViqrzwgnM190CoC1qWNvs+S+rnPBJVQA/gKxWvnODgiRZRr2yDeNNd4dTK5N91AvwAkvP0xSFiF5cu6u43SQwHzpz8oXSFbmc2Cu/sVKBPv0jqjSA1bdJmY2eHwBg2LbHtBAYfKPnGz9UE1g7IjHZc4AG1keNBk2nIBPINFdVmByqziaCQIHu8gLuEIc4PjR+ZttCn5vH1aXB0RLY0Sl3PfwGV/A3Rod/uRZ3cSFhwzVfho/GkFkSE+bO3FvdMhnkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=posYKQbWWTEJWc9YhLSbmjzO2EaiJH/gcEE/yOXaY8k=;
 b=M8N1JH/Vs/eUkPFu/ei0TzhkXsd1wnvseYZbRZ3lk9vKTU3i1rAcAZvNquSuUS4IgDgOma3piqVIU6Fzs13AfYnt/2zA+++jegOHNOdLZYG6tfe8/0l8Ao1gBrRhHt07kPoa8qQcu8nMYCLczEM1v3gs92FECukJOytnfZu1w3tcc1EEqY/SjK2jmgmJy7bvckKvhhfvnE7HVu2JESObAiSVwIFZpydvXJSRYEOVtOZ3CBhx4c/gNn+M8IN7A5/3tafd1tabKZXUe2e3Eg9FBmn3W/+cKebi0f3jMdEggnizCy7jkNbmFXeA4UBI57EVXRS97r6kXl6pSrIMzKKoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=posYKQbWWTEJWc9YhLSbmjzO2EaiJH/gcEE/yOXaY8k=;
 b=GfKWJl/IXxJBOC2Sgftc/zk1rDmhiQXdLQKcYd+iCsjD6MWcXZB7+bCq/VpSkRyRRN8At+wup920ZsnlpTFpTR0ZkvElO6K9KzDYAOLKtu/vWRbq8qXjoXHrlxhvasU8nUi6u3ljMk1yY8pQnmnk8Cz3E+Ge3DsmcqazQXNKwadEZkr5o70U2KbXEB03GG/9tXnM40fWlBzSS8WfNNE+ZhI/L1g3dsMxPUU8syfe5+LqhOGl81Ujuw42S9bCVRM5KZOMxaS3LvrPI7dfJvLwMFTAjUS65dz4Oa+wvSfrdcxqhOFamkSZ3MFXFZmafEnacm+NCa9y/nRNTPWXaiSpJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:34:38 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:34:38 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:39 -0600
Message-Id: <20240827074857.2671808-2-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SI6PR06MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: db6fe64f-abcd-4aa0-1ab5-08dcc66ab4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvoZwisLN6LEyZQcp0FCoU+BjFdM7Vm1FCfat7BF5bn3d+wdbIxtAe5g8pMq?=
 =?us-ascii?Q?98YOwEn3IgBOr4YK69VIkKqIaaTsTlz8vtXEa/PkOgAIVUek4to/TnYVjGTP?=
 =?us-ascii?Q?3z9kqLZVCEsa4u0aWaJ7TdzAmy6VH/1rOMEgGuPG3MyqyNmClC4boUqaGVQS?=
 =?us-ascii?Q?Q+GlWU/J5gKuXDdPyUMvNQiAXr8bFFsRIMLU6SMbVkROQcuXXCuCraahJKFI?=
 =?us-ascii?Q?Qo17j6h7hPU9cKNqf6CYS/WGYT7TRf6SpSnQbixphq1u6Wae/d5cIM+bDgNJ?=
 =?us-ascii?Q?Usf2gw7QPNX9aPiqkXMgYRWZgCXI2iDryn4uBDGd4XcrRs14iJFnJm2wXQ3H?=
 =?us-ascii?Q?Z+pFUNhkWDskfvwD3f4wEHLN/V0uQwMUYrSV++HrkVizrFUTGC9djqGbY0x+?=
 =?us-ascii?Q?caXSlDk/6wyfl0ctLnnBvCtXtI5k8kJxARwhYWp9l67igsoj7wF62WhREivO?=
 =?us-ascii?Q?npScmm1C/hXFSnakvjylnyCgXJ2xsklffGDhuJ4vLokt/be+C72Vzfdv3zGo?=
 =?us-ascii?Q?CszFv6T32+3yC5Lv19IffhmGWSDRv4eLEJg3j2ZS7TchM74OfqKHD5QYeM5k?=
 =?us-ascii?Q?ZxY/0as5TJgLS5nUKUssMMxcB7/Lbgsk2iyV4ElDGJ7bmyOT6jQ08jsdhQfx?=
 =?us-ascii?Q?jkP9GBhhjqknJKIuvHyIRFplhs1bejvZnX1dwwgYAjXk9IDSlg9uPkopKYZx?=
 =?us-ascii?Q?jfCNeYx8Nkwa9qniSvN4iZxrllpYMp7G/KrnhjIXh7ENkOtwARsG8RHGkk3N?=
 =?us-ascii?Q?4Zl+7ZpWXLqbKWbK2dPcmj7usD9vRdFLQQwS9UXA1HoORAQbRQia7+CvfT8I?=
 =?us-ascii?Q?okaViQY4CuW2zudV/lvVGYTXPsoaOffrzfX5lgZjo9fbdP01KFeXM9lx+K40?=
 =?us-ascii?Q?6gDFPzs5S2jHdV5oHs6HZ2XB0KKNY6QbXCzCQo5t0HHXWjDayQOjJf+SrOmf?=
 =?us-ascii?Q?5GEhPsSdPipcaVZIbS7kG0LwJ3PWTQER6MJgq8Gb0pvQdePobAaJPT77xEYO?=
 =?us-ascii?Q?q5eJNyb1N1Q7R83SMxJbA+Sb0d9JqIkEX2bMj4Z2BkiWmYIl1X6Jbcux7xZ7?=
 =?us-ascii?Q?nCi7RYPFr5d+uMnRImt4lad+KzFGaOxrRriCcI9W2Q4Hsjwe5sQ1bed5OBBI?=
 =?us-ascii?Q?fUYDVssfUh7aGSrOt26+09++yqmxq8cJj7kchVuNqG89qfHQKStO8hibg79d?=
 =?us-ascii?Q?NTa8hccVS59mX0JI5tm+pc+5unzWCdTJsBB9dstkvTrn1FS+lz/MO/GDkM5X?=
 =?us-ascii?Q?jqRIqc8iJzprQxRvK5BgBdbkbifXpjAqCEq5FE3M0TIzPGGcypSyRbMvRejK?=
 =?us-ascii?Q?g4yAZHyILP2X3vaa6/6T4AJ3X49gt9dICYjGKzjYBpK38MqYAhy2Wn75VBr4?=
 =?us-ascii?Q?iCjb/TAsdilfYYnjbxuwohSkvQqM8GWdC5ehP67B8sMvA3+3nWCn6sVUa/aS?=
 =?us-ascii?Q?MW6dR94c0X9x7xjBIlLNyAmKjS6bg8jB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uhIYZQmrjmAyUpQp4EQqFngCP3R6nRO3EnsVhQsNG8j/nL/jJTIawSuEQxi?=
 =?us-ascii?Q?pmDLmqB554+nhxpyeXVy/5w6Jt74+RziaW5J8xHsnVAJvkjaQHvfPkrblKIi?=
 =?us-ascii?Q?oDmxHdeiQFsAddtaU4SoDjXjZE8e6lkp9DD3bgw8h2poSawF78XlJq4OZLXY?=
 =?us-ascii?Q?pbnMZ466HycRU0PwaiWvbNxo8GzgwEELEg9SU58rYRv2502BBIdcYT/npNDv?=
 =?us-ascii?Q?YFxnYXwXmbehEfrb3VgztZYra/f3KUuHSZ7OYPL/cVAre/awtvGRj5piycZR?=
 =?us-ascii?Q?rPR/wkLVwkeiukvnn4QIb6zSLuEWb5Ley/bCusVEuY7v8A9AyvOonzEelNIL?=
 =?us-ascii?Q?fXe1yDJ2AqKobuuljY6jczdBia0KdPzYAxQ1g3ZLUkqbH5SROqv5LqE0Hhfn?=
 =?us-ascii?Q?2wG+7txUWfQb769zfhhB+vw+CU2Pl7nDtlnQ2+fBLTzQJj7DdSYhNC7tIqI2?=
 =?us-ascii?Q?gQ5czF6jIOV3WV1LUzWDMrddv3DmAynf+jp/s2/wrREtrhDkFn08Uck4qjpa?=
 =?us-ascii?Q?w8qvb2NjL8TOVdc/OP+Kp1PkerScn6Mobg98CwDqJVLa3aSN9Fwyh9sLbxXO?=
 =?us-ascii?Q?9cZ1qD697N88NNA4G52WbvDA0y7HsT4EsL8Ks6f7MM0qOrxXgDGWrNA1iv9w?=
 =?us-ascii?Q?VspSU9IKHZS5m29o1jKYNneFSAOg4xgk8F6sghrcCL5ssJ9ubR34h4hEgcO0?=
 =?us-ascii?Q?dxH6Rso+Mmx5LDAyuZ5nFUk6yZzEUSXzE2cnVTt9mhMvzo+SzEuWKa5/zb+9?=
 =?us-ascii?Q?hOfNRNmhMx5T1MjxTVpB6gp5LK7H5ufSQLULKlkS/uUZdfE21O3k+tQ5SAqP?=
 =?us-ascii?Q?fNsLVF96+cCB2sEZs244dspF5AczNO9951ch2wa3rkCfgyDlv5yiFLxDwppC?=
 =?us-ascii?Q?sZCR0eQFJCD4cL9su0xUq5xz9tMHULeH/mmGQA+P9z+gLNengEgWx4KcSW6c?=
 =?us-ascii?Q?+Z2jsvQocjn5d5XFUmjCi0S3YeanCLqaRpTSrjs6VqGaoC4/H6Y9+KFBkyo5?=
 =?us-ascii?Q?2/IvatFkCf6TKEamfISthcMa/gtjQTMtrcfxCpuBmRxkTstehkNigdJdAwsZ?=
 =?us-ascii?Q?TV3VyMkV1BhgVfEHfm/koFuY3W/iIzF+hf6RNAiqex9GFKhb3nz+hDa4NIkv?=
 =?us-ascii?Q?1U9IzsibozHz+41TP9JAEOwhYTxpl4CSMvkCa5xGWIt1Sw8TqEVNG9TWbFtR?=
 =?us-ascii?Q?Gs9Zc+T/okZBefVgT777LEu9VYd+6ljguaWm9YMGKH4AFG05rnJ3eRQZ96BJ?=
 =?us-ascii?Q?5oPAkgvxX7R/d1oJdWdNL8SHdIbc2q7s+HxnFDcMuDMiUKRPrj/ij3N5TIiQ?=
 =?us-ascii?Q?KRRhba5QJV7Ob4zjp4LWmibDuF6cuay4ciXQoUAYX5aoCJk588DzWKyVxNW9?=
 =?us-ascii?Q?riQCe/Mwl0Sn4QBlUdt7NdiXQNjzzC0S9G9klr7UXE9OhPJ46y5ZJoiLt5ns?=
 =?us-ascii?Q?AFNS+xdrnSXFn403nujVm6IXarYiwr3VZGPu8jT/VXJ+eW7QcNCcmxiGfavF?=
 =?us-ascii?Q?dJTAsmnXSZx5gXVgnGWV/DkhbirYbmW7JKBIIkOcvWOd8p67pKk69yVCfVD2?=
 =?us-ascii?Q?Yw/syK3aSg8l2s+EjzoPMxJJKRZjO1u5y0GgxZh9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6fe64f-abcd-4aa0-1ab5-08dcc66ab4c5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:34:38.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5uHeLLH5B6dJX9KL2isJTSSs4tdZP/E+Fs+L0lhnaGKbE/NwJhdRB7NXdBIWxiU50jh8RQBGqlWgFsB+3KQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/cavium-thunderx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 2e2ff984f0b3..8111e24c52b5 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -88,15 +88,12 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	host->reg_off = 0x2000;
 	host->reg_off_dma = 0x160;
 
-	host->clk = devm_clk_get(dev, NULL);
+	host->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto error;
 	}
 
-	ret = clk_prepare_enable(host->clk);
-	if (ret)
-		goto error;
 	host->sys_freq = clk_get_rate(host->clk);
 
 	spin_lock_init(&host->irq_handler_lock);
@@ -163,7 +160,6 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 			put_device(&host->slot_pdev[i]->dev);
 		}
 	}
-	clk_disable_unprepare(host->clk);
 	pci_release_regions(pdev);
 	return ret;
 }
@@ -182,7 +178,6 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
-	clk_disable_unprepare(host->clk);
 	pci_release_regions(pdev);
 }
 
-- 
2.25.1

