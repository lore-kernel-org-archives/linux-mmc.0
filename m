Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609C75801;
	Tue, 23 Jun 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200044; cv=fail; b=rZRS+kazJQOoxTlHJs5y76MOCxSLVZqKemAdooFnIT2ABmC75iSJMgHmmHsGpCLQcW1NIhHgrs3yyJz1MPxpt/JMLNU8mtmyN4pO0zGDoAoDLDnzBrA8Pry7h2LFgkG6StyLxc/X8thFvVilU0x/N4g7EBnokr3kDzTvrZVdJ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200044; c=relaxed/simple;
	bh=XNrTLtzeFDTEvy7qyyoj7cI4dGa+iouDfSGXKtHmoZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hF6uxYna4Ki3aWgSvKTjs+etbelbymkXF+s0GtBm4Oziz/Tfsnyt+dKV/WeItUz/Eh4pqhHrRjjo2pfwHAimWbFOGAZu2bPanBYy+Od9ZsUIDxiqjYsUOTFKBfqx/hdZvzADrnjw3LjIGui9j71MneP5GsvMB6ZA3tsSVMBTkK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q9XksGDe; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q9XksGDe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKvfvOzfdpuQa4unxH4tSWY5n+8fH4rJiAGLv7vatMuWvgWCanbJFP2HH6JMaULNY8orxVV2XnveaCdP4FV3ziYlcHEHoSSWF7dXfX80rDfdawYCLuREkQ7tLYBKzEG2KFYdzaEydSBkcwA0jCfTcJtX+Y1SwjcnD2qWshrWjM2pkKjby6Si61acvxgSFMttGV+Sx3rVTZ5W7zq4WsAjYmWvg4DxVT7+22qCqEVbrPIcIKYIoDADau9IsxPRKZTGkgk4D07too5D2iB19ToUVhFCBqttjcUwI20OfKXCkQJd+UlIpGmwDH4quukoJR/JbEPrwbQRNZDxbr1llWxr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NofonEFMP6mSpwao0YmaE1V7bcI3ZadPa5NapNuX7Y=;
 b=fEs606cqV73PTp/J5iKw080W6RrT9MQ3Es/wbEVeecip9yTqJbiE2zeWLGwqTEY3Jee/eQFJMiQeSe5xVXzvKYgBG3rhawlHxCjfVoy186GdoZPOTpW4eKjuOvfVxLOtO7yFP15oLx2I938IKOAkO8bXf60os8ByLycfJxtyx4Hwy8lJ6sn0Q2OCymWmNKeZLLXmnj2fq758pjEngl+pw2CYijAHDA048rqmSQBXO1CdyWFnnWB+UKgUuKDdWCBRAEHXAwoeMIYNezcxvXhLa/vLUhxLlcyJddftKp9WJD3dBzhMk3SHZ5x9KTvAH+IIDvNSXbNLpvTGB2RwNUGTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NofonEFMP6mSpwao0YmaE1V7bcI3ZadPa5NapNuX7Y=;
 b=Q9XksGDehYz1tflEhwUIsgy+huYW2DBRWGSSm0o4Gvlj1IArChokXrSicZo5ljr9niIvzVRccUWXyBJnhtSv/0XmdBeo8fEoN1RDfoxoo7cuUv17ympfg/v+7Gd/9XwGMhIIOwSqu5+7fiukD4SeblAJ6ep5l8IxiwVER6MqcZ7KWljOO4qLuYL08iMFZCQ2MM5YwJzB5146vO6Dbg5TmG8Do5D3jEFHgNbFKfE9cEZ9Eycf7cGOuvGjMZHZi8wA4TXf6FXq7Mi21SHsU6v58wZjByNJT+W4PwL78+YU+WBra+K/3gjzg385JZge6QiGXJWUfCqygDoPgoqgCqngiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by GV1PR04MB10822.eurprd04.prod.outlook.com (2603:10a6:150:205::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:33:53 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:33:53 +0000
From: ziniu.wang_1@oss.nxp.com
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
Subject: [PATCH 4/4] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Tue, 23 Jun 2026 15:35:15 +0800
Message-Id: <20260623073515.2658205-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
References: <20260623073515.2658205-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::10) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|GV1PR04MB10822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c72f3cf-4cb7-4dee-dc31-08ded0f9c6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|19092799006|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	T1Lkjkcsh1ki/t4AbnCNlilfzLOe3dDHnVDFiy8VsCnzjHallIfKJuuppbdZsNyybeHqDjJHouMnCsywQd1iMnXeDPrs4uNZdltoIlnEQReaiJPrnRZh4ZkjFh9FNRmZmnoE3ZLvSYGi/8YfOOXZfjwOYtP0j3aFa+5KZLnXbN3j7HH5DTJ6hNZCwDZ2BIpqAJdz3ekQZRp2uPnIBOxOw3BMBAi9o/7f2+QHP41iqt0Pj+s42/Ys27mwzN9d/S6tI4PBvzyUDxg84QAo9aprafZDKLFxPo5tw93x6zFOfx6t/aIpgSXQy6/3IWkPtgUTpS3ctAhdrNhpuH4jG9F4He3sAFmdYuGrJiUOqeST0yFRM0PKpMEPG2clRyll9Ggs6jWzBblIXHZSkA1rGojhl4qTVQCzsK8ADUIUPIfcNegdFB5bpqDxPLcXiFA0IoB9y9+pCCRXxloCYT6/azk59jHbgkkN2GDNqhZWr0SYHpMnIyz5gTy9N+bo/n5Uz4hdllYJm1gOLRHUlR+1LbHyPmrCmdpLNffN0aYb0lfdonvuB85/38UKUmie3FWk/I7Ink+D39Mej5rC1i8Jm+RhZYogYbXBGnZzrTH4CUews2VfLW0prFYY7RH594KZx/T6Rb5xjfhDmYdSF8R34+DHMVVC2w8C+l+10l2HwKSXYGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hL8mYSxdxKaywoCAGagSno/D/T9T+m6HZ1CHxvo1iZs2sR7rVNmtMB3pu6mZ?=
 =?us-ascii?Q?7zCAKyzovTB1WAkV5JK6LfamLvh0ReXGJ2kbqtNTOa3/k6w+Wy4kK3Paji+g?=
 =?us-ascii?Q?LiwDN+LbgOMUgLsE68e0nlBL7PwpULSx3vA1TkhqqNkBnzCJTmfAijUhJFvm?=
 =?us-ascii?Q?NMN6TQ7vh0Ou/OuhfkHZjK4zyqKJxdQZaPU0kS+4miskTDFeLkpndY+nQBKJ?=
 =?us-ascii?Q?nHvw1jwgYaT7OQsaZiVRrFfHWWcwxx+VnfDtCmvfrMTZ/DycPgHxR9iQ1I/F?=
 =?us-ascii?Q?kkuKZdXRHWfmmJKmQ9VoieGWVCxjjCZFduHCdYHtryDhmUroIDV5A7wiIkq6?=
 =?us-ascii?Q?z8LnI5Hm2V9IelIemhcjkmU0AVDy21+btS9BPuhiQfHrImA2nyvgl2kMXiXV?=
 =?us-ascii?Q?faNXZNbE/VVieWsSCA1kxvKVgzScj7FkxKhQ6L8RyBeUza9z7lQJyJ7m8NR0?=
 =?us-ascii?Q?K3AtCTUMbbx8wUJ5Mv36lyOUkkzAlyJoRg3ZjeWTl6Sr+v0Tz5xaWRHzbTfS?=
 =?us-ascii?Q?l29ky+nZaIzeG7gQmVWsmMgx8xQPUA0XGKNEADE9RSy9bNH5APhHgqfCT3/1?=
 =?us-ascii?Q?w2iQmOBUATCZF21QFwFVFmyhYjUfEAoou+wKViXo7cTW3ExDZeUBU16I/Yf6?=
 =?us-ascii?Q?Z1zi3UElMJLELa85QnUjEAfxst+ZmR8koOKou9niFo62vj01+06APJjKd3/b?=
 =?us-ascii?Q?94CyWFVg7cRcpiG+Y87tyUQVMfOy6qhASUKs51hUKhhmGId8KMYsnN3s9Ixp?=
 =?us-ascii?Q?6oPdFOqZitvLbwoeURaoz15U0PQawxnBuXRWdsZX1A+qy2acGjAmmi/2pLlC?=
 =?us-ascii?Q?mayBPXdviNvOD4mDlh/21Of03eZcnBWGRtsI0Vjh2h6NL2dvDZ0WleldypN4?=
 =?us-ascii?Q?QrsIGYdbE4R0PFoo1wccBBnw2EBX3egprD8r6wiO9pi+TQqXIGgI6dlhpQuE?=
 =?us-ascii?Q?8YF2VNsgCJHdAyEV7Sis5la0+j5D05XFERPKW6F9EjnnHmqRJO1zDMs4P480?=
 =?us-ascii?Q?fpgnv4awpsWxY/9RYwv0CCIHDDivfXwA7ZexFk+1J9PeGWMZs5a7a3yH62Gc?=
 =?us-ascii?Q?erHlOIWg8233NrgY0qg8j304jadoJtbwY5WJ9/CEhWVil+Y0caVB2WPyNon1?=
 =?us-ascii?Q?Rf4Ge68AIlJoaJrC8fuAgSjpV5yiEmIrbx+A6YFhEO1pZesRat26XFbShcVy?=
 =?us-ascii?Q?StOjx/Joz+HsKx0ZA9F22j3Kp5gmwiOpFNhl6lyqJNVb/nKEozU8oLwg0+gt?=
 =?us-ascii?Q?T+Pg35YX6dWF7lHPBSUXA+IYVfRz9b8cWmc1JPsdLEgiFWIg833jqBWNSSux?=
 =?us-ascii?Q?k6UKMQbbYOuuFQETckHFOL8N0HSM2FtO7Q+7AC/edtkiAl0Rp9RkNCx5tOzY?=
 =?us-ascii?Q?m5DvX9NshPgNr/3xzyM7EUtPVyHh7/7Yy23augNSTbVrW27e5nx9uXnZAUDE?=
 =?us-ascii?Q?WUOtkTRR2P8Mm2QXba6lRVihaCs8/7EUG4byfFTWzQ9ExqYUAzjPradmuod6?=
 =?us-ascii?Q?thj9uT7h0sYs1CpeW68ThisjW9bYSo3kzEh7l+gd8PPi8FVWbbRu8ycyXmfS?=
 =?us-ascii?Q?3Nj0v55nRudIx4pIQbXf7q5qJ0gh/Wm6e3f5lZtqaXp9mqTH42bjed4nQGkr?=
 =?us-ascii?Q?Qp1lHYwAoRM35t5fu5EG8wK/naZ0ZS1YoHE32ulGclMosUoAhkbiHHb3ZwDm?=
 =?us-ascii?Q?U7qvtpQ+xXhiWFA85Qj54u5CvquZ40zPNc1WCV0GT0n2n9t9pLLn6RyMWPS8?=
 =?us-ascii?Q?KDO7K2lRLKjrL1fnn9k2wg/qOlydlzaXgTfP1DXEXbJOa46UNvYY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c72f3cf-4cb7-4dee-dc31-08ded0f9c6ba
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:33:53.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98vGgoI69BeNhz5nuEJEABq29OhMkJdKeRtEBdjYWX7JNjVyZWHE1mQB8himA4a9/753c31NQhgUwmKGzL3isEH/5v5pSHLnC6yMoYgaCYIxY3bLNb8Jys9pdzGq/g8Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10822

