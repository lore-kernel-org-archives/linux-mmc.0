Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC425487B;
	Wed, 14 May 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216071; cv=fail; b=BubW4ePY284MO9JMm2S61QurXOhld0BGInqEKB3JIbskqovIBZUbhvmafG6uYRqmTktpd8DU2Gs90IsXSmX31XjoKS4A13/BU7lMLkC1EM2zwYq+D71k2I61iafvmuU75T/aKIdjwSRbDDauP+YGpMS6+aQGYgJ7UYNA8CYkUMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216071; c=relaxed/simple;
	bh=NHKosSgBkUz1f4WsR/yKXTaYFQta1Wmwz3xVbp+VY1c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TeXMeJHBOzcV29mQCUngW8JaMrt6kxLO6yfPRCJmxYgq4yiD6eYZwJiofp3DItKvJD74aUGi2DfKSrsJDbRNjaR9Q3Yb3P/byhdOgPHLYMk7zz/VfRtSSf5jpl//34FszfZ/oUMSoiAmQpFKY0We/I4GhJCE/QJWwFkbBAyisD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EbUWeUT4; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EbUWeUT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPwptER4Z6+eAfOFI4dvuoUc8JXf+cQKHf4FVOWXX00fuCxiuvTA/h/IGmnYycWXCwfWC4YRyVEKX4QAMoL/CHD2X2LircqCdGuKD50qUwz/MSVnbxhA6LvDKSLDxosdwSASzEKdiOBsfpx7LFXW8LR4tUR9JgMib9zdx+JuxFEHPmXfFKh1GtIs8NqzS8QbkdAe6/GRX6p0m8VOMjXajfXAa7YDLO6T4qNfPVnQhKMNBvHsjYNSp2r2m6N/AdYYRqPIfkQ2Ptg7S/BrPPiFjurlwIKWgR3rViaC2VDfNxtLWwnHd+sZbOJz0xtzXck8gt/i0IaU7KJ3Q/svIsdR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr05PoxdbyXU83I5GFGTZ0B4h5EL8Bgl6f8LngHF2go=;
 b=XV5Ayib9P+sGlznWyTZyRU0M8FuKR6XszCdQlSQMBoFrBf5RcJ85dundmw4LC3DZ5o0fyaHSl45a2036e4GoefrsqcsDbKgGyMqJEnHM/7JimVdieH4LNlmTGe1QtBnyoG7pUjE2+Km1flDcYElXvff4Dj26IgHNscGzg5sX3NtF6BnGqPIAUKithG3SlCXZwOyupQzuu4exUSvWDsgrcGAmjQEbXqAWW0Sh4FzO4J84EZjX6v7U1pke6A9nxWvqwrMVm3+nmnHaI9EpYopV4sqvPL9cy3t94wqvNGc3uTUWd901t8vJD+2fVZtEWB2l6/EiwL/N40pu42ZKwYZm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr05PoxdbyXU83I5GFGTZ0B4h5EL8Bgl6f8LngHF2go=;
 b=EbUWeUT4M5RTp9uJlLwlvrjMiUf5RR5mDvqHcqwKuMMFznDgmUZGiasPytO/HT5ddlIvpkY4BgW84o5K8xa/6rhIX9RtnIJHYp1QutGI0e/BnzgOTaqgYbvAJQhSQQzzUt7AjqJvU069xHpq9rTdfvgNdgZl1nC8FcDuNC8Uy6vVzVXxL492HqG3pCUR8fMqxrQ5ePPL+7BAzdxDNwNaEdinV/1tB93MwGirtGpdpJgb8ML9NKtN/pmKlnyEPahN5hjWoIjcJ95sE0cTnZiM381XRofZRmsKR2nPcClgHZTmRVEPrKQK0kASNkQ35eLztvwxhoJAghvxIira55cl8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 09:47:46 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:47:46 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mmc: sdhci: export APIs for sdhci irq wakeup
