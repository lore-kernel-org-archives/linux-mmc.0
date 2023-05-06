Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598FCC77B75
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 07:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjEFHiq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjEFHip (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 03:38:45 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B45E46;
        Sat,  6 May 2023 00:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipxnnO2EzEZN9tG5yISamuzrJGFy+pvidmdn3SYwbyLKxQRfs/M4TLBxevQOH7/fXhuHh8W3lmfGEGK33ZSGFcT3PPppFrNjSuTTIe3mEu+tv2g/QWE808cyCHNQENNnIPYpUA+SpQ0C0aRCqBn2NgcO6VEYU/Hk2s2FphmIJ/7ViTdzokqKxzWOocgwEtBxPQRavgLCNHvwOnMhQMeEFKVBquKFypOFhWUrmsw10Eon/san/eHOEj1dolu1Pcya2LuEtyDh+sTYNE5Ru+70j0p2clAjwk6pAMulp+pOLf+fcCj153AzfgpgswK+bcUFokCPWzI8sjgBrZUlsXbUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/SOJD09I6MyT3dBVZkKU7DLkeL0WF+RZkNcyD+yXTk=;
 b=fsI2MxxjkyOp6y3jBiO0xkVfG7NjfcS6RnXjX2u80FT6zZp6J99QH5nJP/HA+9QaIib+KTeG/n6+wGewzYpm2fCBmK7V5gSmuBFynAae34zobILjjiIlcITcrurDR41VQpg56ORpa6tZlznYjXT0edkXbKSwlBflt2IDoRRP6mMpuWpBo/gEjkbpL9YEAxvpnNP9xzd89th22/zHt7k7JFcP/xqxjeEvxyiRhblSvHgWNFXZsYbLb0ElmfVLfdlSQHRzVdaf+c2ho+bgXkP425GCrtgd0HonkHQhm8MeXxKOcRiIxKQC5nCg6Un/ebONiDhWSWWrq3Cig6qA7SVPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/SOJD09I6MyT3dBVZkKU7DLkeL0WF+RZkNcyD+yXTk=;
 b=eH3TKUPDt2D9YaqkPhw3xDgEc1hCVALScRvcpyEVn3k/sXowXSbrUGnYT5qN47OoNM8rPjnClg2Jybda2RCJBJGW1597OvFz44Se0JE+pOr4vmSCJZsFwmLeoSYR0YEIL/SciX2A6f+8e0IErsLYlcxPJhaWnLz0O+e+IBnNMcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 07:38:40 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 07:38:40 +0000
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, cniedermaier@dh-electronics.com,
        devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: [PATCH v2 4/4] arm: dts: imx: remove "fsl,wp-controller" since it is dropped
Date:   Sat,  6 May 2023 15:40:37 +0800
Message-Id: <20230506074037.522961-5-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506074037.522961-1-haibo.chen@nxp.com>
References: <20230506074037.522961-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: a8660c82-45c3-4cf1-d90a-08db4e04e95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvKqdAOIGjWPLaikFDLrIVOarc+RWF6yitAMspoZz27MrA6xZ6CMqEtufs+fjo8ygkETnJW2t8VUV5KbVdmvHhEtE65VVZq+t1spRmRZ3LpkRwNmpaTaq6K+vRVpzlqxEQhFlLiaU2gJPA3d3IiDEvHo9tGTCSoQOhm7069MHiD1+XFXeeFZwb3vcuirGJxkYpNijlv0Z64KXmLAWOgfoEJAGbjHAkZi8jXX4wreJX9HaYrrq/v0rD9JwCYpLs6qQk+YGNmyfqxOe2JL7Mls9Wyn/sq4UzQ245+GTunblPP8j7ByfkTjiWSG8r5n2fYUrd5Lj1BjMcGSZZF/cxR/yWJ6ENgmRJwRzxY7MWPMvGXXehjCg3xyeqyT7Q4ZZQqvQNBwJ3EXBcZWY4eQUneLvAr6b4VitWR70BorsI0ZOxgD9O+aFugAA/0pUhDt1S4znMvPGFrl2D7JmKSTMi4SFLCjfO7aavdL22xjX1OqmUZMG8az2MrFVSl4dBBrfyQTFEZzjx82C76xfKLwWasMQmc0PhiLXPETSrzL1msXtDMqrA2E4emw8n0VsxNGr8fbwkpNn/cu/UGE+xD0ft7P5iRO+fzgPOEByLutWH047xP/yUpHsd/PQvAdeOl0Pc8g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(26005)(41300700001)(2906002)(186003)(83380400001)(478600001)(2616005)(6666004)(316002)(6512007)(6506007)(1076003)(9686003)(8936002)(8676002)(7416002)(86362001)(4326008)(5660300002)(38350700002)(36756003)(38100700002)(6486002)(66476007)(66556008)(52116002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRCu8SANe9pL3lLhzcBn5El8R4mCfhiHxJoVuC5l5jsBkgV0crv2e2K3az2I?=
 =?us-ascii?Q?XG6DwVmDOyh9FV6rE9lpWbSVsHpQt2cyow/EawXx6cm5JStwC9DpK1T4WcCw?=
 =?us-ascii?Q?18L1RN0mnbzIYb9xjtDkZ3NqYehsFNNbxsQ0/EMS9f4NKAJco3mRiTUoYwrk?=
 =?us-ascii?Q?jrnt9w2umC4HndtqXbtmb7UupSXVHQo8ZPTuIYwL61wbVtemxiW2v9Wy0GCs?=
 =?us-ascii?Q?e++dO1Dmz2mTw34vBSyRadGOFGTQi6EyMqVeeGU4jI3Xj7pddo9iXyrcc4gB?=
 =?us-ascii?Q?sm01SzURZdSYsMFzHl4V89B+VapTt4aUG9/MGT123nRO21t27Sz3TLQqhXIl?=
 =?us-ascii?Q?GPfU0YGex4DwyPCU2L7pOoFtQFa94HwhgIpHcl+5IPMAwvSGwK9+LzJuJZga?=
 =?us-ascii?Q?sqwqvSbKmIbfvHhL7Jl/w/uarz9Cbn5Z9AwNzYXYKDygJ5Z343OY5rXS01yI?=
 =?us-ascii?Q?UUzIdGyPfBoS8mpG5dM9DUVw0be9L8QBwJV2lOp0W02Yms9+CZCKIY0uMlIe?=
 =?us-ascii?Q?FbNbNhoSiO9zl6vnj4iSv2XCV22JAFKwEiPZQmy49gunLzAjcf7BUev4BXYO?=
 =?us-ascii?Q?oDo192SYvUtGpl1c6UmmAvu/Uq4sgdYmTij93sjoAbsQA3eGcssGCfmx5ssF?=
 =?us-ascii?Q?hhzE0wXGp7SwaQub36jTohvaaCnirVWwdTPUyjGV2FD7wIDU/NorB8I4G7hK?=
 =?us-ascii?Q?KFKfL43MpxTvgvHXmwXr36vkOFay+Usn7Bw1jJlXir82oKnPwlKQAUK3u9J+?=
 =?us-ascii?Q?V0p7pmY+gWMBi3gTZoDXNeWNNZxR8LFAZhow0pSXEiQcsY8QpkCrrwM8lcCw?=
 =?us-ascii?Q?Gtj0a1BJ28QO/XCReADdkeVugXiJ/lewXCIgPC/BxTdaz5d0GgI4bx3RE4zL?=
 =?us-ascii?Q?9X9u8pQ9KgoPEcDwLDPMld6r1hARw1rIHWWdQ4zK5PDznG2m0P8ZA93Hs4D1?=
 =?us-ascii?Q?Lph6K4O6WuWUx+OL6Ujoa4s+njFrrU+XsfE9+8iPBitO19izZCr+wkrnskiT?=
 =?us-ascii?Q?oj/41cMLLibPf4abo7D1Qm7daWJr+0uNZzX+NbcrP+KBIGyzhEJIbkDmjFZ2?=
 =?us-ascii?Q?gOEDESlxb2tbpkBMCokCkes+tfliJIkvIGMTMpI/cgLcFajlEPjScsLD4BGe?=
 =?us-ascii?Q?Eo9j4KZdgIaXlWhUvBX842DYedFBW+4G654l6sVKlQ/M1MZ6YMBPN0ZdJZwZ?=
 =?us-ascii?Q?DvhSiPDME0P3V6h5FtCvD/wDOKQ7J1djhFElHrXbZAlcLKVSPLodnc4/jVA9?=
 =?us-ascii?Q?beLr+iROBKFt43nan0kGacHgNwlZRFsgLS1AZ1c/Oua1+Kxg6zFxKxk54myu?=
 =?us-ascii?Q?RBJAs4WOKsB3sPty8L7Q4EGVlMJTrHRj1uiRAe3tpc4u//pCeQxU2kp9Jt4N?=
 =?us-ascii?Q?Pnm9pcw/g4kTuZ3EgPlps6rstC9fd3agM70m8N0Luo0/CpxL3w49ooHmqZO5?=
 =?us-ascii?Q?BZy28iEXoJ5svK5LoWYN7PMWjqlaHfXqNde5xLNfO0QCkSalfjTWRh0dbs6F?=
 =?us-ascii?Q?/jeEA9LsBFQgqAmSishprga1Op8YaBZWS3zyoE+A/mgAVVkeVXE2vY0Ifvqt?=
 =?us-ascii?Q?CO20Gb0aK7nbw3oz0KCq1m2PhYKfu1gmYFWIBm7O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8660c82-45c3-4cf1-d90a-08db4e04e95d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 07:38:40.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KTgo/Rw6iNLmqK4I1fnbx9zh0TSeDt2cEhEKe01E7Bdv53GXtggT5gEAcg0dj2D11FNFohwLpZEyuuvwM3x8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

