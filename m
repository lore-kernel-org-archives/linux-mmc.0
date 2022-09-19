Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E7ECAAA1
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 21:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiISVhV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiISVg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 17:36:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6434D829
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663623363; x=1695159363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YmnorpSuf3XHP6Ly3tFfTf8QNnF+nVpUlMZy5T9Ak/4=;
  b=AKFG4/3OwDKGCd7B11fNNL3967LvajLmL1seiIV5MSU1jRcDnrAbcJCW
   28YlqLZyDhPj+i1z4aXQaIR8fLtzeYwZEbtc6HRKvcZVX8IukyAZKCLpI
   EpRAZJqBIftnG6mH8kvFoitNT6dgufMEWDAss2VtqnYY14qloYylnAx1d
   7ce0/PF8Lda95b0oSpGEYBlsx/O5rxLdm0EQX+QZHaVvxXwAROqYBDJom
   teR3OVerQnF3cC/qy6eIdfj3II3oP8dbCr3szlzhcLngZ2fpvfcMleIPq
   qI0wxZVe3FycJeANLI/95AjcbCeryt/qsgh1Cl4oUMi7gnqJIu6vonKdF
   g==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654531200"; 
   d="scan'208";a="323851836"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 05:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8m9HlY/oa9OuNMPRx88Jj1SuHSVZ7+ht7+ZjjeAlyEKsrTgVAoOimMUNhGJ++Jcr/D5sVvbItxslgDwSxzTcGwIpmmaOdfY5AKWVVAtzInB8XGpja028DTtVdrW9qPd7g/SRImVI2rghDNnc3dgWSWlukKQXIUzk9HXSM0OjvG7SisABB6QIXQth+BbajmN4w3YDXCAagcMIimQHscDpX7yw4eGNj1KcsbBz4LNIGUvlags7rg47Bq39v5jVkRkR04XhRk1t0VFV74elqKsPPWBIe29FV/qSCYFQil4bn5Zc2mNxZwZu3iLkHHQsnChlvZcQycoa0hRPddBCEfsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5IhWFA9Xd+2ss9sbcJUXcspHT/sa21CkNMeRUC0MS0=;
 b=YYWKOegHi4pAbsTAVv1KRwK2+NJR/jdbcs3zKu/EMWLyrlVRcLZD8lblIFzwyc4xORc/vDAhhhBBnGWJ5bp3wnCoNFVI0yxzA3Q9cugRyIaa4shnjw1z+bxwp47Lsoq8GmQAcxyc2cQhPmeeGOE5YNMcuMMLvPsGWalC5tUDmCPfrLVDXbftPyWEvUUWsYQ9GLQxAHoXVcdP2pxAcwIF4rPd9GcCT4YT4YRLo7s/5m72AAtvrStCGr51ZLJF69jIcg4qlKAqfg9oGf4w+ta+X82uJrLraMXLgbaxP0HBYKRov4KeiTo5kRdILrMrSbMHHIKqjoOvosovLLDvYcRedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5IhWFA9Xd+2ss9sbcJUXcspHT/sa21CkNMeRUC0MS0=;
 b=V19kmS2oLT4n2GgNtFAql/D09XaS7txrMTgS44MLDN2y2A1XSFXNpvzMm5xnHkVrGhA/428gmge/AJtwzhLbLOoSGI433qOXZ6ToPQErjjl9i0uPRTsEYVXSZ0JVCJ/biDsq9NkFpUV4Rr1op1wIHAKabK32xianJKA5QCrVuN8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6044.namprd04.prod.outlook.com (2603:10b6:5:129::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.19; Mon, 19 Sep 2022 21:35:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 21:35:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bruno Matic <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jakob.rossler@nokia.com" <jakob.rossler@nokia.com>,
        "aarne.heinonen@nokia.com" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Topic: [PATCH] mmc-utils: correct ffu in case of unsupported
  MODE_OPERATION_CODES
Thread-Index: AQHYzEOVE1e8g7Sl5UmW+071XDkLu63nRp2g
Date:   Mon, 19 Sep 2022 21:35:59 +0000
Message-ID: <DM6PR04MB65754366E4FFD588A9EAEB27FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220919161852.28072-1-bruno.matic@nokia.com>
In-Reply-To: <20220919161852.28072-1-bruno.matic@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6044:EE_
x-ms-office365-filtering-correlation-id: e3d002c5-d7fb-4068-b5c3-08da9a86f18d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBsMer6LM9LgvJMPgnQk5/v63es/AzlwpzDdqwtibir77UA/ZFdJy7CrXuNkEeKhaznJYIq+Oo4S+9ZrD2DzEt6ZvRPtYanJCDX9V2qsFqSz/ZiwpmnX5owGvS5wK0rJYY0W3jByC+34+IRWCBm8cQYRW9NY5+mDq0S5GWSBPgk2wY6JvZcwrOodMB9si189wAKDy5BYBxUsbrD6DJuzwBONXZZttBmiaa47L0v5DO4VtuXDo92Ww21NNbWtK2+Nspvqj9gyto6ja0c3Au2dOfmyOCLVByoi15F5XPfXFf9uYuQOGwZ0PUuKGHmcuMvv3VZUVk5KiyUti79J7pVEBGA0AEx1xR8YzAUSxU4wQticd8Ww0fiEIs/04Hk/Jqpilhx8ME2CIc5m3rF6l9e9MZgfbYEQJDumOmf8WMltZXH6PUucjtEJ/yx0biNB6mjv2BUw4Zm/4IeS7Sx8UR7yzw5vw0ScaqQZd4WmbXOAK4NW4mRQd2Lu1Uh5AFtUGLZq8ZPA6ssYCoH+WP2NQrEujo0xEPQJDK+KOW7BTAkxJelDcIZJ5rySV61GrEireqjjDWo5WsDMEObygIIArkZ09HCLyNHIZy7JF8vcR3zwNv0PDmh2Y8NaOnjmLto3hRfT/c5Rs7CO8vun9Qiz+uyP1uSiBAKo2vkABK2VqrJ/Z/XUNLNtq1hxFeoUkqQHqeP4YeqP/I/vfDS7EH73AIToms5bo5UZol/PZioHehTGYT3rQ7P0vcMBgSMIgVl+0xz0Dy01z1F1sojq0dAsXruhwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(55016003)(71200400001)(76116006)(38100700002)(122000001)(478600001)(316002)(296002)(86362001)(82960400001)(54906003)(110136005)(186003)(33656002)(83380400001)(41300700001)(6506007)(7696005)(66946007)(26005)(66556008)(9686003)(38070700005)(2906002)(66476007)(66446008)(64756008)(8676002)(4326008)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oDJdXbQRJALOmthPT8tm+u/BfggOzRqL4e/yrMZB27bahM0Z+DaWCq3D7k9d?=
 =?us-ascii?Q?EuG1UJgbLqQ9O1cfcJ256t/cbGNF4Ft09mtTVQsJIDvtuJfbPezR4T9ThO0l?=
 =?us-ascii?Q?pekWQbQfoSmMmhAWdlPO59RIHo7OTU8jfA9Y9fk7UETWxLypo4zKi4Cpp6Ft?=
 =?us-ascii?Q?9mIWLAplR6rx7IwVL9Hj4/Fr4hESIClQ+uH1IcifqJLwfbxspYo4nHS1SaN/?=
 =?us-ascii?Q?b7q1id1xknRaWk/AUeuLO9U4BmMwu2dmu3Fldvs9Gd1DzL4De6x8SCcgbmHT?=
 =?us-ascii?Q?nKm1wFDN/lGsLR8D7P9M+1n1qUmLVNg0wayj2niQ/IFhk1G4n4wJliOY9req?=
 =?us-ascii?Q?8mKaJ7Ih9TUPjJKbmwzAi+Cl0TuEvp178m3G/S0PgPSvXgAjwx+fTlNU1Z4u?=
 =?us-ascii?Q?/glsYOTW+iSl/F3s0twUwQtyByLc0C5IGlvX/oTo/sOGA8IfpMZCet938WXJ?=
 =?us-ascii?Q?yV4Cdpv/9xhFrqid3Ah3r/p2V4qh09H5CmmfxVChWgvj/cDWPCiqa3gqU3Ay?=
 =?us-ascii?Q?+u7DAg8LBcx18EfxsJztTN66HwSEm6hYmK6cxaWSuyPsWjX3DWyaFNI3xzRi?=
 =?us-ascii?Q?pV/k/B7wo0AZTW32U4gpi/9k4DT23utPly+sebg707kOP4CXw3ZuxNVi0VBk?=
 =?us-ascii?Q?xv0qmzhpVbvRMKWlppfcz9PhIqS6W/x0B6+9E6XhIxNBOy/9bHfYc+N9grVJ?=
 =?us-ascii?Q?Dh65TaADNWtsTtoPOc41JlRQOlcFSaWgMyIIpb4FJ7UcpV7uzsr2WdQ7Q/jR?=
 =?us-ascii?Q?sROUWtj+6FtiNtfJB1I0UTrWVR+pY09wzNMTJWpEseg9ZmBWtTULsDq0P377?=
 =?us-ascii?Q?CKR5gLbVsDwDly7PO/zEyMgilA9LvMRlXNx/bZgFaefLWVGv4lmFB3bxLENZ?=
 =?us-ascii?Q?MKE/okH5MUclg7e43ryY/kkah/albBx3gg5npv5NvzZCnSLPF0cj8d5gMmjo?=
 =?us-ascii?Q?efCzzgez6foxr8l/HRTbsPRhJnAeOidcfe2V9sdzHQXg5dZMGlmSpUdlCf8X?=
 =?us-ascii?Q?6wAnh1mYYsaWDdNzPhUOOGet3BWkxRjZWFuWcWOjkIx8dMt+MHjbkXfcAylh?=
 =?us-ascii?Q?7XfbYu0epvlz7eWbtcIeVemkYVp5LjLz9LeNU6yZIszfuGYJtyW2P9KcFD/R?=
 =?us-ascii?Q?1I3A2uTYf2tbG42WmiJREPQizIVLLSFYWAjhly8Hjpox58ua9K8hQwdWm8pd?=
 =?us-ascii?Q?KW9ydTUnEX1n/xT6SdUveeRd02FMqcM2cFwzzsIYxo8Vc32oXigpPRm7lwVT?=
 =?us-ascii?Q?tDICDNDTnNfUj+glAp9K4X1emT4z08xIP75iR22zdNhh9KBUq9u6Gt9+pmsC?=
 =?us-ascii?Q?PwSLB36BW27GIZBEdUi4ceBaPWiaccwEBUVXsq0REibKLK1dczzF4twD9SwL?=
 =?us-ascii?Q?m8Iq6+fhL8im35MSsAxj9lZUOS/XmvOHSHzyFUY6wu27/a4rZ73LoQb3EFMw?=
 =?us-ascii?Q?ndxxX22Sr2uZFyE7V/xPrO8m5Cw5sNgkYPcoFHXO36WZjz3ckIVoGg753mN+?=
 =?us-ascii?Q?CDm//p4B9av8n3t1f4xJNPdXqm+eCHylkUQG3HSvTo9P9oPfnpjeTTZIDwNb?=
 =?us-ascii?Q?kqvaCgeRof2nNEQGD7RiuegPlYDr0QPQ40SkGayt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d002c5-d7fb-4068-b5c3-08da9a86f18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 21:35:59.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8o+YjSdyAjliVCHSGcDyLsdGLqfbL5rh6aMdjsi0V9nw37LuREHjw9B2yV2N3K3eMqQPzCm7KwzOpM2S/ZpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6044
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Move up the return in case MODE_OPERATION_CODES is not supported.
> According to the specification when MODE_OPERATION_CODES is not
> supported no checks should be done against NUM_OF_FW_SEC_PROG.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> ---
>  mmc_cmds.c | 82 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 40 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ef1d8c6..81fdc7e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2897,6 +2897,13 @@ do_retry:
>                 goto out;
>         }
>=20
> +       /* check mode operation for ffu install*/
> +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
You haven't read the ext_csd yet....

