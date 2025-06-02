Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13B72C3267;
	Mon,  2 Jun 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876528; cv=fail; b=K0Zy546qczB95X6X+hfaUEmEfYGgQKqVmovtOuGHEua8GUgBFR2W8KC1dnXpjds0o5spjrEC7M5AkYkki6Ek9K2bZjUD9soUiEwVKGZn8zn9qjyXpv3Ka91HID/yqDaa0GXWThucaC++jMzkNhROKYdktxbjV1p1RFJ9sfIld/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876528; c=relaxed/simple;
	bh=343Xz6RTerf4vGtDGvpJOaNSsojVXGDygy30wdTioYg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uVCmbBvBy/13EWVXID+dwwymdDwljBLVq0g4nKJXy6ZQOy9H71izlheSAaXDElSchnxC77zq5foAk3gk6ikTrydfKny8OK5Xp+mNhwAVkL1ABdbMJ+PKxueLP6D8rMHNROV7a4QspfNHVQKf1KrMTdwyZWRLPXi9s9qBOYfAJ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWWs0uTq; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWWs0uTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEpMw1BGxXegj1nIAjbf4JpgTqsqezZ6n4lE5GeQstY9EEMjWXM7jOJ8siif2ULfsMrEmxJ6w3D4ozjuAdaenOLFC8Cb1nc+EX6vLsggwKbhDRtZzm+80RqoeiqkGma56agVlI1l3t4NrIIjoqYi+s9+8ShJ6j4cn9LXyu1PahovWgg8VZs81Z6ZkI+0KHiaDuYxh9IpEk7t7cMO3qnF+cWKmaxYFR5fFbtRUBvi37jNCw1emgBPOb6y18dYkgxc1C54DMy+mb/OOghSJU09y5Nna9LZIlRy70P3dgxqsZhmjrjK/f5KYYjaFzGbWlZhoqt/ssJWORk48QfyoFbAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQnsWIcj/5zCDGNG5be6pKkRU9FfeS5LYYT9K9r3KZQ=;
 b=JHyRS1sZpUk0AeAbfOXNt+nR4hKtuLGWl7tKM0HOsdcKY5kYtxpCNmeI91vxW3Tz2NdBqegvt71OvOyJc7Kd8sprfnEwV9GYD8GPZYjW3enp+lyLQZZgnIX60zUCJGUgJczXe7e+b86bnAztCMPJxEFExnUpwlj4DJofMKJcxmXFWz/bH1eK7VmvbWTafg1eY9qu/zAHwAUBD3jMemKsCsPw2O+Z8OqFyyONNPbc/uWv/523Wd+ECuIOxrQ3509TzWaGnKic0GyjDhRm59Uwb5LneuVA3S6TLSIRS78KWn9iZ9/4aG0ks2RW4QqS4TwwS2fazilt2/5UltFKNQWSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQnsWIcj/5zCDGNG5be6pKkRU9FfeS5LYYT9K9r3KZQ=;
 b=cWWs0uTqjCIbE38dchCD2yrKz1wDXe1XH7XFEbmmIq0uuKT+0Xtit0+9JXc+UpAts84Z8E1xRN5wl41J72PxZ+jtfYc5i88dPGm7ZbTX1c4c7Q2IKril66yyIl6wg/ND4wQq+UJcupnwCTemjugTfdETzrEXiILjAtko8kB8bNBDqv2WEov8aa5u8X0QTjCzBlfbln+RGj2LU1wO9NmiYnwWMOcM/94GDW+YbzkYbGaPE0NccTW/DBgs3wHpjqr0FWQ+xYiLXFPA6xFuAejueJAJwV3E3vwyAX4lAobweSAtracvngFC9T+wQzoo2IVsl0tJwXy/TLTNhLF11FOwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA3PR04MB11107.eurprd04.prod.outlook.com (2603:10a6:102:4b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 15:02:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 15:02:02 +0000
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
Cc: imx@lists.linux.dev,
	wahrenst@gmx.net
Subject: [PATCH v2 1/1] dt-bindings: mmc: mxs-mmc: change ref to mmc-controller-common.yaml from mmc-controller.yaml
Date: Mon,  2 Jun 2025 11:01:47 -0400
Message-Id: <20250602150147.947883-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA3PR04MB11107:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ded934-49f5-4d14-b485-08dda1e66e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W15gsVBa1TJgaJjkG7lohFWxYiZjjnZwRug2u07Xh0OZbUw6RU+mac/wERJL?=
 =?us-ascii?Q?BgJRm8cw9VEV9SCEBfbCQirMwvzqOzFx2y9X0103egTCfP+UIP4u2Th6BJl2?=
 =?us-ascii?Q?lbb5Oy6WlceKp642CXlyjPqfkH0Rt00N8VV/vERHsVrBauONv4GENYKMokax?=
 =?us-ascii?Q?Jur18Ck8uzhZayFHqOOrsqVSsyT2Ddea5UA4DeTtdcBIKmz8V632yCEcR75B?=
 =?us-ascii?Q?KtJsvpJ5/1b0K7UAwvE9REXo8h00qjThsFpizec94vJmCejdJtjQRwL80zgv?=
 =?us-ascii?Q?VUQLw2biyz7weWnAJqVOSlY3de06ytQjFLdWg9xmmYghr9BKTnO7ft230Uko?=
 =?us-ascii?Q?0yDg+nM7cuCZtkWXFqjfliehQy3lzHM1THXyMuuIh1lSUd3IpPsvZDzYdF46?=
 =?us-ascii?Q?Q8mQF9yxAJU8RxdYmzBNnZNjciOL54Stvp0joDjifat5FfZdYvBUHi27fD1Q?=
 =?us-ascii?Q?gsv4B0qIL/VqVv77498qKe8/gMlizebwWgLj28JRQbNF11OSh05J9Q9P6Vfk?=
 =?us-ascii?Q?gixS/qc0NEyDkL9WBv/f5v7P8yjX+5COWnMwBnhn106CtY6LlHJ9H5UMEq+b?=
 =?us-ascii?Q?tSvNO6RtmljT6/pFSazRLYlyskMj+NTR97F3ml4Nr7UH3h0DL8MRyBrwWXki?=
 =?us-ascii?Q?4K9DjnVXuuR6ch06ggxdanYSTAgqj63KYiU2m2oTxNJI/FlObU5vsGxZKLdu?=
 =?us-ascii?Q?Po9hnpduC3VNiGUdKa5QmEuTEYlTKAmbr+p0uR4RIvmMiJjmLU3p/5MwSfge?=
 =?us-ascii?Q?XR2UuDuAPvWM+TQEwLmH4bNwqah4zhCp7fCUNALX0+OBBK1MTm/TAWONwz7p?=
 =?us-ascii?Q?O/b+OoAk8HMRpaXZKHfNpyhU6eoKwn41YZ3HbKr3Yl9gTUPHqI0nxL/3XYVM?=
 =?us-ascii?Q?d1qAg2sb85X3MjAolk6vpVhQgFM8aDsm1oFOOK0By4XCf0XBG6n6XhGmiw7X?=
 =?us-ascii?Q?K+wTycMJLQsKReE87HwYOKXPF4UY5EgDTdrR3mz+JV95fdDU8jbcn/R9XBLG?=
 =?us-ascii?Q?Kas0Kb1hemDd58JJHRTVLxEECS2yPdKrLDo678YzKwJdyYCQEK0rAJBqHrBV?=
 =?us-ascii?Q?ikGeqNsRyIFcpIY8anmPQ/Mh+ee69BKNWsNC3tCuDNstZG6eqOPJIPrHDDOP?=
 =?us-ascii?Q?HrXAVqbks8edNO1ZNCtDB+vWl97OzCLpTdJkYyHQD1bzlLokUP0cyK+dF58g?=
 =?us-ascii?Q?t2zdqtdUQv5TNtKzHp3X1Q3JE51RDCop5Hk5ooe7P6CjcyKkptcIGz/ROHyd?=
 =?us-ascii?Q?4Q3cytndqHNPleAWutmGW/9me9XWD7SlxVYHDS+gOs/F55UhsMS5PKUsJTS8?=
 =?us-ascii?Q?XfVwvwlnHdBN661FK1MYbA9RBqk1xo6O+RxbnquLlAaBFtyf72Qr0M8oDpqj?=
 =?us-ascii?Q?rStkVlBLmXw+VtD7gj0vVUF0Mk/vbzFsJYXWC1jx1hOwEozg+53Lh8eKw42A?=
 =?us-ascii?Q?xXOyL/salzzWsFjqUfqUlM8Kvf4l6G6P+4DXnR/fvntNn4fOA0x6vCwtwb6m?=
 =?us-ascii?Q?APGJn1Oo3uSpXVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4hcOyI84+V6T5RyHowTSu66IBelxjbHMz8sjJmF/hgIy9TQmfxeiZqUsEfJ?=
 =?us-ascii?Q?btT640X18BI+Lj2OXFYRRUISkSQioGG0jAeEEH+mXbwMDAVk/kDa38JEfdkD?=
 =?us-ascii?Q?ZjodekZldAMxiI8nC0dliFFnxA5u02ir77bP59AexCfQJn+xlVuDDqaoJM3F?=
 =?us-ascii?Q?mOoW+8bGJX7MSXtzfAd0op56sNMgZGYjvdJeTQZ14JQLgBo9z9i2PhCx2oEX?=
 =?us-ascii?Q?BhrwheQzDfPoKSOZXeWaf3MPj3UeHUiyloA7PsRG/zKU47IAURFQSCr7XTo4?=
 =?us-ascii?Q?+TcIQLfhfftgK1KCp3r/Hj910I3xH6McnsviZilzYbR7o3/yCboc7nnKcLQ4?=
 =?us-ascii?Q?qeldgOzTn2SbsFr3c0cQ9UJDHGmOw5RmKSW+yrsHtuYarSN1jV+WKjZc1N9g?=
 =?us-ascii?Q?r7Y08cD1WzTaRTOc6yqv/R+P46oBbjSTFQaPaqW2cY/oRsi9dJf290ABpVGp?=
 =?us-ascii?Q?Z8bcvAX3B73RoWotPUBqhS72Eih2EdDSpknjCNHeqVKYeKDStKQHuRXuLVoI?=
 =?us-ascii?Q?R1b1l9qACg59IkM2R42CTymxQ5UUW+PanFTGmaB1f8xE/i3j22pZaFDJBz74?=
 =?us-ascii?Q?bmAtDbGmAd1xlqtDE9kb37iMaPKflnsTXp5tJ2rXmAIX4ZWGgCN+K6yginOi?=
 =?us-ascii?Q?ywPpNSckBAtHpaqN6wPGHo9sAouR4fnaMx67xqQ+2zMqSho/3JqN1G+vkwff?=
 =?us-ascii?Q?iQ1+bWH/UX4UQtzqOLsYGaOb2uRQL11nIYpqzeJ4T3slD+RPGWBQ0YqVZzK3?=
 =?us-ascii?Q?28uoIDZnSQ/Sh1T+Az5X6RTywPjPe0eQa/5jJMiyyy3L1r2yUeMdQ9RfCVv7?=
 =?us-ascii?Q?d6Q+S7zX+09ijPpbVz+sMoDr/RCVGMwQ+dbK5BNZbv8+vu7RoMq8OX71ngtu?=
 =?us-ascii?Q?Az9zdWjmI/BVjKamAK1SdHdRkAlvnyL5h4fL1SSr69p40h8Qnt5HiqMS0VHY?=
 =?us-ascii?Q?aUW6YiNmNrorVXqB+EHlShOTIhhWaZV/eDx4cbhwxnEFii42W4YRRZ0/0zIG?=
 =?us-ascii?Q?USXdvGu0meOOrJjOGwhCGaGeBnY7q4sy7NrS4j94X0ftL7upXdk0rMUXQAX6?=
 =?us-ascii?Q?bS9+BbFMXVdGdthYNpczccBCCugGbTJKY6v6w30Sila+6OK/cwCUTgo9Dqgp?=
 =?us-ascii?Q?cI7XVpo/Ep/OwzhpEWy18O9eJswyvssOUnXRTDgJpWZG4o4t4hqTEs+KaRfv?=
 =?us-ascii?Q?Qg2WZAYqFH+W0j9xgfP43YLUFryIm6txrn3/yRvboovB6Qa3T2k4WxtcZgK3?=
 =?us-ascii?Q?wC/Oxvkctgu4Tmh34TnXH8xSaxKxJE/lN/yVwVnuY3+3Z1ubuj1aIvzUMfKx?=
 =?us-ascii?Q?omzE+gWsEoFI4uT7U9woQHZ+LgQBX77NFh3+lW0pHQp7bq9cvPrz3ypyLvVC?=
 =?us-ascii?Q?yiIColwN3hk5elUTZ6Lf87aLSCcgsroU0LPeWdxuo38io2NyMtLRsx8T+tol?=
 =?us-ascii?Q?rypNr2i37e8BugTw8MP1W5RaeBznmEBjMfle1PqMl2MeXJ6zvtOu9l+FBbcV?=
 =?us-ascii?Q?4f6EcXzuvfQX+q0YkBBpfpiObkN7tu9LMdele9MF22rlr2zdGfoYVSuPgDF7?=
 =?us-ascii?Q?5+IRsNK5SvD2BikmHyE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ded934-49f5-4d14-b485-08dda1e66e99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:02:02.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cchrKuyNX04bj3xpMYWH/m5YFsed4BbAm6SQCLfRivdKO+6fuL7Q5CXyoEGQnGLJ55R6amJvu4nIYuS3mXJO7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11107

Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
imx23/imx28 use dual mode controller (spi and mmc). So default dts node
name use spi instead of mmc. The legacy reason, it use difference
compatible string to distringuish work mode (spi / mmc).

Fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'

Additional add clocks property.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add clocks to required
- fix typo legancy in commit message
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
index 32e512a68ed61..f71db2229909d 100644
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
 
@@ -41,6 +44,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
   - dmas
   - dma-names
 
-- 
2.34.1

