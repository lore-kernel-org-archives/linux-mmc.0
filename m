Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBD22127B;
	Wed, 28 May 2025 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471096; cv=fail; b=Si4I5GiAcLPQtIFCiYegCPSM09OlGKm955deAyahug8WkAgUmGup1VByR+dqp0xb8BQqxeOPCROvBMJL4JfZchXX3APKT9Hdwl5LxZgjnqCvpq/gt7NanoDvHBq9IFyvNUtO/AHote9iSdU3+K6bG29oXndJQGJa2mLM5jgJ6cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471096; c=relaxed/simple;
	bh=5Bk2n8BoLLbEFGwZdZj8CWGNVpvjpFORlAZdMtL1FPI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZMDZqnv1YoQKeDH/h1e8DH017qFJpsuVxTojvjM/AgkMiP99JdMAtnKBKDx2ICeFp0YTLeYt2lwVY1guNG97OUwaxaHCQfs9xdpUuB/8d+DdbrM1KQ1gNvmsBA2fIhK4tMW1yyusOrXLgk1tlSrx5Q1QNFLjbykNCDTFN2PjB1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VbWQxl78; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VbWQxl78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVnhNKeDcGDKBm35KGpjgrOE2/h66rcLW3cPEvYIOY1+UYfWU7pdj1phMpgP4uFNF17E+DAHvuW9LVb8XcDA01hWnEG+carWkfpSDCsKh73WXdb9ft1EQCvUlaSD23SBhytDwZqpZIraBX8j8SPzgA4pM7seMlcw/z1uHQs9TtvCnznDPc2U6zpm+hXJXRZ4lopPI+S0FAhz1ZylJG5MhVRfMHRVctVqATGRe1ZOkotnt7yhpx2l9qseViApfh8k3OLdXMG005C51Mj31ej0GRJXr0RGS/zMbZoOofQ18O6WSXa2Id5XTO78uEkjKo4U2Wzg9xFCj7J4eIrVHSWp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuas8GZta+tCv3fdB3+Z32BrRF2EdaSj7wMJQtjDyXs=;
 b=fQ/HC+747pfVulk7qXxHDTbdKBms22Ke7uY3lPO2v39eJ3/XtIH3KSULwYbYiH2hW5+7BNDED7E9xZu1hzwNJ10bECI2a7kgvA4REtn77etoyd0NMhnEz03kBLMtxM90PdbJd7M9Im0I5WcnL/ZayvUK7qQmwRE96VaSNT6Ig8j6yptUF6S9CeNNeUwFhohugW03sJ6OQ3vEZxFH2PWUreI7SpFtT68iieQNc8iarh88CcfcWajschBeWcxjrW/U0wmXfNQS2IImlQSXIaMzwF4uNF6KFBcosXT796dE93OSI6IfWccercEZq3UcUCpPszuxnVncLXI/T057oN/l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuas8GZta+tCv3fdB3+Z32BrRF2EdaSj7wMJQtjDyXs=;
 b=VbWQxl789K5yvJaxiMdfzaDLakkr1+R2Wm5Z/lEfhsBZYKHclCU3te8BEJJjW+/mhDRAaBThYUUPKKZc+CgvdHHvrkXV1lhxUWRab9x9SBWQeaK60yIwpOJoVx6JsQ+U5cvvszdzyLtAAfGduMInYE8nysvCOrhhWeC+RULZj5DkC5I8wgONTHSKA6XJWBlnmmWIrdTEmt2/aubTH2vaXczNFcaP1qjDru4cWjww2ZDcZwvaaxtyXWNgPNZmeiPoHhQe9ouC7v2b+k0/qfvFFn+LZMFxUfn+qvKNDcpeVJIsiM/1Fws4067yScMKAl2WOObNkj28Xvyf/+BhLOAcMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 28 May
 2025 22:24:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 22:24:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mmc: mxs-mmc: change ref to mmc-controller-common.yaml from mmc-controller.yaml
