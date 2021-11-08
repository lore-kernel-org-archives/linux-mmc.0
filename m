Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A7C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B29161360
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhKHPhX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:37:23 -0500
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com ([40.107.102.52]:2432
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238345AbhKHPhW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Nov 2021 10:37:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VegHdAbgq/yjPkT/ZrO1XC2Ye2FTl5sHvJZtSwVAMsse1DxBujZ4NAp9ckVG/HEWk0c0DFeFf4wad0uxzX/i8MJVjoUu9Eme44KPrUr8dmDPMb9ZcZZ1Qp86omaqFFMpeJVhwrBld2V/2swV0glOVNvufa1VTE6vaWARU2Hi9d6rdzmZ986wpla5ZR4KKwzAKKUfq8EpgfIyCVzGKmpvzwAiIbGloy6SPxMn29wO7yYCZW9d4vIlNBrduG+D5uGR/MxT62G4AGE2IWSVENtWospnGKRqlz+Q+OOdvEuMfOGQlG+ot+ywB5TYn4l0irO+99hV1J7GC7Tl18FsKmBpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn9qf7OL4VPiShom4m/L5mlCbuZD7qWZsiQEor/LmA4=;
 b=REx22iD+er9MCRYbkammiqn++g/z1H+hEh7oKrog1WxBdMHoE+PJJrkcHHRD1retFF54fHYBGixWjf4PphWeCmb13CVxnUOuZQ+NF4ENkxLg5QqdPXFtiP5IohF0UIQV47g+7wbxH8SS0VWAop9v1MlxkTWwRTeOyTm/d3w3g1GmVg4MMjNIWbZ1x2uytqfja0RJxDpP50U/ySmPj+YV7H5zfC8NbRh5gpr7s4/8SDTQwtyNkizVhp3T/A/1UR7AgVB5ekZPm/BT4MIgUfr/dVqnsBpquEtVbZxRZDX3pDoU9ymNAiLQ8m7MjHTALMG9p/2IwhM5932dNbosEQvSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn9qf7OL4VPiShom4m/L5mlCbuZD7qWZsiQEor/LmA4=;
 b=LQ8JQ9TMTMDTWkdBGtA0d2EQzyg4EvVRQnoEF6b6IBYugqFyZiyC5cMlfQSuzsuFquIy6KixOwWnag6N8NmlX67UBdWIxGAtEKGVEbEXSh7GDhjIfXnEzUd9pRrWM96lkl76L47EM6PHfvJIqU75CRVoDjwHaXJSofb3fipWmBs=
Authentication-Results: goldelico.com; dkim=none (message not signed)
 header.d=none;goldelico.com; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 15:34:35 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950%4]) with mapi id 15.20.4649.020; Mon, 8 Nov 2021
 15:34:35 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v4 2/6] mmc: core: allow to match the device tree to apply quirks
