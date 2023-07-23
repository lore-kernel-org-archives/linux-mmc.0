Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BADC001DE
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Jul 2023 05:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGWFAP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Jul 2023 01:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGWFAO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jul 2023 01:00:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647E1FCB
        for <linux-mmc@vger.kernel.org>; Sat, 22 Jul 2023 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690088412; x=1721624412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJ0V7fQyVoK9jFLXIoyUlcWWQF9BpFZe0Xrb/OSA+SE=;
  b=Rw6d4/uFY8anWkSZh0bYC49jg/B68GanLwBnMxB6rMADetGnxjxW1tx7
   p8bdV1Sp2sTODsMhBZ8mq3bz2d9PvQdNBBxc/U4DRbCQfKxHtK+aNSfaU
   ukC4zGjuQx9KUwks+G5NpBsEDqzoty9lHxrEhsX7Puj4ZEnKVDvQuKYBE
   8ay5zX9WRnuUHBdkGW3NrScb24/rshd6M7KYhHPHpM3f1KZ3hcNdez7Qk
   CC2OUmvBZzCC1skNqHX3tiP/UOVnv2EIhIHBsCXoiszSD/dP1p1mvzBcX
   qoR0hyH4uKQmWeGYIxQt0oebeUNUFQX7nA9SBP+j4/4JJz1OCvsFwMRsM
   w==;
