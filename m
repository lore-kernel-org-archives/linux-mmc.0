Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A01C433FE
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Feb 2022 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiBFIDM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Feb 2022 03:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBFHtG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2022 02:49:06 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 23:49:06 PST
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BBAC06173B
        for <linux-mmc@vger.kernel.org>; Sat,  5 Feb 2022 23:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644133745; x=1675669745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=204zhycda5bH0A0wSUkFWxtQQ/sY5q9z1sZtl2kobsg=;
  b=bFdJEUhItEb8srrF4QNlJBkDERwyB43Emr43sGO+500kJ3sok9ZnDPQb
   Oig6ekfdiusBQqG8u6G92j7s0LOHoSPgOpX0SbpD7jFBvsdbxj3Xs9OLI
   Sfe700DRp/MPvbSqZD4gsbd61W5V+7YqLfYk1Yq7et+DYVkflTXCeqSM+
   Fq8epfGvi+DwmIwQPP1GTF150aKT0lj6oWPjc6WgQ4SQNGwx+fhPjwQ5v
   SaxpJKBWJsPSn+VQG87q24cXeqJVjZNCd3WHOHa7U1JXL7lwtFuFvm2Pp
   lWKaiuVfIeXMFVzef5ABQdnHzHnCpQhBZenNdjAtVZLfVMwW9b5PK63y3
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,347,1635177600"; 
   d="scan'208";a="192253363"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 15:48:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6laqq1iSyruu0ufKjFPNq2djjH/2HbH/hF4GRHkw5O7kjQd9Tu8IBcp9GZ6ogaE+Jj/mT4x4fF+1uMYCiMMfxiOZ20m9BZLEza/6JrO1HZ+Jv8lRbMYkZ09/mCVU7fTAmOa9siwKYpESZgbc/mZz/NJroyWWX3SX5wizZdPse6r06tfweZZ/Jt3VyOQF2pOVQ2a14Dr39UHkner8I0L5JBJK7/8ZdP+aTFOsNZrUnvPX69JTEWGW6UmkFEwMLxqYdtHmWUM0QFCeY9oo0FnwPKumx4r0J4yaxLXvHg+vnAa2lff/F15GTx/eDwrJu87hbj/W9lvJVBoizho4rNPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cphAEP4sBIqmYoqbOPf62LjiH055wtK5nh5rLcdypw4=;
 b=IYk1FBPQ2DfeUbZSxJQCGDLCfrJj3yqi8r5TFML1MakO+64ZzWBQFDX4nqJCiCQp38khD3Sd9NMlarhcShm4F8QzaNJLLte7b+Vq1QVspiUrNnj/1DW/87WZXLY38h3IxMC6Pi0G5pv84KWGePxKxD0AP1wG24SBQyj45o+vYk5mWpyKgfGlp7ohjDJC8aEoeLkwKWvrV8VDy2G+94fcN1XzviZVkS6VTDo6WKHDDZB/ZjjWmZXOv9Sp/MJvZfWQrhO2eYzAdyCmC4bTD30Hz17Oy/4od1dby8m39G8aKu4UJXwcPLyE2G5b0k7s3hxVksUn62YskFEN/37c0oNuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cphAEP4sBIqmYoqbOPf62LjiH055wtK5nh5rLcdypw4=;
 b=b1XRgT9P5o0BARdYhiUsALGoYbaMJ5SJE4wkNWGItX27U1doDSe2me5Q2oD0v85YKLjgnhIk+kYNRznw6sL4XNAvVotkXxkdCZ/9pOkx+leIWgzkfGIm/kfPRE765hdqz/SiMDxVEWxzycaMkmKHpWWFeV75RqXIimVD7gxscxY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3529.namprd04.prod.outlook.com (2603:10b6:301:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sun, 6 Feb
 2022 07:48:01 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 07:48:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marius Strobl <marius@FreeBSD.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/3] mmc-utils: Remove unused MMC_BLOCK_MAJOR
Thread-Topic: [PATCH 2/3] mmc-utils: Remove unused MMC_BLOCK_MAJOR
Thread-Index: AQHYGtL3fgJzEnwzjk2tbC4wnNQ+n6yGJdow
Date:   Sun, 6 Feb 2022 07:48:01 +0000
Message-ID: <DM6PR04MB6575B1580A33C1695B5E32FFFC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220205205647.7677-1-marius@FreeBSD.org>
 <20220205205647.7677-2-marius@FreeBSD.org>
