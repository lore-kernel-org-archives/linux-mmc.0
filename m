Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466926121E
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 14:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJUOkv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:40:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50501 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhJUOkq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 10:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634827109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmKMeltsmd9H9QVthL9m0GwkM9AzdQSzndoNzQqiuOk=;
        b=Fxu6YPtZmRAsiYBR82dO7z1KKvAyXP/aMvutPaCHDcK9Wc3vkM906ZcObw0N/Kb+22hqJ2
        7c3K3EXVAeOQjNbKVURS5ms6X2hsLEo1YiluCLrTMSyB9u/+DAOMB/CkcTp+vguqi3urPh
        GC/D7t6MjRyPODxQakvB7l00a4U6rdE=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-T_h0X1DnNuevvBRtw2_37Q-1; Thu, 21 Oct 2021 16:38:27 +0200
X-MC-Unique: T_h0X1DnNuevvBRtw2_37Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIRiiZ2l0w1zrNb3NQw2US61okq5CUydVKCyLE5+HOSULuzrfYqwN4T5IwqIAQrFuY4PdHAE6w0fmOY+hEMaaAzNy9303hHWbWLy1N0jsu0vH2osntPyipWxYXZp7hWbuN/l/E71mKsnyuLu3S9Fauy3y3WeYBIHnD5XLXmpuhRTQw1fIQP8smQpnmFJqwAg7YeNQ4OTXp/MzR3b9wQnnqAgqZybeaDyUyC3HgGjV4B2PF61NS2x0ADAyydTD8TTRcLznXnr4wcXjCFDxvvrVV5OgyyO5ddh4uGtAtjqyu7bux9ZchR/y+fRrgbE8HUb2VyJGhIruenBma3fgktrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy4HwgaQTkFHFrab8EGXN+FaChQKQvWT5nzgm+rHOuk=;
 b=c0crxHCjMyTKOv7kSca522YeVv6nRtuB4Hmrx18pKhPYgjluGcHTSwbrwGN7jwOel8kNEyDGuuez/rxOr5S93mrcyoeWi7WnCAdosgboop4AvJM02SxO8zaLAatFIrS0jC9vfT89sXprZ6JBgmJgjLqwMD0ptwz1K4jJCMByxhaSfWnSQrAzdWRUg4VDOLXu17mauQCsBPdlqhM4sLZevJqge4otI7bQD21SVWaT5pJfZ8l+zYOYqfOTBpyUx8cdV9WnwSeOFSzGhsH3WU+jqVyXvj8GBRvI7YbwO1TJVWIVKWT195xc4C4eDYIIWLAYqj9AR2VKC1zaZRnM2OmQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 14:38:26 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 14:38:26 +0000
Date:   Thu, 21 Oct 2021 22:38:07 +0800
From:   Chester Lin <clin@suse.com>
To:     "Radu Nicolae Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
CC:     s32@nxp.com, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH 3/3] arm64: dts: s32g2: add USDHC support
Message-ID: <YXF7T1F3Lo2agRpz@linux-8mug>
References: <20211021071333.32485-1-clin@suse.com>
 <20211021071333.32485-4-clin@suse.com>
 <7b44bbd45bd6ab4c3815bbc6266d51ce5187ccab.camel@oss.nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b44bbd45bd6ab4c3815bbc6266d51ce5187ccab.camel@oss.nxp.com>
