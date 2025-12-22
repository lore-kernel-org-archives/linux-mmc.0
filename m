Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022104.outbound.protection.outlook.com [40.93.195.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3131076B;
	Mon, 22 Dec 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393155; cv=fail; b=mVKFQ7jGqAeRpKblAvjYmfh8UcQ3DlG4J9YP/xmGoyj6cp5E66sY1KdzcKyW8atpJl+rfMq3KBiJulumB1WaL6QTXdznX3z3ZMPu+66A1Bg1asMrlrDOmJ4cLxLGTmrqYWEdyfePr0LU64B8hM060eb65q1TdC+Oy+7AqNyAfxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393155; c=relaxed/simple;
	bh=MJxaSp0fUT/BjKH13FMYmC2D6UcjZDFqFes3LARPRAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/goiIMF3hoPgsHB4qrfxnShf8+nyktDPokZNp1ZHgA4G1SMf6WBMctVltUP4I+srDsNOQ4iqUO4rzmRKJ8tT4bd0Z1rv/s8UjO2a6BsFrYg0IPAzpLK+h5CA6PCONZLy/Loke3nTWVOZJWUjmlckFL96XsfUxmycMsmdlFKxXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=jvkbadTr; arc=fail smtp.client-ip=40.93.195.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="jvkbadTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF/fvAKLuQQ+kxUNDXT5vDkxfMAABrPbQPRpzxGoipTasdeIhWgT9NTzKiAep0q0tJCULX7PWraSwJCixJNBHT335iXhxQe/ijREM6EJK6Y7CMAuW8apsMVDcJfGiDviaTc4M5ZfituvSlaGYLPwi9wGcLitrr2ELS0LgL+CcDF8MHRsMN0SKIUprt6dqhF3bVExZb00WRnztXwLc3OUtkiSOhePqSiFM7h27oNT78ujKMGZRHIB2WNU2FJ2sh58TfiaerD2S/aKmLfrIpZipu7hhJRxHoubZZbpnFNoFpp7zJazmANawJD997qxVIVzwx75DZGzG3GYoIai46v5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge7rYr6FcjrkqTJw2DCp2AlBRypgRBiyAHo7fxY6sIg=;
 b=LlGFaJkNLTRy78ojOb5QwP7wbI5azi4yI6kX2enXS1qvLjEFXiuBumCLgMdQ1Stc7mXXDGcTodxB4q9TD3RfjhZ8iU2+bh+4EBizMUrf452+NdjvnA0DrHasSCEdtZsXhS1eUzj1H2Y5rtafeaMtH8RrUw/VKyof6EGR4jASeSJEHBJKiUkZ/gvZWoJpi4SiQoCDuARLBobjpL/UuHsMP2zthLO5KffrXeQGWN57XMs12ZG2pwqL9eJBk3/6nVrHotuefUQLOnmp0wzBjVE15OLzW16U7JZca8tAd9C45s0vZNMc3ukSpaCCyURNwRVH3Uiv1cLIO0+BSlVli39rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 4.227.125.105) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge7rYr6FcjrkqTJw2DCp2AlBRypgRBiyAHo7fxY6sIg=;
 b=jvkbadTrP+xwbB510e/Y/d3EHEQ0+T51nXMG2gChz4pCgXIQt0Pm2RLphe9jWh41y4sNsMUbk5HojKpfi8M8bV8FURk7AeLqYzmIStrnvTmylJQV+T5CGZmkFWBsuAFvm/5TXF7x0FVQchpgNJUq6yH5iFl13QCzMCWm/B83ETIX7CIscSZaty3OXzHDIONN0D1sFYvccWvK/UruaU+Mb+bDZYfeSTKnGKOE2wPUTBBNHOGYkjCS5lDzB5lmP84VfOwdsEEKhm94BH1Z1POJt8MjzCb3CxvntVBQ7iYq+gSMDRabS3s3hKJNM4dr167uaAJ1easuVN4/t8EVvk/x3A==
Received: from PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::19)
 by LV8PR18MB6230.namprd18.prod.outlook.com (2603:10b6:408:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:45:44 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::82) by PH8P220CA0012.outlook.office365.com
 (2603:10b6:510:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.227.125.105)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 4.227.125.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.227.125.105; helo=[127.0.0.1];
Received: from [127.0.0.1] (4.227.125.105) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.9
 via Frontend Transport; Mon, 22 Dec 2025 08:45:42 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Mon, 22 Dec 2025 16:45:05 +0800
