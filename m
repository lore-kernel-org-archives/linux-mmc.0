Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012025.outbound.protection.outlook.com [52.101.126.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52413BE627;
	Fri, 17 Jul 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283456; cv=fail; b=p/Y19NRIGMLlTj4hCRfq5LwMSA2z61JKhiVGj0MKVO4tPDc/UWnauy7vmcYSNTZX40ca5pwSfMX1Rl3apr4iaZh4aFsDJz5eTx9sZMFuT4LMaP4I3MdjeNttKycdFPVeUz+UNu4XYsj3hp2STFSIbFBoIWJBMIblxUwl+N0Xkgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283456; c=relaxed/simple;
	bh=J3NFrYDKgFSBpjMeAq7a+gArADW7jP8JsDGz7QtGB0k=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MM2pJWjM3LU5ZnMA27XQ9pV/NbzI6FBXx6EqYQqTBpARsRy4VfPfnm6LiXwk8MCqN84XWsEKjT5TcwTpYMcUNnKhwnO4yRw2fJe1rWYrGqMKUeQZuzDaL6l73n5HIiBuFVu9I6lSYu6F4petlF7NoWLBCc9W39Q4FyLMWEIJ/Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G9VS29Hk; arc=fail smtp.client-ip=52.101.126.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G9VS29Hk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1OR1Ztd+r+GzXaXdOtCkMgul6zjSX9GgjIWtjaZ944MMXO9+TgevaSurUNu7T3oHL9bVvkIr/FkLLmcteBZtXjNiDHFhoT6VDX1fN39Lv7ah9JvxjMt3CVO9W3LILQH8lp4tONlRyW8lHiiDbhdghRBRocmjEX34w/Erex6JfrurLodW1wlS9rjz0qbAjrvJ/L379u7A0VNVEPxFHsxV5r/hd21h5EpaW/yNi6x3EzRQLiQz9MxfT8fKuuhO25jwZXaZhS/ue8IE9G85wy1sgCd6FWHXPzoOghniDqA02lXM4ZymWSw7D/mZZbk6Q/GTXX3c0ZEZ/OdM7zEG97+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlCXnuVJLtgpwozbDJuuBWH1wFu7oE+TtVH9lNTRAv4=;
 b=fD5IoZXtFiNdDKJTkMvnCVdJoKwh852GNe4OE/jqVfUQYd6Ro/BHG5ir+vO1FivsfeO4A080osqORXbJBO09K7Tc/DEzwjk21hyyQ+8QLf8y4sUbemBnxzraa5nyd4meV6NePZdAC7P5CYNdCaT+qpMtJ0CguaZ3ltqjeIOgKA9Vby5V+JTWa6JXadZwXdjb6qSttiul9Ycs7KLYT31QJgSlkUWWbB6tbZGKsXNa1+qUEeYuhPfme3boyEbxr1IYi0GgquPx/rBv/6doG4WF7MHI0IEi0oFesyAtYesKwi4m3N6JA4yST1w5fAcn10pU4eOcC5Zuh8/0fliVXr3bZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlCXnuVJLtgpwozbDJuuBWH1wFu7oE+TtVH9lNTRAv4=;
 b=G9VS29Hkx8WVCXj8JIfNddhvVKc4DywXPVf9PjxPlx7T0Y0iLTRT5Ewr2EeF7Kw7mtdhKbJia+IOJqSSCRELC2keCwoaFKAqPRSAQz27Als3SzmcEtLrHFGj2HnYQ2DYaHfhCU5a7AJsFRehpTHi0h8CUaGKC8T2GW24/5BPD84e0PUOqeUNtKiKIwixfZ+LukCsmJG3XkIcn4cJhzXcoLIWtaCNoAogaSZ/oua5kSoO+XCFMalhIwr/xtvv2xekg10fcwPf7vfp42H177miz9R0bh1eWfXTs/ENiHvSurazu2GUbVwCLV5fU9P1w9tbXmvpTLk9rjwCUuileOevcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB5940.apcprd06.prod.outlook.com (2603:1096:101:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:17:26 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:17:25 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	linux-omap@vger.kernel.org (open list:OMAP HS MMC SUPPORT),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
Subject: [PATCH] mmc: host: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 18:14:49 +0800
Message-Id: <20260717101508.635969-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::15) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fbbbec-fb2d-4b95-87fb-08dee3ec991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|366016|1800799024|6133799003|18002099003|56012099006|11063799006|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	xoNfW4hMvV1k/cnKs8eFDPwk4rBYb2OHFuwrYiPny+OFrP+L8bydW+PWco84Uk7d55uq4foUPGxGKJoamdYtR6hBHd7JVP+OiGQaedTcfBl7JNsSyvRWwAQ2gyugJDqpwm+2ptvUrQGAKVAOKd3b/Z8bYy5WH9EymQmKUQcdy7ChAeDK+7TqrSe8Qkxqy6zLaEDo5Tw9ikP6NGNRflROOFI+G2hLXY0mXqV0ob/pxwPvInXSrz/NFAvm2F307/1+zgEC25Wmi9b3fDFkl3R8G8cmrGJ0sQsTWGSBlo4A1l0cA1oy2GPMpLsi792SgL+vnjWsmYcnbjEUvgzowHag3kUfoUnx43001zAvCUG2nYJ8v98DBaPjGgnMQVRaL1Q7vxNhg6URJcU4XMaFgTFPn9+Z0vRzliPXZv/Siyun2YJQDfmdeP6uIlCtL2iuwxmoSbzLCX0lg4pXavHp2cMdppnF0xP83t2qKdGr+kt5yHnp43OwMdNBW45qHJ/rSvrxzvMb5lb2H6acNyLcm9iniITizEs7EkIrhyUK0jEwVqHVZfzP6QWbseyp+VyGpZ6iuCth8mAv8F9aBAGE3m7QBxtzF6HLGXF/fOsRbstaL0SM1a5733HjjpBTz/6s+KN1dh0Z7pqNDL35FyDBjsSSXKomJb/Ww/N1F6L/Ewv3gMAMYRwlkCvQcwCLskgXC1ThAXkvy5HJ7v55pczQpwYsL0VtWGDaFPikkvjTEPMmjVYViECWR7GV2NKSOzm/Uogh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUveRhYOqkorN/3wiWFS+AT037dH2uQ4yMZ2dA4o15rhjHRL/bP1i/UKkwpw?=
 =?us-ascii?Q?OkXrrvypoTHom2tK99heDKSQD0hSDtottfmvtMNlKEtPkVfEngvA1pvDiBJO?=
 =?us-ascii?Q?jhwkktMmYfCoAeCubyJw41TXkiKiTrfipUrJyGhe5z+NJjH5T7s2R0ckkZP3?=
 =?us-ascii?Q?OVFQAlEF3jVrMKvCM2nzl3LJLYnfert/kbDQhjNtA1WW/TARFmQtzt1eoGjm?=
 =?us-ascii?Q?P6zxqQ2ka2BOfLnLwuSNXAhRux74CvlBCUspL074FFct3oVmZSf/mrUjmQVg?=
 =?us-ascii?Q?CHI01RqdYAYuiKh0zppD2zTI9ELiz5sq7f7V765nvP0Vd/N7NNr5QWE+yD5v?=
 =?us-ascii?Q?uQx9QnVBeMowiZRXjbwekqQD4tSRxxrmU51Uwe1CJKszaSTq8WKTQJFkGmOJ?=
 =?us-ascii?Q?VJ8a/5Hjd8lg0XLccz5b9GWpxu7KT+eNQEL3hiMmV7heaa1qXhU/pTMCsr5j?=
 =?us-ascii?Q?3qwUfpAju/RxKXt3KOFuvJww5OS8Ns5Erb/OnesEaHIS6FrVuv/Z2P+qrsmX?=
 =?us-ascii?Q?pqFnEQSQd3tlAoaY+3wrkvhzVDmxFBPEjfYAi7MjTyLuk4FB9URV9LmG2/NG?=
 =?us-ascii?Q?k6dnDimyjPSbjgzirrg5EHRF878JSLjI7/iN4KA6ksAGWz5SMfmlLRxCzzFb?=
 =?us-ascii?Q?v1GtqKL02cB7qSm6TT1nEEzLUYZwF3NMv6EDxGWyiLMa3J3VipsiwzSvniSa?=
 =?us-ascii?Q?DXyVllfma7Jiwt7LcyMlZN3hq6EUj7fnFWg0Mi/lFTkwuCqc0ufzCavKhovz?=
 =?us-ascii?Q?QiumUBD50MQjZqnEXIQ/jsJomNcmLfB6/jJsVgWcd2JmQN2JYrZlG2xMT/zW?=
 =?us-ascii?Q?WiGMqXn6dCKSIkCEC8Xc6TRdqiZIkdi1zaN0bR+/t8K0muNrQEHeWbRqwzlL?=
 =?us-ascii?Q?4FJRHIeGF1KCu4SZuwahf4ghyDhDMcqni4WUKSY5IVnNh7t+d6ApbAncrO+K?=
 =?us-ascii?Q?KGzxjhAjMnzTRcOOUh4ONe3CNK35w8ozymXRFKGiJ4ZWPoy6AQ1oW368wMZL?=
 =?us-ascii?Q?qBZb5JTH2PW/Ku4n0Yg5rkVUW+skHOWSYK/K+5oxUcfW8DdZnSDaBV1wLw3+?=
 =?us-ascii?Q?zSo3FUSN61XHT/+aLMMLvIDq6Bbrq/P4emhFSLPqYRBUb/9ATGPtdhsCjsDT?=
 =?us-ascii?Q?Y3JZ/1ITRd9lQyQKzff2abmiGu+naOoJfxx7hB5htzaMfbgkblGo6MhIRtsM?=
 =?us-ascii?Q?Tn9c84wSnnaw7+p8AXSxgnz54RQz0vMOTrAapRTZ/BhHaesbrJfdSW4mDn4/?=
 =?us-ascii?Q?sk8amB8gfYuMhgQEMw+2fuaeQbr2QMuThfPr8hWcoGzG5IBM22yslZ5YJNo9?=
 =?us-ascii?Q?SDQLdTgwV1vA0ciyEtL92iWmHGf4GIkWqKjRyBF5dI2hlqtdLhzDJ4V58HC7?=
 =?us-ascii?Q?Mz3KkMbTEUl+7dvdGmzJOpmF+3TLdNtVXIZK7swA7nTtwzFUdjZlytebdiwG?=
 =?us-ascii?Q?5vEe3dK/Cvc9GsRbVwLssAIBGn8VqZEXTRBnFYDD3q7S1Ct2g6b/9Vk2szmy?=
 =?us-ascii?Q?5MzA/6k4CF4Mm2wbKf0gfTy/z4SU264G+Q/rnia+EGTeasULe+2plTJfEdyi?=
 =?us-ascii?Q?yM2Tvmq4vHEkSi7vABp3HiSb52xBf39GT5INxXnmbQyPN/mTPIqxf4T2poSH?=
 =?us-ascii?Q?CJcQWOngT3dF38otWH6/DKDND6aj3ay75nnCW/ygMrw49+PyTlRmQtPD5fnM?=
 =?us-ascii?Q?zvjcsfRQHEdOkMTXPs4gFoM8WZetMwGsYpJZPoz8r2pkK7Q1UWiTdMVJVEGJ?=
 =?us-ascii?Q?0tFVhpUu8Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fbbbec-fb2d-4b95-87fb-08dee3ec991b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:17:25.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om+aYqPkmGZYnKXFzzGgfEpBERCrsOzazsdeVPSGKTOcXVZqPkGtzl7fOS12JyrSxC8yg59CaF+dCkui/sm4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5940

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/mmc/host/alcor.c         |  3 +--
 drivers/mmc/host/cavium-octeon.c | 10 ++--------
 drivers/mmc/host/meson-mx-sdio.c |  5 +----
 drivers/mmc/host/mvsdio.c        |  4 +---
 drivers/mmc/host/omap_hsmmc.c    |  4 +---
 drivers/mmc/host/owl-mmc.c       |  5 +----
 drivers/mmc/host/sdhci-msm.c     |  4 +---
 drivers/mmc/host/sh_mmcif.c      |  8 ++------
 8 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 721db54739c1..45528909a758 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1103,8 +1103,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 			alcor_irq, alcor_irq_thread, IRQF_SHARED,
 			DRV_NAME_ALCOR_PCI_SDMMC, host);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to get irq for data line\n");
