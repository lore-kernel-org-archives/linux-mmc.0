Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C21C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E3061183
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhKEOag (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:30:36 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:34587
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233105AbhKEOaf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Nov 2021 10:30:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ+XBKqJBuD0Dev/80amqDrWsNYjnd+oxTeKLanpurp0T3ncWGI836u/4fXaZ1euWL9tAWABIhjy3ehDPdeGeqeVGh/OlL8An+vsdKvJ4zAUDbYQ41ziewml4fKsC3I41GTMMPbcibahURtHVvGx6CqqoC6waXcdfx06Fl3kml94qzF4tkuPBIrU8NZCex+H4vPE9xjFSIkQyx9wPKeHCHl7kFV+UDtc6F6EdX2i0nZHACzIB7+pjxgIVmcNVvaSqkeeMW69RC80p46p+/pz+vlUjptI38cwAxzxkfuAjqQd78ZlfRgEM3XN00U/42jvAVXaMD+YCp1lGudQIoFJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IpdOMwI3eUEhtBTc6OI9K7p7iza69gpHg4Hz4K3+Gk=;
 b=Z5s2kz6VrF82SpgyXrQYNhXxNrCfzKplhPlj1rcD1+Bz1BT6Y/B4M+3ErSfScjybEbhicZvfS9apunL6MOZDyuueFUiNrCq1KAQC5Ch48ffo0r6PgQBDp5rYd50Y7ohLHA9ROoCFAfMoDCGWPb/yljX53erq1+QmX7qp8uUSwXEU4CFQ98ujZr5k2QX+Z88reO+MKEAB+XknihWB2Ra9GbTcrP0cgrOUOBGOP/eMdOXW1bEatT3tRGaRlidEH0ASLEHSkSEHblnRHQjhMQSN+gQM6qsMevX1mgyO+GKSy+tQT0izdgO+9w8N/PLsuD01J4xQnFGwRUOYFuIk5efy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IpdOMwI3eUEhtBTc6OI9K7p7iza69gpHg4Hz4K3+Gk=;
 b=JNTzurpCEvmJcyu9m/r7a/BrpJ3kTNLaGWucLOGOvtduTOpZSgjJ5IVrmPPqULZlS3jPqUaZsCmPcVT4W9QiqDQN+CTw1xwe+DoHnLu/WLlsHgY0Uoy9kShJB961pB/PPvJRIkpWizD8XHWk+AlgqH+qemOOkst9bKyHKDsxH1U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5642.namprd11.prod.outlook.com (2603:10b6:510:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 5 Nov
 2021 14:27:54 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950%4]) with mapi id 15.20.4649.020; Fri, 5 Nov 2021
 14:27:54 +0000
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
        kernel@pyra-handheld.com