Date:   Mon, 08 Nov 2021 16:34:30 +0100
Message-ID: <10252914.21crK1JNra@pc-42>
Organization: Silicon Labs
In-Reply-To: <CAPDyKFo09xhaWbGgWuPa2=x0zXCfir0VMDhd4ZdSc8rh25nG9A@mail.gmail.com>
References: <cover.1636103151.git.hns@goldelico.com> <7121F069-56C7-402C-BA82-A922B1A36587@goldelico.com> <CAPDyKFo09xhaWbGgWuPa2=x0zXCfir0VMDhd4ZdSc8rh25nG9A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA0PR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:806:d1::13) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.localnet (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SA0PR11CA0098.namprd11.prod.outlook.com (2603:10b6:806:d1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 15:34:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 591e3276-02b5-4318-0f78-08d9a2cd4498
X-MS-TrafficTypeDiagnostic: PH0PR11MB5641:
X-Microsoft-Antispam-PRVS: <PH0PR11MB56413499A73B5A5B0DA8FC9093919@PH0PR11MB5641.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rL41UhKex8GO73CayoaKmzUMPoRU9disUmdapEqD6dcjcjOZfixTm0ZLwCGQ6ge9oytLXgOcZkxt1vClz35VLYc9uMedOP6Sbxgp1grEGv0QoS4+yD6hHifnbFDwjwPU7FjJ3031x4PEmP9SeAGDuxMYyBVGycAxkZKOGPI1hB6g1FvX64E5uDlC3QDaOEaN7fSGcuXgx6USkKnCgx5RY1wGaawN0vuYemYhO1oc2ZvMJJeu+X55inO7w5dCUkQWlvRsTh+XKpTXufg9o2us8slOEY+/xXKVzVkCe17F6lWhL2Bz+xXGTCK6biKK7fxGdCHxtsiOpt4jiai+OBod5SV0gb+m/56rEO27WZSwhriD85l7dykdP2iu3bU5VnjIm/W8wNPQ8LlCMlPPOiNACpLhEYyrFukJ8sdSa1gm57uK36nVx271tL9KFO0f6+cR8XSNoyRoBvDVwH94NtEKFi1wF4KybcDwbGWniE31lyAn8Tg0BtZMvyb/a80K5H3xeL3w02z8PA+IbEBfhEUJBB9LZun893EKnCH3AhMoUoiqInVdHaCXeVljoqzZkYAbpDeBEEodDtVQL0dWwq2x5s7WHi7yCe/XOfHq/dAXsl/X8bLym0PabbCvitYlCAwq9MRhyPjKTzxr0IuQVax8//oN+LEHEWzapTP4tayXozjdfWjBp2ldkYm3r4Znzii7fXFp1Mm+OQeAuaxVmsIhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(9686003)(66556008)(66476007)(5660300002)(6512007)(36916002)(86362001)(38100700002)(52116002)(110136005)(54906003)(8936002)(33716001)(316002)(2906002)(8676002)(6486002)(7416002)(508600001)(6506007)(186003)(4326008)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CKXrQjqx/5cu6eBF6vOAb3EqyGIcONKrNVt6wQpgVcdiRwIfO3BYkmoVjC?=
 =?iso-8859-1?Q?nfgc2cI6p3EOKKmmLUPyDf4kjHMyB+rxdEihpGBuxUDn6LxE4OVDfZrVKR?=
 =?iso-8859-1?Q?w0EopLPHzBniszB/2mgDzG1AiK2kCnJFEQm4Er2bi1C2TkF5DtDXtvVhUf?=
 =?iso-8859-1?Q?ArOmD4UsDbolMarSjSw7PXcal9yW8JsEc1tGvZRq2p9HPNhExOW2PgnTRH?=
 =?iso-8859-1?Q?sE3mso+gPItRDTvSNPV1kJKPDDJNKFha3kquhJ/25Ax1coH8qlyz2xLcki?=
 =?iso-8859-1?Q?z3kJjwwWeTDYkbompZIJN9CPoo30K5FF/Vl6xpeh7iEeVztmn1iw/0qVLv?=
 =?iso-8859-1?Q?U3uP+U1o/4wCXuzzaQ52hkcxhiJa7/CDVIItzD2s5Y0ZFygw5b/MGy/qDM?=
 =?iso-8859-1?Q?grGcjbeZm2Axm3MCaOrj7qvew08iovKDDgs6RIdU2Pk1CB1lbhSr2oUAKD?=
 =?iso-8859-1?Q?7prKsEXuNVWUKBFBnFqs8kFm5KpjVG62q0eMjU20TmJ3/nlLyvfaOmkFn3?=
 =?iso-8859-1?Q?H0Qbojr3wn9gbbp70y1bDmPqgQr6gDuhBH0wQHqJnDXrvBib0K1Cd+NtwA?=
 =?iso-8859-1?Q?/MPFpfJFOJK00QOzT8aAmaDo3Vroi2IZG9RQQWuuK8SA79+loUkqZpT5Ay?=
 =?iso-8859-1?Q?i4IBfWOS2HMLOS6sVzDh0LxWa37fMsHZJd3YdljsyiZG7oTSbQCDR8SB3z?=
 =?iso-8859-1?Q?IgAIUbXfQQIY2DITgNgX/tUmFfnpPHd3vhD3S4HP2lGXqCi/SzELIJicUN?=
 =?iso-8859-1?Q?2r3OLihu9BY26sKsc0Pn9Ik3cxHoH9ZCOMZEQcuHFTj0eXcu0z2aaPKMR3?=
 =?iso-8859-1?Q?29Mp2yMUd/37EHxun85hQeor3zbPmX+yEvMciJtLmQOqpNNdp26Pm+9ClI?=
 =?iso-8859-1?Q?J2pNL0RkxyiLRiXeMSzfLlZ3KCBqhNm0W++iw1BMfooAGB+maQ/qy87PN4?=
 =?iso-8859-1?Q?GUV56qpoWH3G+InUPv3CZBfeNXg+eQu51/qcBLzuMPe/z1uphmlg+75xwP?=
 =?iso-8859-1?Q?/GRNt4F30zou4BG3hHSBO9HGVMLhwLTgr/sS3lesw8Mo6eOA9mZIa54anL?=
 =?iso-8859-1?Q?jIYE/9FQAYFhftZ+3tF+2WzuNmRQvwjP7FSY8mwStyldQZMWoB9B/5khq4?=
 =?iso-8859-1?Q?kuXck0AVRkdEj85kGeNC1oaX2ZaiVil3Z6ia2jioIPopJ0PhTEzvkGUh++?=
 =?iso-8859-1?Q?vB79mX2VnUwCbEa4b5LJvOMWhBrvntkHV/n9pAH82TFNmfKnNJNoqtj2Io?=
 =?iso-8859-1?Q?5bqhrG5lKM1QtHS9M4Pyzc7m4tuBYpEb3D0vwgt+KD5MJyZ87p3H/P76Sr?=
 =?iso-8859-1?Q?FgHU4vWo/yn3yCZA5TWeSrStQTIqRDu/35N3eO/8OeGSiEFCmI82rzR/lV?=
 =?iso-8859-1?Q?9NjWbDSFNEgNmStI0rtpeQJEMxCKXN3GDGe/C2LOdBoSNGHf5s8p/JJmhI?=
 =?iso-8859-1?Q?qcW7NFBAAizD3I6uSO565IQBW1pCffldT05mKfpNlE9XLf1EHvpbByoZ2G?=
 =?iso-8859-1?Q?SYTA/9RQ7qE/91zs85gNIw/qjBk9p1MqTXm0p/4lAkTJW7dt2IU/RLNrNW?=
 =?iso-8859-1?Q?Tm3at6R9LYsBj68LyQ+YMOmybEDnlaEnp2uDRxzC/YfTS807Fxk6GSabLQ?=
 =?iso-8859-1?Q?vg2f5utj1Q1W1mgtSPAkVcYaXjIoHr94IjyoapTOKU/6W7MTFTslxK3FrN?=
 =?iso-8859-1?Q?OvrtaSGj7XWQN+xv3siADAccAcfL8+0tJrI9NZfUp74Hxdc7Tg5udU9WII?=
 =?iso-8859-1?Q?04sfdIm3v6zaEGrgjGFsX81dI=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591e3276-02b5-4318-0f78-08d9a2cd4498
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 15:34:35.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsrC4xzcoXCVhP5wfANg3AN/xYxQHCenDnKUaMawWmoi4WxRobCuIsZ0pYzogxnTHYlFjT6yjrjBWRE28lgNFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Monday 8 November 2021 16:00:02 CET Ulf Hansson wrote:
> On Sat, 6 Nov 2021 at 15:31, H. Nikolaus Schaller <hns@goldelico.com> wro=
te:
> >
> > Hi J=E9r=F4me,
> >
> > > Am 05.11.2021 um 15:27 schrieb J=E9r=F4me Pouiller <jerome.pouiller@s=
ilabs.com>:
> > >
> > > On Friday 5 November 2021 10:05:47 CET H. Nikolaus Schaller wrote:
> > >> From: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > >>
> > >> MMC subsystem provides a way to apply quirks when a device match som=
e
> > >> properties (VID, PID, etc...) Unfortunately, some SDIO devices does =
not
> > >> comply with the SDIO specification and does not provide reliable VID=
/PID
> > >> (eg. Silabs WF200).
> > >>
> > >> So, the drivers for these devices rely on device tree to identify th=
e
> > >> device.
> > >>
> > >> This patch allows the MMC to also rely on the device tree to apply a
> > >> quirk.
> > >>
> > >> Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

[...]

> > >> ---
> > >> drivers/mmc/core/card.h   |  3 +++
> > >> drivers/mmc/core/quirks.h | 17 +++++++++++++++++
> > >> 2 files changed, 20 insertions(+)
> > >>
> > >> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card *c=
ard,
> > >> +                                                const char *const *=
compat_list)
>=20
> After a second thought, I am not sure we really need a list of
> compatibles here. The quirks we may want to apply should be specific
> per device and most likely not shared among a family of devices, don't
> you think?

Indeed. I dislike to have to declare a list of compatible device (see=20
wl1251_compatible_list in patch 5) outside of the fixup list.

If I have several devices, I prefer to copy-paste a few lines in the=20
mmc_fixup list (for the WFX driver, I have 4 devices to declare).

--=20
J=E9r=F4me Pouiller


