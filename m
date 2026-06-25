Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA1397E92;
	Thu, 25 Jun 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385062; cv=fail; b=FlS03f/XxyJghvmFixtryQ060Y+Y6Q8j2l8pYyAZxgfhUignGFTBsP0YDjxY5XfK8nFN94rYlMqYGO1iPooM+RN1opE/9gHuCfbv8ra7CFXcS7PzMjnzL2ZimP6L/FY5AGDjkiFA9zdjj47we3y9OVfe1qoEfrFHHbAcLW9T190=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385062; c=relaxed/simple;
	bh=zC18o19JvLXBI6gmMbv+1j2+IdWlinkOjGiYppm3KxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lft9OVR13iJ5/GcS6J7e5CS64/cpXIQP67RBcAV0wEGtnUHs8NTZwmTJc1YnRaHS1XUKs3XJdgnzjkva7D66O4ZvW9s0FIuActdcSCm818bJjnM6r1wV5BcdpOLwxb/fL6crWtt/VIG+TX0x9KRy1E8cBfv+CAYx0jKIgxD5sf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QVhUxMpx; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QVhUxMpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWDvDK1/MGe0CygFGPJPQEW9oJ4RWZvThJX80UnYPWoyjP19l93ljaXb1YlAT8+qb0lMko5dYAwxulHoe+fHC8FY43x4PSeW5NM4zoZnTRSJjvM0g5Fe8lpJl5hBi5IHx9ScnTYo2AyPQnDfyZ+GnF6idPeUDbpIYUogo1gwBLSomaDYzkDWmyarZ+KqW5XgqngxjTqYcumCd6fdHG2XZ2TJS0YrsQJXPwgWaE5yxSCuY9SHyPTT+q43FrPXAt9nBP5IaEXsUQycj8LRGKJpvyaqBeBBu6JuYzNsKWNG3zo8xWMavmbm6juF6XJZLQEhHNCvWJcqG+97Jd68XiB66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW7W5LpZsxV9DdYu1/wjyIJW8ZtdRN2DyFMvgKB07Hk=;
 b=MYF0W/3mQfKO2AEKdQcXxSr4q7I30ucfhcey3we3vhEYPsCo/7QLz30ZV/N9U5GmAH8E26N3mF1C1CKv+gut/InEhEUTXe0hqoPt+nOAzhLa2t7vgw97dc9SVipNQkBhfxRI0a79SAIh74Gi6Fs2zX1iVsGE3g5QYC87KTPbOIFEuD2SlrkSWNGjIam4rK/QPnbXErOis06RYVaBG7EczRc1Bwj+UUW1Ch4cODvbABvN435kIlYt7ro5eo29Rx4sHJZKRWofffIcegfnVKymRtNYI36f3RMGcUPjpHBbKOeofuLasOxAQYPT0EvvzAsKYZKism6tyfDJleWQ48H1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW7W5LpZsxV9DdYu1/wjyIJW8ZtdRN2DyFMvgKB07Hk=;
 b=QVhUxMpxDpRu3kBf0OWRoHjvCNr+18K/U/Zdy5BmE5tboMtRXuhcKG9nApJARIFYzKznFHQPToFzD/5vuH8qsSpV0kTRgKfWFBmVnERLFOTLlynNgqT5ljU8XlIKRHBn5Fofl7Mq4lDXW1sDB9K8cKnhXI1aPe331Vvq3hJpvH3sCGnlgQ7Oerg1YXFX4T3d7787oObSrs8wpgfUR22qWaNNsreMaE87ksdoI9L/jV3SFAFSlINq3kXGspgymkERV8QyuMihFXrlmt+YkLg3vU0egXY3iy3r5rF8ln7aBQPpgA8iC95mpIJKPoiWC0PoDM3tdFQn5xDSrhExAmy7DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 10:57:38 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:57:38 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: fix suspend/resume error handling
