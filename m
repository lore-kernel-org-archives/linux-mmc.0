Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9A4436E;
	Mon, 14 Oct 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885641; cv=fail; b=NLRhuGSvWWaeljQd7V518uyD2YWind0Tc6xJw6MB1z/FrsJ7nrwExf/6t94ZKYjuhzG55YE5PqIo/cytMpgjmjGEjLlQyxw0rX8BFX/EdijiOb6MlC10T10mRiki3uIKcGc6FSpz4sbiYlvIeERbV36aBcRwnGIc0yzI6+6Znww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885641; c=relaxed/simple;
	bh=H4F5ZZDvDlIaoo6y7hdT1AxnPJpDfEh0S/NhPBB+tiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cawldexwnH7+D8gMdlLwWbxbooxw566eLZuF/b4T42Ynhte66wBQn0jzcw9PXyCJWtwXSCsxSJE6CtkxbbktAzHqVD5pQTidV5X+GntCReCTs2HNDyzi+HapuBCX8nwncZf/VeenFcO4IArZAk6JxUnzpim1BJiLR8QRkuJTvnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OSVrhjDH; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSVrhjDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yotc6oxnbC+0EX1jLPPndWyB2slHV/sgXp+nK3i8/a0RJG3lxaetrEUObbMuVM3Myp6Da1e7wKVRpYL5PV7IwUwJdik8UMdNJFDkYrFJ4MLM4o6utXGKzi2L/qBhvyalIUsqUiQzhs6xZ9mvFb8U1TPcpZRJ5h+7HPVk7LciVMN1IivfFh8qAigDncLilShB0bVoHtIN+Da9z/9HMFr60tRrXARWQzc/uOOxi6VY8m9bTet/S4el/eh/3jHsUThcuLdqIz4EnfyhT4JQKKKbn1jVij6mk3rnGXRlY/M4DGoM8NGSMOcDkCo9WInuTdiCtyLhhKrClnqILc4ii3hVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5JJ7KTa6A17Sn75TWE7cPxLnU+thl6qePZUrJ5fI1g=;
 b=YQNBPcMByZi0jJtd8GZi2Q//tPqIk4zDufHZWK4DhuofMvTXjjTZctbN2l4AvvdikZ//p9tDYzApoxfhdpsnfu6gsc2UjNE1LjO8SOF4aOtYCx5AiE+RYz4s//TF0HhTDEojhy9IcgEYfI+on1Bv9Js7RvZpkV7skEVonxrDf0AtyntCBnMNA5+6FiN6Pdcol+gw3c+8wo8ILDOZ2LTsKEURp3WtExVTjBxdYDiqCY4jHACLOuzGd6ic/Zbgoytp5s4R5peMpze177ZyAZ7VbojUzwJmqHGn98aAR69Ov+Khh1MEVYb2cmFrs/GtKX7zEBdNtjHWA9n5lFcVD1tVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5JJ7KTa6A17Sn75TWE7cPxLnU+thl6qePZUrJ5fI1g=;
 b=OSVrhjDHAJ5tXAJVQzfWFPcpNGVP5+P1YuPJ/bD4PmegIlEXiuZLfEoF9Epg1vhyUg3dTaSM3i8a+ckG2bb4SF/sQy8UmAnVS7Gj2pwIKVwDPjp8W76IcJMrx5Qi8AvEawNd33iSEBDyIZ749fAvHsFwdVckU6lNaIWPfGM/n0EkXXBtbMf8Z9oz2wV0rknezbJnZrc9FsOaSej9xqlpV4TpPQXwWzFc7erHkfNg3gLIHuOzc9bWPxo3JjHVXnmrJVH3LEIRZlO2inBFgFdus7IAP/iKm/xhagO/clT/KGxBAcHjb2ILhZ0XV/+2GVkR3YXeV1JUF4RnPgCbuW52gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 06:00:35 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:00:29 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: sdhci: export APIs for sdhci irq wakeup