In-Reply-To: <20220205205647.7677-2-marius@FreeBSD.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 256330f0-1f0a-4490-7839-08d9e9450070
x-ms-traffictypediagnostic: MWHPR0401MB3529:EE_
x-microsoft-antispam-prvs: <MWHPR0401MB3529D5DBCB73ED4412CEE601FC2B9@MWHPR0401MB3529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /D2cyezVRX6F/8Zye5vB589Q5nINpOU47h416iOg4KXK35UllGrYnI+FT+AtdIfEELCChzmjy/DGL8V6l/3lBlP+CjS0CMz5JjlHMHzv22SjcUUBvIYEmnRdI0u3QcbTbVIEznkkEZBl+g42rNuhE2HqasGcL1K8QT4acjrZdJvPfC3C86m+M07PYuwSdBSrUqtTKTgWic1IJsaC5U1dZWFhLF7JfAxTRqDz/lYdIJGXzrn8JKacyjVPIGNHMxsqfyTBXLSslBudp7XjOvt2KByJ1tzNvjNyiT30wWXmdV5SPbBYA3D6fHObuqe3rVEXhE/T7rAwL7wAMzyXhjionI9CyrfVlgpCFqVTPR+6bTCgUmr5x/aJoSmglpkDziyzvgLOA/fGiaVBx9a9CxdewjDgrn7TIzrO007BD1v4q1xAW7iw7A3B3jb5kWMYua+eWUPYzG/FHTAm8w6WFRHwsEh/VsFARDw7ERJVWETew6+ca0Uo4os9yuSgClJJ64mM81Ru4uzoMwoeQSbfIfpuh1vpLnCFqPR2CoEJgOt2GuFez+yC/YtaELXjnj7YMQdVaI6EwgLrZMy1R4P1cEOUU005W969We3IcLqfcN4hSzkSBtJV5X3H5rkYXDZ1FQrkijvHMnBKySmXdadGEXBXwNBqRLOyJ1jCNcWo0RnC619Rt439Z7WQqodrZfknUkgffeYg6FaOlhqgIGUQltAd0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(9686003)(4326008)(82960400001)(76116006)(66946007)(508600001)(38100700002)(8676002)(8936002)(38070700005)(52536014)(71200400001)(64756008)(83380400001)(7696005)(6506007)(66556008)(316002)(66476007)(110136005)(2906002)(122000001)(55016003)(86362001)(33656002)(186003)(26005)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aI0u996KUvdOq/L/H2Fl8PEySo6Ip7bglEvbEm9PZ5IqcvI1LRlDWAdRPo1W?=
 =?us-ascii?Q?Q+pmxAk9D2S9m/B1eX1qsHkpv1KPruf65M4xKnTsittBWw7SFznEaN/E1BN8?=
 =?us-ascii?Q?yey4f7ssjUpIArIPnOT7s6q219G1S/FqvObRt37kQXc7gRvaV3PhdKiR46Yx?=
 =?us-ascii?Q?oMEYAP1O7q7nna4CVNevThNTfBPBKR06nQZCXWYMT2hS88vBxpTpUCgMYzTA?=
 =?us-ascii?Q?2e/NBrQS5DNVCox9K7njrC6Gj0V8bDFOmx5pMBa8PKH49JX0vE6461Eo6uy5?=
 =?us-ascii?Q?AysAspABVoxflyEiiUegSBpwvJ1Zv0A9SKoH75IsckP2mfALErg6+KvukDbM?=
 =?us-ascii?Q?8diFSr29VpaDTrrEygbJ+n/uMciQr+w5Qw1ZvNBlVSXD9hGg+aW4BJxH7W5W?=
 =?us-ascii?Q?Oii6MAJIU38qEbIeSYi7DlOBdg5GtRxI2HwKlDTe/gQjB67nqiHoV/NZ91Io?=
 =?us-ascii?Q?NHhomaPg98Y+or1/SgPzUWYsuC0ntkQU+0OZqkeMoB7zshq+G4S0SJRiCr2C?=
 =?us-ascii?Q?2EnFNyvu/UIgMc/a51RUgjMLJPHcLsf4VWXdPOTaVG1xNdWkNv7ovGAvVkBL?=
 =?us-ascii?Q?gouWFZivSye1CQSou7t9IpUmSl0D7DE6sltSs4PMQnXn2yfnKPU7xhIUm6VX?=
 =?us-ascii?Q?kw56g3JxRrUfipieHGDJ009nq++VnhCrOwhKYJBE4pmGPtFy/AaRyCoh+tFI?=
 =?us-ascii?Q?Wrao7Wa1wJyzTrc1epJ4BYTTKZP0WgpReYM7HZq+pYnHsgM5wVsHOyUd98bD?=
 =?us-ascii?Q?4TyQ6WSDEIfq6jwKatDvxoq2W98+9AZSlluikjGLai0rATARl3GANPtBMuQk?=
 =?us-ascii?Q?Y/bAL9th3AXrtpQ1SH6pNmYMNJK3N2EdtM6zLEratLuy5N5w0gqw1XoGzM9X?=
 =?us-ascii?Q?UOWam2k3hrClUwIgQzzLldvEN58wHV6ss1r/BpmCxU8CbWi0TbqZhu6prPmq?=
 =?us-ascii?Q?ZRBtZwmgVpF5cBmI7xY7ZQAl9BfjE7+vBHbwONVaAtm5yGZ5gAXIcklp2g9F?=
 =?us-ascii?Q?gkg6G5i+DkyhJmgvhQLfkEApOS5QJ9nfCsarQ9UnjE0a5/AjOTKY8nSZcMTl?=
 =?us-ascii?Q?6HTDKIRZq6nanLVMMhU02ANhDZZqg5zthHSv4/hzGB8PDuSGGsnD3/9mMxqI?=
 =?us-ascii?Q?dvEPHPxAF3s9XDhstz5yEbAfSaGlITTB13ih88nB6rUde2veqirG+wjELhJ6?=
 =?us-ascii?Q?81HgyQC82t3WqXFsPs/Tr0vwHvpXNiBoUcDwoca0n8UVs2LQDkwhTU0ZyQ09?=
 =?us-ascii?Q?EnRcdJTPjeQk+ysK+aZi5ECXkL4hbkKfkpnx1FyBTKaD4HXnqMfE2aha4bBq?=
 =?us-ascii?Q?TM1CUVyfXzm+pnKgsyYReTzVN8HCiC3acToZrpNt+KQBxgwLj6VDorCE3fsK?=
 =?us-ascii?Q?1ihULDQ3HChAeNb7xb9rXMjwRVw46bPepbWMeTt4y0YmX2+qhRGqW9XfvJOt?=
 =?us-ascii?Q?TS5+Of1BHkWy/Jaw9Lixm6zlcVam+7uJAxRRSbHkfgb4SzjoKdjly+Rupowq?=
 =?us-ascii?Q?kRG3MKI41lHwW13WFrN6pyjmUPTVRZ/h5UWwoutY5MWr1URq6ZBsFblLSha3?=
 =?us-ascii?Q?pVrPrSfG1D059Vy8Ot+jUzXi2h+r5Onk1l1SVuu9jiBjKnkkrndHQBEjx4zg?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256330f0-1f0a-4490-7839-08d9e9450070
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 07:48:01.7928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr0CucIozVJmbQx6XZshaSHYkcbbPmOdPP8nX7CpMftiUxxr8izq9Pao8jmexcebHR7wFdjXorELwITWFowHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3529
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> It was added in commit 294bf86972d6 ("mmc-utils: Remove dependency on
> linux/major.h.") but never actually used, apparently.
>=20
> Signed-off-by: Marius Strobl <marius@FreeBSD.org>
Looks good to me.

Thanks,
Avri

> ---
>  mmc.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/mmc.h b/mmc.h
> index e9766d7..2ff6e66 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -19,9 +19,6 @@
>=20
>  #include <linux/mmc/ioctl.h>
>=20
> -/* From kernel linux/major.h */
> -#define MMC_BLOCK_MAJOR                        179
> -
>  /* From kernel linux/mmc/mmc.h */
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
> --
> 2.31.1