X-IronPort-AV: E=Sophos;i="6.01,226,1684771200"; 
   d="scan'208";a="350805691"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2023 13:00:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAsqctC2my0KlQd4ACJPjCAqkKfzPUpOt0rHUzdhf1M/WU16seUw+M5jSSew2YOZ01SBdED+xioueAawkFc31yLo0zsMRurnXprmDUJLT2mhW33wqlEZNoGiyKO9ypWewaxD0DGkfsK+8y/dzBgCdnsqIxT4rNnqOFWpuBG4BISv3APKYNW8z64po+5D1Pmf/oyBn7fgz0K90QhCLGDlWnt63CvFNuoTkQEkzYDNostXCZKaFxKc4m3r20BeZdhMcuukCR5+BCRyX2ZG0vV4q2Hq7t+br8Cf6PI+acyV0ESM/UCZQvOZX8ljXCxLh7rGmeXcOoVsm1wY237ZghaV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et4MCQY1dsDWEfTpJXQky/ajyhcgT5RFvciy4jSzJBk=;
 b=MDVaxu8536O1i8W2TBIiXEyg6NSaHuuwnEF+kQ2LXV6oLWzP9acRs42rJQaSrmkJTEkaHI5Xf0tzRPeuxyXT/TyecZT+SA97o1qbm7aKd4Npc0VyNG9J2wx99OoOlUM4eEEmhsYQfuLBdkmfQe9ypsmuJGd+26UfDtJzyDFWu/S3ke/P7Y7zFuYBXoybS6iQujH5zPGdOtLf+clvItMMGlHxF1cZDFeX2P2Toy1ZuHvUTq9t/utEbHlwIRp1xMDZhvqX2hjZTpQPsIKYTYLNcsJuF3fRCZ1QJ03moW5idlAaYYMp0gptOuZfF17/q+OaNwKLlTGQh9uc+1LJuPyCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et4MCQY1dsDWEfTpJXQky/ajyhcgT5RFvciy4jSzJBk=;
 b=jmSNd1Wo7nlkAvV2l9osguDxQHM16qe6394lyuNF9lRGvU0B0YsEMyheJMHMNTeuJcQ6HD64AKGQnnNgrfhpazeqRU3/A1SQv8OB76LFLs1sL9OmNSusW/pe9c+oLgulniQ0YuFl8SV+6Tnc2SzQr5dwLW2pcDWAM/mxZreMHx8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7655.namprd04.prod.outlook.com (2603:10b6:510:51::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Sun, 23 Jul 2023 05:00:09 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 05:00:09 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Luca Porzio <lporzio@micron.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Lund, Austin" <Austin.Lund@garmin.com>
Subject: RE: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Topic: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Index: AQHZp1EtSMOyXxsk6E6YLTBS69Nlba+sbEmwgAr3joCAD5J4IA==
Date:   Sun, 23 Jul 2023 05:00:08 +0000
Message-ID: <DM6PR04MB657530A8EC2CB5D851B1BCA6FC3DA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
 <DM6PR04MB6575DD2CA332B275512EA281FC2CA@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB657512541358BF3FE167B357FC37A@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657512541358BF3FE167B357FC37A@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7655:EE_
x-ms-office365-filtering-correlation-id: 0445d676-454d-4586-528e-08db8b39b03a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NsDSkhRurrUtBKf9zTMb7yE3aK7qfsEEoQmrw0Vu6VNKJ+TGSR9Rf5CNkY2A4lZbNAghme+tIbgg6oJXLuqX+WkLVIpzZov+y5VuthF3hAJQfnNi6dt/zoYiNNqDU+YJPkVH9eYMTTuTna2LQP+AKl32jN8FrTWgbnlX14cwfB9ihsesIwutMKqOKtIz5JH8CSrPVzZHOi3zCinWDixPx8x1cwRy+dCcj/UmGBmHbE5LSk43Izreg0WqLX+Ea4PQaItN5EGqvG+/knWMzPlWb5iYJRFf/J9fxTWXhzH45pBDwiBAwo3epANbJXpv2a0ChIAzurUvLeTCl+UbJHuANQNDbwQrKQxrgQqTH9nJpccUd0l8jYyKoVJXZe752K7IZg4xdEQa8pcBf5khulEV50uXGygtIvN2EV3gwB82J38IcEit/9Igx48gt7vIXjkLeHdXei9PzcYJRgGTaY9PcN9RBkD/lLt9I430H4aZyZ+jdDEuXE/rb61/3dwSkIbJ/YBOoDyeZGO1J1goqwtnvm2WiCtKxWVKlPHdRi5WPrDtXNwuQgdSH31wFOZAQCidVIOblG0QJbxrPh+HnYM+B8y0XO+6HhPvatxqzw7LfwQyAIc5iG9LmuWSRSKdgTq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(38070700005)(82960400001)(38100700002)(86362001)(33656002)(122000001)(55016003)(2906002)(54906003)(110136005)(478600001)(186003)(26005)(6506007)(53546011)(71200400001)(41300700001)(52536014)(7696005)(8676002)(9686003)(83380400001)(5660300002)(66446008)(64756008)(66556008)(76116006)(8936002)(66476007)(4326008)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?atwn3cfdVeXnuQpiKekFs+tKPVQ0MW4+DR/rRt68bci2uusjMTZsmFy5gG?=
 =?iso-8859-1?Q?3vbfzgg9SEPZlv6BCsS+1gvh1ACUf2Pva696zl4DyHNSbrNFfBCZnCMCaL?=
 =?iso-8859-1?Q?xoihb7vt3zRmLCRmFMul5Tf1ih3xq7QWBa6biDxeNXnaZUBijBieTVuoao?=
 =?iso-8859-1?Q?kTyzEKk2clz9hVgFxoaawrK6XszhYHfDfa6fefcyAmYUh2AJd2O2Az8LWa?=
 =?iso-8859-1?Q?KuU0sNivBsKy7pWQLCtuLJMiAjJUid09OBOVslkSGdv7p3O9GPDk86LOa8?=
 =?iso-8859-1?Q?eaa5bq/Y6JcFt8uu8+eAFG2o440pYDa8EwCt4EFVbWJiBBV9OlVQh15qV7?=
 =?iso-8859-1?Q?memi3W9Rg//Hwu2VXozocKQrGXLyIjuY8kfopJfnr6uYWhO5iPQ5Jj8mdx?=
 =?iso-8859-1?Q?YmS/ZjW46xADSWEWvrQdrdvzfIF+T3yTrzZg1Bgr+BCoJhTwVskvyKNeSm?=
 =?iso-8859-1?Q?6SwigzcmoqH1iwD24tfQWj9J26HO3yHMeYGnrtJywZW4+08mX6QG8egd3m?=
 =?iso-8859-1?Q?3GJJzh+O77l20CiWWjBu7WN58G6tM8OUBulJeuYJGJPN98kQlVQ+YHCQya?=
 =?iso-8859-1?Q?U33RoCOrc0kEbkjTSGSOIwkK4ul0eKUnqiuj1vkgA2i3WvJlegch1aQJIs?=
 =?iso-8859-1?Q?AiZTlljcYGpgAl7hYqgjcTjwNVlcMyjcWoCxYYqPMoYGnb+h6cM92OgSBN?=
 =?iso-8859-1?Q?eiotAgMdoasrLtnCXtV2fNVi/X1qznaYF/Aa4PbTHMEnyV9I/aD29iKq5d?=
 =?iso-8859-1?Q?R+1VCUQcglC7k1IWbaIEs1bt+2CYuQ18CLJdiLaYaAix7gzTUcdgQoRqsT?=
 =?iso-8859-1?Q?mAKpLo20PkaGRjRJ248O44i/LE6SkgE59cgTvF8Cl5jgTwDUusspLkxPgy?=
 =?iso-8859-1?Q?kUzU7GkWClywAZw2+CqYhvE/mFjlyGQAzPHLZEOZSSpMEqi9lvKJDKh7hz?=
 =?iso-8859-1?Q?gf6yfFh9R+gVlhXXKoTAmrUj0X/XVVdV3962vqHejEGu5McOstyMn/TCjn?=
 =?iso-8859-1?Q?yBYsAZeb0HzI9+IB3dVAhGmpKfx+7nEwWrSqDaL0AKHsXyNLZcYJHFC8iS?=
 =?iso-8859-1?Q?wzbLE42heByOFt+8/u/Ej2M7cEQoPDGB4B5B7Vru4DWKfFE8IIIv9fdCfC?=
 =?iso-8859-1?Q?egjSF4dg03UOvIetIDdt5iooNU+8etX1A1l069YIMXitylvRakCZNL01Vg?=
 =?iso-8859-1?Q?npc1zciU/qGIjfVvx9PA4Gm9vJnmYzfUF6VmOS4yQJaHV1tLKxgv3DtCPQ?=
 =?iso-8859-1?Q?kmrQHOapfbfoUalUScejhgpD0HVoCOOcTZ/jJMjlynWq6uIADMoaI7HqyJ?=
 =?iso-8859-1?Q?vro5LNnm4w5UQUt+Zse69lJtmUyWKDGpSRhNT/7C3snXnXLF6Iq6nSruaj?=
 =?iso-8859-1?Q?UWtMXjWIrXNPwhSjKzP9rJ2rsvYye5Iv49rXuDHqIjM/mZnKUC7Qt0PjGW?=
 =?iso-8859-1?Q?gMRtF6qHX+X2g19YmGnGcTRE8CzscniPT0HuC8e8l5yfqjqfvisX44Pdvd?=
 =?iso-8859-1?Q?AXoCxZuQ5o6nu5jVaXMJqfGQUm6n6lf9RGDFX1Jzy85wTnEmZPbVjLlTpE?=
 =?iso-8859-1?Q?ySoyvVY1MAzp5TG+oT3MJhK9MVoyviJW6ce3A5WI8b5yswy2Ig3VMxxgYC?=
 =?iso-8859-1?Q?WoxT5xmNfg3WFUV4hll+U2TnHlWBMZkZ5Q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wazi9QzDW2yb/+6OjsSzEOYWLM1MMKxRa9sKl7XsmMNQl8DMjBIgpTalFztsHvqKt6KXvq8PZRlHHjOh68siUTau+TASkyVOHthGkb53rzgoQ3fmX0dXiaH/86BtH/Y5lR94Se056S83I+6ItcplAMU6poYy2o/zoDlEr4Kf2rViDPelBpgFuG7S/8RPsrWPBxOZE27ul4Nmj6vf7Mccad3qOCCWi0YpVXvksJ49Sjr3JxfAQRiGkIaUMX2fMKxfv0SUF9aSldJWrFtrQgDXEuyi4lY2Czt/hbfXXRwxa/7NLWh9qZ9ccNedNlP0R0auSAZYklsVgXUaiol3W/z4lsr9aIZYAUn04UHBWtzgOMEIzMueFPw/wVKGZjdDy/0Rxg35boRgiU6LZFNz/6zjNl6yqJ1pQYQlnopQTbfkNIUYiQAM3CoeY4OVwe2DBLbuqqLwR+XU+it+4F2btM6HIPxM2ewkVu0Gag8+MW52paNVZYqKRXyp2xvqaHv9+iMRnDwh4CQSCHzyp8f98awGlGUxIZ8tKTWioDmP5Nc25Wm4xBAidYGqaX5SVOGTvyYsngMSec9Kyi+5gTz32fnQhpTg0MUH85BysbcZiAa3JUSenlAXxvLykvdcs/Xe4wNOZH8O5Q6fF9X2PV8Jb5JlYOj5qA3ijZV8iWu8HC6lY27e18cblID3A4m+OYwOYElHcbDuKonNE5Gp7utaRl+naDHPPW0smOJyO3x88obnVow9XsEUqT7l57k4HRHnJaeLxBycJPxvNQYDAGcxUyOWMda7tZnFPMJzEjmXa62efOo75TP2IDSlguab7uQGlj65d686zy6tkQlSkgRbEH8KLyf+6UvWa05NeJVZuUzMKWjah9OqVC+IA0yQFRlqNORDIjJOSH+3VN/MmV9B0+qy4Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0445d676-454d-4586-528e-08db8b39b03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 05:00:08.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpJxkwmrahNQwe+7cGWINxl5f+P1Tq/eEUC6BiZnjObB0Xmb1PCXcA69G47oXhvXK5FYyzolzxymlGbAMf1PfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7655
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > Hi,
> > Would appreciate your comments.
> A gentle ping.
And a 2nd one.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> >
> > Thanks,
> > Avri
> >
> > > -----Original Message-----
> > > From: Avri Altman <avri.altman@wdc.com>
> > > Sent: Sunday, June 25, 2023 1:38 PM
> > > To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > > Cc: Avri Altman <Avri.Altman@wdc.com>
> > > Subject: [PATCH 0/6] mmc-utils: ffu: ffu of large images
> > >
> > > ffu is done using a single multi-ioctl to carry the entire firmware
> > > image. This is limiting the fw image size to be at most 512KB, as
> > > the mmc driver restricts each single ioc data to be at most
> > MMC_IOC_MAX_BYTES.
> > >
> > > The spec however, allows the fw image to be written using multiple
> > > write commands. So if the fw image is larger than 512KB, split it
> > > into a series of smaller chunks.
> > >
> > > Avri Altman (6):
> > >   mmc-utils: Add fill_switch_cmd handler
> > >   mmc-utils: Add arg argument to set_single_cmd
> > >   mmc-utils: ffu: Simplify ext_csd bytes parsing
> > >   mmc-utils: ffu: Add ffu multi-command set handler
> > >   mmc-utils: ffu: Allow ffu of large images
> > >   mmc-utils: ffu: Add optional chunk-size argument
> > >
> > >  mmc.c      |   6 +-
> > >  mmc_cmds.c | 161
> > > +++++++++++++++++++++++++++--------------------------
> > >  2 files changed, 86 insertions(+), 81 deletions(-)
> > >
> > > --
> > > 2.40.1

