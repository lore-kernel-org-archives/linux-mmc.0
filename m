Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95577C43217
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1F60F9F
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJUHQh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:16:37 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25888 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhJUHQV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 03:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634800443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uNfU5n6gIiyZCQwYy1AEH18Z4Cg6pOsHo1y7Iyoq3A=;
        b=m4jl+AAVg34lMJheSbMm/j4uYClR0rQK57o1PMalC1MobmIjBdcnCezhTr/T+XmyipXCDT
        5z6Drb2FH4S1vGQpw6xyseFP0yT2Ngh4I0jRt7ZH0ZCgHF/EBBM73SEg57Urm99BuchYOX
        RtIb8zMLZhBE6lJpUiknbwXYFuDVFeg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-Eo6sDTlnP4-WjxRHqGhQFA-1; Thu, 21 Oct 2021 09:14:02 +0200
X-MC-Unique: Eo6sDTlnP4-WjxRHqGhQFA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huoE5jHUg9S0MqxsZLjq0rkUpkxXjc6FMpCG8Rx60zLkdPWZgLSOKGQxDD+Yq/lOeTM054RbT8c3sk+sForHYMvjnkFtolw5Ey3Pm52c6TFECURrxbn9+iEVS9Hcsdgl3gNFVeSoThsl3ZVui9wu5YIN1NyrPY6LaSVBW7348F8lxYTwn1UrT7tm3qVEeU/LESo2+tM66LC0T/Pseq2a2h4g3+jGCymY2s1ugQaC+nvFWKcSxK64HooezNWVp8UH6fvXBTCjM8bUpLzkOmSW5XWikLyHx0q3ALrzbMcfagsY2nT3bqVADAqHKkersxmeU66BdtHUFb72xQ+5KRjA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwZV4JFI3uKHl20TnNkeX+eP+5cllUDV5bwlbhKzkJo=;
 b=MhcRylKEbaHumrWCk4+4hABf5Xyvnombu0rvrxMgqRBGGslF/XxRg+2dVHCXrs2Ewdw4N2KAryi1OPMeEUblWmlhwVT+aYrX9U2xa/L2R1I0pgEJ5V6/1EoESWPRBX6zlnPvAtDJqTWRvP3qHfJ2VMxL49bdbn5NP9j2ValxSUEj7EAEP9QOh0Y8w6srRDJyyRMKTjehYXdxWz2L3ICQQ4zFq4ZxH5+WhbQcPCrX1/oCXk6QDn4xMjpm5OSgVuyz4/0ldF7LfGsEEyNngYddGAiWNhW6ZGTzSg8i70qkXscBIuOdiWnZDjbgCf+O6hIR8GACPTr+F9gwBkaBLc+vTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 07:14:01 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:14:01 +0000
