Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC52C433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 15 Oct 2022 06:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJOGop (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 15 Oct 2022 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJOGoo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Oct 2022 02:44:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEED2724
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665816283; x=1697352283;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RjaXdPZW6T/AzkeG60pkjtXNKQfPK++RswvWijm2UNI=;
  b=GKtxLecszU2SL30T6xZpU9ODmQBlAeh3r74JrplULvdv/XbERe7u/jPD
   vLW2iZwbx+1Nf/wG5VrikpXA4e7dH9X8TOtuo0GDSRuNx8Io3zN2AUy3o
   xsB9REa1+o2zFvc2Y31ZmxoGHMz/9G/sDhjBSNE3b/ufG9XO7/PABsJtD
   99nKzct8sS/iLlnkpw1lHXmGvqi/TMaImZ7pirCn8rAEe02v0jubWOEUB
   SLJOoWh3ZuiKAeJPpWphe0DaE3RdmPTmAAcXT1vtRKo1j6AMLGHMrFjmr
   xHyIGQDLyu4ahAzLQRwWSuNS2D7TZ9f9foHaop6lqb5VANAALUjBZW9UV
   w==;
X-IronPort-AV: E=Sophos;i="5.95,186,1661788800"; 
   d="scan'208";a="318180309"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2022 14:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFTs1z0/7h/ThIs8t6p6+0JxLDBqkF2gOSeSYzoQzGYbisNLWLGL2VMLIppRkr0hXN3eWj7DRG82nKqbzu+gWkEodyvnChp9Boez98pjbLr+KunUwjYoyerxzzvZvMLAgGYM7iMpqmz5Jl0HC16CPXm1H9pfDVg8UAO0qxP98PAz6QjJemI0wSchXNedIuHF+XyCqwX47q/IA6VqvW7qhhoMJwqZp1LqWFf9YB2F7lme4uvigNTk86wr+6tV47quX39B3kVAz9fOz5K2p0X7AR7+ep9M+lfY26IILg7C3tNvdIyVN7cnU7cf3mHpHvc0SPKKf6lRKkP3H1fvfAKMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bC/dwmYeT3ab7O4pNY81TgC/8+Y+ApScEH6EyQVWCc=;
 b=CAmu+WnmY1fSLgb6rRdCrB9aVXM3xN3539Uq5ymejmAe9m/NCzkoj5Xh9tOhSTa0mtm3MGroLX13IAQzONXXVxPf9vhrcGQKlZ4/hTzIDGcjQ/K5nYMCAqYGHjAabTitSf3Cu9mQDuZXqMc6U5gJGkygMUX9fBvRkgmLZsZVqA0Si4upc97EgQQ1EKb24wFXHGeOdnLhKK9fGbsqchkt+7TmGjIOplmkLvIZjWPVCS0G1/hbRzxJUPfAUFTwYUayeJSKYlVYaYRGQa5QGHLbOcTKH2CxLz/+j40a6n1ja63m2NR1YAX2C9S7E91isBeyoVxadn1F/4nnHrujbpuxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bC/dwmYeT3ab7O4pNY81TgC/8+Y+ApScEH6EyQVWCc=;
 b=bzhtGlC/mNm58TNiz5Yc4m/K8claZ/5M1g+otqMYtYY7YJ+f4ubrrijBq0+ynYfVbbYY2FYbpa2gXXQgKLei7/+rK7x58laAO3F5VyXOknM7anVm/9GJYTXtKJIZyKbTBzTN+Jg3OGWakfLeNJ+dUuyhKCT9YOik5MhbjIOXxNM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7633.namprd04.prod.outlook.com (2603:10b6:303:a0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Sat, 15 Oct 2022 06:44:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%7]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:44:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv3 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Topic: [PATCHv3 2/2] mmc-utils: Allow for custom sanitize timeout
Thread-Index: Adje43JOZaYCnu4XQLyVuyVzcXP++QBfY/lA
Date:   Sat, 15 Oct 2022 06:44:40 +0000
Message-ID: <DM6PR04MB65757023C99C041522C6C188FC279@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <5a0ec3abd08f437690c705fe2da4766e@hyperstone.com>
In-Reply-To: <5a0ec3abd08f437690c705fe2da4766e@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: abe98b33-4552-4e03-9038-08daae78bc1e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F87XGLwPkpZEkTUgFJ2plO5Ea5bSlvpuyYaWMeTW3R6zBGVimEJAHgXJJ+VD6hGZT7gG4f478vFFyDlf5vhJHYiwEF/dlOy0Ad+aJXQhcqPB5xRLAKMszmlf4fciNwSH3EC3W42I6mdBfZ+KEJ1v3NGFasXOa5n/bwZsot7Yzp6wrbU6y1D0VF5dgdQIYqxaqHmoVLY1tL0R9zAriq9ZIIApasWu+2UYfoWURZsNCQk1Wnd/ae2fDOX58H5ES/ltLYuNyXbbDcnsNOcmpq8QFGproZ76ArF2vau9+ON8EylrEPSoWZQ0lXtm5kabdH1GrQI3yqDtRiOOwaqW/qHWaK9hlIVXjg8gBXbbVSuOPu0NqLukmz0lhlmDCZ6k9A3v/1tkYkkdbXZFI8vc+SqBotHab00WegpYEDe2EUWDJ1yCpYPAUz1yCOoCXrTyFmTkDwXJk3g4qxTg5P/JlEf4nGyAG4jFCad1fRMkwnk3FV+1+UPYZVIu2gijf4NkiEMMarHSwTXmprooDNq06ef6cpQ8x2IPa4y0rsIF9OTOrrOoc9x2vwkU3gdM57dbpoCDyjVd6fZrkbqs0+PAYnfNHPQi65cPLm/6069gXg7BIw9iUmmYbgpnPdG6AkjSuCiuObtO8tUSBMAuIU5OdmO/S5gKLrvYdGFuRT5g8j85JflDToEB5DCN59UFok2td9a0xDMI9Dh9Gzbo6Myj4qPNCyL016nQOIuEHRyY44UGaaasDxeWmV9GqkpezZ9h0qcST6Gje4OoYn3pHMb33rj9NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(186003)(66446008)(82960400001)(7696005)(6506007)(83380400001)(38070700005)(122000001)(86362001)(38100700002)(2906002)(5660300002)(8936002)(26005)(52536014)(316002)(41300700001)(55016003)(8676002)(64756008)(45080400002)(9686003)(76116006)(478600001)(66476007)(110136005)(66946007)(66556008)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7XODQm1jasDJqHdNfi5zXVD6epiaFbriILBn9Nxnb5eWctIDUlRoWA0l+q?=
 =?iso-8859-1?Q?7QDLJuxk3B1Km0mLTffLHy/0DW0DoaM4p6Iu4z1xi5xTpkB2An178q4ykd?=
 =?iso-8859-1?Q?lWXPE4OsHUU9+ZHPrTbS5ONoMGtixJWIkAwkrJYsQe1zgupm9F5+4Y/gdu?=
 =?iso-8859-1?Q?qMUN1hiI+Ew51qNBrZVtVUYZayIW0vNJqe4Db+VvboCFxARF6SzXgYIxwe?=
 =?iso-8859-1?Q?Tu/Lh0Lp3j767lesg16vI0nFVdhvu5c37wkxIm/98FS7PrkMvH3oNo0CrI?=
 =?iso-8859-1?Q?Uqo0HUdvN2kX88Rc/H4IGNh1c8Eobtv771g1Di8Ucp3nYqKshXb5rQOzSg?=
 =?iso-8859-1?Q?WnMTNCrIfDeUB58OBQee5IJKBflVskOE6c7p1jIDT17q/rSM30J3SqiIT+?=
 =?iso-8859-1?Q?cCJfi9r2zxjFeLPD8GzVlo0bsKTYoSJqhnQB2lci/4AsaBusVAdOtCZFuU?=
 =?iso-8859-1?Q?WCg962vxB8Nkktja58NmWXSo69bIldYjIAWPgAo7s0ByoBlXww6U8YG1KB?=
 =?iso-8859-1?Q?PSR4M+FFUZDjgDtw3Vzypog6udqt1XeATyIwZX1lgnxXey7oId0RIk2YxP?=
 =?iso-8859-1?Q?X4s3fXqCMwRNLhNx8OfxhzRN1q32YWRNAetP3UuqqY9gxRPPOnSfRT31C4?=
 =?iso-8859-1?Q?1m80ws5k0tIbpUDcMd3tPmKByXEo55+Euz4Z7zQKre7tyE6Xa31woY/8k+?=
 =?iso-8859-1?Q?Ix+ONGCWh8j7yU5y7A8EyUM0cALSN67zDuwphDzQBqTsibBKMjlH4jlld8?=
 =?iso-8859-1?Q?DnMV1ihLelq60UUxOQ0K3bbpJHIUNo9Btf3JNbHTt2SNCNjMtBSJ6NWWmY?=
 =?iso-8859-1?Q?aS4Rz3MlC/Xl8Z1RXVlHIBaNfJhm+i8IyeDj2klEvSk526xFNykRLxJRrH?=
 =?iso-8859-1?Q?0fVTHz1Sf8VtdIOdih7cUjlBBNT1V1cccejfQCXnIQp003AsSGm1FpWpVt?=
 =?iso-8859-1?Q?zlOmTagZLQN4d96bzLow0wEWX4m7tZ+2VLKM+8Zwllkku1zBJa3+UfCy9W?=
 =?iso-8859-1?Q?vyBJ0IdroprpohAUwjRrTqxQ4Uo9L3I8vIF1kmlMd+g5Xkk0p0N5jldpt+?=
 =?iso-8859-1?Q?1TJz2dlK96Svhb6fvks7N1QoA9Hbjrv1Vcvzv6VdLMsCsVC6ho9EdSXb8I?=
 =?iso-8859-1?Q?/vw9h7X3KGuzks9ChwuanJtTSXO3o6WPEvp2n23zE3D123cGC30biXRhun?=
 =?iso-8859-1?Q?tin9YG7retjvVB90P+wMubKUpfT2vQw/LZjFNmcdw5gHZOlAuRP8liD2Ip?=
 =?iso-8859-1?Q?jQUQTKmrz6nJ4HHk+pMWggGiJhJfAdS2nHOUxPLsJygpWLyfcU2+GUmGjt?=
 =?iso-8859-1?Q?LyqOa7QftOoRkeymw3g6l2l9Ocl0KCDKD/OQBE3jjjWnYLzZFlc4yQ0QoC?=
 =?iso-8859-1?Q?C2rYxNolPwqqigEN5LIx1xJLlLkCUXDtjc/ju7XYTaE9IVCyGEOlcPLxta?=
 =?iso-8859-1?Q?9dgOWkXRpnBK3EUv1tuG9HDf/rIiLBmnd6GnoW0ARj4uGnT+75zxB/4Vd5?=
 =?iso-8859-1?Q?0d56egQn1/Q/NzeIiRZh7LuQsR6AzMGrdkj9mE5tW8PKizDwVs665HuYXh?=
 =?iso-8859-1?Q?ancNCZcZoeY5/9Mrw2lmpDkjy4rWA2mkkebPe57OL++d7VPbBv9zkmR3+X?=
 =?iso-8859-1?Q?/WffQYCJWxV0D8LbDqHygQEz9p9flDoFtX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe98b33-4552-4e03-9038-08daae78bc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:44:40.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1eP47IMZ1EwSeZFtqSHJbACgDHPLaqjhlC6lvZcNQ8CaKjoV+Dt8nwFFz/8YTTrijg27Aro8YGvCsDIosXtUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7633
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> Some cards with certain preconditioning require a higher timeout
> when sanitizing. Let the user set the maximum timeout.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
A nit below. Other than that:

Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  mmc.c      |  2 +-
>  mmc_cmds.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/mmc.c b/mmc.c
> index 6c56387..2344879 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -150,7 +150,7 @@ static struct Command commands[] =3D {
>           NULL
>         },
>         { do_sanitize, -1,
> -         "sanitize", "<device>\n"
> +         "sanitize", "[timeout_ms] <device>\n"
>                 "Send Sanitize command to the <device>.\nThis will delete=
 the
> unmapped memory region of the device.",
>           NULL
>         },
Isn't timeout_ms is your 2nd argument?
Should come 2nd in the documentation as well.

> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3337ded..4171dfd 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1986,12 +1986,16 @@ int do_sanitize(int nargs, char **argv)
>  {
>         int fd, ret;
>         char *device;
> +       unsigned int timeout =3D 0;
>=20
> -       if (nargs !=3D 2) {
> -               fprintf(stderr, "Usage: mmc sanitize </path/to/mmcblkX>\n=
");
> +       if (nargs !=3D 2 && nargs !=3D 3) {
> +               fprintf(stderr, "Usage: mmc sanitize [timeout_in_ms]
> </path/to/mmcblkX>\n");
>                 exit(1);
>         }
Ditto

Thanks,
Avri

>=20
> +       if (nargs =3D=3D 3)
> +               timeout =3D strtol(argv[2], NULL, 10);
> +
>         device =3D argv[1];
>=20
>         fd =3D open(device, O_RDWR);
> @@ -2000,7 +2004,7 @@ int do_sanitize(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, 0);
> +       ret =3D write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1, timeout=
);
>         if (ret) {
>                 fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in=
 %s\n",
>                         1, EXT_CSD_SANITIZE_START, device);
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