From: Luke Wang <ziniu.wang_1@nxp.com>

When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
occurs. This happens because the usdhc interrupt is not disabled during
system suspend when device_may_wakeup() returns false.

The sequence of events leading to this issue:
1. System enters suspend without disabling usdhc interrupt
(because device_may_wakeup() returns false for usdhc device)
2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
3. WIFI sends a Card interrupt before usdhc has fully resumed
4. usdhc is still in runtime suspend state and cannot handle the
interrupt properly
5. The unhandled interrupt triggers "nobody cared" warning

Fix this by unconditionally disabling the usdhc interrupt during suspend
and re-enabling it during resume, regardless of the wakeup capability.
This ensures no interrupts are processed during the suspend/resume
transition.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a3688c94cf58..9afb74cac559 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2076,9 +2076,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
+	/* The irqs of imx are not shared. It is safe to disable */
+	disable_irq(host->irq);
+
 	if (device_may_wakeup(dev)) {
-		/* The irqs of imx are not shared. It is safe to disable */
-		disable_irq(host->irq);
 		ret = sdhci_enable_irq_wakeups(host);
 		if (!ret)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
@@ -2127,10 +2128,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	if (host->irq_wake_enabled) {
+	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
-		enable_irq(host->irq);
-	}
+
+	enable_irq(host->irq);
 
 	/*
 	 * restore the saved tuning delay value for the device which keep
-- 
2.34.1

