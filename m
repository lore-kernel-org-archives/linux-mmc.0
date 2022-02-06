Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D07C433F5
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Feb 2022 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiBFHsJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Feb 2022 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBFHsJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2022 02:48:09 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 23:48:07 PST
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16FC06173B
        for <linux-mmc@vger.kernel.org>; Sat,  5 Feb 2022 23:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644133687; x=1675669687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nndRWWT98/d7dlQvUYrr42zpr+0lmMKIctV9c14ov+c=;
  b=ZjxsqQNci2gjP4Pl5zcw5dvMfZeCrpmmxgwMfsVcdHcLE9Lr/OnCTTD+
   yxAqSwaE1kGKJNlC4JYK7FFuO2kJbuTojQFWciI/PUGeVk6i7duCK9JCs
   TX8v/FgNUsSPKo9B0pdtcx/Qm3TE00zdRcvN4nwn9tmxwLFgw8fJBpVyX
   sroPNPmOhafSJcJi7tjKCyGAVcsTpbS0c87WpAl67LGac8LykqtoMtQJK
   YGNN7VHZVO5Tnnqi03Dim8HeaplC5tm6E5eeRAg8FUu5AuA0G3Ht/xyiZ
   rTC65ZLrqDmKLinhBcTNIOwxuvZX4mUPVBnJvV7evowiMs8TbjNCIlRdE
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,347,1635177600"; 
   d="scan'208";a="191194148"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 15:47:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsc+wdYra7v5NV1l+oHstOH99d9PLWSo1v0IzGOwHxoNX0Rqi8bU5urmA22WE60+y7TJpMyfqFJRnjM+a7uIzbQ5UmIpelslVGWqH4b+12dJQ0yFpoSBJL2aGOiI/wJwcMuHX9hULjaq9KJA3Wck2chT+6xg4pq7zpMphD/hV7R7/3bwC9ih51rI805R97ZEqZ8fWDB5hA5qKX0ii0OG6Okad6KFiJKKKwDSFtWRXd/j0lIWWbCEfpJ1c4RUxYNyAy2+XySGpqyXPmKYwuwr+SFvQtgY0JVC5n+/3MsQ5QiaFkQWc8PZTxuQGBwVPXFlrUEHNlLq/IIrWmogM15fuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2XUFFVsVQnjbN0l9j2/P7xSCjoR58ZrmYqy35HvDt8=;
 b=DoMyN112wrt9mVSDEYwAh0p29gFuFNAR5ZvypyGdfLPLYKdGrRPQTnCFmmSfp9y+DylPQqs4UTTJJxZt/r57yeJVxY50UKAo6eQVxuoPhlkU5eWf5Cw2jVvu4fvuZxW4RTlMuL24v3LrDQlJeH58N1mRF06UFSYyGxC6WqeaVlKY92JS/ESxXVanvgikmg4WV30db4ZAQXEl5nZo5e5ZzQJ176fw/dnekzUUFmldqukdR4P+A5Nkx/mhuppq1MjZIpCSSLKvdxCeKirOoVEqHrmVNJdY4uYed4h+EugHB/EhwZLdRj05Rz8oTtDOw2jcx+PDOHOUJDbLEHwMT3bUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2XUFFVsVQnjbN0l9j2/P7xSCjoR58ZrmYqy35HvDt8=;
 b=DclF+L5nvEOFNatWBO6ufAfVetTr7hZhWQ5wCxpOrb1D3ZmVedwXNk1LifcDAV0gwG+bSHakkon1JrQPu3Vap03S0Mt7gZ4KHZXYGzVvIjlW9d1LdFOaX+qwE/+5j+ScfBRT3xSqKri4HTITyaANS4m7zm2wYNoBpgEeRnkr/PQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3529.namprd04.prod.outlook.com (2603:10b6:301:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sun, 6 Feb
 2022 07:47:01 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 07:47:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marius Strobl <marius@FreeBSD.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/3] mmc-utils: manpage: Document -c option for
 partitioning commands
Thread-Topic: [PATCH 1/3] mmc-utils: manpage: Document -c option for
 partitioning commands