Date: Mon, 14 Oct 2024 14:01:27 +0800
Message-Id: <20241014060130.1162629-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014060130.1162629-1-haibo.chen@nxp.com>
References: <20241014060130.1162629-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: d2775155-40a9-4eca-d5f0-08dcec15814d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRIZX3N8LnwuBAfsTQ3fKaGqYnbFrVithA0prd7826m+6TZIN04QixgWda5V?=
 =?us-ascii?Q?/vfZO8X/dHCnNegrjPZ8Luj1VNSjhzlEhNtrF2Mi1X8u8ocTqih11bXU36ud?=
 =?us-ascii?Q?aO8QvZqK+F+jKGBtcL/3V0pXnNbYmBmZ+zzhuFB344CD/PmnVXFethXVdpBK?=
 =?us-ascii?Q?mqQUxxV7aPHA+dg+fcTkO5aIaOn+uOuQLH934nf7uZRkxMlaBKPkkxe4JNf+?=
 =?us-ascii?Q?CBzkqNfBuviI9FZRqCT/Kr2SzjMOMxSxr1NAg9neNisXwO1PkzJnY9MjITJB?=
 =?us-ascii?Q?2Z187m/J8SrpFVTxzOUPLQglB3EJD78d+VXjzNkzdizTTikLQ6zeAgHX7hPw?=
 =?us-ascii?Q?JiWHO1Y3WZ3I7tXXkYprhmxpJ+jJlkiPNjpb39QKiqFGGzkoKGyRAL1qAk6X?=
 =?us-ascii?Q?Txer2o1GQhnb8CPhtvpMXzGDV6F8GYsGa44sgV0zU8ARrj4aMTZQxSkGBfkl?=
 =?us-ascii?Q?0Y6Y23p6mE3BvazHei5vP2YDd2iK3mp8UYdYp2j4+uQl7GQAQAkGKSVX7Wc9?=
 =?us-ascii?Q?tmRJhEocTLvUiERjA8JM97jFawDNU8S4RVl0cN29lF4rUGQFZE3Y5bmQBDIZ?=
 =?us-ascii?Q?Jdr1E/lp6UfalX6fQf8X+0041/tHIij6jvqk5+1N0KZFkNRW9xlEZ/xDkCIc?=
 =?us-ascii?Q?eJirMV+3Tyzp2WW7RmWAYtCybCbnWhqBSfqXBsV20iq80Bg/Yoz+PUJzNZX0?=
 =?us-ascii?Q?/D0tvkacgRzOBtwBFL4pCsGPmBcUjTejlYJf/+F48e28aVJQEyOnqKGN0PFa?=
 =?us-ascii?Q?p6zQpVICxxhJN8B0QN9HbVeXwc9xEP/qWd4t2N1cORF63DLnjly9lHQPQVP+?=
 =?us-ascii?Q?2VyLUBV2C0AU9H9fq3b5fwt/rEK/GUAf8CISVUxG2PsKKPunWel0xDTHYhAm?=
 =?us-ascii?Q?wyQVQCJt4Luc9H4zXGwa/7RQH7O/q7dANRIuLefa60dlki7bk7onebRtf4+t?=
 =?us-ascii?Q?TVt+BpgorobPxffE49Bm8vFLycx44sZzYMksep6fHYgJRVazIbMWZ4HBwZ0l?=
 =?us-ascii?Q?iRv75bk9cY0u9xdFrbkRTuaU+/YLQ3k+89ldoAx9lnd+bsjRcRRPMhZA0ar5?=
 =?us-ascii?Q?wbYlb80RNzeLJUzBNUg2joa45naa495/egPNNpAb78BpM/+lWExpENNKqQvk?=
 =?us-ascii?Q?BmVZfzFG0FwIuG8Vcr4ysRZuUn9m+riLmgeI8iVqmN+FDDaMMzCtgDyoJs7/?=
 =?us-ascii?Q?qnaXGxm9PfI+KqyPTy9idGnfA0myiMZV09kJq6Mc6H56m4PkUWRnVZqu2zcM?=
 =?us-ascii?Q?ekIMU1DV0Y+xO8DJZ+9xQe1bQZ7DH+u8BznzHrV/s//wD3SPlNvULYv5Wxx0?=
 =?us-ascii?Q?+/5Vm6dP30LaFgDLex+g3NrV16CzIKavTMX+pogEPmBq3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dbsjVyXUlhx1okXEiENK/hyaJxnZfGGGvtgCC0DZ4rg+3Utu7i35bthSy3v7?=
 =?us-ascii?Q?maicZOpcCGMScX72ulm3toS6KbUNh5J/sg8MiQMpuoctIqOB20lKRbu2S//y?=
 =?us-ascii?Q?Ze8diLXbLi3r8Ad+R1ZsfyuenNsPzeHg5m+omOyCKI8rKi/BEX8p8zVvbydt?=
 =?us-ascii?Q?x83MOihNUrPI/KzuOX+jjdluvOKmVKdPk9uVa75wouP/gPVki0VM0XkOxr9L?=
 =?us-ascii?Q?dMzRsV2+ml7QQCpTSEZiHz7guKz2QHljztHrEfX71AnnhDTI6ATKcwgA9siS?=
 =?us-ascii?Q?RExlrHI2o27MbBf9YMDYXajLCW1IIm+/HR7Gs+Rcn2amQZcA+Li3s6+z7a2t?=
 =?us-ascii?Q?ZzfLtNd2iglMCG634clFrDFUo+QynQi1P3WaBsrod6Bxv033zmTqOnMzvh6D?=
 =?us-ascii?Q?1/O6Y4CrMzirUOTj8lct6PLb66MxHeKkGye33/2NrVt2MtIt5Rdw6WpQ9Fh8?=
 =?us-ascii?Q?OAhfR+HV74QCEv8pl+DWRUSr4xCx9UdmuumMomTnYS5fucqPQDETRYhcmVhs?=
 =?us-ascii?Q?zG9Ftsu3r/Hj2iSjGtlUKdC+NKyfJdKeHdRgKLohj+Iu7tHtlzyeIXbGcu7L?=
 =?us-ascii?Q?awQWTzvt3DoWdis7qN9EC/iBOYGrHTgg7XFklpEi1GuXbq2U1+c4daui0MRR?=
 =?us-ascii?Q?Fgu2AMPg37ibUVofUWPK9EIfSzvBhsbEtDIHhT4Xun8eNbPiAE00ixp5Qish?=
 =?us-ascii?Q?CE2HCJxeFQEXAewGlsjM8seiTBO4pUQ5lHy9nS/VoVVr8aT0xjYbd95AyDje?=
 =?us-ascii?Q?EocsaWXSy+1dO+6RwFATxkVtPLT5F8TWHQ87uenVXoNUNdzDjT55DcrHZj0F?=
 =?us-ascii?Q?7EGfVeoDg7HkhEhkXx0JMH20Oo69LmLGbBNIBb+kjdLEFaUerXC57G1/d/ft?=
 =?us-ascii?Q?XJezq4NqPkFiK01hp05KA/Mi+n2F3o9ZC9oQbURMWZbjXzDPyD+VnMu0BKKi?=
 =?us-ascii?Q?JuXgHGnKkJsUCOwQZZK6x75exz12lBtJxq6LJUPGy7FXxB+fN9HEeA9uxcgy?=
 =?us-ascii?Q?gl98esnsBJsSWaQXI1gt+0gZ3DKo0etsPPJPBj+qkxWWBXeMUXHacVTLeREA?=
 =?us-ascii?Q?0xeOXmeBdFBsc3WgnyBm7cIHY8+FpKH/6lT/TBIfDwyerEwviM6vwLxhFfwh?=
 =?us-ascii?Q?IZNQhnKS1icUya5sFkdGxwacwIC7gs1B7lqRDZg2ofeCQj0yfUfZlN9/6dtG?=
 =?us-ascii?Q?2qkNnMsPj5EHLxJveM5ONYSkiO/74kkLb8rI6Ydt6t/pecBmwcCic81OaIaS?=
 =?us-ascii?Q?F9aiH7/UGdkB42VfeKNBe1j2v8MOblJGN7pU2dw+Emir/7zrcSqVO4Qg5lVm?=
 =?us-ascii?Q?9QAw7rEQLyO2LZ1lihLIS3fJKlFRyPfBqDIjydor5Q+iS4U6q5CujpvMCraq?=
 =?us-ascii?Q?MXYfd7i9qi9iB6bNPLcZezgidW5/QvrZPjmowzGY56VN5PUV9TaeAjZjAazp?=
 =?us-ascii?Q?TrbYTrK20RUwph7YJHvJJRuy/DL8LrK4Mh6x9fHj+C3TA9dTDSWpMokljriM?=
 =?us-ascii?Q?16nQScP10JlLefCZRBvNG9tjQ/GrE2Z+82QtyPHs6s/CRMMl2fSOCH+8ky9Q?=
 =?us-ascii?Q?SJsLeVEDQsmEkIK12uCsDLo1U8711f125Sap2mzc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2775155-40a9-4eca-d5f0-08dcec15814d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:00:29.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK8GaNoim7R4rX5VnnbEFzu9Kca+F4Ajqz6dr5N0+TjaAjuHwMsHUMG0MrChkR8RDFiqk+1ek0p4Jj/Y2Wwv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

From: Haibo Chen <haibo.chen@nxp.com>

Export the sdhci_enable_irq_wakeups() and sdhci_disable_irq_wakeups,
so other driver can use them.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++--
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b91c9e96635..b3df3e7653af 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3698,7 +3698,7 @@ static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
  * sdhci_disable_irq_wakeups() since it will be set by
  * sdhci_enable_card_detection() or sdhci_init().
  */
-static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
+bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
 		  SDHCI_WAKE_ON_INT;
@@ -3730,8 +3730,9 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 
 	return host->irq_wake_enabled;
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -3745,6 +3746,7 @@ static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 
 	host->irq_wake_enabled = false;
 }
+EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f531b617f28d..bc303fe7f87b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -802,6 +802,8 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
 #ifdef CONFIG_PM
+bool sdhci_enable_irq_wakeups(struct sdhci_host *host);
+void sdhci_disable_irq_wakeups(struct sdhci_host *host);
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
-- 
2.34.1