X-ClientProxiedBy: AM6PR08CA0036.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::24) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from linux-8mug (118.166.56.207) by AM6PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:20b:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:38:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdbce505-2e44-4601-4804-08d994a0710a
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23686AAF82555FC8DF72E213ADBF9@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rNwYo0nb2s2ulIb6oyl6V6dz57EosfcP0/IhGAdfZtqu3Hbsa/7jQXfmB95MKMC/NCl8kawbiETNtxnZEm7rzxABFdoTfxVK1jtoTrjIOWkXTlRoQwfccVFGSlUQ4SEq8IsBikMWM58iH/nlPm7eNI0zAzRuRThx/MAyEsqPPfo3xFMSfyIjwsRr40iZbZ4AY7SMPl+HSqyxNt7nAoZM0OTFj3KxzdePDMGV/uKqbCSn492Mq/6foUacSgt90MDEW+OGPKCBlZvNwo1zSHaNLwWcytFXwBCyXbVWhTMbk6TpTRJ51DZO0c52kzOxgfFW0PUJgXLQXHxeL44MvAVtmwDSCfsKTE+6NE6MNewOMYEjb85j61Z/uXtnVy+d4JJKZWWWqnmfWkEaI0LKLL2lkCh4twHL0UXzR5rMXn6rxhqaAeFPovoewCSTqnO/qYhUR2+X0WJVOHMawbCFEtaVNqaErXOQuKKpa59cFZ/ywGLha/kPsswEC46SLwwytco+1K4TwoQKVvUAKTy514tunbbNSg+o+7oufsoO9Z/7exmkK9/gTrQCQ7tmZBc4fWlA8mcYduGS67j5M9JqbtQa+NwkZ0DBQ5DDdAXBoM0MJyaDWRftx1m3XOfumbGN+N8s83P2Jl5Cl2TXlXDrBaTqbryzpp0GH6SArC12/5QNwXp+d/WYWtBxw+Bnqz5+4aOknpd9WgdGMeir40+6t/HzzoyOhJMqD6sSJfFS862WC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(4001150100001)(8936002)(9686003)(186003)(5660300002)(66946007)(86362001)(26005)(66556008)(66476007)(6496006)(4326008)(966005)(55236004)(38100700002)(6666004)(8676002)(33716001)(83380400001)(2906002)(55016002)(316002)(54906003)(508600001)(7416002)(956004)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/r3NHJX++Ry/69cvhQe0RWVA7DAWSjQTGfTtE06N+0SQ00SfLJDxwfTXlut?=
 =?us-ascii?Q?CLuD8Frc8T2Dt5MAwwZBwWyHVDJ6feR328X6wRbSKNCqK0YulbG2ml9AnEFU?=
 =?us-ascii?Q?Z35YVlCYRqpxP6GZiauruB53nNLPpKrrWiUpop5s7iXrKW8WWly7LPq76rab?=
 =?us-ascii?Q?V8uKMxW6n/7TpgmbPObd1fbax9LXJrz59BR56c0qCKmluO9aAyGamrL4siZ4?=
 =?us-ascii?Q?0HkeWZPrUB4/48+on7pbCscYfPsVM0KhutdTQdzVJcmEb9uHFXGKtLUBoqSU?=
 =?us-ascii?Q?UZ6PTdTBpeOAFMi9wOwegG3W8bJs7k70dCZfq2X/2s0xNuLsudZ16peQIRiX?=
 =?us-ascii?Q?wkIC0AegkTJcapx+U0bwjKUQplFXZ6R/mKCb9gQR+2cLA2jIdoAN5fBzt0zP?=
 =?us-ascii?Q?mfLsbpQfEd4r8fgSdAaV8/v0M3YneDMM++LFDlytEg9EFDAYb84Ah6lJ/BWh?=
 =?us-ascii?Q?1tC+WP4Al15r+h6GwUXZeJRkqGhcAuuKq3bJiQ4naKijB6c0NUvT0jGjPvVy?=
 =?us-ascii?Q?sqwkbX9aF9H5byO3hUZEGZGvwCMwJFIgEgMkyr1dr/y8RNi/KQOB+zhEBYwg?=
 =?us-ascii?Q?6DsO1hwovB4b9uMbVSVzYO9dnV+73pKH16ieIal+9H8JKBUqgCO7MEnWVOST?=
 =?us-ascii?Q?V5Ek7pSWEVGB5MhfwMF7nDn3DEFpRSvb7OqmfzLOM2BWC1AxJZetMEIx34hB?=
 =?us-ascii?Q?sfb3z04qmAhfQS3ehT7yKdattEwVdIRipQ6NKRvXE7ukSfoGotuA+nozURtL?=
 =?us-ascii?Q?JqTZLFrsw9Z2qsdB33XRt1tnFPuOVZ4HpR6rDwnMyJvltXV5qoL16Z8x/Vxy?=
 =?us-ascii?Q?eWqmmyAy0fBdHfpeID6faD5JcA3Ja6GxsPw8jse8Vg8nU9LNT4BqfDB54Wpm?=
 =?us-ascii?Q?vt/cBVbR3JQ7+wNRWKMXwD7grdjc/F+rVSp9Ex4hrwCJcb3Zvy46o/13og7c?=
 =?us-ascii?Q?yLjxkUtjiznQonG3NZivJpW8kST0sYFUy3Krr8NBt9P7Q8if2s+O1SaWKe/6?=
 =?us-ascii?Q?PDc6RXCp9lzxhwjBIqdmRSCLxzujXzRcxKHrSVs0lyVaYIqZ+0XelxRaBdSC?=
 =?us-ascii?Q?OTq2jDn8fTefnbaOChN1oO2bzesGXrkhPAhJlFVafyFr3j5BaafhJpp+IBEl?=
 =?us-ascii?Q?ei1P1J5EdZHenBMXsrfJBft2bHIx/nJw7foCBiQP9wQI3kx/rtKz3bDf3S6R?=
 =?us-ascii?Q?H3e+aXjctP99ULOorEchlqYhW/BBnKmm317WH/jEHJt/5XRWoOGTNmUjWDIU?=
 =?us-ascii?Q?ySTNRSw2HjDM+1DNkCKur3e13ZDmqnz+G5TF7d44m9r0DPZyDqHTPF6nw/91?=
 =?us-ascii?Q?YvR1L9V/0k9Fxz5m25+ZvH1k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbce505-2e44-4601-4804-08d994a0710a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:38:26.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Radu,