Thread-Index: AQHYGtL68d1ig94h2E6AoqKCqON1u6yGJQlA
Date:   Sun, 6 Feb 2022 07:47:01 +0000
Message-ID: <DM6PR04MB6575C84BE1581A53D7D0D2A7FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220205205647.7677-1-marius@FreeBSD.org>
In-Reply-To: <20220205205647.7677-1-marius@FreeBSD.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced83459-f79b-4785-4dd7-08d9e944dc83
x-ms-traffictypediagnostic: MWHPR0401MB3529:EE_
x-microsoft-antispam-prvs: <MWHPR0401MB3529560A8C70F0A494E2ECF7FC2B9@MWHPR0401MB3529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaqW85deJ5JlpsD/Wltwup6BNmjQAsANO+ds/plG73JsZGx7V18z0C3As+vI+20duAYhTdZAEg9iwGSRAsEjfh54YEZS9UDocLtfPpD6Sv+g0YJmGqYHWeT2/eKpjzv8W+/HmREb9al8xxDfC643zxH8FXhSdlcfdITeHkMcrQLtnduZrjRZQPyhhzv5hXfMhq/hrgjPg9DO/wlWzR6dJ7WDXX3xoGLG59RFRNKX1eFV4+Pr5Fh4Sxztv30dlI21LwqTJIvn/9VZe7jOcv4cc6N0XhIRVitES+gTUh0cW2jfWeKhOi1vLZDFxu8naANdIyR6pykLRagfp+FQKgBxlGse4iYj5itrAXqwH2iuGhJ0PPHrniv/RCGbzzBjo1EWp1FCTOp5DWU+l6bx0oeStJkFKxWY+GSNb0ubd0KsSmX+cEMAeKJ6vusFHMKXFdttg3h5D1sT7UAUGIbHM7sYpanq8prbzMTmJbAHgVWj8xq6hvDouUWOp5HCEVa5K4wAiThpzFJEADps4zDEsRdBIzyzOe6mBIJf6fWY++slMQOuD3NhN9HDjQWvV63CmM6sp4uXkKWmSX+4A9gs9vXWw0eS8XoDPSFAKuWvt/YXy/tpiMEp6Za9qQPeTVD6reiXwsE+1dx34MGqAK0Ws2PqP02yy849XMCpdEd7P9LDjzxS0vuQL7Ro8+wX1ooiiAO3EYe6K6TX4bA+VqnULcWC3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(9686003)(4326008)(82960400001)(76116006)(66946007)(508600001)(38100700002)(8676002)(8936002)(38070700005)(52536014)(71200400001)(64756008)(83380400001)(7696005)(6506007)(66556008)(316002)(66476007)(110136005)(2906002)(122000001)(55016003)(86362001)(33656002)(186003)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ITdcXvsbUIFh3jnHTQLPDuHitLgE9zf2SdB064vSeInoAXfbp067YHndprA2?=
 =?us-ascii?Q?b7PP3OxTrYcuX/qEVw7H4IQdCbd4ctvMkLFOBLOsN3RkXO30+8RhJOHu0qoW?=
 =?us-ascii?Q?n4WpRonnMQZo5F2KsdIkhC7lGaiRbxhHrl9WbUJAc1DRcu0LOn2fSCqklNz/?=
 =?us-ascii?Q?9L5pinqjeP8zHHa45bNhb5qGg5e3CAPUMc6qZqk5U+IPC/nUnFD4xPtZB5rz?=
 =?us-ascii?Q?M5peRMTVEq1k+VhbBmsr1fFFiR6AZJlcueSpIes7pz88QYDQl7LcfTneIaJF?=
 =?us-ascii?Q?0uYsfj0L1pwHKx8q1z6CCFwKBSm3uj69yibpYOCTzUtyrPzJCABjqrSK7+O/?=
 =?us-ascii?Q?/OgNwYWhaf2pZvCbPUyash55IMunmU01xJshuz4jb4EjTLD+5wlp7m1LFicZ?=
 =?us-ascii?Q?ue95/mziYazlFr7048piyqKPOC2CMTMIrfN96npjIJA93xKa8E+jvO3ACPl5?=
 =?us-ascii?Q?SeqfdSyrR3vNhin8xYTrDnYjMOqXo2Qme3TX6T6GU2dLdJCbFS0nol7TKG3x?=
 =?us-ascii?Q?1N/Py5I6G9KoM/YPqoM1e8yxZo5ofVQCDWMzpPteOZjy4eVECx8lVbmEsNsZ?=
 =?us-ascii?Q?DnNT9ef0lhU5D9bDGkIVQvL94Cw/Touqj09Jzy1y6dxrKM6TJVBp7cGPWew4?=
 =?us-ascii?Q?qR/JO1lG/OFoY3OuAu2Oa7zv6yNzuu9OeORdCaJ7Xt4iYwx0dtoGoVZG0bne?=
 =?us-ascii?Q?4Aq1t14du2CXjQABy8XkWzUEL3lZnpbyhhq1UNY1Zq+KZxNzfhCTZ/HT/0qo?=
 =?us-ascii?Q?Kq61fy/EWI9HLBnRPRfHNq12OlcDCX9OyHAKrLNe+GFHQMcHX/I8xh7xBzkb?=
 =?us-ascii?Q?5Rac4iYGu6GIuX2H6ssChs8B/UnPiZHeeAwEuOi3CZdekiMfQTz7b+todS9c?=
 =?us-ascii?Q?UmeDk68N1J/0hbrmZDkihipwaDgLA/CkimdNuGBAamSVr7fNV/x5q7hPHv0w?=
 =?us-ascii?Q?1hTzjlB1Pr/eWlQqDPXJz2c+1/6ARUxXd8FHsSa3+TG8Jwr0auIVRVHW38cQ?=
 =?us-ascii?Q?gO4yZ/yrkP2qbkPGxmoqdiE60zpDa2hjTVk6Va89Bjr6kNEY9Jg3mS7RnPZW?=
 =?us-ascii?Q?gdrXhrkQGd9L4pZbmwIox04IJPeVrJzzxuaAXGtRt8s4too9kFiRljH05zEe?=
 =?us-ascii?Q?hyhaEpdgTavJtccEsfpSzkLSukYxDzt02AtkB2NZ+LuI2E3SKHuArWzsamLR?=
 =?us-ascii?Q?We9I2y5Jlext3hPlbwki7W5Xwzc9YCFxdzK/7rBRBbl57z1qUtBtLfe6A/eA?=
 =?us-ascii?Q?Tru4/iESpUqwyJ0mYNTetv7uE45uDMdHbvIWaNjDrVudZBFQL1ipvWmNIj8E?=
 =?us-ascii?Q?i5cM8cjQnkCAC5PrgisU7WE5RB960+mDo8HGQfrHpXI0L2LfAjnONuP1tedu?=
 =?us-ascii?Q?0pwJ9Wq+TsQ+Be4MmyqjaHGjkog8UMuuzStlkxy8LHaIFVH9S5E7GV4Tk9N+?=
 =?us-ascii?Q?VRNG7KRzPSLa9N+HfXw31GqZCgunkgMBmvRIoOrsczcOeFu7fIFBafCPcxh6?=
 =?us-ascii?Q?YoAOUabkuX7a5HDMrjr2wnJLv4KlNKiqp8V9JaKpJnH3eeHeuC3XVmL8VsRp?=
 =?us-ascii?Q?akt81KCPmlPCByBhtcRFI9mlmmRz7tZt1NrQFshU3oyoWVyJQcwrfMWS2E+C?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced83459-f79b-4785-4dd7-08d9e944dc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 07:47:01.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OlHeRms2a/+65UbxIHND5xRBBsaFqNpl9+f26UYQfNdKm3qoc5qrLitSNJQHkk6Vu5HpBqDQFayogVXf7w9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3529
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> The 'continue' option was added in commit 752072dafe9c ("Add -c option
> for partitioning commands).
>=20
> Signed-off-by: Marius Strobl <marius@FreeBSD.org>
Looks good to me.