From:   Chester Lin <clin@suse.com>
To:     s32@nxp.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 3/3] arm64: dts: s32g2: add USDHC support
Date:   Thu, 21 Oct 2021 15:13:33 +0800
Message-ID: <20211021071333.32485-4-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211021071333.32485-1-clin@suse.com>
References: <20211021071333.32485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::30) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from localhost (118.166.56.207) by AS8PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:20b:311::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 07:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b803e789-cc03-4058-4ee9-08d994625b27
X-MS-TrafficTypeDiagnostic: VE1PR04MB7248:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7248F01780FD772105D28084ADBF9@VE1PR04MB7248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3QtaweZVZG6s2n+/3ryFFx0IE/BSo+F/nOIBK+Gx/ByDZR0040cQTzx3Wa01wu+VkhMb9VEZhO2Nw8pQsYCtOsd+HxLz3X6C8mo6MZCjznUDgTt9E4dD8sgXRmV+HpVF1PxG1PNMxzHJjjPfQEKIPVP+OzEeqpnPtXn1n0Ye/Nza5qcxYyBKUYkzDw9rimhD8/k4ZSOnXGCrrJ4KRfOBceVOM5RwR3qlBweiFOQUeosHgy1s3qmq86bvOVXN2O/6+D8Z1kRis86MJKrUCmJ5gylXCjcrIwpM2u6vXsdmUzngTylKW0SiJZaEKSIv3hMnber+H8ESewrUL8e0HZ1K6zBM2yZ7naud9zDsVY9jXvMeTsb16DRy2z61O4QaxbDrzNgkDQLVkUoggRwSwDHMIXYzN1BgNQ1ehq9zW/2ts+BPS0yU/yGD196RIiMcpYS1KmBv+IXdve1MBlFWnl+7Gkf+Bis9DbV2K9GMQJqgjKKateA4YuJfI2equxf46Hs+faLXNG/C7WTArPUCo4Sbf1GdYqzohRfSJCOpaJ0cZFyJsGuJuRav6bLpF6JbO1Qv/96JBY3hLK82SQr8FCsN11RO50Mca+Fe7Sm9Xu5kHLvOEp1L2UhXMlzFzVswtQFAYILoOMQv4Exrxt18X4cnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(2616005)(55236004)(2906002)(956004)(8676002)(7416002)(38100700002)(6486002)(66946007)(36756003)(5660300002)(4326008)(508600001)(83380400001)(8936002)(1076003)(186003)(107886003)(26005)(110136005)(54906003)(6666004)(316002)(6496006)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmVZ2kpkL85WgF5EN+rDoZApDjw1eOyDRgNTQJz5XCHBamU2BZAdplBeL5HF?=
 =?us-ascii?Q?MiLRQHxoRhTXtwzDWD02O+FEYrIrmnBkfMVHbmEDkG6tLQEphxgsA9deuTcl?=
 =?us-ascii?Q?ZD3g8jQZSuQyxK+aD4WRleH4PF/0H7kdCtJQ6UP8h7nIBVD8qpcxCt5k0UcF?=
 =?us-ascii?Q?+SHvgE2wDJyXA0M4VYWJpaxi1GzbwAOxaQ+FVJ4i0oeq/6h40JOYk4bBtrAG?=
 =?us-ascii?Q?VyZ1qlLOpU25LPpnETNIMpXFkPufuQOiruTDYtiL3GX5zEiQxujFvHLwX16T?=
 =?us-ascii?Q?vmpk/CZyzbEwY1WwDrT9VB3bv8O/M0thZZE5XKLUqMa5WX54OU/pATFrwzaB?=
 =?us-ascii?Q?mpvtHgQ6TD36idNNCtUDoyvFWfnerKWlwFXK2CO7QF+jBs2LqhSyoSVZmUTY?=
 =?us-ascii?Q?WLF0ajXzSw4NROo+/VdXlnUZ+CqBZOKwEbr8N5i3l7JlkKbAFmDtgrJB7vaY?=
 =?us-ascii?Q?7kvd+XXOqwxVxb8DiTUunzeHEe86Qk/g3CZfUH63Wlu7iQwsqEq8WaHpXUCw?=
 =?us-ascii?Q?ZSjKVtiZP+zhnGaiJtwtIY0LeBq2kE7Tfa4QHWwnRSj0oz8izax9CR1IViI6?=
 =?us-ascii?Q?iCKLhP+wRHnSAzPq/I6vBrAjH6izfL9blhDaJppddtiok/Ba3s85Q6b7BdeG?=
 =?us-ascii?Q?mIkpNhPFWoq9Te8FaQZS/gto1SmJHyEEKqZLh5BRFRxEm4VuV/G3RCfrJgpD?=
 =?us-ascii?Q?nJ+84HZSFnp3xn9uFBMIsq8vTPkbLyCQB8pgVg435Q0jRZEgim5CxoyfkZbv?=
 =?us-ascii?Q?xvReH18sS48Jw15iOXUMC8kTNLNiCyZrc+einQ7e+YdVI2qk6rO6NwUSo7Vk?=
 =?us-ascii?Q?KLttUFhhqaOM19zgPV3OfUQEh2P3XcjAdKqwMliwacrDf7T7u+wrUWzpkYZa?=
 =?us-ascii?Q?LERj/KfZOoKx59HuhfA/TC8JFKvWEF7HzM3e+gqyHjuSn3XrzfmyMGYG1dG/?=
 =?us-ascii?Q?e0WVbQosZJBXuehylAP6/eMVlBZx2j33OIizTMF1LG3c/iDFbyB+juAR87CK?=
 =?us-ascii?Q?8h26BppRgnX7pSDykO2J15PDgHkV13t1HHwIvFS850F6EfPcRzCouMac3V1q?=
 =?us-ascii?Q?t2cN0umiD3f1ZWR4f7DrzabB7aKQw4zvs5YNfPAY6Fm/TIbgqBxPjVqyPaZt?=
 =?us-ascii?Q?27Np6Xrz2tfVcaWlYWZqbJBOM+Io5ax0x3kSBhgiMUOE9jBH2ozxiRKGbWDO?=
 =?us-ascii?Q?amNkkPvH/kv2qOt8/wT1A5ybNUh7sCdzVny3hLe408gN3/22PuUgv2J0328p?=
 =?us-ascii?Q?UtNlSVR9kriuPzZFIdus7WhYeh2aIZFSPjQibZt7FcMddah3f2/hcfF9rKJo?=
 =?us-ascii?Q?d/6uBUCUR0pLajj5Lk1KmKUB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b803e789-cc03-4058-4ee9-08d994625b27
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:14:01.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a mmc node to support USDHC on NXP S32G2 platforms.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 32 +++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 +++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
index 59ea8a25aa4c..19e2e2561374 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -79,6 +79,26 @@ psci {
 		};
 	};
=20
+	clocks {
+		usdhc_clk_module: usdhc_clk_module {
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <133333333>;
+			#clock-cells =3D <0>;
+		};
+
+		usdhc_clk_ahb: usdhc_clk_ahb {
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <400000000>;
+			#clock-cells =3D <0>;
+		};
+
+		usdhc_clk_core: usdhc_clk_core {
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <400000000>;
+			#clock-cells =3D <0>;
+		};
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -109,6 +129,18 @@ uart2: serial@402bc000 {
 			status =3D "disabled";
 		};
=20
+		usdhc0: mmc@402f0000 {
+			compatible =3D "nxp,s32g2-usdhc";
+			reg =3D <0x402f0000 0x1000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width =3D <8>;
+			clocks =3D <&usdhc_clk_module>, <&usdhc_clk_ahb>,
+				 <&usdhc_clk_core>;
+			clock-names =3D "ipg", "ahb", "per";
+			no-1-8-v;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
index 9118d8d2ee01..89428f1883d9 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -32,3 +32,7 @@ memory@80000000 {
 &uart0 {
 	status =3D "okay";
 };
+
+&usdhc0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
index e05ee854cdf5..30eae51121de 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -38,3 +38,7 @@ &uart0 {
 &uart1 {
 	status =3D "okay";
 };
+
+&usdhc0 {
+	status =3D "okay";
+};
--=20
2.30.0

