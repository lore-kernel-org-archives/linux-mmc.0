Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47EC77B7C
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 08:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjEEIrx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEEIrw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 04:47:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B11892E;
        Fri,  5 May 2023 01:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUqeFeY9RIIxTdERvzLCJU0bae71jbg1QRtsYHn4icTUCBp2LN9baS5HAQCsgxYN3b017ANOPRa1R9mq+nOhZqzUc6X891Sh0q/TRLgmAKHlSt1VPfbiCbYjXS8qjR1owATgH1CrtUvtyLfsG5ocRe9/WFBHQZ+5mhn3NMs18U/MDGTFNpxZihILJYCXzqtsKYkWSbMfeg21j05qKizwVrkgAwQaGRP7kJaLugSUQwhqHqhVObd8lRIk7EBp0vcQsh6/VLSUj7wLUtWm9gu1RkT94YDtnOlc8EPBci32hmZ5Ry7AAH5uDzuERik4vHkmGNdAzw7lk9gE3iWHrgNSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/SOJD09I6MyT3dBVZkKU7DLkeL0WF+RZkNcyD+yXTk=;
 b=R2y7lg8cKI2xCWec9bPsvE3dq8/pISqnr6wC/1u/cy7g4MRF5LT3gbdMEfcmxIF2KePR3fAk5NCmruNb30N55hkGYkczZisUCNO9Iq4xREQ1oXVcESpO1NSHVg2GaqlCDDIdIWwpNEi4J2d8ZnPmYVpAaEJPF13LJhhcHQfsnNU5jzteTGNn9eU0lodBRiqeNLX3yJ8NrKejqju9V2EwlubRMFZszXLyT/C2XFfLu/AelXstxiPSO64NMkeDJa+09VQM0n2gxibNSVZboqCpZ82fAjlYKsUP01VkJhOFto3+UsQEL5dUua9OwxYlcmMIRHeugU6DePvvfj8oY73gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/SOJD09I6MyT3dBVZkKU7DLkeL0WF+RZkNcyD+yXTk=;
 b=DsBJigQLwFuAOoxbwM+W3wta0yex+jYoEGoczfzEZnrzbKX0wd9viu7LVhQk2NsnxN61F+yyOnCkiZMYqNzrr4M3pzbUlJ+W5Di1WSrq8SI5PyM9EErOfwbUANtk8BAmzixnh2iuGj34SsFAfLiNU2iLOkcgdutDg99F+nFMDho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7024.eurprd04.prod.outlook.com (2603:10a6:800:124::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 08:47:33 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 08:47:33 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH 4/4] arm: dts: imx: remove "fsl,wp-controller" since it is dropped