Subject: [PATCH 6/8] mmc: host: axiado: add AX3000 eMMC PHY support to
 sdhci-of-arasan
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-6-5457d0ebcdb4@axiado.com>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
To: SriNavmani A <srinavmani@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Tzu-Hao Wei <twei@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=twei@axiado.com;
 h=from:subject:message-id; bh=2v3Om1eAD+eXMvIzSOeF9aBvCxmTFofqTOEAYAbAk9k=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBpSQUoHRmrbzogLJzyPh8g23/9hx1BuqSpaDlkJ
 7WYE08+CTSJAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaUkFKAAKCRB4EDBdxFrx
 1wTpC/sET2l9QsZRAl3IRL15F7GzXqO7zxrAbdDAKxZdhAuVqDItwkeNTmTfXlxo1K33/1l6g7P
 jpuTlnvGKo3K1BmEhBHpGnLAGAdPH5KFUHeu2/1sUkXdNmhpZ7HnRz6J98Y2YJ0J5UFbAt7Igbu
 4yDOEdVoEeF1FOikpNKhdeLm4ANZQKS48qTT+0M+tE7Fe3h3HKg2Re+7awSkl21pMza/3Ya3ciE
 oxT9CorPr04mktBZ8Vf6YzA0bH0YbLrNEPku52/rMY7XC1TEYxg+IYbmDopQTGh7vwsvKI7M+Be
 0jBHF9Pl3X1+SMV3ecp0E7sm8+v+A9r+UdFng8bNljRhfBIE3HFm/Mb7e67+rrdWVBEJcoCi6O4
 weU1IJFfyUYJSxmV7LkEozV/P8ns4FXuAm62QvD8+Lgk9qh+FKZ9pLSzW2bwK2CR1k7FYHgxwgt
 uvWC8Z2RA+haLnZyB9XqAOX4hQi+CkE0woWCFQG0oAaB21x9GLWJnzF+j3YRnpdbYdL3E=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV8PR18MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: c05a054a-fce4-432d-b428-08de41367e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|34020700016|42112799006|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW9DM3pDa241bHdTeFRpaDU5Y0wwbVVSV0YwQnZjTmZ1Wlc2OCtHY0s3S0d6?=
 =?utf-8?B?V3RTblVlS0llWWZnOVErUU9QTkwrK3ZNZnJCN0RpV2lkc1N6Uis5N1pNdmE3?=
 =?utf-8?B?bitya1l1eWdlQXVZV2dxRkZxM1NEWkpGeDRDTVpKS1o4cldLY3N0cDdxczJs?=
 =?utf-8?B?TTgxZEY2KzhFS1NTc1Y1RlhBczNFZnM3aE1oSlVkYThERm5wM25OdGh6MTJS?=
 =?utf-8?B?MDgvdEFVVDF0QjZaUEhBdTlwa3E3aG1QVFBxeitOcStYdmd2WkpGUjVrVlVm?=
 =?utf-8?B?YzFxVTY1cWw4NDBkdXZ4UmlqM3EwRGM0cE0va2tSUEYrMm9SZ0xXczJvcE83?=
 =?utf-8?B?QXgzWU5sOEFIQnRHazFjWG80U094dFU2OHhObTN5cHE5VXNiVzZ6SmhHS0s1?=
 =?utf-8?B?N2dKWFVxWTZhcUg2QmlmY1ArTUZoVlU5SXptUmpyZ2ZzOXQ4SFAyU0JiRDkw?=
 =?utf-8?B?ZHc0eWpLbFFyK0dXdWtiNmlmdkludGxkRHBoNjdxS1pISFdlL1IvQnM4czhN?=
 =?utf-8?B?eVJNWDhtb2pRcXdYUTB3cENUQWlvQjZBc3hJUkZ1TUhpNzJuZHJjYkdGMzdN?=
 =?utf-8?B?cmF4T1RXb2FsTEx4anFpc3Q1QThFd0ZoaEIrdU9Tdi9jRUNwdGdvVFlBY0NM?=
 =?utf-8?B?M1hZZ3NoMU5EVGI4MU5NMTdqMG4xSjdqMW5iWmY3bzh3VWNSQW02TS9WRUlO?=
 =?utf-8?B?dU94VnAyT1JncEZudXc5cUZpbWlDdHZKN1VIR1Jzb2V1TlpMbDlzNDQwMWtY?=
 =?utf-8?B?VExOVGxKNTJFQnZjYTgzcmpHK2JpKzgzUGZMYVVJNDJLdmxIeHVDODJRZG9Y?=
 =?utf-8?B?OFN4eVhMM2h2NXdoMVRyQ1VsOHpzc3UzVFRFZjErVURBNVlUZkNSNWR0YWdJ?=
 =?utf-8?B?eWlrNG9wMG44ZUsrS2UyNmpMVHF4YlJ2UzJrelk5QUF2SkVTdlgvMUFNWFM0?=
 =?utf-8?B?Mm5UWFNlZUphdXplcUFZeUJKU2l1cWZ4akpPRE0rbW5HVzJlbS9YeGEvVzI2?=
 =?utf-8?B?KzNGQ041Wm5CTlJQRzEzaTdIR3Rmd0tYclhuT2c2MDJQeVJJLzR2WkdUQWs4?=
 =?utf-8?B?ejNxbVhqczUvenVubjdCRUhTaFBPUDZaUE9Xbjc4ek83MG9lRC8zSS9DdzR6?=
 =?utf-8?B?ZlhrQ0xSNFdMOFNsNkpOQ2dqVm95V25XVnRDSWsxZVhVTFhMa1YvYTRML2lZ?=
 =?utf-8?B?NmJoa3dmdFhSVGYyNW1kazlMMU04dmpLdWEzUlhGWEdmV3RCMFZhN3lOMmll?=
 =?utf-8?B?bGhVYStOSExtOGtSS3lhSVZNZVFMNjJVbmpMZ3o3V3Uxa0FHVG9UbnlNRnp2?=
 =?utf-8?B?anlNSGRiR3QyNmVWS1R1enBhZ2EzSlZlaGlRN3RwVHdIZUNncFd6d1FEdU1n?=
 =?utf-8?B?b1JOQXE5Qy82OFFmeXJhMjBOemR1dVZRcDRtNExuSlpDWlpGbmhPTFlQek9X?=
 =?utf-8?B?V0dOaTVENnZsK2JJd2VrcjZjU3lLU1BqdGFIRThRK3JMZzZtaG02YXgweVcw?=
 =?utf-8?B?K1dicjVveEViRzF6TFBmQ2c5WmRwV1dLWUdtd3JkcXk5eVg3VTJkVVc2cFZq?=
 =?utf-8?B?VGNTQ2REcmVScitnNzNKZFJxMDFFMlNtM0pJWW5Eb2JsUWZVMU1XMHdWNjVB?=
 =?utf-8?B?M05TcXZJcmRqbEJQVGxUL3RORWMyQ0VEQ1dVaEZtNm1lYjc4Q04rOUNtSjJ6?=
 =?utf-8?B?OG9oczZUOE5xeXBRTC9sUDBpMVI5VTNaaFQ2WWFsMENRbTZTZ0RMbDNiYkgz?=
 =?utf-8?B?bFFEaytPUngvOVNnM0FzVWpsOUUzeU9JMk9RU0pmRDh6aWZxTkNWTXNoTFl2?=
 =?utf-8?B?QXJrM2lOcHhqSmwzb3p1UU1qeWF3WEtBT3gzb3BubGFRNXl2MWlRNTZ1c0ds?=
 =?utf-8?B?bVNQTkJ3L1V2QVNiMVUybWlsaTIyMDdBY0FEYjJNTjRUVTNXOTNGcTJXUE5a?=
 =?utf-8?B?QWs2N1o2VndORmE4NU9YVWNCNFRsQ1d3Si9hRldwNDV5ZWxISkwxSlpic09K?=
 =?utf-8?B?ek5hL1lQeHFaaGVjZzVkL0VyYjBqT29pQTUyWE9RTGxVZ0J2Vmo0TTRDRkg0?=
 =?utf-8?B?M1lpN0QzeVc4aWZ4MDdka0xUYS9zQm5GRVNLR3hvMEVUNFVNdVhWUzU3TCtY?=
 =?utf-8?Q?cOTo3SnFO3rxIwjqBNNxUb3o5?=