Subject: Re: [RFC v4 2/6] mmc: core: allow to match the device tree to apply quirks
Date:   Fri, 05 Nov 2021 15:27:44 +0100
Message-ID: <4570288.hTGhjlNkSs@pc-42>
Organization: Silicon Labs
In-Reply-To: <e072de2b480103dbebd941f35be96197534642ee.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com> <e072de2b480103dbebd941f35be96197534642ee.1636103151.git.hns@goldelico.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PAZP264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::8) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.localnet (37.71.187.125) by PAZP264CA0046.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 14:27:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617afb62-72bf-45f4-ceac-08d9a06873c5
X-MS-TrafficTypeDiagnostic: PH0PR11MB5642:
X-Microsoft-Antispam-PRVS: <PH0PR11MB56427BDE4E13FAC6A0CB5D06938E9@PH0PR11MB5642.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMQ0H6Nv+fWJqOGPFjnqem3stQO1DiwiKXTPVNHOXdb0jP0O1wwI2GoLfNvQ10qdbaZrci0ETOfJ2/aPOWzA/RZYxlfPOOdfnsdJsNPKd0zvjYNJy2h57WErZkZYR4EN2TIW1zPJQ5whR3VOusvroscF6ZqkaiU6krkPTF9555/FX0cZc34t7YmuRpstC+NmYZo6XYS5gEN/CpaGhJea5ckmJkrKFPKO4hlCYfSAnMVGixhcXoQ+yMU/jvY252+PARcDPzoV0bnnArZzjWYuppmheX4PXGW35XQN6cNZWekQzeP1/rH7bF7i/5ariCORzGK99HVhORu3INo7ZHHZUcDf2JJX6/G3haM82KM5uL7mVEHSYjPVXWVmLIjO70t9OSviPGUrHBI7hlMTYVvlsnwOhIEEZmgN+4TMsZQpant88+bRbEV1P5BOrA5z8GlHXt4ByLIVO36ZErDIO78R8TzcjiJAaBtXfFU1/xwcTuObGReuD+CEsOv+pJCkLQoR5eZRpbY9wJDC8nhKlksIext9Va3A48snVYEkVZqG++g/PSMjRULc0J0CWOGvndENZZE7U9eEuItq78L+zaVM/CMu5qRaior99afmHyF9a1H3CTAMSoasRk0UCBxL/DUtvvGAF/+E6Ds7HXbluwZFT6xu4BrIVh9ie9AxHP11jleQ9N5OXPX3H/jKSdWIWGbmMUMaJ8HE+mxZXkAGQOFXvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(5660300002)(4326008)(956004)(36916002)(86362001)(52116002)(8936002)(7416002)(9686003)(66476007)(66556008)(66946007)(508600001)(6506007)(316002)(186003)(26005)(33716001)(110136005)(38350700002)(2906002)(6512007)(38100700002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?T1bmLEOwxhCv/aSSFUgSp2RDEMDfmoUCSuKxqN8mAwBB4XCFOJmTeV0oSv?=
 =?iso-8859-1?Q?UtncAckCAcXZYGed4d/jyaBEJ33s6B716rwh4q15ilH4dFfax3sZA5e7tX?=
 =?iso-8859-1?Q?aIolSRn3XJsoQPvkYdETYar5BDDpNHDXPgdhvTKtMifKsdbbBJPUUhKx4V?=
 =?iso-8859-1?Q?JvCRdD/sAd7S7gYrDCU67/mYoHRvl9DSSJci90+lOlta/7YHZq318h6osg?=
 =?iso-8859-1?Q?MBd7WQlO/P/5dUGpKPP6uyeRRmbwOMSdWgYvY25zAuE7GI/d2jVOCrRQor?=
 =?iso-8859-1?Q?qfiGn9jqY+HuduEkcGfvD39gamw/STdbCbOsAF2ClLMDDcZPegoL/ppXgX?=
 =?iso-8859-1?Q?Ws5mdnEBBXT9A3MHM6kuMEl7R6ONJ9+BufkHckH/JOO2U1yQDt9Vcesyn/?=
 =?iso-8859-1?Q?6Mp9Ej+rvFjV+eppTiWy8fygF8m1VxfAPTspNqcML/+KkJ2qj+REd3ya/D?=
 =?iso-8859-1?Q?xshWhh9rQ3YjSgKxCscDRyQRaz6ljRyZCPzl3/8jbaxNy6XHbENPBgpWGr?=
 =?iso-8859-1?Q?XYmFtDqzJ6RvbZAz4xVL3ACmewzCJVACH9bjWlrBJniJo/KDcmCJ+mPBAp?=
 =?iso-8859-1?Q?i93ah6Hmadqv06pJXHuhgagwJIWH18ZVjXw0R++KjppPjaepeSGHh6JTZu?=
 =?iso-8859-1?Q?v1dg4rOuMSy8z8JipE1c4zfsUwgARcHdpWnsTBkus9o3dVqcBIlzh9LOui?=
 =?iso-8859-1?Q?Lt/5WwVumC5BshnIJKgGO1eDdfHdMR02j/mPK1OQOi/VryqGGbp0nHWtRh?=
 =?iso-8859-1?Q?ftJKKtQ+5aON/z40xi8ZuTldIExUJs2oqauaiEgOIT0OGtLk03E+lcSutE?=
 =?iso-8859-1?Q?IcFEaTvdhdCDjf5K70kVmXHzhKCFFU1Id21v4z+X1DlaZeMrLSL1Q+YGgs?=
 =?iso-8859-1?Q?GAfucrbIhKNbpVV1ue3/2LTtZ2AXKGvaClRcUoRdRLeve0GEkElxUvQymK?=
 =?iso-8859-1?Q?HX15k48zvO8LWdhZIU7Q6ptX5bygur0q0MUR+BQ0o0GqOucbd/jKi+gmQ6?=
 =?iso-8859-1?Q?cybolvJxBJE8n7lZ8ZSF6EEpGvhVIVBJZSf8HIkhF3nXP5M+K88Gdl/h0K?=
 =?iso-8859-1?Q?NybC0tce4vjiPcXimqDufU3BH/j2TfV15uXioQ+0pX7GeUfxDxP0twu2I+?=
 =?iso-8859-1?Q?uUWjGlrgvSpQFRUgPgO0ZRSdKwKajVa1UND+O4nM8uqktTMaaSrKsD5rvU?=
 =?iso-8859-1?Q?9TPPEJ1WvG+ZSq1dtI4PCANLevapx5YeAzkJDH/lG4xgjiKSINFx664XLO?=
 =?iso-8859-1?Q?ixx0rpNv2BTL9dsLC4IE9ysw3a6hfOnM29DBOYubs+ysK2E2E71lnUIOso?=
 =?iso-8859-1?Q?EXt0Sgjf2S7Rou7I0vSPbPdsakWicHHL4WvYtvGdDLNmZ1bRa2FfIxsBWF?=
 =?iso-8859-1?Q?cYvA7s/weF8BiWwefKx7vR9atewysuJ2qDeXjaQkU1S73lBMqV/3GDpqHS?=
 =?iso-8859-1?Q?cDLqc2TggbK47j8TLb9j/qoY6ax51MQQYqrFPaPRd1l2dSus+cQgjtVsL8?=
 =?iso-8859-1?Q?udFwasi3jsGwxBbOyoeSCdaHRzYtudlOlmDHTJEKPd3s5dFJmBtiR7YTS5?=
 =?iso-8859-1?Q?m5Eq2VgzbUY32d+MlsuaAp94RHIJfPYkXbU9pFFeU65DbRYGdbz63cqDVJ?=
 =?iso-8859-1?Q?SQPHnImSRzWAmsoQILZFJ8XscpndFZEQqhwaPIMV4juuNkGCrb+Pbj6BF/?=
 =?iso-8859-1?Q?7HX9mu38cSjXBeYeVyc=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617afb62-72bf-45f4-ceac-08d9a06873c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 14:27:53.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xCyVvhH1y99pcoJ/SJLSzRYx32Gn8etOmabDcULmeHbdvw4+qD2tm8K3jBis2bla2Nst+ENxtXR9JCYWLj05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5642
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Friday 5 November 2021 10:05:47 CET H. Nikolaus Schaller wrote:
> From: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
>=20
> MMC subsystem provides a way to apply quirks when a device match some
> properties (VID, PID, etc...) Unfortunately, some SDIO devices does not
> comply with the SDIO specification and does not provide reliable VID/PID
> (eg. Silabs WF200).
>=20
> So, the drivers for these devices rely on device tree to identify the
> device.
>=20
> This patch allows the MMC to also rely on the device tree to apply a
> quirk.
>=20
> Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

Thank you for to have taken care of that (Maybe, you would like to add a
"Co-developed-by:" tag).


> ---
>  drivers/mmc/core/card.h   |  3 +++
>  drivers/mmc/core/quirks.h | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 7bd392d55cfa5..a3204c19861a4 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -59,6 +59,9 @@ struct mmc_fixup {
>         /* for MMC cards */
>         unsigned int ext_csd_rev;
>=20
> +       /* Match against functions declared in device tree */
> +       const char **of_compatible;
> +
>         void (*vendor_fixup)(struct mmc_card *card, int data);
>         int data;
>  };
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c7ef2d14b359f..ee591fd8aeca2 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -10,6 +10,7 @@
>   *
>   */
>=20
> +#include <linux/of.h>
>  #include <linux/mmc/sdio_ids.h>
>=20
>  #include "card.h"
> @@ -145,6 +146,19 @@ static const struct mmc_fixup __maybe_unused sdio_fi=
xup_methods[] =3D {
>         END_FIXUP
>  };
>=20
> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
> +                                                const char *const *compa=
t_list)
> +{
> +       struct device_node *np;
> +
> +       for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
> +               if (of_device_compatible_match(np, compat_list))
> +                       return true;

Intel robot complains about of_device_compatible_match():

    ERROR: modpost: "of_device_compatible_match" [drivers/mmc/core/mmc_core=
.ko] undefined!

I think we have to add this line:

    EXPORT_SYMBOL(of_device_compatible_match);

in drivers/of/base.c

> +       }
> +
> +       return false;
> +}
> +
>  static inline void mmc_fixup_device(struct mmc_card *card,
>                                     const struct mmc_fixup *table)
>  {
> @@ -173,6 +187,9 @@ static inline void mmc_fixup_device(struct mmc_card *=
card,
>                         continue;
>                 if (rev < f->rev_start || rev > f->rev_end)
>                         continue;
> +               if (f->of_compatible &&
> +                   !mmc_fixup_of_compatible_match(card, f->of_compatible=
))
> +                       continue;
>=20
>                 dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
>                 f->vendor_fixup(card, f->data);
> --
> 2.33.0
>=20
>=20

--=20
J=E9r=F4me Pouiller