Thanks,
Avri

> +               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> +               ret =3D 0;
> +               goto out;
> +       }
> +
>         ret =3D read_extcsd(dev_fd, ext_csd);
>         if (ret) {
>                 fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e); @@ -
> 2927,49 +2934,44 @@ do_retry:
>                 goto out;
>         }
>=20
> -       /* check mode operation for ffu install*/
> -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> -               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> -       } else {
> -               fprintf(stderr, "Installing firmware on %s...\n", device)=
;
> -               /* Re-enter ffu mode and install the firmware */
> -               multi_cmd->num_of_cmds =3D 2;
> -
> -               /* set ext_csd to install mode */
> -               multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> -               multi_cmd->cmds[1].blksz =3D 0;
> -               multi_cmd->cmds[1].blocks =3D 0;
> -               multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE <<=
 24)
> |
> -                               (EXT_CSD_MODE_OPERATION_CODES << 16) |
> -                               (EXT_CSD_FFU_INSTALL << 8) |
> -                               EXT_CSD_CMD_SET_NORMAL;
> -               multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1=
B |
> MMC_CMD_AC;
> -               multi_cmd->cmds[1].write_flag =3D 1;
> -
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +       fprintf(stderr, "Installing firmware on %s...\n", device);
> +       /* Re-enter ffu mode and install the firmware */
> +       multi_cmd->num_of_cmds =3D 2;
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl failed setting install mo=
de");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       /* set ext_csd to install mode */
> +       multi_cmd->cmds[1].opcode =3D MMC_SWITCH;
> +       multi_cmd->cmds[1].blksz =3D 0;
> +       multi_cmd->cmds[1].blocks =3D 0;
> +       multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +                       (EXT_CSD_MODE_OPERATION_CODES << 16) |
> +                       (EXT_CSD_FFU_INSTALL << 8) |
> +                       EXT_CSD_CMD_SET_NORMAL;
> +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +       multi_cmd->cmds[1].write_flag =3D 1;
>=20
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
> -               /* return status */
> -               ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> -               if (ret) {
> -                       fprintf(stderr, "%s: error %d during FFU install:=
\n", device, ret);
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "FFU finished successfully\n");
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl failed setting install mode");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
> +
> +       /* return status */
> +       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> +       if (ret) {
> +               fprintf(stderr, "%s: error %d during FFU install:\n", dev=
ice, ret);
> +               goto out;
> +       } else {
> +               fprintf(stderr, "FFU finished successfully\n");
>         }
>=20
>  out:
> --
> 2.29.0

