Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013063.outbound.protection.outlook.com [52.101.127.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B782EE61D;
	Thu, 21 Aug 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767856; cv=fail; b=jMT2NwOyBxP2zYthcL6cXwciVUMCLFeWDSQZavoUrY1IU7a/smL/diygfkHra6+hH0NRNnr1K7jSW7Xl7DvR3Z23VEV4rZEDxuWnJHv96vxPzCWVapuPteEuptmGolLj9rt33+UiBk4UAfgDaujmQV+2B/5bTZeSEWk0/ePzN+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767856; c=relaxed/simple;
	bh=bP7QGoFOtmdOtA5b4ZaVelpMRMVQBAS/2ClIEeEuTLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gE0uCMX9eetLf4+5x8b8DhcHnAJhL9fJwGBk8QGKzHvSf2UkjSY08UXjz3FYg7X/3sx62NHnFsgFxyoOFwRjPabkVNOIf77OpevXyDg1ueAR5rJVnrEHAAWNHDzn7nG5DSRdAtdGR+aZntN1m/fViIIoOI1/AiAwcSPL/lb69yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h+YtfX7Z; arc=fail smtp.client-ip=52.101.127.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h+YtfX7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b84mimz7RTW+TiMi6yjYj+kuv45SNiRF3LqhFdW0DeNI7o1AZs4ENmVQRRI19VSbkkWr2f1ldsA0o+6TEC+ruMDAykM6R21vqgC3rdo9Vl3qpqYSX7SuVqR4qBAqV0jjPlONPSiCZTn2Thr7SvyUM7wOxnnR98NEh6o/ybUTrWDu7JwwUtCJm6rsekRwZnAVZ6mXSkD9bUTeMUF5m65rhQayST0uJatcSED5MM3+wjyPrT9qGRULVsJJrhwzAcv6AqvO6fXd8A0kr7XOyb9WWaDPv9KK5pjvZQ5WzfMj4tpZJrDS9tG5HjM4KDK9WCY4j3PodaaqkKXY4A53aJvR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfaCJBcqXkUCsjXVs4C0mGa3BUrhL6G7ZGR4V6uXWr8=;
 b=XYD1EzXgVaqAAvnDciViBM4ltozRNqb5eZnlhc9V0Yta0+3hcpQzRtyJj53UHH5xGnCdamr94qAgwRTlTTAlBykEPPfNshkR3DC+OU2xMmLGFd7vjk5G7eTBVXCMfHz8kblUCZ30J7UCZBkMqedf2ke7rYo2PJ6Xqth2wIcKsaTFmIz+LYs0Yt2Qo2bDK5D+u/KMJFO+uc4P2za+SvvsZFOSY9WZFEfxeuIc06iw4NSkCcWhDZzsTCTiatfP6EPkp1UDXuk/LkG0nponkA+eFtWRceluBt8jsTw4EXCmUHOhGvlXeC6HW4jkuOoOPK1Q9EmGAxczqCMkd5Q3sIfpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfaCJBcqXkUCsjXVs4C0mGa3BUrhL6G7ZGR4V6uXWr8=;
 b=h+YtfX7ZAQWQ89hTn9si5h1YVPDXSwebhZz5XR5IdH63AMwZ9214+cBvvHyXLD2YnGkIru7uHYMYBIvCNiN96i8s0nQTiqudbMQuFV89hx/6tGBMzkGmTEtdORk3sDuwcUTwTwVPk0EUyAxatIhY0vk3rKY9HCXDs3pBEGi79YyhM+JcU7JYI/lBt7mctEVtKtultPbPYtSbCm+MQVksOulolsmKV3FjlPr3AzNGD1iBU4Le9MEp7lFJqGrRjJ30h6tyU7sY/6C3mUnjkeWYCM9zIk+V7Wq93PFnhP3LNuNyTO+XaM9vWpC0gF4ym8MtBNGyy4uwg6WMgDK0crD49w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY1PPF6B208127B.apcprd06.prod.outlook.com (2603:1096:408::918) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Thu, 21 Aug
 2025 09:17:29 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 09:17:29 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ulf.hansson@linaro.org,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-mmc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mmc: sunxi: Remove dev_err_probe() if error is -ENOMEM
Date: Thu, 21 Aug 2025 17:17:21 +0800
Message-Id: <20250821091721.546580-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY1PPF6B208127B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0ed54f-6292-49bb-43a3-08dde0938d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kNV7qQhfQy61MFyo22UmUJebURFqTuyI1jtlsFML9eCfWvSx3b3UxAvXHWnW?=
 =?us-ascii?Q?EKX6g4zWJIYPK/khxqq30uk3AQ0EChnPaWte9Ng/UH7ApxhobI+NGd3vrVY0?=
 =?us-ascii?Q?JPnfIsQrHdI/7mrm0Q/e7cT1OaVh1JkkFNsn+bBunSLbjilXafpLOnWd0DAL?=
 =?us-ascii?Q?IW5MIrXeXeffCRldbl6yRimcKMQCSAmcqu8sAMYVsBvLCkbVjveg4+WjaguN?=
 =?us-ascii?Q?lJSo1RLJ/eWYRZWD17RSrl+mTsL+ACF2vYXj2TYDUVFh/7dXO1y3QH/ZENxw?=
 =?us-ascii?Q?pfdxDicEJMI/n+S8cHvqn04fvBJd2Far4Y7ZDWVsGtWxzFpTdqMkT2/mDih1?=
 =?us-ascii?Q?BTLbRCNNgykVAqP8qqOLaPIPUkwbvaAVnwldeTYMNeKM8unxPrdHfjl+mCJ/?=
 =?us-ascii?Q?YsuxH0qU8Wxi769AugKcyWHso9wzsqILkOjtuc4BJOzsuyYY/Jf1f2hRd7J7?=
 =?us-ascii?Q?iWnTbFd6Tu58bhouV0ISmhZZ2VVUbHWE5bEoKIFhpCEmve9bV9tOnxgiWQK/?=
 =?us-ascii?Q?FaT9FlK1MdcSO4RhZIYeieBGw3KeMVV6v1FaIh1NiWXRpstJXJFMmql9g7f0?=
 =?us-ascii?Q?rRGAaVX23bwxVeqCbSemD4MkYdx1CLnOGKn3Po654v57DJRCONHYQ+4pltPW?=
 =?us-ascii?Q?zyuP7Cc3B75FoeaMJBcxeE1CnpYQIgabTThkRq/xInFnjD+RgfW4nirFBPcq?=
 =?us-ascii?Q?Jev86CFEsYugN1sQWYjmLnfZr3FBJK6K9GanU6sxqQg75iEPUJiR7Wfc+M7E?=
 =?us-ascii?Q?GTOMktUexSeqoMCrqhuRtDs64ko+D8jp+MhBuaNewY3IkfxegeWxiIOdYUPF?=
 =?us-ascii?Q?N/2632A0QaHJIg0sWSUKKakQdfY5tca/eS/Nuc5zp27HIJTpKredaArzzDtl?=
 =?us-ascii?Q?l9KXO/kLWnqNHBMOuJ3Ys/k4mU993jy1zW2QKqfO8mWeZyL3hmywVQ7PlYGG?=
 =?us-ascii?Q?q7FEcPDCmQeIBZJyJYTxMLkkA0dDGn2tMHjjVxCI/44sswTE+Gs5HsysWwy1?=
 =?us-ascii?Q?EDLOeBE0eehs2ybs9dGWHhCycgeU9i0Y0G/GOmw4bTOs721g3h3SH1Gqd2m/?=
 =?us-ascii?Q?QRQHqS72mZVXf0Q4Z2S0kfq8sA4SDKCsvALFDOBZP82pB3YOmGL6n2GFi4TG?=
 =?us-ascii?Q?xim9E/4FzkMhXPm0h9frPIDH+ivakfrH0ZOVDCjJfMpgya9TF1z5BK0Iqb5I?=
 =?us-ascii?Q?DclQgXxncxW/5vezVyK//xgkyWlc5cDKKkPyySm6qEoCVpXiZxWo+G/9HfE0?=
 =?us-ascii?Q?HlcOze6YmXMIVKGHKlyFhH5bohnEssUHkxz4duogns4JVylqcB8NgCIP9Hbg?=
 =?us-ascii?Q?TLuC/Rm65wLkVfLybNNYhMbFWRBwJVHD33iEOWCu0s8NudH9wb/2q/7bMz8M?=
 =?us-ascii?Q?+GOxkSSDnVL/ZOZ1zvcAVZUJr6kzCqOm8y70NSv6H32ARudmXZgw7LVCy3Fj?=
 =?us-ascii?Q?2g3WpXCDClIBym3atMHLIA8RuKx59zJR+meP+17/eRgYZn52OnO7Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrb1Ag4FzXF/b1kAOqOBSNPpBzUAci7sNL7hROE4M7WsZhm20kNZ9673nwda?=
 =?us-ascii?Q?4jc3radc0anDahdSzQleF/4RuyaFupnOwAY3E3tFe2JzEA49fo4gZo9iO7eZ?=
 =?us-ascii?Q?CruoiWZLi+UBuwE0udxCGqx71JCTC8UOVKa4Kz018lwdyEMShIXIYdwa7cHS?=
 =?us-ascii?Q?tRH0Mz7a/F/gbgkuPGt+D1kZ5iuZRbweRQ9OwqARfMOLh6NnpKdsKhRWKWRj?=
 =?us-ascii?Q?WDMhbu1DHmGKLrZpP4/dBd/8zhFua1TWyoug/QL5raI9f8OovlExeDQQRw0N?=
 =?us-ascii?Q?JExeVraSzY/EFNhlDa4VE2Pek0pYtxn+fHmjankh5vLUVFoOIcGSUMBjQHKz?=
 =?us-ascii?Q?gh0gzmit13559/2d4PqQkhRCVzKh84sYjiiZIFcFbiAq3geDstwgLRSSsmVD?=
 =?us-ascii?Q?GWloJ7IrwIv2jvYy94VlUbCx7YI8B0yEfeaN9zLw5RaBH+eyJ1ci4pSZKxwC?=
 =?us-ascii?Q?wwO8zK5BS7kgmds5NeyTEcBuD0J2hiCORV0wjng+AIm10Se1jT5zDR2YNXzS?=
 =?us-ascii?Q?WhEVsSmVh/+XzDsmkY6W61+0hiNIbpNkuEQTGLqyO109KX9tCwpa7wHBImRn?=
 =?us-ascii?Q?5i4tDWzL2IKBgQpFpKy43DZkFHC6oP2wqsRyprVwLk4uYhMijeHHKd6mooIH?=
 =?us-ascii?Q?aYu6YbpNiNaQc6gK91rmXMcm6/B8m6PgdxfFu9ySkszt6dwTyicorQSJ7G9+?=
 =?us-ascii?Q?jo5OFfkJicoekLHTirP6zU0rQIO+I9Le+4jH2l7e3OtEt+VB8FM1tsfGY/Ai?=
 =?us-ascii?Q?HUyi+3ZGmvFj7Tc/nUL1XGRr3X7dryErM07o84YUUnvy+z05ZBYrCWJ4dIWz?=
 =?us-ascii?Q?g5eELLo1QsJxy2yyJTp6B8G1Ubh5sgA+l9aaPdnGC5YrAy8RXf6hninM06P1?=
 =?us-ascii?Q?idMoj7yOTNCB372PcoTwZK4u4XDj+ic9QfqpbqCltwnf5VtG2FevJz0dr0TY?=
 =?us-ascii?Q?T5uhta8CchkDhAgxEx+rDZFE8BXl/CiYrOfuoQAURnpCJQdgCHvVqIbK5lYQ?=
 =?us-ascii?Q?nEWbUqrc8Lx7n7p3hbefD+q2XqrocU6owE8Q6/Cw4PhrtKbA2hwMbroxd3T0?=
 =?us-ascii?Q?In2zL5IbJx6ov7Fs8VzkrTkr3NqJHLCaiO9u7pH8CI+CZqT9VI+3qyNtlFw8?=
 =?us-ascii?Q?p2xK7F8flhKwQHJBqdKdmBNs7KZaqtPB21UnRJG3s5dNyoIkjoawo8pudvYq?=
 =?us-ascii?Q?btFM+IvHuOqU+C99ghOJPA8ecccB3/vqa7Kcf/PjxSGs/5OnLhRUGGJGHr3R?=
 =?us-ascii?Q?lGwEdnxIxl1lsGOFNKSh6c+nKgQ5KezGJkJN/rviyo9VXbzWXMT37ph+vF2U?=
 =?us-ascii?Q?mpJaDTlgm7mUsHIJ3Ri/WvUQt4uf53MZwYPM8JsspQN4hGRtFT7onlRcL5sW?=
 =?us-ascii?Q?15dnz51Uzu4zuFJui63E5KwIsFTo4gjE5gfoXaTaSeBgf7Blu2nhNGZ/y3yL?=
 =?us-ascii?Q?swNg8k6X8ZZFMk09ZEfeDzVxpeIeEJHoZnaNIv3bdYoNUvCeauFHiASU86Z2?=
 =?us-ascii?Q?kFKNNRr1mTf0a5KwfXeZ3dv+l/iA8TKzOnQtjY0boSoab7u7wtx0xfJAszIh?=
 =?us-ascii?Q?Xk8NkoC6n0x8qaymt5FEstrVsNfP39AvmwPMaXVl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ed54f-6292-49bb-43a3-08dde0938d78
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:17:29.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7CihriUHXymOhhzC3Kk/Hzhu7HpuZzQ2iPC3OhQ2WRhhExK1mi9nXKhtrUYqfKB97ho8QC1eOChycTOXaa2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6B208127B

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mmc/host/sunxi-mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index ee4a65b0a22d..8dd1d2409a26 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1371,8 +1371,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(*host));
 	if (!mmc)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "mmc alloc host failed\n");
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, mmc);
 
 	host = mmc_priv(mmc);
@@ -1387,8 +1387,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "Failed to allocate DMA descriptor mem\n");
+		return -ENOMEM;
 
 	if (host->cfg->ccu_has_timings_switch) {
 		/*
-- 
2.34.1