Date:   Fri,  5 May 2023 16:49:55 +0800
Message-Id: <20230505084955.238940-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505084955.238940-1-haibo.chen@nxp.com>
References: <20230505084955.238940-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: c08ad199-aaa7-4f4d-677e-08db4d455e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5lUPdRNJ4ucHtfxULLvVolO15S4swxVUHl8BiYc1Qr12qCDNnIDvEplEM3nXofgHFDcweQ/hhdW37bHGVaIEv/JvYAEbmmlidxK2BS+ksne9pNnW3+rToHsSWE9cq63tQr7T+eB8tnn5+Xn3WhsyoLnYGKbSnX7C3PrX/gwdlAxYL8n1K0I4OICQVhw46enxZ/Ynnvj3NFyw9Xhd1rj2wT0C3sXO3X9BnsoyJwIR2MtlOUfZQGFOckXA+ciC+9t8/SMYG0/I3WESaKIJbHYyB/03Ls7CGLn4qDMzZaEEunMpklmhu9fNWCSWDQ7jWuYynjtbuYLS+lUxXHnxUL+LLARpNbsgyODEUh9mMhi/dheV2wT+KdJMZWT4UQznry62BOmB/4ma38JOzDJVutzajAaX1giydOCev763wm3LOxs0GnIaxqSlQ/tuZrRPnqYZwr12ZjKbqnUogIC/G0fWP5/tYpSMkpUCKvZqxptEprxLhs0D9/xKnflP8bRQ+EC96xDlgZu01lIXZVSyLRWB2EsQo84PxtO0Z3xf1AFST1Y3FqwPNn+yErHOvtbQvdtVKkBubZ3cUKoMgnNFdlocZVv53ipXVGytI5UGo1MLLvnGdZmjE9lTn25adEsg7oH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(86362001)(36756003)(6666004)(52116002)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(41300700001)(7416002)(5660300002)(8676002)(8936002)(2906002)(38350700002)(38100700002)(186003)(2616005)(6506007)(9686003)(1076003)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/Aozrzm8WQ966E3TLXev3gh/R5r0JGXoixQdJL9Z7yH48VNsUr8lyl3/JtM?=
 =?us-ascii?Q?NcdBlHMZupzjxO2L/jy7ub2bu6BEZpq1/0c9jh1CirJewX0RmkdDqhX5gKcQ?=
 =?us-ascii?Q?NPzYo389oRyDMwYE4TTnPSpwrP8cG5ObiVqm/et1NcypueRNJPLCTsBT0zpL?=
 =?us-ascii?Q?0+PEG/scfVNWwQo4aulYOCkxEjnP6S3k3k8ur7/dSqkk4YEGV6ecwrk9rWT4?=
 =?us-ascii?Q?qXHXRu7Yfn5eO+QBshEUB/FJWX7HIRvBgPKetkCn30OZxlgCRRdjdW0aonXS?=
 =?us-ascii?Q?7G1ZTdTsgGeNfBwdDm2hMwTNbZ1rsOCYjBpBM834YIV21hvldlk8ATI5aBTk?=
 =?us-ascii?Q?Jmuh7/CvUTU/9kNzyAG7tyAMa5NSp+q9i7b9zBy9pgN9CkXzRXH8N9++cT/e?=
 =?us-ascii?Q?wI43e47ZzQ4I5tD1VDXhoeurhf0pWZW/42YLd5bjH/LXRLfVWYNdgKV9xFEV?=
 =?us-ascii?Q?WEo4wZg0R7GBae4ut4dxYSWLgrQGb++ClipxH114UftkZ1aiU9rSczbtaUM0?=
 =?us-ascii?Q?1YOkFnix6AY+nZPXV7DguHBFhHvSdRJJezFAD7FTM/59IKmF70sxJYnch9CC?=
 =?us-ascii?Q?wQcbc1qRlzt7VbsEsnMMYK+tIRISKqdjPryyIPlC8vRmJeMmbroairvzvutY?=
 =?us-ascii?Q?GyjmpCNsDGf7oONGVziKioF4iFl2XfXMGN/N1cj4bRJA59O/bgTXuRUfgGG7?=
 =?us-ascii?Q?R8dXy6r28ALEASU3hqs0mmujV9s+Bd7Ttg67DS3/5KMbUIvIXkCEgt/P58wa?=
 =?us-ascii?Q?74JHhCrQe5jAu4ZvdSbo+H4D8u2Z998bpJBeAVB8q3Xa1Ki6vANKpH0Gzju2?=
 =?us-ascii?Q?POvG//kMSOxkSwjeU7b6nrm7WqE2JtjGy6hhM5/pJ5PbMGir2SZiVCjriIiX?=
 =?us-ascii?Q?VR/G55Evn3dl+VgjYvXPuzVq+nvhozZvnRXefZi5P85Fzhrc+3PVPbX/TiD2?=
 =?us-ascii?Q?nVwDGtIc2Q2MaZigeuQraAhv7sGVSU+/6Iht1FwghEhCSRPDqWiQxJRxYOep?=
 =?us-ascii?Q?2L7x0IyaNFXWbWcTrpf+dxRcq+nomJH/fdza7p5L4Px5FyhhhQFjA5GzTdxc?=
 =?us-ascii?Q?CwOny9Vi+F4SFK0YwruN+m1f0y+pVkptZfrG65c6Apy7LqmOfjiF0m1JrrX0?=
 =?us-ascii?Q?TsmmD9WC7sB3TeZNQBoHagSBXK4GVJE4LTX7mcPvCLnpl7BNq/IkuOVAm4+3?=
 =?us-ascii?Q?HKpnEun/XD2l4f/o2UwanaiJ8962MdTpkz7w9k190Dmya42nMfTRAxarz5b8?=
 =?us-ascii?Q?irjomIqm+D7xK9z2OgYQCFGNB9gKqK4UITXMlNFKb7PPHvsqm9vCobZa0jcT?=
 =?us-ascii?Q?fibo5yQZOh+kjzZdk9nB/C1RT6LAL6aAMAiBAabtvJijDKjKusp8WGjmY00O?=
 =?us-ascii?Q?2BFGPMIhVj1DZp92pL/igtmtENsvfWFOVG/c++7bAPpINO0HAkQF8NZiXNIW?=
 =?us-ascii?Q?sbVMxnF9nXCrAH6yTcfbDf9+TFheSKtoCZVXaNHps791rWK2aNI2KlxyGYQb?=
 =?us-ascii?Q?pzkmAy6yN0wFfrVme9uF3b6mOSnUyGlW81ue3XnvF6bO7BSTn9nOYadxv2/q?=
 =?us-ascii?Q?5/3yr44IbnP0dGjyyTcHxaeR3krr5Qo9LK0th68R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ad199-aaa7-4f4d-677e-08db4d455e04
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:47:33.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr8BFT2od5mE8LGBNNckCeGkeLVtFjk5JWbbCqe0HhBxfdbmczoWmHe12f/NCzUitnjwzXiCgcJaJP2A9aMy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7024
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The driver sdhci-esdhc-imx.c drop the "fsl,wp-controller", so do
a clean up in the dts file.

Now the logic of write protect is:
if want to use gpio method to implement the write protect, need
to add "wp-gpios" in dts file, otherwise will use the controller
internal logic to implement the write protect. This controller
method need to config one pin as a specific write protect function
used for the controller. If not do this config or the board do not
has this pin connect to card socket, then the write is enabled.