+		return ret;
 
 	mutex_init(&host->cmd_mutex);
 	INIT_DELAYED_WORK(&host->timeout_work, alcor_timeout_timer);
diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 8a0daddd9200..1bfc1a4f9fe9 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -240,21 +240,15 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 			ret = devm_request_irq(&pdev->dev, mmc_irq[i],
 					       cvm_mmc_interrupt,
 					       0, cvm_mmc_irq_names[i], host);
-			if (ret < 0) {
-				dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
-					mmc_irq[i]);
+			if (ret < 0)
 				return ret;
-			}
 		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, mmc_irq[0],
 				       cvm_mmc_interrupt, 0, KBUILD_MODNAME,
 				       host);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
-				mmc_irq[0]);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev,
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 5921e2cb2180..bef5e843f449 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -683,11 +683,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					meson_mx_mmc_irq,
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
 					NULL, host);
-	if (ret) {
-		dev_err_probe(host->controller_dev, ret,
-			      "Failed to request IRQ\n");
+	if (ret)
 		goto error_unregister_slot_pdev;
-	}
 
 	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
 	if (IS_ERR(core_clk)) {
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 79df2fa89a3f..cf705b265e21 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -764,10 +764,8 @@ static int mvsd_probe(struct platform_device *pdev)
 	mvsd_power_down(host);
 
 	ret = devm_request_irq(&pdev->dev, irq, mvsd_irq, 0, DRIVER_NAME, host);
-	if (ret) {
-		dev_err(&pdev->dev, "cannot assign irq %d\n", irq);
+	if (ret)
 		goto out;
-	}
 
 	timer_setup(&host->timer, mvsd_timeout_timer, 0);
 	platform_set_drvdata(pdev, mmc);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..63a9fb970975 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1915,10 +1915,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	/* Request IRQ for MMC operations */
 	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
-	if (ret) {
-		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
+	if (ret)
 		goto err_irq;
-	}
 
 	ret = omap_hsmmc_reg_get(host);
 	if (ret)
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 349082d76a99..d5b8a110267b 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -635,11 +635,8 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handler,
 			       0, dev_name(&pdev->dev), owl_host);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request irq %d\n",
