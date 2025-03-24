Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013051.outbound.protection.outlook.com [52.101.67.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FD1C6FF9;
	Mon, 24 Mar 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808101; cv=fail; b=NkSfrdxyHNvMjEreJJ/++EWE0l/VCP8drUrklcw4CiC5b5/AhonSeWyoYFweC1Xhhd22OLoM9xUD3F8PVcKZwtOVJXJfVkHqW0XLhcCfOf5aGJfN5uOPThT0IOCCo0aJ4Dvr0jAI+kT0jwJXwpHP/kHIZ22O6gc9qI8xISPEoPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808101; c=relaxed/simple;
	bh=yZ687p3PHmVTT3YI5FZh3UCQhI7YTuF2JvNWnxfJsvE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RIg0kWFADVJh1G5a3EAsspLCTroOiHgrZmrALoPBrqRt1tpIT776BXxfzXzg0O1whc0tzcsXqL1FG/UVtDhHCqvAYnnKCA7Gae+AlIPnudPQAD55O2bBhg7kkPueo4M2FFhHJVRzeshCLLcp2a/ZVG7tn+zplEJMG1YGmdhXXIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SgNilo/z; arc=fail smtp.client-ip=52.101.67.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SgNilo/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNOVDy1cWtDnP7+LclYm/Uz164xUmXsw14pZnxZ/WTExAKihFk/JnT9GYm1CqTGFAH2kxZhpG6imi33jsjFHHRKIuexpLFfUra7QSN4sjRp+0tupdBq1fPvgOPM3R/UgPx6iX0E/R3mS2ySE3aiW4WdPIlf5FOzr1nokozGiKBwklBvtgB+0ii8ljKZg0uEHWHNVqPb1SrgOy7SEyAwxyiK76qO05ffxduPCKI9/j3TCTTxMeE3Xi/e1N6hUblTaJURIki1+npWfBvIY9OOtGzSkaoKSmtvGW2cHRa7yIKNVLhRkMns4wG67UUQqBWFFp7Pq2sK1Sx8XDPYyi8fcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWcKxIkYaSrTfyKpsGYKtd+j2XaCv3R1ahV4WlL06o8=;
 b=pCEg2Mp8H43xdJkppeijlJ9DsaWZUN3airFdjki2FiZeyyIshvZQ1x4sVkMqQG95H7uafO7fbra9QBIIps6WgDk8bRFUGgdcBN7C5FN0iAqNBaOMgnvX9fC56AVHWmuZtF/Kj9CQJaWCvMAAf/Dk6aEKxmXO/yhau4YQ1CBlspUhiZrIMdQeNao2q5EbYkBuzXDNvGsj+Ro3zMt9uKGiOokvSV17rGo3olyX2H53ZJoYSHTRISo6LVUhANZH442AxfB9WD2AHiTq0DY4AQlJBe0KDZg9C/wt14Z2x9UDDNuIIO1wy57o8bUn5z9/4sKq0lORXJNke/Lks4iFdNM33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWcKxIkYaSrTfyKpsGYKtd+j2XaCv3R1ahV4WlL06o8=;
 b=SgNilo/zqSUx32wVNmmo/hBgQfPCw45nMVEeyicwEM6QHDLtqiURnpPmJS+T98mltwmdOdEyyqeIFNmqUk1x7PFFfwmpFfGfCqBJ9BlP3DMHjMErI5y/8OaPkpLNcIhAiFQzsW4fYGvEZR/FqkdogEiiIRceDvDsQ7PHm4kiBIdBxe+E6rZKQSAtjZTRLPFtoaw8IfylTiRd5FfPapnUB7mQnppPVdlr26CdWSqyWrXN+lAxx+uyUOCay9mWbjGAIJjqmji9Lp/I5Pk+kUBzXcIoKYvIOhov0NQeee5Fjc75lCJt0/qQFQQrIz/JRr2LncXh9muYu6rNsgX70YFyZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:21:36 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:21:36 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci: convert sdhci_calc_timeout() to non-static
Date: Mon, 24 Mar 2025 17:22:40 +0800
Message-Id: <20250324092240.2230955-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM8PR04MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 54219302-75cd-4b6f-04e4-08dd6ab54646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I55VrtRsHDhRFerUXj/bg4UN9E+XS9+h1iKz/s5/3qxcv8Fcq3bKhNoTJjpP?=
 =?us-ascii?Q?c2kEbd3JuMbVLA/+lajz6S48ZcwpmywC84V6coluZvleKHzmrhXSMpFH4vq1?=
 =?us-ascii?Q?42Gc2MSgv7gZN8g+KaeFlFjhulfLCCJnxxu+PRzcuOIo3VXY63fTYGJJ1/bI?=
 =?us-ascii?Q?qO/JlAJy8WohULhOP7IXcjI2y6/mgrH693EpA2Knkk+/8n6zMORN8qf+uJba?=
 =?us-ascii?Q?y9NApwa4LDMCjX9s6rOEcpsTQfT+cYByy3VyDHp3QA466uD+FT8c+gGZ0pkm?=
 =?us-ascii?Q?x8Y55OyG21d560ERxWR4QVpRx1rI4b4NL+NLP3ee1zcSM/NoAJhTbAXTZZzM?=
 =?us-ascii?Q?fJ8GC/N3C9NIVD4e+OJZVaD4bwHNQ0dfqjUnzgLl0qtEdu2r/q4P2baIMnH1?=
 =?us-ascii?Q?uMgRSOo8U2v5PEEWiCAYcVPa2P8IPJGUIy09W7cKoC6O1jGc5SThOrXcTtLL?=
 =?us-ascii?Q?mH/eYdZw3lGVPZ/UmTZHMcRz2IjDmG/fWVbEg5iAwZsdX+ughNWcvX2ralA7?=
 =?us-ascii?Q?K+qWx45ReyRVmTGhtS2PYB5MiqIxZfJzoEHYHVlLSI7qnegdSXwU/WVFba7v?=
 =?us-ascii?Q?p0C0rcVZjyq0BNuUJtEvYBoC1pWbPIK2yC389mbUwpUvjmISAUMInvuYVbLw?=
 =?us-ascii?Q?0HaFR9HK0ntm0UFfusIhPf2NbGJcvbUU9Jv2nUAWW6IhSa6Xh/J/WFFHWA5i?=
 =?us-ascii?Q?R5vkXcHDZ4d6Rcq+qgN55WnPQU+1zuguFhhY1XULb31uTTygdakAjLqRS47T?=
 =?us-ascii?Q?tG3sb4bHuEF+spKDf02/9S7rv6kskcuQZySfbNRVn21V/5pg4A/n9S5okiUb?=
 =?us-ascii?Q?z1lcSi5JOLvBAobcAgw55Wsm3bT9Y4prq7rZgElNl5N4PcWARUXps33pyIau?=
 =?us-ascii?Q?k7u7NhjxvWFxbXsuqxT+RVf7nts01pI3KmMJSZ9NSVhnb3MQdqcBLBcqnCMr?=
 =?us-ascii?Q?J3+x4ufV7BQRAXKbRVhX6esfBfFjhQdU512a+qlJKms6oTXGNNFwkmSuOpTb?=
 =?us-ascii?Q?r1ZXOaX7tKjPWU0WrVFPqllpPhZz5iJ8MmJzp8R4A8OOxmuJDaeoOUUIPvNB?=
 =?us-ascii?Q?tAFY4IKALO/E3sL2nuY75fbMhJME0qitK+AcpiTV9bDwB3kPpJOokvMLl3zi?=
 =?us-ascii?Q?fzlWuON1GH7ebDmgSL5WjOIWubRfWZ2HVUmoWSvInUTOPqNjvMuXgWzZTKEX?=
 =?us-ascii?Q?zS2NDnJgMHjueGrINrvhn08yzKDfmaK/11I8URyaE2gTzU25zCruUjXUbw2I?=
 =?us-ascii?Q?UvAl7iZRy74UBzQKaXktEwbm05331AaqmqS/sGyK29bALfCmRL2To8DdQ5oF?=
 =?us-ascii?Q?9MTHUc6t7iaDHd4AN0i7SZN/kYD4AEoep0qiSe9SR7CF6NA0IIVkcX3OzH+Y?=
 =?us-ascii?Q?L3crqY3kh9vaijVCU8RYopBPhxEX85qMcUHVlX/V+qJo4oWt1M+/E3hGEZqH?=
 =?us-ascii?Q?nAYzpkfZwMetw1oYw2pTPop6DL/z8Tch?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANWChv3lNUgDIGx5Wv56jChCuUTJDwsuxrRHzfiWUyqExs8Pon5q5GFwDnAx?=
 =?us-ascii?Q?elPoqrfHBPs0sW91bq9QfwpEKu4WtHcG9ayTipQkx4wB+H2RkCd3hLps9JVg?=
 =?us-ascii?Q?WkBwmqMJSrgMR+qqbeRQaj3zSx/wE5kakpiCCRT3141q7EpkngiCpistccZ7?=
 =?us-ascii?Q?4VOwccIyLaN8gnoZNV3tLAmvkAEovXHd8Jge756TnKXBDT6dReqTh0M7yxKV?=
 =?us-ascii?Q?m8uokHAp1zoOeVWSThvrIa7nltcASfdzEyn0EEfJcS1pCCQR7a6pUud/qa2v?=
 =?us-ascii?Q?7SHScDbJzt9H7AhoiOw8luYXqz/dZvLjypdQp/Bi8Fp0dPT/ici6PdneD+pO?=
 =?us-ascii?Q?mP6jkpAuqO0K8aiJnTX0R2z+/7u8DP7168YLJBAOldY9srCR+xrW7vgBjKD2?=
 =?us-ascii?Q?27sWeQ17QV2qIs8v4Zlrl2J/Ivndxca6erpKXjHrLjDZgByu8uXh2AQKZRtE?=
 =?us-ascii?Q?qMjeR/Yg7IyDcQ5LlY9bB47oFbTZp0kBAYlhRo6WqsT30s4l7pP6CuhHLJeC?=
 =?us-ascii?Q?kFCVm1BoqKUuTAVxiBgNRKqMUurCYFAWV+I5ejRxQJ3+EQHa5VRhNGokTx9g?=
 =?us-ascii?Q?8Q6mfvgx9Zf3wDSiyAlGFAdogcV0UrMUEjkwH9EUGEMEnyGqGzV/FP5wLhs/?=
 =?us-ascii?Q?/sH0pS5WC83mWvOg5z4/0saGQ3Ac7xl6278HnQVVSqeUy/AuE5iUbnuV4Goc?=
 =?us-ascii?Q?lStO5PUaW4n3NwBa4v0qAK+SOOmlVAwLYaiP/pjgIVWKscHB5XXtO8ImMTp7?=
 =?us-ascii?Q?TZDIlmjRBQdoNuuFfyJ5q/60gpe9dn+W11OphkPjeX8kyD78qOrzCCFcLvAh?=
 =?us-ascii?Q?1EYqD+5j6EnQCVip0zKRs3OPP9wYtecYvBhnEDiGyd4gRrFwIioxcnX8pHSS?=
 =?us-ascii?Q?auvzRzJVkVSQ1YJptcS0GlBlRIqJpQfINyu7ySznCfdNB8ZvXau5MKBNVIk8?=
 =?us-ascii?Q?WsJ8En9L6Pi9fvlmwbu5mw5NztA/RqAymJ+KRwwDQV5u+wL5WusiZiClvBWG?=
 =?us-ascii?Q?jS999YzlPzgBaomba82IPL0+mj6E0GNjPSoa1c/Kr1bf7fVHpTtUOnUeqXbD?=
 =?us-ascii?Q?fm359XVN9S0h1QKzbsGZaQVQLhZjOvO3LYvhJerC6PZSAOM0a0oGHnJYx2Vv?=
 =?us-ascii?Q?og6KmmaapqWr4KLXJNHWFmSSd4iMG0xjD9Bl3PUIUyJgBJ5Dnz/tLsqTVtg1?=
 =?us-ascii?Q?Bi4q6Toq42J4+LgArF1Abq+K6LLcJnNefvP/tBxdffNcwc8eM5Ssp5GNMG2q?=
 =?us-ascii?Q?0NPgy2FJbyc8iyed+wfeAvCnytDont5xfGJ3FFrqFw3gBsPj9S3ED0UDBYCp?=
 =?us-ascii?Q?bVX6Oh/+21nW5ZjCb7x1g6tQkLyTtq1TCiV1fDO23+2Oodo2Anh9rYEPkhRW?=
 =?us-ascii?Q?tMm5AVfkwCzjqoYmOID8XOixkklM2aMOfv28s0d0V7gbXPI6oSnrb56RRZQH?=
 =?us-ascii?Q?15Wyj2DuihHo0lH7iVr9YYfmrkdBXa3LAgraA2HF6OAxBiPNOlZH9wfSbnBa?=
 =?us-ascii?Q?8ND3Ywb5RoxLz+TdDssbm7ep2TqB1rSnUpcYk4i0P5Ua9bFyRLFYEyWrCAeY?=
 =?us-ascii?Q?AcqEvWlFPc4Q7SvkEdsDkZVVYX4RFZSloax71GrO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54219302-75cd-4b6f-04e4-08dd6ab54646
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:21:36.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhE+dfTLdAe6QAnfo1/Ek59Kd2tjqaXRRkBewOC6H/1bYIalhvaH9A44qrme7Pje/kb5usEg56IQ3Ndw8GAppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249

From: Luke Wang <ziniu.wang_1@nxp.com>

Export sdhci_calc_timeout() so that it is accessible from platform drivers.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f91b44891f9..ec99616cc51e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -966,8 +966,8 @@ static void sdhci_calc_sw_timeout(struct sdhci_host *host,
 		host->data_timeout += MMC_CMD_TRANSFER_TIME;
 }
 
-static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
-			     bool *too_big)
+u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
+		      bool *too_big)
 {
 	u8 count;
 	struct mmc_data *data;
@@ -1023,6 +1023,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 
 	return count;
 }
+EXPORT_SYMBOL_GPL(sdhci_calc_timeout);
 
 static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..71a48899c29b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -897,5 +897,7 @@ void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
+		      bool *too_big);
 
 #endif /* __SDHCI_HW_H */
-- 
2.34.1