So now remove "fsl,wp-controller" will not involve any logic change.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx53-sk-imx53.dts         | 1 -
 arch/arm/boot/dts/imx53-tx53.dtsi            | 2 --
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts       | 1 -
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts       | 1 -
 arch/arm/boot/dts/imx6q-bosch-acc.dts        | 2 --
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts | 1 -
 arch/arm/boot/dts/imx6q-tx6q-1020.dts        | 1 -
 arch/arm/boot/dts/imx6q-tx6q-1036.dts        | 1 -
 arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-emcon.dtsi         | 2 --
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi        | 1 -
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi        | 1 -
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           | 2 --
 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts      | 1 -
 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts      | 1 -
 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts      | 1 -
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi          | 1 -
 arch/arm/boot/dts/imxrt1050.dtsi             | 1 -
 18 files changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-sk-imx53.dts b/arch/arm/boot/dts/imx53-sk-imx53.dts
index 103e73176e47..071e8b4b0a7e 100644
--- a/arch/arm/boot/dts/imx53-sk-imx53.dts
+++ b/arch/arm/boot/dts/imx53-sk-imx53.dts
@@ -76,7 +76,6 @@ &ecspi2 {
 
 &esdhc1 {
 	cd-gpios = <&gpio3 14 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index a439a47fb65a..4bef504008cc 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -196,7 +196,6 @@ &gpio3 19 GPIO_ACTIVE_HIGH
 
 &esdhc1 {
 	cd-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	status = "okay";
@@ -204,7 +203,6 @@ &esdhc1 {
 
 &esdhc2 {
 	cd-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
index a5532ecc18c5..63f043372931 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -67,7 +67,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
index 7030b2654bbd..2d24dae7dbfc 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
@@ -63,7 +63,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-bosch-acc.dts b/arch/arm/boot/dts/imx6q-bosch-acc.dts
index 8263bfef9bf8..26794f425a59 100644
--- a/arch/arm/boot/dts/imx6q-bosch-acc.dts
+++ b/arch/arm/boot/dts/imx6q-bosch-acc.dts
@@ -573,7 +573,6 @@ &usdhc2 {
 	wakeup-source;
 	voltage-ranges = <3300 3300>;
 	vmmc-supply = <&reg_sw4>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
@@ -586,7 +585,6 @@ &usdhc4 {
 	keep-power-in-suspend;
 	voltage-ranges = <3300 3300>;
 	vmmc-supply = <&reg_sw4>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index a773f252816c..15956a92fe8b 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -91,7 +91,6 @@ &usdhc4 {
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <4>;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
index 0a4daec8d3ad..9dc92773c2f1 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
@@ -67,7 +67,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036.dts b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
index cb2fcb4896c6..24eba1d2afd9 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1036.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
@@ -67,7 +67,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi b/arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi
index eaa87b333164..f8b985029f51 100644
--- a/arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dhcom-som.dtsi
@@ -412,7 +412,6 @@ &usdhc2 { /* External SD card via DHCOM */
 
 &usdhc3 { /* Micro SD card on module */
 	cd-gpios = <&gpio7 8 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	keep-power-in-suspend;
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index ee2dd75cead6..61306e6da6bd 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -792,13 +792,11 @@ &usbotg {
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	fsl,wp-controller;
 };
 
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-	fsl,wp-controller;
 };
 
 &usdhc3 {
diff --git a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
index f88da757edda..6d2f04434d6c 100644
--- a/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts4900.dtsi
@@ -464,7 +464,6 @@ &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
index 1e0a041e9f60..d4c967971f6a 100644
--- a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
@@ -579,7 +579,6 @@ &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index a197bac95cba..e74fb3171656 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -777,7 +777,6 @@ &usdhc1 {
 	bus-width = <4>;
 	no-1-8-v;
 	cd-gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
@@ -787,6 +786,5 @@ &usdhc2 {
 	bus-width = <4>;
 	no-1-8-v;
 	cd-gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
index ffc0f2ee11d2..18cda0d42826 100644
--- a/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
@@ -67,7 +67,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts b/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
index dd494d587014..7478ae7535f4 100644
--- a/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
+++ b/arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
@@ -71,7 +71,6 @@ &usdhc4 {
 	bus-width = <4>;
 	non-removable;
 	no-1-8-v;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-0011.dts b/arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
index d82698e7d50f..5a2e8edf149e 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
+++ b/arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
@@ -63,6 +63,5 @@ &usdhc2 {
 	bus-width = <4>;
 	no-1-8-v;
 	non-removable;
-	fsl,wp-controller;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 70cef5e817bd..62c96884bfda 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -575,7 +575,6 @@ &usdhc1 {
 	bus-width = <4>;
 	no-1-8-v;
 	cd-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
-	fsl,wp-controller;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 852861558b47..7e983c52ebcd 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -91,7 +91,6 @@ usdhc1: mmc@402c0000 {
 				<&clks IMXRT1050_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <4>;
-			fsl,wp-controller;
 			no-1-8-v;
 			max-frequency = <200000000>;
 			fsl,tuning-start-tap = <20>;
-- 
2.34.1