Date: Thu, 25 Jun 2026 18:59:34 +0800
Message-Id: <20260625105934.2890635-6-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
References: <20260625105934.2890635-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ebf552-2db1-4bed-b890-08ded2a89207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|6133799003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sAaF1u0naKCxmKOaKbJy8llkHlaphEFNsn5cSqOoNP5rf1FamIMnzlCLPAAv9X0a2rmCD8nBIqdan3MJUleCD6jc4qdkV2mYRZGeOS1kZG53BDsBqNdOh7vHWK4U5BRPPd8Z1DeHLQ+TrsnDsLcDpKuN6fqsDT8p27xOnIEzXMxFLYJ+uM4SHbCDkp7eEziRwlRhfWM5UaI4n6nn9O7Dm7iicZZJIQLom/ErZpk9HCYNhiPh8mgxQqSHSSColDDWjN46uX2CYfseO3evWURII71or1Drqp53pSKZvACcPYlf52O1T2fV3YpVVsOlICI2Ac7Jt88PR7yMMvS4fJbd5Mmu4FqpOkRqI26fEqyUm9WhhprECzqR07CVcj6qoMm36COcEVLoL/uQMXr8bFJGbu5vlkDsA1OYlg1xUWNupSKluuSXCQ0XIVEFLVWpUf/qKWkzjecSylSpIxtr8c+TZBjvs1nyVPWgy42/J7w5dw4xGFic37+fS2OVIMYVVQSGq4b0kA9cd1MBT3KX6bYoheLbniTxUg8E+Qa3y1Ski+ybWq/7+CABSVGfMLiqBtyxCIFcdopIn0DfekevnX1S95buUkhszL5TQrY7R5MAVPzuBj+XnFfUX/aay5OUq+7epycW34QNN33SgQ+2+AsSlU+PAPCs/khagP8nZm6VuZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fFfQ3CtsIXW8HBrQnmr8UdWAm/hG+ETkO175uyB/f3fPLVhC0A/847GNzVz?=
 =?us-ascii?Q?g+l0AnDke1fzfE/ZNFqCruOa5XjkfL9wfclEK7ZrBFFToUFNU8N2QFKhO7jP?=
 =?us-ascii?Q?46apYdOCoTmWs66+DQuTEAa1wZSMN7hEdNdzyGFVZwXF1xfQc0ZdhPYKEb8G?=
 =?us-ascii?Q?L+CwsKjyd81Zp04cWUWaURjIC/mugdUKq+l++Krh6h+dlawDW3qhqCo56s14?=
 =?us-ascii?Q?6RG5iAVSV7zC4FueLktqhzOd7gNM1Mk6U1nhDZKCqxgCtLFOWb+6kCHZY6Es?=
 =?us-ascii?Q?8wr2YNzc5phjB6DNiy5nmh6P5aNmrHSY5ExBAU1RYIKgcaAvFiwk7r8rMKFb?=
 =?us-ascii?Q?m6xigUiz0fV0A7vN3BXDgxxHvuD0TSQGH71kVfil0Ow+FrVk0pqatlNPhdvX?=
 =?us-ascii?Q?Vc2qhg5WfmnvoYepkHHRxrupPGclJf634cqoXmx0RxW4mA0M4SdTFfVPqzIj?=
 =?us-ascii?Q?fxhFouzC6ZFaOMjtpBOu7RiyouZpdZmuVHH5ll3sHPshrGahSZ2CxZwByfGJ?=
 =?us-ascii?Q?ZZpI4CNaTB7cK/cRwHZfXKSdv3jBYtv8km41vO3afX7Aabc2WMBsThErDZ5Y?=
 =?us-ascii?Q?D1wRtvjB8eHuCvxtSH+6e7XkaNKL0RmEgkoq2vkiDSXX9JFu65IpZ7fMzBTT?=
 =?us-ascii?Q?QiBZcsNhm4TylmSD4NTfky3657B1q6NH4ddVraZMHPtFepW0KVsyQg6Aj/6O?=
 =?us-ascii?Q?2nhu1BiqLEWoFp7hzkLx6cyotiAFDNVQ7PCs2Qu9IfwXzUOhhjgdFdF24Lsv?=
 =?us-ascii?Q?GCHEku5hkE+UK+b0/rE+SR0F+cILn78yOVeo1tSwh7eiGJ/vkRGY2M0ldCIr?=
 =?us-ascii?Q?p3+kn/zoAJN6fVczWo7Ps1iOB46Uwg/opVVYziXXzFW2bEacTrRAEbN3xsTX?=
 =?us-ascii?Q?osDBR0zN5LxSmdf8O4WKszHc+3hw5MXOhqf8qnneIx9GamVMF4T4mOqcWBey?=
 =?us-ascii?Q?hnf4f8ZmpmF486xkNBtMCHwqCX5U879JB1QYqdA1zShDlfld2yum2792/o9M?=
 =?us-ascii?Q?8UUVLA+ElmRsndNuikF1KUkoL8+ttwXD2CsJQme68/7lQweaPwbSGJVvvtlR?=
 =?us-ascii?Q?zvjs7tiqHMFIR6mkAF8YRlyjelMOOB5CiFQ1TYvgLMaEedmOS0/3ejNcXFDP?=
 =?us-ascii?Q?2rUiq2S6mXdrTi+ItlFlSHoM6QAXk4wHFlnPBZJ8IimzvByTLXW+ON4UrCYS?=
 =?us-ascii?Q?G1argZSDOMH0UVGQVnv1y/DVyp1E57dETsqcFUXZiIbvg2LXM5sEuMCIa1et?=
 =?us-ascii?Q?zPNQfIf+AFHRyP90rDSDoyFd7pN+TpHMlQHG7YdKlWdNfeZjiwzPmAZqNn+h?=
 =?us-ascii?Q?tT8JLXjEUnr2irSkw70Q+luj/HaQWU4nzUbUtb0yL9/qaWTv3wnscccYdWCB?=
 =?us-ascii?Q?6A2QHdirj0rqHnnrSgfTar79ZxYD+9/lJCRxythBIjGWvpmNk9ai1cODGvD7?=
 =?us-ascii?Q?yTUA/ZblzDWQbtspbnpkvsY1Lfl1oHU+g9jbso1jU8wsd03vQnEtxo604tx3?=
 =?us-ascii?Q?T1NcY+fJtFK2WW3+ctjuiYjJzBj3O50WvhYGpBjTODkfyzJzaFG0inGvu8hq?=
 =?us-ascii?Q?52745wjR0XO6ItAR3KQqRr6fIYCx3tLpbcSi3p6w42IaUsso92Kp115oUI9e?=
 =?us-ascii?Q?EZDCpZAa8n86U7aFWDqGxSsqws1wA0eR6TPu3c1FalHg/VYvk4aBsTAMTQvZ?=
 =?us-ascii?Q?Ja07nHIYgQn9LhLoyjfMGnIEBvzTWQ/L840AVOul0bkkzvn9KunGuKEzg3SB?=
 =?us-ascii?Q?ybrxeyIrz4HoM+695qnVSrUF+cusvp4fgwM7OdwaV5SWQyZxbt15?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ebf552-2db1-4bed-b890-08ded2a89207
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:57:38.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1R+KCO+MwQJNEpP73BOiZCXbnMEeBIB5v7Cdby7x48KC48Y54ERpYHC7w2EhKBP273091D55ccfo2UWYku/qrLfipscBEQ7l3j6EjpDjFRKfGJJzPPUzhnbDBhKlLWO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823