Date: Wed, 14 May 2025 17:49:02 +0800
Message-Id: <20250514094903.1771642-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::17) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdbb778-df3b-4c61-3cc0-08dd92cc613a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4MufiTVjSZLVNhE3qQoWt3qBi5Q1UFIN4w3rZDCvl1CY6ea+94dYl9pZQ3Ta?=
 =?us-ascii?Q?L8WrPVRMKxCniHjh0+63QXcITIL33vKkuVcRQ5rpyH36141ZDhdi7ebXpaAg?=
 =?us-ascii?Q?2dOi7lS4ryHwxSRnKNvalzwflSA19EJCCjIipmsWoF0XZk2znoARq9bbVduA?=
 =?us-ascii?Q?+RgwRHvcOtIzQI4j+wxGcHvi146OUY/baB/9PJEZSBUq8bFyOpVU+u5b/4+O?=
 =?us-ascii?Q?iXRv+GqdSpRtrXCLyTKNJDnEvnKWVb0o7vcPotwwDoK5ih2G7X74GWSDBYNy?=
 =?us-ascii?Q?LbrdmYTjqsaGDAULsKKfKY2fSz8hq1XyLvIF4yGD24SpRtloSK37Fshy9wL5?=
 =?us-ascii?Q?WMz9z59LaRP8OuHmDicz47A2Dsh6zN/4blWolNK+b4KID933IS9bt7RFjc9a?=
 =?us-ascii?Q?Ed9zWtewsSn3rqIM7pllxCOmN+X8yYtXHBahBv58nb9Nbc5IKvUx0DZfLmNn?=
 =?us-ascii?Q?oMe8ozBn2DcvpYKDIgXUJ52msLzCL6MHpmkL+Z19db3QNDckUwxWng9ErgoN?=
 =?us-ascii?Q?7Clsjd/lTYM/8APzLPZWoBtwPdi4eeBhjgO8ja0xpBfZoo9G+Db9nV/2DxPA?=
 =?us-ascii?Q?ElAZxOXq5xYdu1E8RfjrgALwGG9wE6LpauNERYB9nhlaZ/uyEJLzqcPPwgDT?=
 =?us-ascii?Q?N88a/SKD0Zzy/47Vhr2OYTE/IRe9uNag+tQaTLl+ojrZ5YSh4XynS8F34xG4?=
 =?us-ascii?Q?6C/aKPP37n5MNXz/BgWeZAxasfErjfEj0uKuTtGyGuhxSYmxSh16dAgqhC8t?=
 =?us-ascii?Q?YBunomaovR9WXtfP61Quunmwvo6Iqv15lgFSzRLWdDal4rnADe9VvKPTgbU5?=
 =?us-ascii?Q?ojMUW9QYGEj/bJqHCdf/AnHXDBRUyoV5yd5oYQpFLu7IsQwB20hEXlMaIetm?=
 =?us-ascii?Q?w5LaVpZkfhExTIyxOOwjVfBVlAIOLcw6kv5ar7t2DrANP0tm955Kqf8IpUhQ?=
 =?us-ascii?Q?gT9RvdlIlvwhIRWHC0imoKcvALD5gIKzEwSeDlJJ5Lr+APME3QuJISnL+EgN?=
 =?us-ascii?Q?Wk61EnvODeHzgf3wFK3aEuFJH2FfOQAknZ043z1rBuBimGeiIcfAWMdBYxf4?=
 =?us-ascii?Q?HiIgYVuugsU4ymCFg5KC0L8ItDi076VIyPkQTEoUf8YIKThzwubHmRnePYeo?=
 =?us-ascii?Q?LWd8JmcDuGeKCP7uIyYr0DXgoxuvWu4P+TfncQ4QD4brbbBlwMyO5bHXsgGS?=
 =?us-ascii?Q?Z+HLo1Y5p4cxaSP+ImLu5OLRlh2YVVzis+MZWqXuch/QxD1nayEypyfRCK2+?=
 =?us-ascii?Q?KGsS/X3PsPmesRyCOebkS+NjnlYOOrSSE87e6LJP1CZkdgN5WehjpYGGA+qM?=
 =?us-ascii?Q?ZFZggO3azCUbn6TJgLHgl2Yrbe6FFePmJoFn6zy0mP8mt8VrUmLqSyzwVlNi?=
 =?us-ascii?Q?D/oPrgOYGvcKsR94Sr6vtNGHGEWJpQJrlt24y/gfF/Ss0R/hNy7u8YWTqS/a?=
 =?us-ascii?Q?1GRO/m3PAicLa/T2B1/VftdR8zcXlshR3ka55qJaO0cbnotXCHb4DOqbveaP?=
 =?us-ascii?Q?Kq/WYVMPwesNRmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adL6qYlfbj1nT2+/0Xb8guJXWOgyeKSR99JM9Q7aUJbPrYWzfxzVm5DnOKQm?=
 =?us-ascii?Q?CSBv/N2Gmtd8MGN7AJm8gmI8quD2JdqHIrmFcJuSQvRbInJghw3fS360rNi+?=
 =?us-ascii?Q?Mi+mA60nzgpga0uDIeEWnzmX19DfaEYGd3xbQNaws8f5CePBzssKl4EYzvpx?=
 =?us-ascii?Q?cp7tdliM93vgKA6Kh75jEheRILNX2KESwdwhcDMCgpGEflt9Vshup2v5dSPm?=
 =?us-ascii?Q?sKkAL4WiyEG9H7PfA6ElCHLIOKrQ1gfW3146T4u2tc8lx1urCYZM/pagOjF9?=
 =?us-ascii?Q?J892js4ZXEug8TZV2ES1MnoFYHnQJ4UbuSNANRtFFfqHXMk1HbN4QmiwfOq5?=
 =?us-ascii?Q?ZnPN5poVm9UFaPizbOWhpBLbR2gDWkHkPV6uDZSI/tuTy+sbwS5gdgTfIaW1?=
 =?us-ascii?Q?lWrLMO78OkhqS3PZ37MJ4YKdeOQKltv6lBGJV+Ig2Ao2Yo2gBPf8B6SVPil3?=
 =?us-ascii?Q?xL1ADalJgBzAUHIQqJCerWK03ZpUmLLKyco+wokO2spAZcSRVzLIxwYpqz+u?=
 =?us-ascii?Q?9RzCoAxdqgWqrqNfYFThqlLwxNylp/XzyB5n7lIsr+/DqtjfTOubgzCMKZlf?=
 =?us-ascii?Q?sGpmWYKLYPdSOAAJIOHD9TbLUagwPDoZXM8nhIw/kOa4RPuVIXptDkTSYZWv?=
 =?us-ascii?Q?2p50L5B0Cm9Un4PyklSrJeNdwAtooZFjlbzoJwsCeOWfXX6ULaYfjftbuQG1?=
 =?us-ascii?Q?RXqdEuW72Fs9zu0hgcMp0VvKx3PZUOJF7WDd6ZLkt6Xad2wbyF9FN483vvqV?=
 =?us-ascii?Q?b59iu+OWYu9wldpcoRqd/NBjxvpmg0XUw4oEGZ/2MO8+44OjOrQbvA+xm0XC?=
 =?us-ascii?Q?n01LQpVfzEpQC5fEECNgE1/HP9K25+GVGch868jCBvFXJX3irIqLctZj5QMM?=
 =?us-ascii?Q?h03ObGq9Ljp64UP+V7+6HmqqQAVzoI6lbNqtM5Cx6/3jdmLTA/P/EObQZ7Lz?=
 =?us-ascii?Q?OUZi+UZVlBOuPXmD2uzCAfFmUKK9HAzlumT1cO/GZrAExQA/svmhTi3ADZdt?=
 =?us-ascii?Q?dF/vTkxA3F2HtDMKZ8cFbSQfC5/qIzULfgw4XBtGfTBMEKtE8oIWkI5HitS0?=
 =?us-ascii?Q?4zE2mexAByEtx29khTkbFNeXNqh/En6xNrPN/SmfQRrGPwowr3IrDxogJ//q?=
 =?us-ascii?Q?+Xh3Dbg8MiVd5hQGpey0iYj9SfuCvujwp4Y+g5ksld5KO+9Wt6HCTQ7lsAW5?=
 =?us-ascii?Q?NMgvjsskL5RwKIQeFZ6nBNSShBFf3olG7DdKV2Ep52Goaswez18eytRg3xzj?=
 =?us-ascii?Q?nhgQ3YOrqboOBBsEkI38IPfjP/nhvRaWSet73nX59qXJ6Lm8+5L+4FMk5yz+?=
 =?us-ascii?Q?kqfBWPCUM0BKZ48jh9W96kSAssZHQ58E0deqtoLlogwA9uhhkTb6wivl7fte?=
 =?us-ascii?Q?vPje9qPKGYrJDMXu94k6NQszKba20yHho5/IkFSok02CaZ/zsvQGbaXbXRoD?=
 =?us-ascii?Q?kjULbwIgM1s8npInWyP0h8VOV7mh+WVhUXFp2ZGM2639l1tRRxDeQuILoRor?=
 =?us-ascii?Q?KZOgr/+W0JGRMOA5yStDX/+2PlD9xpWduGM3V5z2RiTew0f6ykgANssmqm+Y?=
 =?us-ascii?Q?Tv1FIuVEbVl5KL2aVeis0CQ4a9StIe+O1f+sbuJp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdbb778-df3b-4c61-3cc0-08dd92cc613a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:47:46.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zWObU26sHq5ONy6Lkf5isNLh9onCzM3Lze1bE3gOdHo89iqVLbrVe7gmvd8Ds5qKAvoI9IG96tonWqONuyMbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497

From: Luke Wang <ziniu.wang_1@nxp.com>

Export the sdhci_enable_irq_wakeups() and sdhci_disable_irq_wakeups,
so other driver can use them.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++--
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd5681d1e31f..32fa0b2bb912 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3755,7 +3755,7 @@ static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
  * sdhci_disable_irq_wakeups() since it will be set by
  * sdhci_enable_card_detection() or sdhci_init().
  */
-static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
+bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
 		  SDHCI_WAKE_ON_INT;
@@ -3787,8 +3787,9 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 
 	return host->irq_wake_enabled;
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -3802,6 +3803,7 @@ static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 
 	host->irq_wake_enabled = false;
 }
+EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..f9d65dd0f2b2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -875,6 +875,8 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
 #ifdef CONFIG_PM
+bool sdhci_enable_irq_wakeups(struct sdhci_host *host);
+void sdhci_disable_irq_wakeups(struct sdhci_host *host);
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
-- 
2.34.1

