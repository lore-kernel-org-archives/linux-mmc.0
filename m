Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DD70838;
	Tue,  3 Jun 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964185; cv=fail; b=S88lHZ0WGnyT6MSV24Cy8XbjCHie7RTx+m7odA/4cP9ATM+k2NcMRxRP9vpBvrvXBPZFJdxVWUWvz6KNHtMpvaK+qHaKsXnUHWCmj2W3R2bzlJnIJKScDVT35UCUchBkGyPPxqixGzV9y2T8POJz7DyrsNLw9sAY9kPldhFIKVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964185; c=relaxed/simple;
	bh=DPEPGfkRiPNI0taBAzxtE2Ikfawt2cEyAJbQtV5vh/A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g37GLk24/RQ9g42oz/5QWrMMqTOuYRvqn2uxhinfkDqFYrChVvcKUmf6QrF5uh7cb8lW6wQ+F5jqT0E+hvGI4sOkVCUUJO9koUD5PfZdS8/KzqJCOuhZBC5jfFj8bGTbdYa+uQesG9D2Hefx55XOMAPVgRx1J2tfBKup6LRyqrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1j7cZoW; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1j7cZoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mle7b7Wh2Q9uudULq/d82rNjhEUfua2qDN2XRH2wKIb64lm3Gc1CJVqsTKWH0kusWGDZoLw0UpKTle4wwwiagL0QtqXJNfkIQxU5dBMsU6PSi1iLtrK7Pm5BK6ldDHQl9GGwTi0tSiARVN2FYifwS/068KAq9hUoPctNDbTMyD+nhlviHBuAl6xjC0Oku8+5BPbEdZ0aZ/m2yyURzl5dh0IcGIjEb2CGDestsIifPWjVVo8PoBniwhBFZoDt9413HhB53B5j0NHYJMPk+R7LEWRqEddZvLXM0LDioSe0oefnsUn5J5hekjW1V4hW9ajnShl5Ia3DV0nvb227I2VA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oilhRRzxifOYQMsm3nIyo85+w7VhdbTDqLBwbnwnt2I=;
 b=rq17ADKZ7MgMqcvxjUw9aca4gUO9WSwJggMu9ZC+PbZmayxg0uclo/42EE82BArp/ceI+LJKlStXPsOlbVTCotDhXORF8wfO2iufD14NsKYhi9pwAMls7YqfUDrQVzH6HINQyMS9mC/sFiv/599D8ovwaS1XQj5ZsAAgiDrlS6MdWY+qbFhwYNGleFxVWi/yBuYmcxJwCMwcgTqv7UAOOWb4+odRuBUn7q0NhUlWEvRZyR+pZFcAENmV3A4K7ITh6ZEcxqnZ8VgB8QCWTZGa2Syuviu6TCrvsP6cOJTycNug1jz+GAjWeRB20Dm7bqQiDJ0jPoG5LQFeOosq7q2Qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oilhRRzxifOYQMsm3nIyo85+w7VhdbTDqLBwbnwnt2I=;
 b=W1j7cZoW96B9y9EASprNT/6lR+W8z83XqrlPeYM5G9O5b87/cUyBS7PWWeIHhIRMb/TZWz8C+hka6H5MneyvBNwsVbSPzAv1GTKmIs8kHtvzjp84hCMdaP4GIXAaShc4I9YO4Yxyo4LbWC30upN+P01GARTUdat8j/wW4JW0nHXwWS/bEL8UmXjgny3T7pGuakUGi26wWsTa79Qeok3eDhzpeop1Tap+jDc13WKusPtD8h4XU8/fiQ154U1mpdGUAUBzdx2lNfi0DcVgrrvY7Mw9BqE9tQT5WC8gmm/pb2TNJOPUPN1Vsdop9jJsagXTme42N3Mb5YMsbo/sl1Rycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 15:22:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 15:22:59 +0000
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
Subject: [PATCH v3 1/1] dt-bindings: mmc: mxs-mmc: change ref to mmc-controller-common.yaml from mmc-controller.yaml
Date: Tue,  3 Jun 2025 11:22:45 -0400
Message-Id: <20250603152245.1068740-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b37e12-bb95-4e05-13aa-08dda2b28631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qugvoCr141O3ww/AtESVh3cEyVZjJ92GOvc1L5rh7FtieK5Ao/2cheOV+py?=
 =?us-ascii?Q?r0sxfdGX7tDs9QhKiahn42ta8G3XPHCDgNiSZBC6C9bstT8ATPBW70soHZGn?=
 =?us-ascii?Q?hhyllHbNnY5JBhPcj486H3NrFFA6ozuy7CSbeX4Zu+0KqZbn3MaJgmR072m1?=
 =?us-ascii?Q?maRrGgBfuMeiXtvkZ2b1FTSQE864uq5WGjfX3Hqu1LIFUmv0XddU5/gsOqoM?=
 =?us-ascii?Q?6Nceg+M9hteypdEhMsp8htsBGlJvUqtYp8oKCGNQYjsHHQxe9c338R8r78ix?=
 =?us-ascii?Q?5YtaUQ8f/P+gKPcv3O+UDURy9JUV6gIruMCgdvLl8/98j55lPiS4lFQ7SOfk?=
 =?us-ascii?Q?ND+dlELC6DtWYE4k3u8+z4Lo2VS5HJDcHspoQHK+3MMWGLKohHtenXfQ+BFy?=
 =?us-ascii?Q?Da9L/rs9DkmPFz8H2mlrqP8ybAd5eTS/xaFc24nT0ZwkI0857goxRJyhzhdC?=
 =?us-ascii?Q?JhHbPZ5cYtUMb7wlk59ZYpbEmJL35u6qI/Ju9TfzjXs3XCh1gVKjlYayO0ds?=
 =?us-ascii?Q?ie9bA5SVwbI+TlMjf64v+TKNWkfnAgdS9WvCeYn79zdITjWsW2rnK0zmHd/P?=
 =?us-ascii?Q?kdnZ/geRWDogrT2kxITsWnmuNuJbaEMqLSkzFxmq5V41/EbD3AUuqlzUMyNz?=
 =?us-ascii?Q?UKhooSW+udP05n/nfXCzC6GOoVNj8BHL/hiFPjJk261LHxH1RwpLpavFMXuJ?=
 =?us-ascii?Q?v4Y3ke2/4ZSE35ITBpDnpRjcGw3b9Qh8hk3aV8TFCHhVICj95jjfCDONZ/1Z?=
 =?us-ascii?Q?JSVS1gImqUpO4ew+Np6xJ4qea4HvrSalCltUwqZiAaYe3OGkPzMKqqldilVg?=
 =?us-ascii?Q?poHyMNA6HJ5DajK1TrKYlvjXGbnTx6QzgPn38L01842vCZh1ATugEdpuV6JS?=
 =?us-ascii?Q?7kTmJ6ZjbI4JczYTORyZSYdJJkQjwC92DGCq+V2rvR77NVs9jKwhSjVLZTc5?=
 =?us-ascii?Q?4+Cu/DzAStmvwwEpvmT61A715hhcn8rxSqCu3BwMfU0eWDoK2XeTIIcwQhpX?=
 =?us-ascii?Q?OPTPLxZsePWWZl7y5gjVgkzeSDnziop1xMplWFSIz7BuNOVvkUoPI2sv3Nh5?=
 =?us-ascii?Q?RbgoIAeWNrN+MOFBlxbBlqpmWxCqnkRMOgRbwxJDJFLr/4m2jQ8xgHpoI8jo?=
 =?us-ascii?Q?0uK6DTsxVuW+x/r4wfLivOFRMET4kQPgn5KYR0ltJVP0tRcItZ8x4ei++H4E?=
 =?us-ascii?Q?WHXOlboTy3bphMA27gdI7CqTWWlJeFbiukHiefm0TLCaAOOKf4xnGTUjhu7U?=
 =?us-ascii?Q?UT+WzgCO5HE3EyJQqrFTHGAn7ApFCvv81HnfXe8nD6Wk+PoW3VuNX7gLkRg5?=
 =?us-ascii?Q?gnTIDAF9a+AuKDgdn5tuSoqCxjyjATcmAbToz/sIevyu92ECbNGWNb4lWmrK?=
 =?us-ascii?Q?gYLOubAXa61trEyKC79cF2OD6yiC2B7PAkPtAVBwV7ouUfXxPgOsm5gYsBST?=
 =?us-ascii?Q?eFfsbvoV4YLQ0WCj4GF49fGVr5MAFIvXnXU3fojK8hnj3brrNbY9B+N8xy7N?=
 =?us-ascii?Q?3UECDPjo0Lu1BUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJmcFpHe9ThRsI9MGE6ymgIdvEwSWgrN/de620eOniQK2l3V9vah59pvd2R4?=
 =?us-ascii?Q?2QlDppNg+W/of7rNfU9ea7MnpoEE1wi6IU+Vo00fsuYtGp1jHqD6QUCuz22P?=
 =?us-ascii?Q?GxbDouyBZjO0fk6QkyRjZvnLBZjpvuDzRzIKlD/MLE82Ic1ckZYWnOrHREOg?=
 =?us-ascii?Q?4eBv4RhlnR5cwk+kbdFpuRwritmJ3vqc7tYaf28fAftzbzo9Vdqx+V3NRsg5?=
 =?us-ascii?Q?xw2RGGS+qdWgNP1itdpH14UQOaA3cm8jEZVDM1dcKfLySMHadjttWvOJVmfs?=
 =?us-ascii?Q?lBosRpREO9GSVfMFuFF6dCwGhl6/oBVtHAETLPxgcWim+rW+gYYRadaQLmRA?=
 =?us-ascii?Q?AodOgFidHwr0ixiJz0fxgXYuhSeRhkLHPrk25zmzd9Kzv/YXATeOkzJ3o/e1?=
 =?us-ascii?Q?UgSOnReQp3cqC/HIiEI4RC5ytjO/sQpHfbFEPsK7FObJtk0AGTLF8RifmRB+?=
 =?us-ascii?Q?Mn/aYKEqJrFcolcxl65419txEpI0a8NkQGdGFQC335pKSFldRkbGalfky/PH?=
 =?us-ascii?Q?mDnXUXnXRKHYW20SacycIVQzC9W5scF7u9tAsyKtvYuj3FI5vR4ZQKDDr6HR?=
 =?us-ascii?Q?PuyYQpHe79qgXfHf3THB4IvYFASFRccAZi5Q1TISnGRVxSmQ0PJvyAFNXPXu?=
 =?us-ascii?Q?50Gb7S3N7cTgVVsKxXJUequQ6/x+wZXG88OnPldeGTj67ShknuOhPWwAN5oK?=
 =?us-ascii?Q?9TbEaKXggFH4lE8ucqZ6+mqvTBtsiv8HNwkRJlKG2Dn5QREIaTKhzCnJIc3Y?=
 =?us-ascii?Q?BPwyzHG9wx7CDIFGmtTOzXO4J6JFkoFb4noHcQcKvDbEDSIL8+f199TxIi8V?=
 =?us-ascii?Q?bWGfhDii6t/0AFzcsL2wHAFpIlLCJ+NQYBXHXEgfojtqudet7eKCKN0JVvJ5?=
 =?us-ascii?Q?GbyTrfldvcCJoU2Yi6Qb2HCNb0xfrQpFEZwM+HSIgI7vugfE9s8iXL7hIIcR?=
 =?us-ascii?Q?bXZB56243L52BKsArfw8eWSWB2eeUr8laYCVcBdFQiF+t04A5h6hoWzKSF5+?=
 =?us-ascii?Q?bBthihsNjerjFzNjmYJ1xskAYmdH/6z/9HEh2dHjPuKPzMep9mxtGQJt18OT?=
 =?us-ascii?Q?Fm1RdsATsuuTInR0r4ENcZL2bGlqSg1iMvZpDliUWn/lnxn50BjYg/4Gt/oc?=
 =?us-ascii?Q?dXIAHCVkwUK31XQbdzkcPZ3QwKa+BakwvQ4IuGMSl4sMsDezwSetJk6AD3i8?=
 =?us-ascii?Q?U74XC1HnxlI26D64Nuaa4A58RVBYXaJ3N5NFJTKjibFciDw3+FGZ+hPeOU2b?=
 =?us-ascii?Q?exJA3vUnx7lK94aDgTBqHMT76rw9yBeop2c/n0T8hFw3MaDpF1GHhADBgzA5?=
 =?us-ascii?Q?romyYis7/Zd7zH9HEeZzE+Cu5nHarEKSAckqbkn1ITxBM2s3uX1pb4uL+gcR?=
 =?us-ascii?Q?CHVNlSs6ZRjjJvl4MvNhgfBlvggniVmLO67kCeAOWG9u2d1xEz88oFxF6IHe?=
 =?us-ascii?Q?BSR541ZOPvYvsDe0NPk5av8lYVXs3ElrpbxfE2zk4AdL9WJYMYGG7gJ6D6Oy?=
 =?us-ascii?Q?mWQE2ArWLVDHWLUb+TFqUQAgyJBe0uLK/xJ6ctNM0mJFacG/hqUebnChxrVP?=
 =?us-ascii?Q?m1vro1ahRknYOGn9tAhtNzlMghIvSEjXx4k8+BQk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b37e12-bb95-4e05-13aa-08dda2b28631
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:22:59.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByWfXC9XzKWTo5jqomS0VsiIa4+x11DlNC8FEwNZ02w5UWCVaRKL+/a1pw137zI6zDHcC1Cus7U5KvR0RYRqzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
imx23/imx28 use dual mode controller (spi and mmc). So default dts node
name use spi instead of mmc. The legacy reason, it use difference
compatible string to distringuish work mode (spi / mmc).

Fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'

Additional add clocks property.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add clocks in example to fix dt_binding_check warnings/errors.

change in v2
- add clocks to required
- fix typo legancy in commit message
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
index 32e512a68ed61..df07ea3b81d15 100644
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
 
@@ -52,6 +56,7 @@ examples:
         compatible = "fsl,imx28-mmc";
         reg = <0x80010000 2000>;
         interrupts = <96>;
+        clocks = <&clks 46>;
         dmas = <&dma_apbh 0>;
         dma-names = "rx-tx";
         bus-width = <8>;
-- 
2.34.1

