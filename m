Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9013FBB4E;
	Mon, 27 Jul 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148525; cv=fail; b=PJCJG+wYzRbiq7qigIxUuMt/3n4WGAm3G2+BYxzV+STuYfHu8yGV9bnauJ9ONkXPbFrrbG730OECsbpNqdFw6QPph/IajHs13jzmv8Np8mYBEKjMv1k0ouUElAixzJOi5Jf8HR9N1xLZ9N8xHO/W5tRAoIegj4f9ZkqxZlynFik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148525; c=relaxed/simple;
	bh=kQkPCn4YVBNY6lpRhfYYaIMsmc2GGyU0Xd9iv1gBDys=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=sCQRdu79WGVRIUbH8Lf2KjGgoRrUzIhMO871GWXv0JxDsKprVe+Oi6GgufkamEUFN60lWJ2Pm+iXBu4l0J0ob472PKQ1FvK2cxie3jMTdfmro9+UmEttVIsa532QFHHtYN35eJfTK13aac1/XZ18nrslcFt6Q7WR4Ltz5vZ3hBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QXcyGsi+; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QXcyGsi+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8BvLcnlCuEZcLU2P+vkhF5yzTV6RnZwnKeiTiP83U0vG4lYr19myEududyZQ+Rt3xCrdmb1Dkun//mNfcF1oZiS853Ko/Khk36sH+gPWZXOWd39agGNusezGWmzaduUr1FOhtnjZF3IPC13y9KXJXMFo6xOTOAxBC/YKRRxWDCvzK+FKZYQcOpv8GvFcONEdd4wzmH0IQ6ceFsSInAwuWXLKwsZBJV3pHwgXZKeIktCeakXx3so2y261yGfu9JLBr2O/NmwM6Gnq2wECEltgqCDdeltoyaH9A4EZo6csctIq803bXz77S3W9taw0At5pePeOaOaZt9FDo6nQnO1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT4roHj7IA5uDxmp02CU5wdG/Zf4bXvc0f6nY0Nyuk8=;
 b=OhxxiL6mtoQToDOQqE8GFaDkcuEp/LpiK7cJU4ZxT+CRilpBDFBCBN3/nbu5f+tMDzQoK/6DW710STaDOFaM8xNtFun9Mlpy504pPuDcX3bqug2f+a40f70crc0VJjG3PU1PrWj0qQ6DKVN8FnIYB36/6AEq3PRM5YpwN1ZgDA0TPj8TOHDF12UzybgsD8DhJxP4DnkpYXx5iSIWbjSwk7ZoCM8mYzbWVKBwkMDvKGmGfTIoV1Fx8gy41cHKuWi2CI27SZWR7dMVJLG8rwxjNfPQBKv88L56JEClmwD1kWD4pBs03zZs9GRn1O/KzFvT2n2u38J6HK3WbQwLeDU87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT4roHj7IA5uDxmp02CU5wdG/Zf4bXvc0f6nY0Nyuk8=;
 b=QXcyGsi+U/PiporXKSW60y18STRch3ii5WP2xz00+Wb4XG1OzT0YW8peuo2T4b6LJP0RuCxvnaLlfQEzD7txnnWGOHGs+DlFvnQgYK1F/XITEOdzWiP03ZU5VNMWuO+rrPFY3qMw0g1N5WCM5swTrBOZ9yjy/Ez7QMTtBE5t0Y6CbWptVJ0zq07R4Au3yt9Um2qnvPQ6xiHfe+I0OJHSGnUMlU5qKqNEHIt+CCjkGS1WPTOJJbY+fYirHDmk9FBmU98XFj4RavShKIzYbS11LC3uamfDZyXL4IuaPeJI8Nm3nv7/+DblDqkUftMxeTTiKy3IxDk5f4+JgXlT3P4OOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by DB9PR04MB11558.eurprd04.prod.outlook.com
 (2603:10a6:10:60c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:35:17 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:35:17 +0000
From: haibo.chen@oss.nxp.com
Date: Mon, 27 Jul 2026 18:38:49 +0800
Subject: [PATCH] mmc: sdhci: make tuning_err a signed int
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-sdhci-fix-v1-1-1a655a5d895d@nxp.com>
X-B4-Tracking: v=1; b=H4sIADk1Z2oC/x2MQQqAIBAAvyJ7TtA1NPpKdBDdci8WChGIf086z
 jBMg0qFqcIqGhR6uPKVB+hJQEg+nyQ5DgZUaJVDJ2tMgeXBr9RmXrQ1ypNCGP1daOj/te29f1L
 FxzRbAAAA
X-Change-ID: 20260727-sdhci-fix-13481630ae02
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785148738; l=2120;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=hhkbayyhcraYQCXPFr8OOkllGyKwuOqCjtsgsqOEi8E=;
 b=UlNV04Rf8e30Ns0uUEPAA/tFEUJZZAyartEz+mqDk27iSB6WfPjON6os+rhgdovaQXvWwCCTh
 n/MT7Z0RaReCwj2iwCTrH5SRaTmS9VWe6kon8DO6opu56NhK5VM5rXH
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::14) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|DB9PR04MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: e46426e7-4f3c-4720-a73b-08deebcabfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|19092799006|366016|56012099006|11063799006|10067099003|6133799003|18002099003|17002099007;
X-Microsoft-Antispam-Message-Info:
	+gaNnr8WYY9948lzHHiqRQ23lzznS6lbEzSzucUIu7QJ+ktj1tvegWIA3ZFJMYozQl0YtDKu7IzyZ/rLpOSdJoJJXRkcaiPW4cHSM08cymkh2izXY7dzp663/CP1k+HDSLxpYcXfijd9jalocy8QGdWkefM9Tv05V6iFAGCAfijqU8Ij59hs2mV+S2BZMNyNiCLDxSVt7hdXATfOO6RpHEkPzH/pBaLiVUtG82LBmMQQt2RT9sFhzcTahct54XAEXwNEugj1BprJDSZO2N7za+F8nKb5ZWyzhYTSyEklFYwfR0/gItyybE4/3pz4DxOKxHcXW42xR2HesRQlCSSrn4AgJVguqmIP4pNvVgmUv+zpvR5W43yjEGLb+KczPmHRPpw6HJvTRiP4fyazhh+UTpC4b5pi2X+Pnaz5nmUUlLuxUrhOF8a8/G/dNdzbMG2OgOAOeYoLxv0/gjJyicJT86Oap0vNchWbcVZtqKUN2vh5ggpaYyBJgcESMQcbBSZ1GJKl67n94S2dqx+43O6rUt+GpK7lyMBoeCtV8qYs6LsqdRtuv/KEE/yuwH3Wwjz0RTlVJxilterDVOw/TIxkcy55uVTLOzzPK4SfrweRMMpLbYYzCdHdsKHXgurC1SHm7s5Fhr1Z840tHlbZZO1Umg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(19092799006)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(17002099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUp2NzI5SUVubmUrQ2UrY2lIeDljelVKNlFzRVV1YnlYcEt6aVFRS3Zuc09C?=
 =?utf-8?B?MzVScjVSZ3BpQ2J1NENEOXJOZ2F0RGN1bytJa0JZQnNFYmZMY29FNGlFVkpE?=
 =?utf-8?B?ekNSYmR2Ukc5ODFEVFpNS2xOMHJ0c2NxYXc1UG1HeUN1R2ZudHQ3Z2N1L2hO?=
 =?utf-8?B?VlU4YWl0VXJjN0ZMZjJ1eGVlR0ZQQlJvM2E3TUJtR3VmeTB4Ky9yWkthdUdx?=
 =?utf-8?B?WjJGT1JESUsxOUFSL0lWUWpleVZPaHRPY0FCWEdCS2JvQmdsbzkrQWZUSWpw?=
 =?utf-8?B?YWhYN3N5dnlaZUpKaGpOYmZObFJpTDQybTJBN3NyUW1NWnRqYVNLMHVXdmJy?=
 =?utf-8?B?VnUzV3U0d2NCMHE1d08xbVRmbHNMVHMvTkFvR0lDSjBSMm5xWmRGN3c3OTMw?=
 =?utf-8?B?T2srQWtlNElvV2FiVHBzcVdodThvZW5ERTMrS3lPeVU5elQ5eHphdVBwQWdE?=
 =?utf-8?B?VjVmSm1uMHBwckhLQU53QWI4WGZVbGFGZi9vTUttYUY4ODV1R2ppUGpRazJY?=
 =?utf-8?B?MEIvT2ZGVG01RFVCY2xmNG9qV3NuRGgvenNiUUh4UmpkYnJiUHFqSWtwaFJT?=
 =?utf-8?B?bXcyK0Z3TWRyOThzc3ZCNFdkOE4vRFZOdytrZEU3eUNPR3pWWnVvdVB6THFo?=
 =?utf-8?B?ZjNad0lZMzhicVNKOGx4bkJ1ZWNIelpSZWxZRUZoZDRiRnluaUxTdmEwektq?=
 =?utf-8?B?YSt4VjduOEdwbjVmenNtUlFVSVErTmtXZHozdGdpdlFTQ2h1aEJoMGxsSU1K?=
 =?utf-8?B?UmFjOHViUmN0a3ZHNXExWjNzaDVoSnNkWUNUTjIyYjlZUWhNaW9JV2Q3SkZm?=
 =?utf-8?B?Zk5BbUpZRVBpN3FmZ1VvNy9EQ2dUZit3ZVJBT1o2R1RvWXp6QkNveWZ5djZJ?=
 =?utf-8?B?VERaUUpXVkcwK3JqMXZpREJsM1BFYjRwTGFpaVRUNm44b2VheHMwaXQxb2tS?=
 =?utf-8?B?TXJacDlzWHlPTVNNRCtmaGpudFVlUFlMMGwwcEk2bWN5dGcxUE8yN2EyNkZK?=
 =?utf-8?B?NFJzckxUM2tRcHg2bTY2KytQRWZTWVhqdS83amVZK0ptYytPMjgrZndDbFRO?=
 =?utf-8?B?emxtYmZFK0JMeC9UNTgyTHJ4Yng0S29paUljUzFwQThjc2liSmduZUt3SXB2?=
 =?utf-8?B?S3dCd0ZqU2JsdGJyWlR3YjRlaXB1NnRsaXNzTlBZb0E1SUhTdEppUm5KL1Ru?=
 =?utf-8?B?R2N2U2syemxDdG5aTVNzT3lkekpmR0ZSTU53UDd3YW53cVZLSVFPdVI2N2xU?=
 =?utf-8?B?Q21icVMrNjBMY25kSldrR1J4eENvMVAxalptNXhjU3oveEdTR1dRek1mdnA2?=
 =?utf-8?B?U1JrVlhTWkl6N2lmTm1RL0VNS3ZzN0M0YTg2bWQ3TDBxNHN0bzlhKzdyRHRE?=
 =?utf-8?B?bXhKRTA4a1IzVUxBSndIaWVoUjVDZ2Z3N1BZdDhMQWNDS3ZHYW1Gci9sMnpC?=
 =?utf-8?B?RXZjRHptRURCbUYzdStKV3RaK0p5VXhVVGRNS2tNN3Vsa2JTcDhNanR2bGdL?=
 =?utf-8?B?ZC9rVmtranFlK1hPSDl5OGgxK3gyY1B4QjlZMUNjcEJKcmZHeStPaXZoYzYv?=
 =?utf-8?B?SXcxeUJwb2lOK2xCYXFLVis0d0pvQTRiRGRJbVAvVm9MRCsrL1BlVUpBY0VY?=
 =?utf-8?B?MG1jT3ZOOFNTMEZhSVpzYUwxeG9aYkU3S0FkZWIxWDh3dGQzbUY4ZHlvUHdZ?=
 =?utf-8?B?VVNxVk9CcE1CMVUzdVhiUUd1cVpkQW5PS0F1UlpRYytLdVN0TFUwdS9HdjNs?=
 =?utf-8?B?VDZIUFdjczFOQzNiZDdTN3o4TjlJVTZtVjMvQWZQRExHdTVqZjM4clozOXA2?=
 =?utf-8?B?VE5qQmR5Wm5XeWphK1hFQnRzNi80d05kbHlmMTZuSVV5aHAzazBaTDhOUDlQ?=
 =?utf-8?B?VlpkOTBMSGFMNzFRbDRCSytldzBvZk1OSlBJNk9LVkxLU1VpT1hMSnlnMktN?=
 =?utf-8?B?LzFWbzZPSkxINVBjNmNwcEoxekQ5UjVIbVY3YmxMQW0rTC80Tk1ZazNpMUdy?=
 =?utf-8?B?eGR1cytOVzVMVEJDZ0lIZlBzTXZBTjE3TXlKdkQwNXExR1JwSlFWZk9pL1hk?=
 =?utf-8?B?SDdBakJnRmgvR08zT1I0bC9kZVhndlo5YitreWIwRXRTUHJwQkx2SUxWVXJl?=
 =?utf-8?B?QW1NVVU3aThMYTNHc1hsQTBFUTBjekEvWTVDMmNMeXU3VGJuQ1J5YzIxUWVs?=
 =?utf-8?B?YUpBSDJaZG12VGpTalNqTS9lYzd1Q3AxallYamZXMGhVOWpMcCtYR0hFSkQ5?=
 =?utf-8?B?a2w0cnBzcTN6TW03aFlsd08ySmRYMW9RQVgxNkJxa3REbHJxcHJYUERlcWZW?=
 =?utf-8?B?MFF3U0FpUEpFU0kxYUE1Z1dUYnFLdUVXTmdIU1oycFpqM3YxK2FoZUJvbVR2?=
 =?utf-8?Q?kn1TsQ7os8LIYxW43iwuw84jcH3wB3/uBbg7A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46426e7-4f3c-4720-a73b-08deebcabfc1
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:35:16.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X3PfrqMC8t46yiPUeg4Pmp7HbgxDNf2KDqLtKh3M3FkRxB5i7AVQs8yqOLsiTjXQlWmoYL3PXDIvr0BI4qMZdXP0C087EnbQTun6KfMohzgZGFVMSdDE1QC/UXwAUkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11558

From: Haibo Chen <haibo.chen@nxp.com>

Coverity report INTEGER_OVERFLOW for host->tuning_err.
The tuning_err field in struct sdhci_host is used to store an error
code for re-tuning, but it was declared as unsigned int. Several call
sites store negative error codes into it and later compare against
negative values:

  - sdhci.c, sdhci-of-dwcmshc.c and sdhci-pci-gli.c assign it the
    return value of __sdhci_execute_tuning()/__sdhci_execute_tuning_9750(),
    both of which return a signed int (possibly a negative errno);
  - sdhci-of-esdhc.c assigns host->tuning_err = -EAGAIN and later does
    "ret = host->tuning_err; if (ret == -EAGAIN ...)";
  - sdhci-of-dwcmshc.c prints it with the %d (signed) conversion.

Storing a negative errno in an unsigned int and reading it back as a
signed int only happens to work because of two's-complement, same-width
integer conversions. It is misleading and triggers sign-conversion
warnings. All users treat the value either as a signed error code or as
a boolean (zero / non-zero), so changing the type to a signed int is
safe and makes the intent explicit.

Fixes: 7d8bb1f46e13 ("mmc: sdhci: add tuning error codes")
Assisted-by: Cline:claude-sonnet [read_file, search_files, git]
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b6a571d866fa53ce2aad0105cea2909abe6bce01..f0fd81409a86c6fd9120e69766fa2407c14e9048 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -659,7 +659,7 @@ struct sdhci_host {
 
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
-	unsigned int		tuning_err;	/* Error code for re-tuning */
+	int			tuning_err;	/* Error code for re-tuning */
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2

---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-sdhci-fix-13481630ae02

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