From: Luke Wang <ziniu.wang_1@nxp.com>

Fix several error handling issues in sdhci_esdhc_suspend/resume:

1. Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
   to simplify error handling. If it fails, the device is unclocked
   and accessing hardware registers would cause a kernel panic.

2. Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake()
   failures non-fatal in suspend path. These failures only mean
   slightly higher power consumption or missing CD wakeup, but should
   not block system suspend.

3. Check pm_runtime_force_resume() return value in resume. If it
   fails (clock enable failure), return immediately since accessing
   hardware registers on an unclocked device would cause a panic.

4. Make mmc_gpio_set_cd_wake(false) call in resume not check return
   value since it always returns 0.

5. Always return 0 on success path instead of propagating non-fatal
   warning return values.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c4a22e42628e..4d6818c95809 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2060,7 +2060,9 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
 	 *    invoke its ->runtime_resume callback (needs_force_resume = 1).
 	 */
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
 		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
@@ -2094,10 +2096,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		 */
 		ret = pinctrl_pm_select_sleep_state(dev);
 		if (ret)
-			return ret;
+			dev_warn(dev, "Failed to select sleep pinctrl state\n");
 	}
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
+	if (ret)
+		dev_warn(dev, "Failed to enable cd wake\n");
 
 	/*
 	 * Make sure invoke runtime_suspend to gate off clock.
@@ -2105,7 +2109,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 */
 	pm_runtime_force_suspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
@@ -2121,12 +2125,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 			dev_warn(dev, "Failed to restore pinctrl state\n");
 	}
 
-	pm_runtime_force_resume(dev);
-
-	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
+	mmc_gpio_set_cd_wake(host->mmc, false);
+
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
@@ -2153,7 +2157,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
-- 
2.34.1

