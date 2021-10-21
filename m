Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B628C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614A56112D
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUNfT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:35:19 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:42368
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230393AbhJUNfR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Oct 2021 09:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARsGhWG/mEski5CgRegDa75FXvxYW6tmXFBGBKvDOTMy870l3dDjUyct1rTvDZuinMgb3GkOOvlTmXImua9kK4AHD7bj2xq6QX2mkBq3hPcLEzkKRg5DM11ifsHEuYxwvVq8X6+wxz21MKnhTVHUZWrvokkVVNWScGmy5uJC7iOPV0WLDV0g1MCmrW04YQC9VA4ziAYKfRFkbeBzNuSQe/ECdY978n1iJEnvLKMjyZfahlsNonnd8cUhf0bUWRc/v30BjFnXE27saQmtNI0oQDcD13OAk/gVmtlaaI86zIK6lPMHj1cLxSwsyd8gmB3kEQJTONIgox6foXR5J5T1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCrAJkfFWnZZcy5cMJxjWW8wogxNsDnCrNlWlXoFDKw=;
 b=EHRYjktxymcWilhu3PqGCmtNrohamXDUvN8BJPJ3IOzTkO9NldaAN1E7nAi9XGTNvca/zVYS8REaSmgl3mg9hDW40j2SP6KHtfOmPp78caHwxpieMB5hbajJVNaVUZnJL9P9UvyvMhqITBJmVMk92bav8k0fZ4IJzNrehkYqiAVVEa/ia8dkv74nP/T0eq8ghpbK1IUkr4VGlV+tyyznvzRdZ6XTaNdBNMpRLcJi2UyZ6TR3cEQP0al8WoEJbw+QF+SjgAxVHc4Uyoqu6YA2svYIBRCM0Kp1gP1k9oKr622iq5zf0kRgvzPTTNB2kJl5nAOhgraiIdQY9h34Tjvh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCrAJkfFWnZZcy5cMJxjWW8wogxNsDnCrNlWlXoFDKw=;
 b=ELOQJzMqk0Fhu5UNMN7xTDIlnCnBuLEdaNbumGWHFk+wgrB3aaI1jk0Kq0g/cya7AH5T4d21JvPITXMDCLodHvI+FmF1rYZXBtCVx9SBfWqvkMQXUn+XAOwFydtnVCuQC2MggWU0SSXv/1Xn7BzwNL5lagxsbkb5kGQevf0Es8Y=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com (2603:10a6:803:5f::31)
 by VI1PR04MB6126.eurprd04.prod.outlook.com (2603:10a6:803:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 13:32:58 +0000
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::4884:f408:7c51:bdcf]) by VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::4884:f408:7c51:bdcf%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 13:32:58 +0000
Message-ID: <7b44bbd45bd6ab4c3815bbc6266d51ce5187ccab.camel@oss.nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: s32g2: add USDHC support
From:   "Radu Nicolae Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     Chester Lin <clin@suse.com>, s32@nxp.com,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Date:   Thu, 21 Oct 2021 16:32:52 +0300
In-Reply-To: <20211021071333.32485-4-clin@suse.com>
References: <20211021071333.32485-1-clin@suse.com>
         <20211021071333.32485-4-clin@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To VI1PR04MB5101.eurprd04.prod.outlook.com
 (2603:10a6:803:5f::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.141] (89.45.21.213) by AM0P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:32:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 851c8a5f-9c6c-41d3-bee7-08d994974b9b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6126:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB61266969E9C50B98C5B24E899FBF9@VI1PR04MB6126.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOrm7imr6dEPq2j7Ak6ic09h1gBm3tHKOnq0BpNh0V4fgdrqek62xLvvgtvSI2Jg12UF1chhs0JAgQfgMBcjrSkEnlST2yNWNPPtkT7r0zIGfOS1PlC/8X+Q8FjRfvskm/jsFEVMKZGqmDNcUKugkZfRoybwUrm9rDi/Z2ZOFJfAKtOdHY1Daxi+AFGy4vfIYEt/8QYELxeBShG/OrdhQpgWupdiCuJ/EcJERXzgBTa8EJeeEXWNVh0/uZa4nGewiDvLG2FQu4KcshqWIEMCp2/PyDN0mp3yExYcjk/VPyQz5+zYmNnSsedfp+Cd0R3IrJAOs/lsWwPKQy2oGXVFOu+NdkoiusOriBsgfUCiwhrZk7UWXIJU9W0jaWE86w4j33plXbzknL5fsC3AHw8R9GVrwm5/BkzRH+rsgDTUHh/Xlb7XQGVUDiFhx/N3MOlTuXy2w7qHAzRhOXMhKScBBOzivlysqf3cMKhHIb2KjU/9Wv2OqZqv+NCI+qLmD77YhdjUblElO5r/dOXiI7jLYzGBcJmbTfdQvVM1JehOPtYMwPEhXfrvQShQcMrQsYzw83wmT3reB1KP+g0fjJ5r4L1eYMXEVqCinmULq7QID4eHtkksgWL57U+2iIbI9OI3SeTfdyKKiEjtXNX2+FWFD8ZagsqnMqezhtv8/woxFUd+RDLLnglh+AnGCpozxRYlNNIIrcflsXzogHYl1wVl2pnu+kRcqVdvs6pJj6cjuUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5101.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(6486002)(26005)(66476007)(2906002)(956004)(16576012)(4001150100001)(2616005)(66556008)(54906003)(508600001)(4326008)(8936002)(5660300002)(186003)(38100700002)(86362001)(38350700002)(7416002)(52116002)(83380400001)(66946007)(316002)(110136005)(8676002)(41350200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkY3UDU3SlZyODJmcWp6YUlEMC9IaWs4VlN4aFVYMldONFZXbkc5NzFwcmM3?=
 =?utf-8?B?SjVkLzZWRkloY3h3ZnNtYk1Da0RpZU41Zi9JN3ZBWTRjdlJYZnBHNE1TOVFY?=
 =?utf-8?B?bU8vVmFqdFhzTnIrdGY0YXQ5UWpCWXVKVWRlS0lKdk9IOXpHN1VJZWowM1Iw?=
 =?utf-8?B?eG5SenFHNkxzZGx1NURxQzRuV24zTlJtNzRWV3FPTnB6UUwvNmdtQUVvenBQ?=
 =?utf-8?B?L2t4N2pPMkxJenBQbjVYcmJxUEFHdTRTMXZGcUJsU3RmbUI4dHY5dU5pQ0Jj?=
 =?utf-8?B?d0RBTmdvNDZkNHY5UWFBOXFVT1RhWW9FcjBLZnJZMUY1aGZQQW84aXFsTzJ5?=
 =?utf-8?B?dkxEZkFiSXZ3bkF1b05NRm9lbVNrbyt1RzVKVHVtQ1RMUGF5SDVWeGREZk5U?=
 =?utf-8?B?RC9QSHBwRUNyd3R5YlFjQXJWVDFNQVRNK1Q1SitRVWg5TUI4RmtGbUpxOGkz?=
 =?utf-8?B?ZnNyNGZtc3ZGYU81bkR3RTdnREEvVng1T0ZRTWFEaWhiM3dwUm1UZUpaZGVo?=
 =?utf-8?B?WEtrMFpWTjVQYTRyVzdKdGp6UzBCdTNOYTBKTTUvQUNBS1Z0VFhPMGV6R24r?=
 =?utf-8?B?Ly8xUEN3WE50UnhiY0swNWtOaGtYWU9aM3haMlRVZXdUcVBHLzJ5anVyMExJ?=
 =?utf-8?B?K1NXMzBaSURvMlBxaTNPbHc3Q2ZXRGZXQlA5UDRxU2JaV3NRaVplcktvZndw?=
 =?utf-8?B?QnVZRTFCY1c1YTk1aWVOVGwvaXc4dDRqZTlscSt4TkNUU2I0V0lnMm8rWUdy?=
 =?utf-8?B?aGl4ZU9zcUN4Y0tZRGRTTXF4ZHpwUzJ5UE9qUy9Ga3NuUHBHNjJ6cGREOXBY?=
 =?utf-8?B?RUpoUmliRVJ1dDFCM2pqTVdad3ZENlZnUnBMcklVNGNWRVRna2xSbXR1UGJt?=
 =?utf-8?B?SDgxNEhtWVR4alVPajVsMHRNZWlCaE9XZzZXdnRBa1Nod2VNNXA3ZVZOWkto?=
 =?utf-8?B?SG5rWVM0ajV1aHBHbk0rZXRtODNBVHFrMk1jVXdoakJHYjBvRDdOTTA2N2Zt?=
 =?utf-8?B?d2N6K2lFeVlyREMrcEhzYVdGKzhMcmxtY0tyV1dMSnYzK1BnMm1kazJIN3lQ?=
 =?utf-8?B?Q1NkMkFCcE4reW5QL3M4eHpJck9nZ042SnpjdE1QR3RDT1RpK3gzN29ZWk9Y?=
 =?utf-8?B?TmhmdnRlbmpmRitna2pOZmJuM3pQR3RnNGJVN3dodHNOTUVqeUx5dU1tSG9V?=
 =?utf-8?B?QmlsbUQzWFZZSCtXSXZxRWs0VWRReGdMd3o2ckZUL1ZZamtTM2xyaktMeXFY?=
 =?utf-8?B?Snk1bFBmOHlaNm9RQ3lKT045OWNLRnFPWnNBeXQra1U4d1FYU2JhQ2xoTTVP?=
 =?utf-8?B?cEhaOGZmNVhBTUlxQ3dBbWU3V0N0d0NNNXZOSXI2VE54d0YrU0VHdkxNZ1NF?=
 =?utf-8?B?dnFJWmQxcURjTDNQR1FNbU15TGtOZ2l5RHRBLy9mTU9KMVhGSzU1dG91ZDZR?=
 =?utf-8?B?aWZVSUdKRlNXZHVhMnB2KytuUjlJZ0ZBUW9rSkF1RXlsREFBVUtBeXdPdkZm?=
 =?utf-8?B?dm84TmduVVF2SElxUERvL2NXNlBqc3gvRVZ2V2FUeWpNRW8xdDF4WlBJdnF2?=
 =?utf-8?B?NUdNY05uTGxwczluTE96ckd4dFFxWXpVUTB6UFFINzF2Q3RxY3c0d3g1TkV5?=
 =?utf-8?B?aUNqdEhScTRQVWRLem1MZEJKMFBOQlRKc2V0V1J3c094WE5aVm1pb3BJbjdr?=
 =?utf-8?B?NXQ4ZUxyVXhCS2pTRzBYdSszaHBNOXpYNDViUi9Cb05MaW81aThyUGo2NSts?=
 =?utf-8?Q?kvqmPf+w/B7EleVuV6ZxKJuzRNvasdsKyCDHdWQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c8a5f-9c6c-41d3-bee7-08d994974b9b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5101.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:32:58.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: radu-nicolae.pirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Chester,

On Thu, 2021-10-21 at 15:13 +0800, Chester Lin wrote:
> Add a mmc node to support USDHC on NXP S32G2 platforms.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 32
> +++++++++++++++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 +++
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 +++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 59ea8a25aa4c..19e2e2561374 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -79,6 +79,26 @@ psci {
>                 };
>         };
>  
> +       clocks {
> +               usdhc_clk_module: usdhc_clk_module {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <133333333>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               usdhc_clk_ahb: usdhc_clk_ahb {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <400000000>;
> +                       #clock-cells = <0>;
> +               };
> +
> +               usdhc_clk_core: usdhc_clk_core {
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <400000000>;
> +                       #clock-cells = <0>;
> +               };

Adding the clock bindings as fixed-clock doesn't describe the hardware.
Using fixed-clock is suitable for quartz crystals and oscillators. Here
we should have the bindings to the clock driver. Are you planning to
submit such driver soon or you will add here more fixed clocks every
time you add a peripheral in the dts?

Cheers.
Radu P.

> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> @@ -109,6 +129,18 @@ uart2: serial@402bc000 {
>                         status = "disabled";
>                 };
>  
> +               usdhc0: mmc@402f0000 {
> +                       compatible = "nxp,s32g2-usdhc";
> +                       reg = <0x402f0000 0x1000>;
> +                       interrupts = <GIC_SPI 36
> IRQ_TYPE_LEVEL_HIGH>;
> +                       bus-width = <8>;
> +                       clocks = <&usdhc_clk_module>,
> <&usdhc_clk_ahb>,
> +                                <&usdhc_clk_core>;
> +                       clock-names = "ipg", "ahb", "per";
> +                       no-1-8-v;
> +                       status = "disabled";
> +               };
> +
>                 gic: interrupt-controller@50800000 {
>                         compatible = "arm,gic-v3";
>                         reg = <0x50800000 0x10000>,
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index 9118d8d2ee01..89428f1883d9 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -32,3 +32,7 @@ memory@80000000 {
>  &uart0 {
>         status = "okay";
>  };
> +
> +&usdhc0 {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index e05ee854cdf5..30eae51121de 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -38,3 +38,7 @@ &uart0 {
>  &uart1 {
>         status = "okay";
>  };
> +
> +&usdhc0 {
> +       status = "okay";
> +};


