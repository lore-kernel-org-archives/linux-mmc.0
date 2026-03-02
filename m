Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8738CFEA;
	Mon,  2 Mar 2026 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438378; cv=fail; b=ml0LE2K1arLJ2LleKm1d3qvnVZ6d8V51ujnJCqiMVsU03TZ5llQXjsBHwWt54EKxedHxukCoicnzo24MRx+loY5J0QmseOXUbJ7PHp8tuDTqyxLY3XFLa8suVezsdPAtWst2rd1UzexK6sYx4vAXfo/aUlopzrXgGhHOEM6/l6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438378; c=relaxed/simple;
	bh=cneyYVXyAbm/XF9tC0XsNCMWiONQ9ujQlIVzrLWIG3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaQ+bKBSiCvZG43UoDeYMxRSmHgPCG3WNpPRSXG7KFFFQ3erEeYWlnkUjTT9vYhLjEpRrJ6qB8aXLwVkdwtceh2NZuD19wsMXj3D1fuNqCzNm9iFBHnFmNBsIY7B5h2FM9xmGVkOzuwj6+7vXJfiZLmykt0JdnJWakE7iN5pTeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E1oOj0mQ; arc=fail smtp.client-ip=40.107.159.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E1oOj0mQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO9fOCP8iFEBVnMhsh5ATzODyDf5otkSYnVNjqOIt6PtHkXwDwTSb/Pkvk8vutyU2iS1PmUhbNboIssJi7eeZfkWV9TiQu9bn6Rc0xZKY9nkYuMaYKTLOSJtBJrbGDRTiMQlET5Wzn+9jA1yiXiON/7Vqy+ojP19G9w2aRLq7n76ZLeqL300kAdHlMj1RGIZlwGBki0d0RscDQqXwQmrDj61N3vgJkiQrNK9WHnl/ew+O03DjMf4G/Ru4tjNwq0XkTuCk5ki30dPlIyYw/p32CxmE+crZSYkIIEFPGVf3A8dJXMwKLLvLJFRWg4B1EFZrC1sns5mDloNBeSbWD+KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icj71/VK5Dj4zopWTZsMofjaXkyYoMpwSXnNn6ELPAM=;
 b=em8GNae5nKvee4y+kybhTWHSSNZUB72B7EcG7RUwliSoVmOhKZQvk4WK7yO/AKX3BiR1+SDIZ82xs3P7maDiRAARqWQtMLoAu3EK1E0RLqdFIvKer+MJWyiXq+OMy8rU0FQzVvLob9HDm6CqeE71gD6tf1SKOqMkVqDtfgbM8JYRSfToFFJ5euOBnuK9al2fCkCV9qwQBj9SdAJ3M81clL/85m49cxUdxSMKD0tdveODdItRlVi+Lpu07jb+t+LGjgWgiQyWCD2X7ZntxUc9KEJqLsf2hjc4/WqHIZt7XqFGJDXtyM6Ag8a8GOkN7PBI1rcQ8dpLEmcmQUG6Y18suA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icj71/VK5Dj4zopWTZsMofjaXkyYoMpwSXnNn6ELPAM=;
 b=E1oOj0mQgPq4I6jL9Z8qd5R/6iocmF2bz99imNqshHG1u3zZi3RNawm/093NnHXteAF2doFzzmXc2OGYnAQue1+EzaXTuHf/0PXzaStNs15m4w0Lzft7bLtXfaU+rTgwZG6Ce4c12aQ9WxoHIk5QruQ6TrGEFeyqGXJgpDcmj/gcW8QZRqk+9N2tDUTKdD3PnXnjJvi/RN+Bkd6r2r5hGyoowBncxtT6PAngT+W018RVl7MtomtXMrCcTro8K/R+piFdcyReddjFvm9UhsfNrtQ+q7SvBWNZirdDuwBxZa4id1Gxhim0KtaguvlUTjP3vJxCYZvsh6UyxcrDMpqauw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 07:59:30 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:59:30 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
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
Subject: [PATCH 4/4] mmc: sdhci-pltfm: remove duplicate DTS property parsing
Date: Mon,  2 Mar 2026 16:00:57 +0800
Message-Id: <20260302080057.974102-5-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: 52240a79-ccaa-44e2-d4cf-08de7831a239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	eS5y0IVBTuiflZc9zbN2ynwxm62MvDkpi+S8LuAoxhljf5DNE3oliRWnHJYS4M+38MqlaD6l6QmEhjYB9IUzc1F0CHZCjc+1FHe5vGQ7+a6mImy/a7xw9QxnO5CBuRJnP/zvwX4AZPwp+SQoZ/YJstE+Sjv243evyaucFvVFLuUeC8bgR1+3lArX0YZPZD8HO3QlLtx7466zsW1PYJdGT2F/6f3FjQKubRfLiILK/jSpGhY1asX5rUcELzD8gEdM4ZmuJCjmyszZtRej99qcsP7+EK3PvGh3yzzojBnC7nNBmQrFhWabJBabKBQX4MAeYAHXD/+GFCIznZYRPvTQGpbwy0opPDlWohzC8/aUkRXoN/PxqK8rvhoiARxjRkU+Yy/NstfxVBCuj1GSb2dwjpv+lSFrwPj3G1kXnIVNMHTaCbrKoOCuOlWcVLjgMiXmmduHZ1GAHD0znqb9oqJ1+kGVBAsOyJoLRFx/4UMo78wIM/RGClguIkxuKN6tBPWrxzES+7BM2iz5skztATmmDb3XwL2nEsquNGZbw/JlZEQOCA/7z0KeNjGWbYavszhKTAZ80UJgnsIT/x/XbLF7+JjQBTFC3+Axk/uLWnzJK5xdU4ym+4TfSZsXv4bB/jXPIYE7WM/sgsoKa9PS2VlFFys3ZnhOPH5r2HCS0i8KdrhDcWugAaGrIs1rb6fWWtKQp2Wbr+myDYRcckCEuo9LcMIT3qrIHZy0SytZqkICLrXMjivBmQTkwmwC6Pjq2+D+WqBzQxJDP+zhNlJ9h94XpqtE9lBFA9ZcZo/73WIrvJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWIoByjmS7ThFVsqrSiyOi3CwwAuvFjFUj8tUkprrSApAZMmoLu77sN7RLz9?=
 =?us-ascii?Q?sOiCXYKghDQpXbEHUJoLZvEC8SwIUiuGZTZ0YerM8SZ2b59DPt0r7WFmOOCP?=
 =?us-ascii?Q?UPNw92sl0QE6uI4786jc/SXnEbeHEkodCkhki/l4rrihiGtFW7yc8EJZaBTc?=
 =?us-ascii?Q?DnACoLPAUcLyMixvaOhM247pSlTNhkTf18gzQxa0iT8qxd4qkIqlH5Y3iGS+?=
 =?us-ascii?Q?7L01AT+nOhbiFll4r0qWO2vvz5lZorb5idsd0Ri5uPl05P34UCQBxzZwnVpX?=
 =?us-ascii?Q?j8Iqn5k2GpGiivXOSoSQRwlrkRECACezdkqubWgE2/6N68rsE6kPAUmBDlZY?=
 =?us-ascii?Q?gEemcO+0pqBKtNdtO8xUVznLSXkx9J9V4Oys8xpdtkmzisc9gzsTPXy1uvjj?=
 =?us-ascii?Q?PRkhDbcZGWDgYkWpWMGF30NNrVBEIDK1C3MgsokKtz4Vzn2SJetEcceNR0rN?=
 =?us-ascii?Q?RshMDGnXvYorj5wXpIBEMPdIX+sN/QTQeiqEK+dkFQegnS81KWu5cXuWAYHr?=
 =?us-ascii?Q?cvzWQUs9wnJc85MvfRd3C5QmJOS8QMR/w7bD4Pf7a1i3lDrZNGIE2EBQCYCe?=
 =?us-ascii?Q?zQvkZQuTfcGCPtErUh8dhygudYeFYsd9a188vrhEq2nktzf9V/+GvzARruqh?=
 =?us-ascii?Q?getYBGLzkCUDFJdY50I0906aRG0BeUoptaW3Efs074z95rfMDT4+rVfGG7Ix?=
 =?us-ascii?Q?gqGmZoAUFbDpyBK0Bol/0zsih7UsfJvLMCGaH07Cu9GMViwmqrCwJSsWlk7V?=
 =?us-ascii?Q?86WzqSS53H01lYkv4R5JjIOyGx+axHvfOJIyI2hp1dtGSsvpmNE3KWkmrvUN?=
 =?us-ascii?Q?GIO6y6RUWeyMYUGw0iRKbFs8qow4LqBht1cIuVM4oIRiaOHjrvyqjojRGGlP?=
 =?us-ascii?Q?ZXkfgSQAFPSBqKvBNIoNN9jD1ik3/RA6dxmXofq1lqlL20e4u9sNTxKwfg1p?=
 =?us-ascii?Q?iMOI23LgAMURhvaofwGDgL+c3HJpEoyfPRQ9W7Ruf5YL6qsaIwXZRa981i7y?=
 =?us-ascii?Q?k8CNp6DqPD5Mw0MjcdpsIfTFEsEmsCkWPu6zoEmp+Z89V+LJqFMUo5PdQx4o?=
 =?us-ascii?Q?Wu1dROGlqFo9jN9IP0q+06C8+oZj3zzaqlm8sLDaIBVOuO2JcaKUE78g4EkO?=
 =?us-ascii?Q?hzMgCYzD+rihMPn1ML0tqDu7b7xsJw6hO3gMsIda+ltNRPuSbHnBjVHykaTa?=
 =?us-ascii?Q?pro43E9RCiU0BdqJec2FFf9R5XnPIyHYQ42rf4GuhKubWna0RVrqpXknumRn?=
 =?us-ascii?Q?ibH1hvDY+qod373tbwCnpHKILNbnMdE7DAv1HYw1ZYQN4R+GUIrtjTdCfaHR?=
 =?us-ascii?Q?A2HGu72o8VfM27Lia48EPPa6xzK7fvY3+U44aq96UAl02rzFUYQAVvixv0gD?=
 =?us-ascii?Q?UC2uMSRPyrI0OiJRrOxw4fquT0fksIN4cNqO+7j4Doyx2FXLvRbIvsk+71IH?=
 =?us-ascii?Q?TGKn4Fq6FxNS+cxST1ycEtY9i59P8MRWF3zoCXDiiTmx6cA5HFiQCIXm+Pcq?=
 =?us-ascii?Q?FCgNOkS/XaIZCubTZJGTj0BNODtG59ojuv2aN4o05/eZYXgog2lMSyNY0UYc?=
 =?us-ascii?Q?H35Wlo0r6AYKHSOfcGF3WAGFstFXbn+vb5DDYEdti+zLQMt9YJVWF5DuUNd9?=
 =?us-ascii?Q?sODoXM/QHi+f1va4OarGqY8piJtAaqmT8dG+r16A1wE38q81Q7YwO8nG+mIA?=
 =?us-ascii?Q?4WovDoHuwihdkvOo/5susf4xcU1x82wACIcHOB2cs1zFoHWJorxKSk/Lrc0d?=
 =?us-ascii?Q?RkjE06ru8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52240a79-ccaa-44e2-d4cf-08de7831a239
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:59:30.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUgrmf5/YbWTZbJLBPt/dO+a+GWRqji7x31kBd8wyASfyXN7QrVNZAbW8+LzDf8RlTDRebQe6YScPBnfcgt1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010

From: Luke Wang <ziniu.wang_1@nxp.com>

The "keep-power-in-suspend", "wakeup-source" and "enable-sdio-wakeup"
properties are already parsed in mmc_of_parse(). All sdhci drivers that
call sdhci_get_property() also call mmc_of_parse(). The only exception
is sdhci-of-hlwd, which does not call mmc_of_parse(), but its devicetree
does not use these properties anyway.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d4fb60c1ef69..933fafe0a0ef 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -95,13 +95,6 @@ void sdhci_get_property(struct platform_device *pdev)
 	sdhci_get_compatibility(pdev);
 
 	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
-
-	if (device_property_present(dev, "keep-power-in-suspend"))
-		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
-
-	if (device_property_read_bool(dev, "wakeup-source") ||
-	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
-		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 EXPORT_SYMBOL_GPL(sdhci_get_property);
 
-- 
2.34.1