Date: Wed, 28 May 2025 18:24:33 -0400
Message-Id: <20250528222433.727633-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc1d4be-9063-4749-bb4a-08dd9e367552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?laJSm+tK45aXXiHzqK8UGHX+Zxz7Q75Io2pEtcfeS3krtXjIDDyFGXGu8pIK?=
 =?us-ascii?Q?a+1RfJtJwBH61ENYAsW+55MTXB2z0fILTsUunMJTxlil21rGwbAb1ehfFkVX?=
 =?us-ascii?Q?r0uXUjE1PFV1NE2FE00hvy73SbuSzj5WIYk/pEplt+eTo4wH15CuwtyQjZQg?=
 =?us-ascii?Q?stPubMIjSj4ccpY6FVqwzG5sYAfk+6WYW0l5ogsTCP2KyeJfhf1xxR4uDNO1?=
 =?us-ascii?Q?RKMG69w3cXV7pxT6Evq+2jJuJmmIfuBep4UwS7l9ldB/y5fQfItcixXzrxe1?=
 =?us-ascii?Q?ts04qSLLqYCM347TFrJ0+RVkJQN4Rftj8+6Xxlo8rtDAeVKoi81UTlVaKASN?=
 =?us-ascii?Q?O04xZE7Ndw0go6G12hekvrWLErcpaSJgiKfB93Aziw3ffaUih2jo+7LaDDAe?=
 =?us-ascii?Q?Kp+g4bcWQWstWiNETNJfK3O0EmLciDTKOT7LSPhlFozkGvkZr8ip+7UBfU1U?=
 =?us-ascii?Q?fL4T4FUTJmLFHeCHWbR/dfFHlCTwS/P6o03nrp9YhYL39Xfmh7R5I8jFCrxc?=
 =?us-ascii?Q?H7PJMI33bIqduM3vBbEnd47RGzWT39MCZqQeYt8urAYY8oYc9q+2D8n0Ym5p?=
 =?us-ascii?Q?HPbXo6uEjeRQzp+qxIVexYNgtOFdbrFvLRyEL9QzOkNS+lcRLWnBaDF3EzHN?=
 =?us-ascii?Q?duux3IPIkJQ9DzBap4Ldc4pXPMl++RLwJZDT++eyeZyBrOvUyJLeNnTcqflx?=
 =?us-ascii?Q?MxJyVqWTTDHyVfx0gzBBs+muRNcb9jfcFZoSgFRvU7pKMVSTcvBmzn05X0PS?=
 =?us-ascii?Q?dBfL37xQmZZxIuwhI35rb6zi3jEioyVdgxxkrfkjWj6E8jOyf3pbgSEco0pP?=
 =?us-ascii?Q?pMI2Xqv8mSfur+bg2vPzG13bbEluUMohSkigjy3wzlSl+i7V8YVmrRBTZwdi?=
 =?us-ascii?Q?F8+nha7mTD57wqOOp3dsyb26jGmDVXKN7/9ldDycd1/y8CJwFuQ34ntkXTsV?=
 =?us-ascii?Q?itpASNr8RBoAWd2xLGKlvJDFWvxJTKGy/mGnbjL6/dK6ddtNJiZbEhqhXmvV?=
 =?us-ascii?Q?2wr50fwnOxHz0OYtx9c7+UVujGJNzN7vKbemvjBeSO/5BL/9PP3hBQgUbA3a?=
 =?us-ascii?Q?4tGWvJlNJEwR+Lbw/T7vd4RqYYXFStbBH6Cl0c4Sg95IjckG6kumHIZZZBi8?=
 =?us-ascii?Q?HhmdAFLVH5Hi3S6sTPQRbUMCXA6egQXCwKQMWhbsZRdTb+EH8bwmcrDp3lE4?=
 =?us-ascii?Q?yfW1Rtmg0QMQbnomsioGh4Yj8HGM+x4yEwNdYtuVimDP0PujnMPw9Wh+htjl?=
 =?us-ascii?Q?T9S3/hU3jJKByyd21bCAsZDFLDP8GqyLlPdujKf5dFhR2RLza9i5Ifzk/1YD?=
 =?us-ascii?Q?ARy8wFHGYnbPFZTqp948YdjiiqVvmzmv+MdQ58jHCYIH/pMLWEzigKjp0HQR?=
 =?us-ascii?Q?oDHBS8yUG+6hFwE3iZfsv88DWI7LLasvfkKzjdbLUxsCUcgpmQTH4xVbsCAc?=
 =?us-ascii?Q?2TiXwkkpDWkSFGKf2DsSClGl2tjbOg2bM7uRvQLFuP5EYGa7puZ9tck80yKL?=
 =?us-ascii?Q?W4ztzz9Z4LpeTso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ax9llx0Vq33YrQxjFOKZuzqzORcXVRf/E2YYNyaKr8O2weljDqAsu/VuTTb3?=
 =?us-ascii?Q?JBUfseVyMw0earIS3mmry72MYoKBJbQHJakoeWojQ0Kbi2hSfR2VEZttQKti?=
 =?us-ascii?Q?Xc5b1GpQriE9YMPN0Xu3+ZEnAB02YLe9LKzU3twKMpuYnyKm2xmOqu3oKWcw?=
 =?us-ascii?Q?3g0IJgzS7UBwpdJSp7ykZdPtpbDC3DvdgBPkKbpgh8QcgHryGAdVGGVfUN6I?=
 =?us-ascii?Q?iUlqM3nIvQG4iK6N7M9s0mNMVY+aZEFRq9RTeDJWUcQmHJYcRmrt2TfipSjC?=
 =?us-ascii?Q?6DXdp75/Md5Vq9xgbbZW4sjepFBE38UqUUKvps0CZZga1R+Aw7HIn+sw/xSz?=
 =?us-ascii?Q?R0HC17jjEUgT4iTUYUf4SjYlmrk8en78+I6cOhJUGjGRk269RPOF4kTzNWQ1?=
 =?us-ascii?Q?2G5cEhD5HRY22OvJAp/S77qI0KbUSVKlS0oB/U7P4K4cTiEUhlge4hfKhWGv?=
 =?us-ascii?Q?MAiN/SvtZFRl29rw6Sxg0l+o0xc7Vk+h21Nsqh0JoYEk1/v4/KF2FXQ/5Oc9?=
 =?us-ascii?Q?VGvoUpIuBNmAjS31TrSRMVcdPSsmyNanR9m6qI0UWVTRFAzUQdCraKIwgRZU?=
 =?us-ascii?Q?ks3St12cx4tAD+lXY+n4MoHo5mNfqP3FPo5r8Z3VJNlZPWazeYvgZitJoNpY?=
 =?us-ascii?Q?zVVfg1kH5z9+SvszzNi6/Wlw0lRZF/gmmgBer9ZY4uenskWzHy3AmplBmwev?=
 =?us-ascii?Q?6G7gxGRl7rkNaFZMFm3PZBFW04XHYToacrIIBPpG5Hqf62DnGA5xVlyAfyLD?=
 =?us-ascii?Q?iQ1q3tZdcNOgWnZGEagzzaUrTS4lIXFErzLYhY4p8snBc6pTkV7FolNUii0P?=
 =?us-ascii?Q?4Nj+yg+/CEwvvPkpRNtKz8yTfNZ+tvsxAPq5aqT88fhebr0CKC+LrWgMG5Bw?=
 =?us-ascii?Q?9VoaT7ZGcqSrudGcxU2tDMB7xkabACGvdgJUnQcF9gQCNuJFwS4Qr6PX6RSm?=
 =?us-ascii?Q?TuxPLZeU4fBU0EUpg3pUxE2HPM/fDiuoPDbuCTRcDAERtaKoA2uJUBDD93Vp?=
 =?us-ascii?Q?+i6IjHxypi3Bgw0nk6z4FUhcXP1IGTBbApyVV7jQ5LrS+6MkBPvamaQLcfhe?=
 =?us-ascii?Q?jGi7HRxUDkW62T69pis9PQHPpUqBZLCa9BeHHmuV/2+pXA8FDancOEoII+eU?=
 =?us-ascii?Q?RChzB+tBe0FnZZSTEsZbUFVxgQgFPpr7VH772MCY8RoxQKM4QQ7MNVQkSjk/?=
 =?us-ascii?Q?hjcHRYKzVWzscM6G6T9Hi+1me/P8XtLZhZx4np+gw9kW9o9FQlTp+nARC/FU?=
 =?us-ascii?Q?EkaMAhteLAUoFRxoqZt/BxLdgKT0DUrRd/EBjwN1rNPotQb6OE/qvnP+0QDc?=
 =?us-ascii?Q?yya8kvMH+MmRiIQ/HaBcpn5aUM/n1vdz5gDOeSdxezhItfZTNOzErSV5XoKD?=
 =?us-ascii?Q?rBG8+DvD5uTV6FptYqg6zgzwdi96S1UO/wht+hP2yYwVME1wfKbBLrmH9IuC?=
 =?us-ascii?Q?xsBn9S/S3BWoGsTT0/uaKk2jWMpW+DJSDsn8q8y1j3o3oNNUc7034Jw5m4r5?=
 =?us-ascii?Q?/Qyw4oKeIsVaNT11aUkAwDopthsMo/clhhhz2IkZwWb3F8O4CNLdMrdux5Nb?=
 =?us-ascii?Q?lKkGTWaLo5UvfN/oHtc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc1d4be-9063-4749-bb4a-08dd9e367552
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 22:24:49.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJP8L0dXstL0a+sowlWMNxO96NLgUYxlWLqY3aksMdrybAkY7upH1N0Xthr+3DEcxVktkvfudw/qM4nHOamgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
imx23/imx28 use dual mode controller (spi and mmc). So default dts node
name use spi instead of mmc. The legancy reason, it use difference
compatible string to distringuish work mode (spi / mmc).

Fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'

Additional add clocks property.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
index 32e512a68ed61..ca40ca92f858d 100644
--- a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
@@ -17,7 +17,7 @@ description: |
   and the properties used by the mxsmmc driver.
 
 allOf:
-  - $ref: mmc-controller.yaml
+  - $ref: mmc-controller-common.yaml#
 
 properties:
   compatible:
@@ -31,6 +31,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   dmas:
     maxItems: 1
 
-- 
2.34.1

