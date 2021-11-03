Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2AEC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52D260E98
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhKCN1M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:27:12 -0400
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:19519
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231757AbhKCN1M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Nov 2021 09:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1+kOXiAaJ0dP7hCs+3jR0hNhiGY7K/nO/1zXeVw994V077sFyOta3oimfgrtfNo+w3R3yk8qA/qWqV9n0zRtzXUkOqc4yL6qHEJnqc0iOCWBD6e+SvXEULUdGfJj6ZfmEP29n5htrY3wqVRwRziDZrvaAuKJiWrp/01O72FiN24ef/LxtE0mu80ORmw1BkVQc6gU8sOL4bTnba1/QR5zo0CONSM7BPv/Ami4IwYpyWORZIom9WNLpBnmdZapxroB9AwMvZNxg/nbShT1AJxL8cs+fT3gPlAlXUaf28eJcdvRcF5FldwhWBwVL19SOGb+IezlUwO36DW8UNChcOhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nawMxUV5Dm1O0GRwS1mvpf3A1h3/bY96LfDndlPQrKs=;
 b=K63e8DnyX95MEC9P7ku9hKNM/iT7DrIZdERCkUg16LZ/K4fwLinfvjZtCH0ttjuDccrI3p9pppfOMOf5KD0EbXDtjU4H0ERPHbk8pfZ8bw99s3HEzWOv3DWvnipNJmqvgVr0WmSFnJsVyg2BHsOgzlDWi7lVrXMx6dPddD1qgOWC+UYuTxX8VdZVPaaBX1YTM7/JFuC/9XGzmqgTcwzL5+GvuuyTmP6dgRjyb/7YDVfvP6MdE9Cqx+CwBMS/LNUA4HNZEwweO4Uyds5qsw1QKli/v1KPJdDqdDtPruauRv4rpGGiETt6tx+3asPa0g5AueqCZpcUjkXmR40VdGbtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nawMxUV5Dm1O0GRwS1mvpf3A1h3/bY96LfDndlPQrKs=;
 b=SGhqtvD8QxE+F0YRKleQiu1IHtsm3Ml5vwIpy74/OBgQ+cO7C0tjrDM+mSh4DABSQw+xpc2o5XlzQrcy6o3WS6qB7/7pkgiaXKq+XWV/8WDx1lC3GHDveQvhWj+yy9F2x3uGZG1Q/M4MtLMOWPi49JpMqWhAONyRNTOEIcMdI7M=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 13:24:35 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::999f:88c6:d2d5:f950%4]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 13:24:34 +0000
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
Subject: Re: [RFC v3 2/6] mmc: core: allow to match the device tree to apply quirks
Date:   Wed, 03 Nov 2021 14:24:28 +0100
Message-ID: <12030734.Zn5U6lzIJN@pc-42>
Organization: Silicon Labs
In-Reply-To: <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
References: <cover.1635944413.git.hns@goldelico.com> <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: CH0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:b0::32) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
Received: from pc-42.localnet (2a01:e34:ecb5:66a0:9876:e1d7:65be:d294) by CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 13:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a15dc9-63fa-49a8-fd29-08d99ecd46ee
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:
X-Microsoft-Antispam-PRVS: <PH0PR11MB5643935A15EF7487769F9988938C9@PH0PR11MB5643.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEstR9YlbQuSKgep4XjU1S1ZNyqMQHdP22kLbpMgeZxljD63iapjuuWk/cm8yD3bSgAiYVrHh0I+3WTI/HbdX9GadJjdltLDmtm7oEMClkxFM57Pfv1VjFyeARi8ZpnsvHt2/NScWfA70OwRDalyDjBBQzKIrdSRenP11D5rKpbijgclV7lifotfVqmXniNjXcZLudka5cRb+L4vfZFftL32g7fSWZDJuPU0OgvCR3CprYUPxwqtUGlWFoQycx+licbxu4YCKFz2YPaHcJ9iRgKbNwN2w2z0ms7WAewy8LdxQKJ07EBuWPsLPKaf4cOmAn/LvGrbfxPsJ6RVP06bjL15GL8qTiFyU3MiywVNHvA2amKiKRy7FrG13L1iMZ6rbp9A9ABjR4w3+jBMAeHwmGbOfP0rZtpD9P2xdZ5nWDBD4zeT7sWZC+K9HcHqDdBLbsNzbxnWPXRAAF3PgP0tiXNIa8QZjizSK5ePhFsCcIfjUeDX511XVFs1sWgHW4MY0U0fxuj9fK4ouOs8bzsdtNWGONFFupp07YTkUqrpy/xenYwS/k49L+ArIikF58vPgJJZhVbIKWJ7TRWDZ8ZnAZevse2bDhwiC5fx4cBTk0jySvw8/Iet/CaKlJriu9jFPYtRwwxomhMBUv810utSUWG7jFwRwKYejLZ1aoaBeg6rzA9JG/IKkp+0gR+di+2mhwCrtrMiwrGTEFxHrk3SlYT0F03GAvBW0HW3zw42WdcL9vSmkqG1epBtwp60BIe/ATF0kKtaKXaEwcgP3xJ8dzTXuzQ4FNt8IfcW9rGqLqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(66556008)(33716001)(66476007)(8676002)(6506007)(966005)(508600001)(66946007)(36916002)(52116002)(38100700002)(9686003)(86362001)(110136005)(8936002)(5660300002)(2906002)(6512007)(7416002)(4326008)(316002)(186003)(6486002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CHQOieyK0SrnmlwvMwo1imSlmS8a/KN2JVn8c1jEx9qZeU9HgQ3LrVVEsi?=
 =?iso-8859-1?Q?wNHJUWqBMV4+h115MfQhVDJzo3Z1yrqlIpiR00H9QU+R9Ao+eZzxdODYdl?=
 =?iso-8859-1?Q?Z32mvwGFTC5FHWXLWJiEQWMd3MPLblkLqQx7052CEsuWcfWOl9LAimnJKL?=
 =?iso-8859-1?Q?vozmPwGbYeHwhO+46DiI8TbmRa6qN9hGbQs4TpJos31vuYDr7bwaVe70Zn?=
 =?iso-8859-1?Q?ant+q4CxHmnX790rGk1uEatxZoYa+xNSZlTDxibkPWikUXeBe3DYWUkYg3?=
 =?iso-8859-1?Q?7KqEabZSpfEj9/UW2kofw1NzoMOk+qoFBEh+4k+gO8Ts5G/QmOA82COzeq?=
 =?iso-8859-1?Q?SiXeiv83KI1Hsz4DRIHTBG6t5DH+TKahcDj41eLJZ+prH0XMkcJf1zpWOv?=
 =?iso-8859-1?Q?awDIylgrAP588+I5szvDq+7pnanvr/O15MazDHdLGmYovqweM5iK9KMGNZ?=
 =?iso-8859-1?Q?THx6k8trz27vT8gsW6Zc+w4esCS9NAmHaQRyeauleB2X/34LOMZlZCEPe8?=
 =?iso-8859-1?Q?C9grS8n4NwW7Kvju/cPNfaJMikkyeY364eYmE/jJKPmmjCXaEhqCpA0XgS?=
 =?iso-8859-1?Q?VsOCoN2R+ejWtVee8o+gNoycCwWavd/AwswEeVrjMAU08aGyUie8Hgeejq?=
 =?iso-8859-1?Q?8Nxy62/fRn/QBYoclxMa+jStQovuixmIM/0CI2kfRYv+iTaPJn96y5kfSS?=
 =?iso-8859-1?Q?TLAhIJtkX7Yj4QGDgNEam8CDMd4E7UJOTIwAL6KVMFEmw+DhhEZpcyeXUi?=
 =?iso-8859-1?Q?bmLHcMCMFwDI9LlXznsiEWlJbJ6V2vDFNvOyU0ItmAW9Zjxh9h00Ek7Hk8?=
 =?iso-8859-1?Q?8r+GAcYZmsMQ+35stjLlmmwDA8EZ1XftXaFaqw+stBrgcGgvezX+6S6F3k?=
 =?iso-8859-1?Q?RNjsEZoU1FUffTxUW6oUb06RsFcpEw1G2pSuazrMoQv0vSY2zRlX+KU9AR?=
 =?iso-8859-1?Q?8ZwxWXXwsqKtX46bgxc80C7xwpW86xk4YzPDMyojbCv50clvtJ+EVH1kU3?=
 =?iso-8859-1?Q?jstU8XVHSgJx4qrapdc6m/XjGEof8rcXvRDjmLTKnljaw4K91WHkFeGzol?=
 =?iso-8859-1?Q?g9aSp+ZjVs7o4sZ1sHYPoWETvsiTiGw8DYlD/8yiWKMcY5Qw6r2hCFOy07?=
 =?iso-8859-1?Q?Gftc2LxVPNGmHz8XR3yyZWt5EPsBBBeaeQcJoD+ZsepYLicQdLP40wAaTw?=
 =?iso-8859-1?Q?jZcx9Zsq/1GTm7TEFXzezZ4bLo6pyIhJjHKwP79AJ+HI+Fzrx04wREl5F6?=
 =?iso-8859-1?Q?OfCJJeWhrvvqvM9XYbl/NESeaZ2uI+JJdUwv4Xzwp8lEOdORqjUS84Exus?=
 =?iso-8859-1?Q?lPmJVWk+LleeoA/idfGlV1unOJrBepXxzCebEYdP0ieKY4tKkMzunvi/O/?=
 =?iso-8859-1?Q?sDPuSDm2fLGmOuyCkjrct+XIUzs/5bkJUofY0460P/oHfK+7XeSfhXpj5i?=
 =?iso-8859-1?Q?sy5Iqz9A6O8dO91vhYbHI8poSiIkl0jjmHDzWHu1KQH5vuziuyqjM0hOU0?=
 =?iso-8859-1?Q?ZmxzUzs99Ck0QwywIqSut7Jk9Fb1KeDBPXefNRYLbpmedBsxUO1yDHn2eb?=
 =?iso-8859-1?Q?gddYKDuCoRl6/yCO/koliR3PK6MCfMoYGBj2iqmpuanm5c1xcYM9632CtD?=
 =?iso-8859-1?Q?NAsRicaJ16tuCm81/Yh9hc2dsYxUdG6re5aWcwuKPSPe6VNpFRPho5VIuO?=
 =?iso-8859-1?Q?CS8F3/PlgjtmmoxS2Yc9qvoOXHnusP/WU7uKLlktiBKIBrmp/vR4AECSPU?=
 =?iso-8859-1?Q?noI+dLmYldcGO6oq35D9fITuA=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a15dc9-63fa-49a8-fd29-08d99ecd46ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 13:24:34.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbAMjjd9ITFd8/WxHjQjHxIeJXhh3sFyvH71yV1R5wMjDtUTdWWClM1StnB+Ko0Yycaao7hjw+KAaglRIVyWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5643
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Nikolaus,

On Wednesday 3 November 2021 14:00:10 CET H. Nikolaus Schaller wrote:
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
> ---
>  drivers/mmc/core/card.h   |  3 +++
>  drivers/mmc/core/quirks.h | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 7bd392d55cfa5..2f73f8567e14f 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -59,6 +59,9 @@ struct mmc_fixup {
>         /* for MMC cards */
>         unsigned int ext_csd_rev;
>=20
> +       /* Match against functions declared in device tree */
> +       const char *const *of_compatible;
> +
>         void (*vendor_fixup)(struct mmc_card *card, int data);
>         int data;
>  };
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c7ef2d14b359f..a8b82b34dcfd2 100644
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
> @@ -145,6 +146,20 @@ static const struct mmc_fixup __maybe_unused sdio_fi=
xup_methods[] =3D {
>         END_FIXUP
>  };
>=20
> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
> +                                                const char *const *compa=
t_list)
> +{
> +       struct device_node *of_node;
> +       int i;
> +
> +       for (i =3D 0; i < 7; i++) {
> +               of_node =3D mmc_of_find_child_device(card->host, i);
> +               if (of_node && of_device_compatible_match(of_node, compat=
_list))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  static inline void mmc_fixup_device(struct mmc_card *card,
>                                     const struct mmc_fixup *table)
>  {
> @@ -173,6 +188,9 @@ static inline void mmc_fixup_device(struct mmc_card *=
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

Thanks to take care of this. Do you know if the comments for Ulf[1]
are still relevant?

[1]: https://lore.kernel.org/lkml/CAPDyKFpr0kpRXoUACNNSwe8pL1S9wJPjnX+GFGS1=
PNezKCDYzQ@mail.gmail.com/

--=20
J=E9r=F4me Pouiller