On Thu, Oct 21, 2021 at 04:32:52PM +0300, Radu Nicolae Pirea (NXP OSS) wrot=
e:
> Hi Chester,
>=20
> On Thu, 2021-10-21 at 15:13 +0800, Chester Lin wrote:
> > Add a mmc node to support USDHC on NXP S32G2 platforms.
> >=20
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > =A0arch/arm64/boot/dts/freescale/s32g2.dtsi=A0=A0=A0=A0=A0 | 32
> > +++++++++++++++++++
> > =A0.../arm64/boot/dts/freescale/s32g274a-evb.dts |=A0 4 +++
> > =A0.../boot/dts/freescale/s32g274a-rdb2.dts=A0=A0=A0=A0=A0 |=A0 4 +++
> > =A03 files changed, 40 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index 59ea8a25aa4c..19e2e2561374 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -79,6 +79,26 @@ psci {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
> > =A0=A0=A0=A0=A0=A0=A0=A0};
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0clocks {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usdhc_clk_module: usdhc_c=
lk_module {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ompatible =3D "fixed-clock";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
lock-frequency =3D <133333333>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0#=
clock-cells =3D <0>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usdhc_clk_ahb: usdhc_clk_=
ahb {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ompatible =3D "fixed-clock";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
lock-frequency =3D <400000000>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0#=
clock-cells =3D <0>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usdhc_clk_core: usdhc_clk=
_core {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ompatible =3D "fixed-clock";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
lock-frequency =3D <400000000>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0#=
clock-cells =3D <0>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
>=20
> Adding the clock bindings as fixed-clock doesn't describe the hardware.
> Using fixed-clock is suitable for quartz crystals and oscillators. Here
> we should have the bindings to the clock driver. Are you planning to
> submit such driver soon or you will add here more fixed clocks every
> time you add a peripheral in the dts?
>=20

Yes, I'm planning to add real clock bindings but not just fixed rates I obs=
erved
from EVB and RDB2 boards. Since the upstream support is based on the psci
method and TF-A, I noticed that we can use SCMI clocks [+smc transport driv=
er,
e.g. "arm,scmi-smc"] as clock inputs for most IPs on S32G, and AFAICS the
downstream TF-A[1] has infrastructure to support SCMI clock protocl
[protocol-id: 0x14, arm,smc-id: 0xc20000fe].

However it will take much time to verify and upstream all SCMI-related stuf=
f
such as clock dt-bindings, so I am thinking of using fixed-clock as the fir=
st
step to have initial support before we can have all SCMI bindings get accep=
ted
by upstream.

Please feel free to let me know if any suggestions.

Regards,
Chester

[1] https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/=
tree/plat/nxp/s32g/s32g_svc.c?h=3Drelease/bsp30.0-2.3

> Cheers.
> Radu P.
>=20
> > +=A0=A0=A0=A0=A0=A0=A0};
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0soc {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compatible =3D "simple-=
bus";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0#address-cells =3D <1>;
> > @@ -109,6 +129,18 @@ uart2: serial@402bc000 {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0status =3D "disabled";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usdhc0: mmc@402f0000 {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ompatible =3D "nxp,s32g2-usdhc";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eg =3D <0x402f0000 0x1000>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i=
nterrupts =3D <GIC_SPI 36
> > IRQ_TYPE_LEVEL_HIGH>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0b=
us-width =3D <8>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
locks =3D <&usdhc_clk_module>,
> > <&usdhc_clk_ahb>,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 <&usdhc_clk_core>;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
lock-names =3D "ipg", "ahb", "per";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0n=
o-1-8-v;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
tatus =3D "disabled";
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0};
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gic: interrupt-controll=
er@50800000 {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0compatible =3D "arm,gic-v3";
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0reg =3D <0x50800000 0x10000>,
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > index 9118d8d2ee01..89428f1883d9 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > @@ -32,3 +32,7 @@ memory@80000000 {
> > =A0&uart0 {
> > =A0=A0=A0=A0=A0=A0=A0=A0status =3D "okay";
> > =A0};
> > +
> > +&usdhc0 {
> > +=A0=A0=A0=A0=A0=A0=A0status =3D "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > index e05ee854cdf5..30eae51121de 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > @@ -38,3 +38,7 @@ &uart0 {
> > =A0&uart1 {
> > =A0=A0=A0=A0=A0=A0=A0=A0status =3D "okay";
> > =A0};
> > +
> > +&usdhc0 {
> > +=A0=A0=A0=A0=A0=A0=A0status =3D "okay";
> > +};
>=20
>=20