A small editorial comment - if you are bundling your patches -
a cover letter is usually attached with few words describing the series.

Thanks,
Avri

> ---
>  man/mmc.1 | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/man/mmc.1 b/man/mmc.1
> index bdb6f09..bccabf3 100644
> --- a/man/mmc.1
> +++ b/man/mmc.1
> @@ -30,21 +30,24 @@ This sets the eMMC to be write-protected until next
> boot.
>  Set the eMMC data sector size to 4KB by disabling emulation on
>  <device>.
>  .TP
> -.BR "gp create <-y|-n> <length KiB> <partition> <enh_attr> <ext_attr>
> <device>"
> +.BR "gp create <-y|-n|-c> <length KiB> <partition> <enh_attr> <ext_attr>
> <device>"
>  create general purpose partition for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  To set enhanced attribute to general partition being created set <enh_at=
tr> to 1
> else set it to 0.
>  To set extended attribute to general partition set <ext_attr> to 1,2 els=
e set it to
> 0.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
> -.BR "enh_area set <-y|-n> <start KiB> <length KiB> <device>"
> +.BR "enh_area set <-y|-n|-c> <start KiB> <length KiB> <device>"
>  Enable the enhanced user area for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
> -.BR "write_reliability set <-y|-n> <partition> <device>"
> +.BR "write_reliability set <-y|-n|-c> <partition> <device>"
>  Enable write reliability per partition for the <device>.
> -Dry-run only unless -y is passed.
> +Dry-run only unless -y or -c is passed.
> +Use -c if more partitioning settings are still to come.
>  NOTE!  This is a one-time programmable (unreversible) change.
>  .TP
>  .BR "status get <device>"
> --
> 2.31.1

