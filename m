Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D7C77B7C
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 06:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjEXGno (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 02:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjEXGnU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 02:43:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1711BB
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684910509; x=1716446509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aw0ivlUPM7THroFJ5WBiIrWMpdS/yUrYi3rmVEF2t8Y=;
  b=o44ZzncyUGIk1o6ogt5fwvBTms38CNyufhHvOLRX125pxsd3aMY5x2GP
   1PLUH0u2rWy9AP3+T6xxfD2URk2sxXejHl1i8ImXqJhImCqU+Mi4R9zEi
   6fLE2E3FGiH2dukK2EdBd1XOCteLMu6CuTQVdLyzLA+zza36Mrf7N/152
   WLh0Ot8T+xPwyqShoCpmsYTehp+2jWpm2igYVez6ZSUxedxBuK48XkZ3y
   Ab7Sv+sracmJ3tBs4HTL826WeJ8PtuRJIu/E3ciMCy1Hvomt8y/9+nTQr
   0a1fV//F4nna4Y/9pcPSMQUI6kE/uelYg0ol/HL8m2+e14XD35KReBKmb
   A==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="231439237"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 14:41:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLE3DW5n/fNa6RfDLj3kxXHUI05bzLw/YGzyotFwbLsaeXNiFVC43/A09bJoqtX34wgulIgSN9SpRi28OCNKgS6rOtPASFAnu7EopDHBmt3rsVPAXkOhYzAcpEYk3fFbzmlUiHzOA3FRWhXbBWHR7fjFSh+4OPnxWub0K346FUFureU6gM0c2BTqOfyo9J9AIv1Y3HYa8gl18El5rkWBMCZ9nm/Z2TQo54URSZotvQUQ9KfCOtgRqxVowMIxob/n3X5VHmsTqiJO9CQCCRL5tuhb1VylUmCc130YHZI2pyfQ0YelKqxy1dLvx3dKwfBd3x24lOYV/1XIwiqVW0tbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEzZwd4IOtOyARRMNi/0Jj6Pxh1T8TgsIoRBNf2bbhc=;
 b=XFOUTJ67YG8nJohUvhFoNH1IX5dmRYu58jmaoDdfQYwTzlGkIDzGoGgM4nNwOK2e3/1I8d+aoeERU21YD9E+pZBZlq1yRpgj4tg+BWzpTtfKqjU81fV+Rcqu03WDvvNoNeh6lieX+G/g867Z+KsRC5NLoeC/6ezhOLldPfbN1naHo7GNwRZUBqUlvkQcTWCVcKW/WvfqXsGTcq42LgcstFB4eO3XbEzTCElQ3rBjfYPN3C1m9jCcR+80/33OoxXpNASi0d/w8daDoUBMvDyYFmJo0rS7t8yybvqjcMz32e5SwUFehzaRHea9VcE7WKH6njWHmLB6RSO6se2rANPGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEzZwd4IOtOyARRMNi/0Jj6Pxh1T8TgsIoRBNf2bbhc=;
 b=XI5B7Y+GV6+NoJ4ieby5XiX9kpRKuFIdhQV9UEFypmbJi/447pQmLPoXuTUHXg78/PJUzvxnTGCdh4dGn5WwXN8iN8ZFB7H6iv1hPtuIY6nKIjc5Di+mqjl+1eRJzqsmRnROP7WTAqyvta6pCE9C0pqtHOPUvCpNGafJqn/HAYs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7951.namprd04.prod.outlook.com (2603:10b6:408:156::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Wed, 24 May 2023 06:41:47 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 06:41:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/3] mmc-utils: add SanDisk to manufacturer database
Thread-Topic: [PATCH 1/3] mmc-utils: add SanDisk to manufacturer database
Thread-Index: AQHZjPdBe2FOM+9r4EO/sxh+uGo3yK9o+4vA
Date:   Wed, 24 May 2023 06:41:46 +0000
Message-ID: <DM6PR04MB6575DFC9F508E3998D5A1423FC419@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230522214818.2038252-1-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-1-ejo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7951:EE_
x-ms-office365-filtering-correlation-id: 97261719-94ca-4fe0-91d4-08db5c21f20c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsCYQws7d5+10PyAPCG4ViD7UG72xm5Si8P2ng4s7t/cdKQucPTK/mvSTM/hq3l7SfbuWI4UIKmiyLacMFtzgnKakPVNVAxry7XvQNPJwhXe0TnlOCRQfqno2f8r6V4krBataShhgxWsffPgJ4X3fdFt5+Ej+6DBV7X07ARz2FBafaGF+t83KjjKgVBiiQrCidIi3x7x29m0kGg5X1T9m8lFQZN9RiFvCczdKaTJSgcQYfo8ONDacNtQIJmYMBw0mNKCzT/v18eas5z1doorzi/Uvr1+fokZ76VhIDtpz2M/0mLtY7uQLe6hrM457RfoQF2nD6Z54dzf1UYV7Gz3khW1x3T2T7mXQzU5l9zrcvYRrAgqmd5jteQLGQhWdHrWKx6M2vF/lZIJn8jQA10svXQkS/yJeCiBCeP03+hbVewTDOcXOmgs0q97XZT3T3lWvRJ9ZUQ8FF8lO4mrDdp93ld9rs3hgz3+w740eU3ZlLry/2lOA9+JOpCwP0Jh/t/VXfFXJiZUvBErIjgln7hmUYe8dNE7lvycDepqkvvrlLFZdpoF7flKCzBgXkC7CDsDLeoE/FZQr9sd2URt0Yz8L9cOXT+rccZ8gfRGzguMWL4/hN+NM9ZnEyms8bZDukCRCyPYyGl8klDSozphTlR3Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(82960400001)(9686003)(6506007)(33656002)(26005)(186003)(38100700002)(122000001)(2906002)(4744005)(55016003)(7696005)(41300700001)(110136005)(316002)(71200400001)(478600001)(64756008)(66476007)(66556008)(66446008)(66946007)(4326008)(76116006)(38070700005)(86362001)(8676002)(8936002)(52536014)(5660300002)(130980200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?plPJRQXUezcRS1IIp5vGHql/NnfeAP2UIvuMR+1Qj90A0Xh8ziEtL/30i2gk?=
 =?us-ascii?Q?xzUitKzsm/rp7G5E5wZpBxPOFDXi+O6HPKBGBtkePhcLNSbPU/MeAOOgCLuN?=
 =?us-ascii?Q?Yn5lwUD7iY6AxMzRWIwb1AX6+igp8OOUloVBpj4brcXUwZmdB1aCq9A5GiV8?=
 =?us-ascii?Q?RQvraNHg+qno7F31NAIN1rxECeZ/KRj7BqODq7Xz6SNqjS2pAJ1Q5vOnPzhi?=
 =?us-ascii?Q?1tBzWPjOo1zT4QgSQk2y49KHuLMLYIxcw9VpCGU022+4fqNuQy6ptGQXnPy1?=
 =?us-ascii?Q?EBn1co+5+mx/hShRnvBgahLA3bd8JDLfeE0r2c5Cj7cJKrE9ybpAE/UfEzgx?=
 =?us-ascii?Q?Js1+WnV4SJly2B+k6epeP4UaU5owtzn9Qcz9jfWW2XpTCH7fcmd5nJnuYSIz?=
 =?us-ascii?Q?fj+UhS/vigQfnrY7faZxMFiAH52MDG1IlOg8cs7RgAamiQIm5LOVmT6r5oio?=
 =?us-ascii?Q?Yvmcfk93cUhH6U7XPPXs40lewabcl/OPmLYaO8GkJfT2qdOmSNrnF57O4XbS?=
 =?us-ascii?Q?xBOIk9hx0QEjtDZvXmd+HcwZnHLE67id7maBAmYuufbjk6mX2jc93vug5p+f?=
 =?us-ascii?Q?6LAv0NrW9NH8F3QtvfByLIZiqJ3MCj3FiZtCdDvxqDbisizNrmDSCzIAaooq?=
 =?us-ascii?Q?tFlaWRjTRP1PSy6fz6f2ScSGSddSDsEo12s6HcXKiWHsaPEbGgd8D/ZlwplE?=
 =?us-ascii?Q?5ywPENzzOfn6lPb/CIzvrEPi/LBGeCK8620dgF0E/Xls1IvSFQ+rqAoOnVHU?=
 =?us-ascii?Q?J5uhdme8lu+1aAoJuTCkMiLqQ2mTBuK6l6Mp+nVpUKvS+a5qXjUlheRmEo8q?=
 =?us-ascii?Q?tavw7SRJfoxo5Xyt9XEGf51qVUO9GQor43G4VWxvYUV4FTamFs+PkeMho9q9?=
 =?us-ascii?Q?mW5rA7Rn8l2Dn/OM8/4G1Ju2MHZdmP6fh3Khz7GKP/qlpcR45pJGg3hpnxvf?=
 =?us-ascii?Q?1kMdXFrKLs+KsQ/YLCFoKgbxo8BcqfLBDJu5T6WPFIT1tcQYsVPYXCpajmOY?=
 =?us-ascii?Q?lHZdmrl9INHbjfgpbcQbxbdYU4+6vQQxP23wQxhXQZ4v+54j6e1mBXSywSM0?=
 =?us-ascii?Q?VO04yH+jRkdXZJ4z8SeEXGpkgPsy1Hy+VBkqQX/3xqf10SVtX9AcuJuUEwz/?=
 =?us-ascii?Q?CvPFs0dKY+m1bZ7i/s/F2vR8NOiMuUpk0WizAmwEGaiYMXVbleD920dlXF1E?=
 =?us-ascii?Q?+6vVWcW6kyZybPCMFqYep0+iqUTM5C/g+XLS9PBDSpAvvrFF5RybdEYGAyYX?=
 =?us-ascii?Q?jPfim1aVBdek9kJxpvBTCRB80zd8qBTOCAFInFOHxyiLPhxIm16u4DtFcosd?=
 =?us-ascii?Q?MvtYgjeK92qeMf4pf7LYYHbuhiHGobd70GyAgZ6pnqS7TAB+qhghSvXad9yk?=
 =?us-ascii?Q?eQeu21ATINeAp2OOzxYF1dKMMAkTm63cHMeUWuZj5cQgfVYbvcg6d09rFZip?=
 =?us-ascii?Q?SBeOiOFzwxcv/Tm97zAxO5mf1nxaVklhNMM4sAtgelZLoExZb3lGBjDD2in9?=
 =?us-ascii?Q?KMtPNF25ZXr0O21y6DM5er+EtafK40/4wQ+Yq0iqQgu/Gt+NbjyQW0r6v/on?=
 =?us-ascii?Q?Be4UwFMp2k4CLErjCxz++ZD9IzM/FMeHelFI5YBz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gxRiAU2yNBg2KUMgy28nJWGgza2s5qv1USIi3ErhROpb70ohAvEMPjQRfxnCZIdpVq5PqT8kDVEyig18MhX1t5Hw+dojQWr2l+90VrOicLk4ysa64jn4aI/4vdX4c+neuuRFr+FZ+UQxoI8WVw5XwsJlVdefHhyHfxi59w/IKU4Qg0/AqeL7x+DfwDpJ2X3/kp6JuLFhl9D3J4Vhi/ucNT24WkFe4bVCrdW0Qya26nqC5fKs9dY2pVZFcCEzp332BIPsZzA5xepLakXXwj0kxBOSMuixN1NIyvoh+WGpbAH8//123jw/6xRlNgW5Ga9b9iHSOibHazZJV7z2jjJserG0pTqUoYpt6Xr7NufnVsJUDjcPUf/4sKITu+lrQrC++K8wbcnmJgwK1ry6Bhw0JH9jozBi0UcmEKI7HlHPjcG0TFx4s1N4tq7Ykk49/KWOhtGWGys/8i4WwzghIj0lqoQYNS3NG/+ch8wA+IbfuegeV/2wzCfF74DoHGlBSh4W9ziSVRX9GZtAqLaojZx6ipm7c8+XHVX4u15QOLKZi9MX6Ny9kpVjHVgf1Ak6NjALLOqniUfl+6VjUf6Mqm60bE6KkaL+YrtD/RUoa6tarBHnNfIiEF+UloRAPVkCCTfd105xScjZjL1dADR3/zhoGdeAdPWrhtT3dyYstyQEKE1CI/5Ijj9Js/qtRYMXCmQSuN5YkFsiqN3kstnZHjwvMNiidFdPX1HVV9Gc4O/ZTED6MMUv6vllf12YVbzUyn+hCKl4+CybrVYvwDZt6wDwx0pSY/5gf7/gv+lnslZSY7okUVXqZ5oQZYPc3S0+RGdYsYxFA7fzKg2S+GA4ps4rzLiDfA3gXcAFKic1VqAfApE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97261719-94ca-4fe0-91d4-08db5c21f20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 06:41:46.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIljhj3uZ2aSdIWy+nvyI0kDjkYS4Wy36uhINwxmFbul+kFE9pXLWaEC2aQsTN+RwLbBWEUSYdYq2SYQePu/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7951
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
>  lsmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index 55da3aa..da9d69e 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -239,6 +239,11 @@ struct ids_database database[] =3D {
>                 .id =3D 0x44,
>                 .manufacturer =3D "ATP",
>         },
> +       {
> +               .type =3D "mmc",
> +               .id =3D 0x45,
> +               .manufacturer =3D "SanDisk Corporation",
> +       },
>         {
>                 .type =3D "mmc",
>                 .id =3D 0x2c,
> --
> 2.39.2