-			owl_host->irq);
+	if (ret)
 		goto err_release_channel;
-	}
 
 	ret = mmc_add_host(mmc);
 	if (ret) {
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ceed47ccfda8..4aff965f0e2e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2864,10 +2864,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
 					sdhci_msm_pwr_irq, IRQF_ONESHOT,
 					dev_name(&pdev->dev), host);
-	if (ret) {
-		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
+	if (ret)
 		goto clk_disable;
-	}
 
 	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
 
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9831956de1c8..7706d01b149e 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1505,18 +1505,14 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	name = irq[1] < 0 ? dev_name(dev) : "sh_mmc:error";
 	ret = devm_request_threaded_irq(dev, irq[0], sh_mmcif_intr,
 					sh_mmcif_irqt, 0, name, host);
-	if (ret) {
-		dev_err(dev, "request_irq error (%s)\n", name);
+	if (ret)
 		goto err_clk;
-	}
 	if (irq[1] >= 0) {
 		ret = devm_request_threaded_irq(dev, irq[1],
 						sh_mmcif_intr, sh_mmcif_irqt,
 						0, "sh_mmc:int", host);
-		if (ret) {
-			dev_err(dev, "request_irq error (sh_mmc:int)\n");
+		if (ret)
 			goto err_clk;
-		}
 	}
 
 	mutex_init(&host->thread_lock);
-- 
2.34.1

