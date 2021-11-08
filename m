Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF0C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774336124D
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbhKHPmT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:42:19 -0500
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:42977
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236257AbhKHPmT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Nov 2021 10:42:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRz+3hGcKqGu+FLkZ9Eq9jv9hF740ItPWqLNP73w2EtrwyELIk29gYNXkj2msqm8407HzFbwX2CqHql/CZ54INcvXHoDDzVWyxitEG0OTF9NDG1ZAnkWyhagtdiUR646J8weJFst4WAYF9FkZOENX/XzE9Kd5KmPtjx609w17CO3/hMlbfdLKkg0Zk3LXee6tiIkGnXqc9iPVGApUYxD3PGSBNNvYSZrS/Q9HAXf4zPlvQfJ7iByjXvutMASyXjIhwR1wabKL6d97r/fW+d5sQ+PG1SzLxyylFcZ2TdJgZyMvoGXdbm0QDNlcwESUycYrBLf6eF0cFCzidYE5W1+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcNzjnn+vIw6uAsLjBczH5mAQ/2mRhnb/Y3DsDHgx7E=;
 b=m49iVr85uVUXPpW8gjaUEm1sPqvDdYaS+fTOeoPCiQE0SAg19bT26kxkeNgPpQg2TPlIzKM0xTdtq65n4tfKtIw/oRDpn/4iuM0GuxWKryiVjHu3aeXtAAKukIDPJ20fdO/VcZk1VvCzHoeObsClQcIig5oeiQU7FNgvZ0BbkgZfN7lkS2e8cBanW8vmEdSwUdzkqTSt/sxFjJkfauilupww4ofSasrlq2eDGQKvN8H3UwzCmaPN07tcMIf0w2zgaf0UtJadbZ1HiLEA3yT2y6GAGsUaY+QTk4m9pRF7gtSBf5mvpyT+YBXBvVgSC55NbFOP8DrRyVegyIzfPBMGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcNzjnn+vIw6uAsLjBczH5mAQ/2mRhnb/Y3DsDHgx7E=;
 b=YRmKYd/W2Q82cVZXpNdC15jH/pH3SqQpgHIy8Ktc1q7scS4gB78fZpB/UR6bK9UIZVESpfcNE3DbKIPtCO274sOcSnJyiTuR0n66VgPt2h9jQSQZVF/JPYBNP09rW8/4Em1122oPameHoB0GBIzCsK1CDigs6KzL4/ECCWjvPnQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5644.namprd11.prod.outlook.com (2603:10b6:510:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 15:39:32 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950%4]) with mapi id 15.20.4649.020; Mon, 8 Nov 2021
 15:39:32 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     notasas@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC v4 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