X-Forefront-Antispam-Report:
	CIP:4.227.125.105;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:[127.0.0.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(34020700016)(42112799006)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:45:42.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05a054a-fce4-432d-b428-08de41367e63
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[4.227.125.105];Helo=[[127.0.0.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6230

From: SriNavmani A <srinavmani@axiado.com>

Add support for the external eMMC PHY used on the AX3000 SoC in the
sdhci-of-arasan driver. The default Arasan host driver operates at
25 MHz, but with the external PHY support, the controller can achieve
HS200 mode operation at 200 MHz.

This change integrates the AX3000 eMMC PHY driver with the existing
sdhci-of-arasan host controller driver to enable high-speed eMMC
operations.

Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index ab7f0ffe7b4f007a58eb0a26868b08b0b02b40f3..2d4f64e9014ae168957113478edc11209cd76b64 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1547,6 +1547,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "arasan,sdhci-5.1",
 		.data = &sdhci_arasan_generic_data,
 	},
+	{
+		.compatible = "axiado,ax3000-sdhci-5.1-emmc",
+		.data = &sdhci_arasan_generic_data,
+	},
 	{
 		.compatible = "arasan,sdhci-4.9a",
 		.data = &sdhci_arasan_generic_data,
@@ -2019,15 +2023,17 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			goto unreg_clk;
 		}
 
-		host->mmc_host_ops.hs400_enhanced_strobe =
+		if (!of_device_is_compatible(np, "axiado,ax3000-sdhci-5.1-emmc")) {
+			host->mmc_host_ops.hs400_enhanced_strobe =
 					sdhci_arasan_hs400_enhanced_strobe;
-		host->mmc_host_ops.start_signal_voltage_switch =
-					sdhci_arasan_voltage_switch;
-		sdhci_arasan->has_cqe = true;
-		host->mmc->caps2 |= MMC_CAP2_CQE;
+			host->mmc_host_ops.start_signal_voltage_switch =
+				sdhci_arasan_voltage_switch;
+			sdhci_arasan->has_cqe = true;
+			host->mmc->caps2 |= MMC_CAP2_CQE;
 
-		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
-			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
+			if (!of_property_read_bool(np, "disable-cqe-dcmd"))
+				host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
+		}
 	}
 
 	if (of_device_is_compatible(np, "xlnx,versal-net-emmc"))

-- 
2.48.1

