Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E8C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiITKRy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiITKRt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 06:17:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E106DAC9
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663669067; x=1695205067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8RNBbFNLda+yv/bO5hDwcw6DfDK7tw+ugpC0uW0C0RU=;
  b=Wt6mWon2fPSRsAaVviq5XJRl7lsIgyLuaTGfnsXLWF/hvtfriRTBpka9
   bjTn0Eq8xXdpI3gv49VhGKNoOVZBVRLD63vJW6XUjHFf1Rf221jUEaDam
   MsoyTWVuj0oJ9yeZdzIDdGn19OJOlX93tAq9U2cH8oRzZTwra28SSY1QY
   9yCXHPlOY6E0SN/ogdZkWB3y4CvRCWOSovhTnVKArV8GWHC+7RjOUjg6a
   cI8mz8ClLydbLek8ShsDYV3QYWo5WL3/rG5NLwStlPkX5nnTvSIXgMwzV
   HHvweupMPPbTh/821ZoGL3Lt4DcdBdX4laJFHd1P9NCyI+lUHkpYcmVso
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,330,1654531200"; 
   d="scan'208";a="210185365"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 18:17:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5dptA2UU4tsgMRdp7xOawDdxB0/9Km7ajgSsSLA4J57r/ZFYxEOfjs8ZBLIH7QEj5AS59ZLZ9Pfv5wgMgwh0o3YuDHHMVpkoVzqIZk4xLtrD/ARDMH/qLCMLt5TyMjgeCoAhdaSlupFPcT3L2WznIefvwxTrAftowHpZDX33geniawPSmiebchsHXPkRpgY8u5e6lXmV17rwdr1KnI5UwaeNk1MIpmYHB2utRL+VZ+WudIQCmWTmNrl0eSmM48smu5vZoQNxR/eo9a4JO1sqCpYT4g4eQemrVS4OUtv8KxdxWZNWHB5o6iYWrjOADJK87cQnITO8WxT5GIYIdpwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+jzrf1nMBDAuT9aGE6ZB2A4yMstJjd143FuN/9GdM0=;
 b=DtX6VsqbmwFjWjhJqJCSCTx2m67IILXT/EHdo1MaMl3fUu2ErAejvFwprMqXyrgFrfAqjQEQPKFW5sBMCW97p5FSjDo6UZeyL5YWSyZG/hgfe2gnOxLhvO+2m5JkBBCsn8muVf5q4A1oBdEV0MeVjTA1BB6kYri3pU4QmylfUCE64/e1Igxgzln+1w3cOR6ptVrzQ7XonrRFZigYixxpaZNou0hs76NYGD5d/vME4gNKqqJZ8iGEa0/99OUyQL2TpgRA2YTnbCjNoqwCDrnErmqhGdBYPAkO0iXu4w9UH9pjakyHVd+mc/oVjt2W3p1CQMAnP3NubeC8vbRxGdYHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+jzrf1nMBDAuT9aGE6ZB2A4yMstJjd143FuN/9GdM0=;
 b=raYCb5oojqbZhu8+dtuk9VfHuNuho8Jx6DnuzmA/6P24LzZEgXs+ISI/js92kOv0X3mYOBLKiPgzSsBKQyjc+TYUPNXTIJIfLmJ1uU1Mn8e/uZRU8pQBldeFLheS2d46v+Fzgk3J+iWDVcbWEJJyc1OIe5Z6EM4kB0KYy2qXP8w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7764.namprd04.prod.outlook.com (2603:10b6:303:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 10:17:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 10:17:43 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Topic: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Index: AQHYzEOVE1e8g7Sl5UmW+071XDkLu63nRp2ggAADYnCAAK4IgIAAIvLA
Date:   Tue, 20 Sep 2022 10:17:43 +0000
Message-ID: <DM6PR04MB65750F5EE2E1C9D2CC103A64FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220919161852.28072-1-bruno.matic@nokia.com>
 <DM6PR04MB65754366E4FFD588A9EAEB27FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB657501FE8AC5E9937FB96AE8FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB296424D4D1E013CFB88EF0D7EF4C9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB296424D4D1E013CFB88EF0D7EF4C9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7764:EE_
x-ms-office365-filtering-correlation-id: 6f1dd9de-2f4c-482c-a13b-08da9af15b43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojJRydZqf9TXr06rkXwlzr78nl2VrPHkbe/inn2JOyaV/R5+wobghBI6mhtNyAz/Rsghr2/3bLAWAYGHzDPNaU5MqziTVsVhLgnvcEW8Mmy5G8Xe2M7Y0aGCR2yU+WD9g36sIzlJpYhJO3MJNmOmVVBTWXkjhLQMc494LJIOJwRsKVg3s6f+Gkodu/FWiGvVy3FhZVu73DjTr0SHn5ACtaRjsinrK1vlbD47bgdsTdoohD9DmOb823LlUpgEqqy5Cz2RQesMPd70ByagYAM0hXgFdOTw5aA+iAd5xL7O2sspA+taxXdb2H2M2BJKajjrnF9X3jQieOhHzjY5jjEUVBNoqceLCg0L1gX4SJwaodtGjJIXqmy+kCyagxKQLeeyBSTDvtJDCrByoUGUZ4Sia/3zKoZEc7U03heXvw950OIpYzQx2AutCn9pg1vg1xmwZ9Z0NM33KfEz8j0GDxjXgdvQR6DteK0fFeAGGqHeFhXPUaAY57tdpdDiL8r9w2GHNMBmS8AiJG4oL4jY2XCQ7ADXZjhn9bfRiKZxAxqDXIFJofLO7OWzTX6Mn1z3HNMyirrNk8HpAEc01HDNOD2uuY16chHR1yIaDOZkZHPxF3QhM2rVH+MbdpH/zfGlyhRc93QjKHkEnCnPbrpNo4RSlQ5EbsmjPuvlfAc9w9f/BjqjeEMXyhmPKnzXLJYYHSg8a8YZDtnYyC1KUYGuwDUgTf7FMdKWFigeY7CSjymGMa+X+IriWnLDqPykfSaK4DrMqV5dCImvQqAun/5wHlU0dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(2906002)(8676002)(54906003)(110136005)(5660300002)(52536014)(316002)(296002)(76116006)(33656002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(478600001)(41300700001)(71200400001)(8936002)(6506007)(7696005)(53546011)(186003)(9686003)(26005)(38070700005)(38100700002)(55016003)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?gBUCDECGos91cWxXei0TFtxgpjF8RMSPQwxal+u091dAqqbGKk9WLw7gox?=
 =?iso-8859-2?Q?5ZTJVQPwaq0cMSiTp/IzEmj7CvA6DNawgdMDAUbxCQbsjj+cwp+jAKToxu?=
 =?iso-8859-2?Q?Q/mX+gwC4DTJIKz6LXvt+0EhftNg2OzdJEMVqhcalFrfQ4x286DKMHqFwt?=
 =?iso-8859-2?Q?tkiTr8EHyMakyURyP+DQxYK2AvLW5QjnVot6DD2t9Erk5/tD+mryfiCGoQ?=
 =?iso-8859-2?Q?7qy7s4Po0EvhRRbwb+GOheFavdLZYk2SPEno0+NNGPuuHPNc1p4QrmrEcS?=
 =?iso-8859-2?Q?X+SrbuapsP6yCnPztONEzjrqgp9wgb8jtwzOABpfRVIw7GwW+vpX90eXPm?=
 =?iso-8859-2?Q?AtOacGOIsGlw90eh2jIoHfrK4U4SsYKYjKOxbA5EDDAqh8Sjonb7bhdbXl?=
 =?iso-8859-2?Q?TeHRwFdQN/XStPEi9NF3r5LIHxiypwvH9uayOzs3s5KnElcMMb3UTNrfdB?=
 =?iso-8859-2?Q?IA/aLwDEPaRz7pMR0jGDIke9Gs/Pm82FXej8C7kE6pzZs1jwLFN2tb5aGd?=
 =?iso-8859-2?Q?phKHqJ3rn9isj94097p4iSuQWoRyx4lFbaIYY1nWeXH1J4Kx7PfzcHFrPD?=
 =?iso-8859-2?Q?8Wo7WAuzRK1c0nl397Qi2zoBAhaeeizqyodx1OEjzQ7ggu+UejcfhNHdTB?=
 =?iso-8859-2?Q?EgD1ET8l5wu3MEQ8ixKM/iCCjmE1j2PlvSjY1xHmikzUyWdse1qoU19d4A?=
 =?iso-8859-2?Q?HYMLlN/g/xRqHu3YRpubY1buOmCEXUS24AQTeu/Y2Kri9UHLI9+8wyRfCY?=
 =?iso-8859-2?Q?zwQzzNIXmRaJoVu/DuPZiAyQFRxjCcSkyVrne7VWqnzITk0O00Sh1QXuVm?=
 =?iso-8859-2?Q?cW1PPc513Ep3GnVFwq71UUiaEjzJKJ5zewJCaPD/0Lt1oYx2HepkMVaN+x?=
 =?iso-8859-2?Q?g9aMSXhv5Vgblx9lcmiL/SU+9lFIHz62ybNxn83kAwvc8pzR8dNeBJ0qNN?=
 =?iso-8859-2?Q?XrxU95yZeJ07RZf4Ie6ON+psnTDoRXIaUQ92C6kwsfvkU0rQTJANXXitRV?=
 =?iso-8859-2?Q?TOIgxz4qvejNOWUsNBIUWVAOpid9Jr6sO8iCsPpNFTz6qmsj91cmbWgaay?=
 =?iso-8859-2?Q?8v3EHfogdyIVOZtSuVIS5R41T/Jium57dxqgYlhhQj9w1QDJAL0UwN27QE?=
 =?iso-8859-2?Q?IWgtKWG6Mv2Y4R374hQU6oZ9vNfR3uyicfTiSNi3mRJHZH6I9ivvsv0tUV?=
 =?iso-8859-2?Q?KDvDoI0PcfTbHcVkiaSKK1qUzeo6K0Ol0nLGmjZEhbkRwxjSERTPX1l2Rw?=
 =?iso-8859-2?Q?TN6cqch7Qmv/nmXCAxnbZM+mjAG6Awi4eE4cALXQnOb4GP1b24aHglaBF6?=
 =?iso-8859-2?Q?6AdizXdPXIgoghPC+wqUHVdWzylWhszVmUxwNrYtpWHwHtnuMXUw9lQej+?=
 =?iso-8859-2?Q?wVaSzkEiNfYlWqMwhye+O8udf1kyrVWwnlwmQzY8UdnljERrYWfpiSE4Hl?=
 =?iso-8859-2?Q?AS83gi69wtH1f+7LLcifFIx8REa3prWy7Oisk6gEwlg0oJaCdc1CjihGT4?=
 =?iso-8859-2?Q?ClBOsc1d2xzCm7v8v6GVzgSq/H/miMW1KARfaf1xY3V0YyGvpVjIh/QM2C?=
 =?iso-8859-2?Q?UTLVmdMEZLGXhzPtQHFsRM+Ji8awDy+qdpuFKJUhBatI+sbxOmzHH6+HoO?=
 =?iso-8859-2?Q?3jnU2LptFF9VRpmQkHu4kZrWjK5Vb+oaf8?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1dd9de-2f4c-482c-a13b-08da9af15b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 10:17:43.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ew98UXV/KRm2254/4szqsEks4C7bN129GpUmvV+E/SO42+i2VnuQufuL8eLBSz6mSJ3VMXvB2mo4rEATSg4Eyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7764
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Hi Avri,
>=20
> ext_csd is read in line 2789, close to the beginning of do_ffu.
Ahha - you are in the do_retry clause.  Ok.

> The mode check and skip is done by the following snippet in the patch:
>         /* check mode operation for ffu install*/
>         if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
>                 fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
>                 ret =3D 0;
>                 goto out;
>         }
> According to the spec when the FFU_FETURES field is 0 then
> MODE_OPERATION_CODES is not supported and sect_done checks should
> be skipped with no error.
> Further reads of ext_csd are done in case FFU_FETURES field is 1 - to che=
ck
> the NUM_OF_FW_SEC_PROG value.
Correct.

>=20
> I admit that the patch looks ugly but that is because the check was moved=
 up
> in the code from an if-else block that had to be refactored.
Actually I find it quite elegant.
Please elaborate the comment above if (!ext_csd[EXT_CSD_FFU_FEATURES]) with=
 your above explanation.
Also please add a fixes tag.

Thanks,
Avri

>=20
> Best regards,
> Bruno Mati=E6
>=20
> -----Original Message-----
> From: Avri Altman <Avri.Altman@wdc.com>
> Sent: Monday, September 19, 2022 11:49 PM
> To: Avri Altman <Avri.Altman@wdc.com>; Matic, Bruno (Nokia - DE/Ulm)
> <bruno.matic@nokia.com>; linux-mmc@vger.kernel.org
> Cc: ulf.hansson@linaro.org; Rossler, Jakob (Nokia - DE/Ulm)
> <jakob.rossler@nokia.com>; Heinonen, Aarne (Nokia - FI/Espoo)
> <aarne.heinonen@nokia.com>
> Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
> MODE_OPERATION_CODES
>=20
> >
> > > Move up the return in case MODE_OPERATION_CODES is not supported.
> > > According to the specification when MODE_OPERATION_CODES is not
> > > supported no checks should be done against NUM_OF_FW_SEC_PROG.
> And I wasn't able to find in your code, where you are skipping the check
> against sect_done, In case MODE_OPERATION_CODES field is not supported.
>=20
>=20
> Thanks,
> Avri
>=20
> > >
> > > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> > > ---
> > >  mmc_cmds.c | 82
> > > ++++++++++++++++++++++++++++--------------------------
> > >  1 file changed, 42 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/mmc_cmds.c b/mmc_cmds.c index ef1d8c6..81fdc7e 100644
> > > --- a/mmc_cmds.c
> > > +++ b/mmc_cmds.c
> > > @@ -2897,6 +2897,13 @@ do_retry:
> > >                 goto out;
> > >         }
> > >
> > > +       /* check mode operation for ffu install*/
> > > +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> > You haven't read the ext_csd yet....
> >
> > Thanks,
> > Avri
> >
> > > +               fprintf(stderr, "Please reboot to complete firmware
> > > + installation on
> > > %s\n", device);
> > > +               ret =3D 0;
> > > +               goto out;
> > > +       }
> > > +
> > >         ret =3D read_extcsd(dev_fd, ext_csd);
> > >         if (ret) {
> > >                 fprintf(stderr, "Could not read EXT_CSD from %s\n",
> > > device); @@ -
> > > 2927,49 +2934,44 @@ do_retry:
> > >                 goto out;
> > >         }
> > >
> > > -       /* check mode operation for ffu install*/
> > > -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> > > -               fprintf(stderr, "Please reboot to complete firmware i=
nstallation
> on
> > > %s\n", device);
> > > -       } else {
> > > -               fprintf(stderr, "Installing firmware on %s...\n", dev=
ice);
> > > -               /* Re-enter ffu mode and install the firmware */
> > > -               multi_cmd->num_of_cmds =3D 2;
> > > -
> > > -               /* set ext_csd to install mode */
> > > -               multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> > > -               multi_cmd->cmds[1].blksz =3D 0;
> > > -               multi_cmd->cmds[1].blocks =3D 0;
> > > -               multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYT=
E
> <<
> > 24)
> > > |
> > > -                               (EXT_CSD_MODE_OPERATION_CODES << 16) =
|
> > > -                               (EXT_CSD_FFU_INSTALL << 8) |
> > > -                               EXT_CSD_CMD_SET_NORMAL;
> > > -               multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B |
> MMC_RSP_R1B |
> > > MMC_CMD_AC;
> > > -               multi_cmd->cmds[1].write_flag =3D 1;
> > > -
> > > -               /* send ioctl with multi-cmd */
> > > -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > > +       fprintf(stderr, "Installing firmware on %s...\n", device);
> > > +       /* Re-enter ffu mode and install the firmware */
> > > +       multi_cmd->num_of_cmds =3D 2;
> > >
> > > -               if (ret) {
> > > -                       perror("Multi-cmd ioctl failed setting instal=
l mode");
> > > -                       /* In case multi-cmd ioctl failed before exit=
ing from ffu mode
> */
> > > -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3=
]);
> > > -                       goto out;
> > > -               }
> > > +       /* set ext_csd to install mode */
> > > +       multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> > > +       multi_cmd->cmds[1].blksz =3D 0;
> > > +       multi_cmd->cmds[1].blocks =3D 0;
> > > +       multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE <<
> 24) |
> > > +                       (EXT_CSD_MODE_OPERATION_CODES << 16) |
> > > +                       (EXT_CSD_FFU_INSTALL << 8) |
> > > +                       EXT_CSD_CMD_SET_NORMAL;
> > > +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> > > MMC_CMD_AC;
> > > +       multi_cmd->cmds[1].write_flag =3D 1;
> > >
> > > -               ret =3D read_extcsd(dev_fd, ext_csd);
> > > -               if (ret) {
> > > -                       fprintf(stderr, "Could not read EXT_CSD from =
%s\n", device);
> > > -                       goto out;
> > > -               }
> > > +       /* send ioctl with multi-cmd */
> > > +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> > >
> > > -               /* return status */
> > > -               ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> > > -               if (ret) {
> > > -                       fprintf(stderr, "%s: error %d during FFU inst=
all:\n", device,
> ret);
> > > -                       goto out;
> > > -               } else {
> > > -                       fprintf(stderr, "FFU finished successfully\n"=
);
> > > -               }
> > > +       if (ret) {
> > > +               perror("Multi-cmd ioctl failed setting install mode")=
;
> > > +               /* In case multi-cmd ioctl failed before exiting from=
 ffu mode */
> > > +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret =3D read_extcsd(dev_fd, ext_csd);
> > > +       if (ret) {
> > > +               fprintf(stderr, "Could not read EXT_CSD from %s\n", d=
evice);
> > > +               goto out;
> > > +       }
> > > +
> > > +       /* return status */
> > > +       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> > > +       if (ret) {
> > > +               fprintf(stderr, "%s: error %d during FFU install:\n",=
 device, ret);
> > > +               goto out;
> > > +       } else {
> > > +               fprintf(stderr, "FFU finished successfully\n");
> > >         }
> > >
> > >  out:
> > > --
> > > 2.29.0