Date:   Mon, 08 Nov 2021 16:39:27 +0100
Message-ID: <5014485.RYphtzS1IF@pc-42>
Organization: Silicon Labs
In-Reply-To: <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com> <73440c0f227778e57167dd9fedd350637a1d737a.1636103151.git.hns@goldelico.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SN4PR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:803:2b::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.localnet (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by SN4PR0201CA0019.namprd02.prod.outlook.com (2603:10b6:803:2b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 15:39:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc70c86a-9738-416d-9042-08d9a2cdf5b9
X-MS-TrafficTypeDiagnostic: PH0PR11MB5644:
X-Microsoft-Antispam-PRVS: <PH0PR11MB56444D371E956C2EB31BA5EC93919@PH0PR11MB5644.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu5B/0tubpbR/GBdU/dnovFIKix70Y841tCNjD9j5Kwf0erIlwsHYxe1KOMeBGKDuhTbtL8kMAu1mWXFu68+ExSFW3uWdTnIpUoA4zXg1B0BB2Ky87YyIY+oiyiFy2mXqoJZJIFtNVCNZMI4pUMt7NPFylPOJh6TEF7gW9Axo9zhZBXdV4ORqGBdWRlrJaz4U0cbDHLiijw1QYNHD4KEQ3HLrnQqs6ze8tGRw5JEisex+VFTkdZHknsM7OBPfExZCrqYOgMC98XEicFkcnY09ne3syVTOyJcgDwqnN5Covr4JGce9vvzdI4aabAkW7FHw9cgl7MC14sBkW8NXE8EjgH9dpWTGQwbcvSNRaCWvnbp1mIbcMOqOpEN3gocjYSDu0KrdzIaq3Q+2X4EuYxvKumBEk1KQWmWsY4CUzhBZnrqU3j8V2cT6Y01kqw01gWwza/R4yTsDKSAWAeDqJ78zz42zAiuWtlFzCwIRiVGBO+bB9sGrazKVGaMxpnRw5YYml8YvfrMb4ri9tSPXMfiSrq28kxE5quFLUHddNRthsvBBxTLaJISBUtAwujiYPbrF9tr9S8y/1pTgtbqiAuuSOT2Or1DI6jGCNEbWX6NVUTOF7E7+yuxDcZLsYM4KxCJAtRCX6OC1N0XvixUX8/lwdhAsH8PZf8wiCyixLzp0oqfAya4aP+K9ZVLTMj+aE+3zgb6nFMWxwnrLLXrwfccKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(33716001)(316002)(110136005)(6666004)(52116002)(8936002)(38100700002)(66556008)(2906002)(6506007)(7416002)(4326008)(86362001)(6486002)(36916002)(8676002)(66476007)(4744005)(6512007)(508600001)(66946007)(9686003)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vcBP8+zZQ9hnD3Y0olEBy5uuQIsc3XCPA3HRTGRqEvlAso0Tn33J1XpVDu?=
 =?iso-8859-1?Q?T1QZOGHrOhDs0wxrSQMlpQqGRVoNjwMWvEHFgVj1yzdXXGX8TzI95ltgmd?=
 =?iso-8859-1?Q?wpcB2W/TTkCWrq6k5FfOeQKaXd806ds0xQXzJ8PkkepAVBzxh064t2sHzE?=
 =?iso-8859-1?Q?k4eF/HsI6hTr1HWFoTcxBKX/Ml1Hln7MWVbxgKahR+wYTTMnP8wqzbyWTy?=
 =?iso-8859-1?Q?5rGR1QRQljo/SgaXU9jUVcqgDg76EyBXklLsHfeGK//g1JRQNET/luMMzV?=
 =?iso-8859-1?Q?8Cf4FcvSEbH0V7PMh4/iMvGejoQ7XjX3Eenwn2CfLgRLF382I7rY/Gdk9d?=
 =?iso-8859-1?Q?HG2NOsS0QPvy4E6fUiq7nRID10YTqDW4kNnbAgwyDSwpOZiy+yYXSnie03?=
 =?iso-8859-1?Q?Ga0glc//KpfHiqlfveoVHc3QkUvvzVDzG3Xu58ApcZzRF6Aks1h8EKT76m?=
 =?iso-8859-1?Q?qgI641y2fZn41DrvnD/KrOLP18FjzrsCoc9WndOH2JgTeNqVZ3sBd58leQ?=
 =?iso-8859-1?Q?37qBvhPN9n1eQt4ttAeQ0MkphNr94PvbxjdVs9e6qZPAApiXDEJSkPWw98?=
 =?iso-8859-1?Q?BEv8oq60KpxQqC9vmtHMffclMQlDfo+jMFumbRjTP29zpD//B2log77yEZ?=
 =?iso-8859-1?Q?fZYyslMiBXJUOzhqqhXX7Eaz9Z+xOe1Q9nafqY/qmpm7ON97HJSVujEDU6?=
 =?iso-8859-1?Q?I8+hWcnH77i3rLqiKXI4pOrrRFT0PNZd/0TCQylBAGFA7BNVRKLVw0B6Ch?=
 =?iso-8859-1?Q?fBMmAtwzCIlRiq6Zca6bUOMWrMS5M/YbKV72gUTR44ba3y8TPOp9K8zU4N?=
 =?iso-8859-1?Q?/o/dPs7iOUPHM4NrpUcYTbNPO8EK4qf+CA5j0LyH5ELuJcl2dxSZmCNT9m?=
 =?iso-8859-1?Q?VjAM7HDYiJInB+V+43sAh3mddquAJ8DgZkUR/DAUpams4tTEqfPfrxItxz?=
 =?iso-8859-1?Q?+XMe0ZhYljFD17fkhOBWUJn2849UkLmbZ64GwVd+5QoksaOWmZiTzACRAy?=
 =?iso-8859-1?Q?jG/MUlx88k+PMXRbbyMHwJhBm5fR/ms7h7XOUBt2pn5Ikjc34ugU+e4KlH?=
 =?iso-8859-1?Q?Fx4hk3W7cjBrxtNaqYhKLHaXVEfMdSNcdLgsnIYpOXOl5VzlaIEu6ceM3f?=
 =?iso-8859-1?Q?jIqa9gdcEpx0aJ4RiK1Dym3qHSUypshh7H7fdxJiZ56MN/Vu8diUh1a1xq?=
 =?iso-8859-1?Q?6mA6uSPVUKvVzEsL953BuaWsKmg1kK51RsiM4x4dipE7is/D1zoCa/axF3?=
 =?iso-8859-1?Q?q5/COuIuEhUlQCrIk9H5XanDlm3P44ZR8OFjqEIPIOOymAhEIAvyUTZc2X?=
 =?iso-8859-1?Q?28zJHRTtKXqdZWEA3qjBA4UMWPlH3i8HzWmo6xgFh2nhxbfPjSazmGl5eJ?=
 =?iso-8859-1?Q?uk13knGVAAXMMEZjMe58x6apxtAbsk1KEofE7a+LKRtdi30ndtnLUDsgHm?=
 =?iso-8859-1?Q?SOGt1TB4uC5M4/yQwPVZKIIdHgJpwmvb8jQ5sXWLIg5Ew0BoS2JY1VGwlB?=
 =?iso-8859-1?Q?VbhcfuB2pfcthdsu7ADhKC82+G+TMRDQkUnpqHdeF64IlGFt0nxmc5uLyX?=
 =?iso-8859-1?Q?u0qrYWQFdkMXxYIIxw1F2WilnfxHqnlPHEtZV74I/J2cwWzkBAwcnjcNZ2?=
 =?iso-8859-1?Q?0lVSdQCb8cJlIsTDPlALXaDcOHYBdIt7nBlg1RzNr15DRGB9RwwPVqse9K?=
 =?iso-8859-1?Q?UZCaW8edYZqOh9/C4ISV0lsVY7dQTJEHBDRCz/oMjdAONUzxm6Txxm41kK?=
 =?iso-8859-1?Q?t8cjoBVmAzsOm2BtWn4limHEI=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc70c86a-9738-416d-9042-08d9a2cdf5b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 15:39:32.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj+JOU6r98WxmKn7spi5DshF3axtpOQeg7soIHihDF0Bs0ky8pIZclJxxp1FH/vB1xMEmU6d7HBtDf4xmj+ZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5644
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Friday 5 November 2021 10:05:49 CET H. Nikolaus Schaller wrote:
> This allows to add quirks based on device tree instead of having
> card specific code in the host ops.
>=20
> We call it just after where host->ops->init_card() can be optionally
> called.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

[...]
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 68edf7a615be5..cf8ee66990508 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -707,6 +707,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, =
u32 ocr,
>          */
>         if (host->ops->init_card)
>                 host->ops->init_card(host, card);
> +       mmc_fixup_device(card, sdio_card_init_methods);

sdio_read_common_cis(card) is called a bit after this line. I think it=20
will overwrite all the card->cis fields. This does not conflict with what=20
your are doing in wl1251_quirk()?


--=20
J=E9r=F4me Pouiller


