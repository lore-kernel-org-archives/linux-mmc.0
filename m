Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0538C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 15:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiDLPXs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiDLPXl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 11:23:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C671C923
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649776883; x=1681312883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ESBdCCvvM8ae9qjuOXlkskyR8JAl0tyxVmYtSxPNIMw=;
  b=TYc210rfM+ouBPabMheSFTqQLOFw/hqOkc99OZzCBan6b8i87I7JKoYW
   WZ4xvqYXQJKzhUbZnGZxJQgubZfyaM0ZAZNHd11Ez/zki+2dCtVuvnpYI
   Sf/mthf4z865hYl79yR/WOUSbpnHUWTE+GfgiiiGO6qLcdiwnadtWyeKq
   7GtbHyZI//j25d42wDtbInz8QRKJXjbWrNL17cOY9FYMi8rohUBDboNVu
   zyFia2AhNmr7fd0fuaJoIyQBC43Y1diwW+EhciAsK30tgQIcD3pqqKmR5
   zTx95crDjYitx4Sg5lDvHbLoAdDxORJkLjVC1ZAIatKKZqwqkMRMgvmx7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643644800"; 
   d="scan'208";a="196604385"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 23:21:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/B/rL4KsLFb9FJ+UzrQH6Wn581FYVogVQl4+xsaW3NUxnGuea8Yg/q1Qb6cPw8KdvGNB6YkB/q/T0sI8NVXg7acMCmIFZOkTqcZNkE86ICTDECFfpGHRFHICxoiKHf5EU7eDNllGqoUZf0TmtGg21azH4iyIaEAgS8wsVrKst/qgVw+amlN27wVsyH8jatJ1nCi92Z9KF+V1dS+XvCwBvXyUBYZ6ZQ8l069uGpUgtvaQTUtarVOR4cNPICzGqcnY3r+vgAgLuA5gYvRuihSqvV5+VeUQ7Jcp5ys64n2o/p5WuqNuRi6m+6mCs8gXW4ozWSJAjL57rMNMZy479VAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp0PptdYheGAyqCOqlDm46yv9U7MSsA6PSSmW6qJzFg=;
 b=l7dJxWITAeVPFfDW3mCTAicILGfKlCebcKI9Dj1DQDKZcSXoGOcxfWy2LRwoR2ib1bGm1QYhwurhOnDpg1EP7c9TdEuJaRpsgFLOeY+7oS0kLdUb8MMce1AKreuUOAVLdI/28w1H5Rwz4czC6EcDUym02Flh42PRGZb999hrXMUodm1rvA/HHXgHiwIpwzff0nIB2VP7VIkjW8aahlMZ4NBOB2NtuGc2v9iX2c809VbZKtcki8P/C3pqC5VuFFBcafo2a12G7tez/VtFCUvGAVOX8Mvk1UhVjf0x2E3iqr5ehI/D6+A4Qh+3GnHkSlqiks+QgmbiiHWQaIr2KXMXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp0PptdYheGAyqCOqlDm46yv9U7MSsA6PSSmW6qJzFg=;
 b=QZZ1QcK5d6folhQOg5IFyDlHYgxa4XEQZLmKxLeillH1pQ0HjE8XDjwSijasFe5HVHb+zW04y9/07EIqVucgLUYy6SXRcOpCOuEs4t9PzCPdeq0V9AtsHhPyoj2eabItyIBG1tDhXIXdode6qpnxoULWSuGydSy2YleQZEgiGic=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6357.namprd04.prod.outlook.com (2603:10b6:a03:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 15:21:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 15:21:19 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "liu.ming50@gmail.com" <liu.ming50@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [mmc-utils] [PATCH] Revert "mmc-utils: Remove unused
 MMC_BLOCK_MAJOR"
Thread-Topic: [mmc-utils] [PATCH] Revert "mmc-utils: Remove unused
 MMC_BLOCK_MAJOR"
Thread-Index: AQHYTnYXutaUs0x4ZkyeCV3rKAA1BazsZIcg
Date:   Tue, 12 Apr 2022 15:21:19 +0000
Message-ID: <DM6PR04MB657590AE4B4537FD88D0FDA9FCED9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220412140331.1146516-1-liu.ming50@gmail.com>
In-Reply-To: <20220412140331.1146516-1-liu.ming50@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e701e5-0c27-4e91-a104-08da1c98186c
x-ms-traffictypediagnostic: BY5PR04MB6357:EE_
x-microsoft-antispam-prvs: <BY5PR04MB63579F150CB511F023FBDB1CFCED9@BY5PR04MB6357.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1Es1xGqtLRzwQaQw5J/Kbro65Gr0F18+sM1/0c5w1dkBlgmWUwrIhyqMLu0IKPBgHIDJGXfGfp7TE2xgvbPdcMrLVah9w1QddX2uG7Gn3U0fpylhR7ZOtJnZUcEHxRnou/orGwIUXvUlEqH5Z1pdHtxMtxPDv/lOiGP9x5M3QGGK3rWCsw1FmTSQAG2k+jm6UpwNnVxqo6Nnai0z/okbgrgZJw08KobVrTJHIgsv4RLsI2zYqRzok8Ch2Tg/RMmMlBrNpiOhsVEn9ZbfFH51ahOaWezeZgNAO/44mgNuT4pSfcBaQgjcQBzqOanw2MItS2IRZXyI2HHJLtHG9ULyGdFWSlDMXXNLrAA6Fk/jlFqAqjJdYwwZy3w/tt3KHCUsiHk880D9AkxVg2Dn6SRMUpQHVSSd+XteJoi4Blcfv/jdpr2hN+Li1zNuoYC+Er3tKIqgzlDoDNQhucYVjRrGMzOmWuVLQ4M737ZJ4Gcc5kfytuRgrpDvHI0IULxp2bM5caBfedi9ts28c3IPLrmpQSZr+oavtFgL8cg5UFJmCkEr7kYwIsDevZ2tlJ7SEw9qNKjiEgw6OV0x+VXUMInC6hue45lopquO/wKMDf/OdFmshFrWIaDAbdrkjrqiFr/cGjjZpNwfYM7ocMCvFddTrGAUz9Ey8Ck5OpbNEttmhIgMoCz+nFO9e9vCu2a7ZKO+YTcpltCn9HVdFF75BLlyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(52536014)(71200400001)(5660300002)(508600001)(38100700002)(8936002)(82960400001)(2906002)(76116006)(66946007)(4326008)(83380400001)(8676002)(64756008)(66446008)(66476007)(66556008)(110136005)(86362001)(316002)(9686003)(122000001)(6506007)(38070700005)(186003)(26005)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ho/oAZQic5cqspvBGwsfKoPPyYbCSYC/3T0Tgb75Qqkqv6AkU9Gp8G05PQeB?=
 =?us-ascii?Q?pcRVrL2qDGBPRkIGTEzSQgtHBZzTvN0Q11IYYPvl7HhNciTkoPgGfUR8f0Mj?=
 =?us-ascii?Q?8pil9F/7gkGI9PenYlknpWfR09xzXX2BqRCOEg8NNjIB2W8tXv6gSJeipZSE?=
 =?us-ascii?Q?Ytx5nQRooZMTgRgqXY1yX7M8GZf+ciGHNMzrzFuCCT+RT0j0yzoatI+9k7G1?=
 =?us-ascii?Q?GUV/a4G3VA9TLxtcE9Rh7Y1n5DsGmKJ9HS2X7FzMOxigOLUmttACXQK98dWj?=
 =?us-ascii?Q?YojApCvglKCQDUeqv9QoQqjVMB+KyGG73CLpSKP2X126wzPa3n8uqeoQaE0o?=
 =?us-ascii?Q?8XO9LiG7FlPuYCyM8YyjL9RxF/qFLzBS/OvbcZ50CHQk+mrzxvb5hbTExRwJ?=
 =?us-ascii?Q?uzHDx2L0g4RyRVMuJljDunK2eR6c8ja9amQRMkooaon7kDe6t4r1OgwOvGLj?=
 =?us-ascii?Q?1zUQNy5utzb25OQfChidhamjzdvkpAX0liYvzXXbr9K1mV6pBnoIuct6u2qL?=
 =?us-ascii?Q?pIYumzXnWlqMWNcbry1pELwjDHQI8Zpxas7V7bQtMxKNklEPp42AMKbtSaYu?=
 =?us-ascii?Q?PNYkEbHE93ZYAByymB0mY0OU2jnwU9KSLEvi2SUnGsZ/1bUhkk6P5Q9lvVjK?=
 =?us-ascii?Q?DS5h7kyJqjrdQuvdLXsL2c0fuCWvm3V3EeYTW4/lwT8Qdzbk13LeqHbW6/2q?=
 =?us-ascii?Q?gmwCNFzWpJ1AbuL96Rwj1/UqFph4jq5bSuQwqHVbYYvr2lNF0w+qyb54xkwi?=
 =?us-ascii?Q?BzEOI+lRkdqQhiyDTJKECgeGn7RrWFu6HVBGav+4MvrEEMuZJCMRtOi7Ikjw?=
 =?us-ascii?Q?5YgYS1gV0/A3kIe1ItRYgZpo47zvX7jZD63Mbc1+og6su4t3vDmHychIsp2V?=
 =?us-ascii?Q?zoTXMb83KB4en6grNRL1dr0m2VzUuCAfcK7eSUWQQsvtqxz3h9BrSjf5fK9m?=
 =?us-ascii?Q?jJnoZoVr5xV+rxTZdD/UfdqC+ERsLpZluWqV+aWbIAw+8DjkHr0EBPgBJRnl?=
 =?us-ascii?Q?IbU5wtF/he546m0WPpAj/9f0afWfGL/aoSf5oHC2MNY03ZttBSFDpKuNx0NM?=
 =?us-ascii?Q?V4/G2teReI+wELwWJCn9A83DnL79CO1V2Zdl6opdborWqEfW1YmSmNfWEvlo?=
 =?us-ascii?Q?S4gzMVarGp2+IrIpqFtkxvfOftUdouXXGnB1fXz3qs5nHk1gt24ojWfbHC85?=
 =?us-ascii?Q?XeIKcdDvBwDuI8JhYvpMJpy6mSeT4amuKRTCJjxM3M6b4whr+fxLrVkp2wlT?=
 =?us-ascii?Q?Nqyt7uc9j1TAxafxcSSbbGxmVh0m08DAU7D/OTVzEA852qweW6V77SisjZ/E?=
 =?us-ascii?Q?FUupPQLAbu7H+oh67bJbf4hTixTFJFoIej9xAbcB77jKJBwZpt2QTcfBMHgk?=
 =?us-ascii?Q?zd698hr4lAiD7i4i6scB0NHYRQ7RmgfGwIQooAMoIAPgqadtdL8NDYDreu7e?=
 =?us-ascii?Q?4VWZVcffC36GLAxIiaavlsyXhw9uYFs6/ZvVGhMMPtBXqQYa30mcLsBF7UWF?=
 =?us-ascii?Q?XvL4azR/LDEAHol5ZDUDGQ/XwhjMGlNlWXMvn/6kL8OVWgednIQjQ0SS5SUA?=
 =?us-ascii?Q?TNl+OVYabPsSxDnmdvvVGndL5IP9ZlA0a21YCVJS9A4DebSeT9N2R74KmEPU?=
 =?us-ascii?Q?I5dibmhVOhnXXww0FnFRR4q+jsYizFPp2m4joWzjowXii+drQcAC7br/zu+P?=
 =?us-ascii?Q?mnXeBXAVvJh6rPlxZFtirh3IgFlaCpfY/135w74F0qBt+5yr0it7dsUZRuvh?=
 =?us-ascii?Q?nBI0hD9kAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e701e5-0c27-4e91-a104-08da1c98186c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 15:21:19.5618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqfUddTqfTGeJwKPuETCnMPrH1fGDn9X2l2YaZ0378qb7gCIbXlwH+ePPFdv0K+sZZfflxT+BBmkDXDl/PPLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6357
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> From: Ming Liu <liu.ming50@gmail.com>
>=20
> This reverts commit 118dc4a0909f3413b6f8bd086cef43262e89dc2a.
>=20
> A compiling error was observed without this reverting, as follows:
Can you share some details about your platform?
Are you compiling for x86? For Arm64?  For Android?

Thanks,
Avri

> | mmc_cmds.c: In function 'read_extcsd':
> | mmc_cmds.c:72:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in thi=
s
> function)
> |    72 |         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> |       |                         ^~~~~~~~~~~
> | mmc_cmds.c:72:25: note: each undeclared identifier is reported only onc=
e for
> each function it appears in
> | mmc_cmds.c: In function 'write_extcsd_value':
> | mmc_cmds.c:93:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in thi=
s
> function)
> |    93 |         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> |       |                         ^~~~~~~~~~~
> | mmc_cmds.c: In function 'send_status':
> | mmc_cmds.c:110:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in th=
is
> function)
> |   110 |         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> |       |                         ^~~~~~~~~~~
> | mmc_cmds.c: In function 'set_write_protect':
> | mmc_cmds.c:148:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in th=
is
> function)
> |   148 |         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> |       |                         ^~~~~~~~~~~
> | mmc_cmds.c: In function 'send_write_protect_type':
> | mmc_cmds.c:172:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in th=
is
> function)
> |   172 |         ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> |       |                         ^~~~~~~~~~~
> | mmc_cmds.c: In function 'do_rpmb_op':
> | mmc_cmds.c:2157:25: error: 'MMC_BLOCK_MAJOR' undeclared (first use in
> this function)
> |  2157 |         err =3D ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
> |       |                         ^~~~~~~~~~~~~~~~~
> | mmc_cmds.c: In function 'erase':
> | mmc_cmds.c:2659:29: error: 'MMC_BLOCK_MAJOR' undeclared (first use in
> this function)
> |  2659 |         ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> |       |                             ^~~~~~~~~~~~~~~~~
> | mmc_cmds.c: In function 'do_ffu':
> | mmc_cmds.c:2888:37: error: 'MMC_BLOCK_MAJOR' undeclared (first use in
> this function)
> |  2888 |                 ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_=
cmd);
> |       |                                     ^~~~~~~~~~~~~~~~~
> | make: *** [Makefile:36: mmc_cmds.o] Error 1
> | make: *** Waiting for unfinished jobs....
>=20
> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
> ---
>  mmc.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/mmc.h b/mmc.h
> index 25d6864..193dfee 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -19,6 +19,9 @@
>=20
>  #include <linux/mmc/ioctl.h>
>=20
> +/* From kernel linux/major.h */
> +#define MMC_BLOCK_MAJOR                        179
> +
>  /* From kernel linux/mmc/mmc.h */
>  #define MMC_SWITCH             6       /* ac   [31:0] See below        R=
1b */
>  #define MMC_SEND_EXT_CSD       8       /* adtc                         R=
1  */
> --
> 2.25.1

