Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF08BC77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 07:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjEXH3R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjEXH3I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 03:29:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326A18E
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684913345; x=1716449345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvlDaJ10solNBOt5NefF77VivrVk99dajI375//zeKY=;
  b=Fv8D2/F1x/FuelEpqAraCAtNw9ej4rnwb36zud1Jjl3bMDXbbTqxQoNM
   e5wg4ZyYa9NPr3CEZPFHQXIYkYz6NToSatK+nkyEejOuWoWtJKVDD0pSS
   ZV4GLYJj7Ntz8z9VAcfmsYVtBeawRqWWPFpKN0Jc6BBskfz4F2raV0b0Y
   L8z6lygmhU1rQbdDxjCkToCpPTfyr31PsH02qZqNh+6SiMkRn6vhxtMVU
   seVfEALiGiXbSfjTyZp4YnOEWqgKhGNlPYN31CnywEMIMQY9LFU7N6YlB
   wIypHZxiGgV985U5P25izOROtZbYt9h8kjfoehL1MdQgDNXKMTRGDLJ43
   w==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="343606570"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 15:29:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8GpPKc+oVLbDrDLQgYmWGG5bp6Ple6xXGc1mZnM8SIq4xgos8Q0F/pN7xXc2eVVdkd1H8daaDdpZNDzYcBd5G0gXJNnYXy1HxGZif4kgIBY42apoWFnNGeVLwQFm+S9QaQ4xAi65Yuva2sMxq7mB3w7NPeymKAPtZv1SzSFFSlGqetCZWzDdFUc4HOeOXELu9T+Zae0XY5Ff+ZuoghXyPTr4kZTnTd3FWwjSv5rEbdPGpZkfGGPZy/KjWcNPfQOL7x45omOaH9wy5O7SLgg5rhEobzpwc4aM+Ykx/StLN2GJUAbK7DfZYHVsPBf1ENtrMpdWMBajN37FYA/uDSTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5bvfxZDNweN8aGV7+mA4Z8vnuOgmtW76I2IaGmIqo4=;
 b=bFeq7G+ag77uQsovBrcfN8jiuKFP7kEeX/aYAGGH93Y2OImI7WQsPekTZUsAdkqe6kJG4lUEKwBGMqrVqk2vYEewwqrii/BFZym4Hc7hrXh0MmspQIDQEaw4GtQalS2F2FHFfMR0Mcgfalj8KQOYwCjSDSIOu4kdE1yBkaYSWuQjQecYDrOIjBQgknfleNNHC2LMuqwoolcCLkeCJ2JNfmenZUx6VCxtzA2BHgKeLIBH0DqY/qcWqJayu/fDOF+1vwcSe7jEofivVztXb4arW5khbobt6pb20cshpi8K8jKlu8BhtZjHU9duINnupw/ZMcWK0e21m1xMg//s4SbskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5bvfxZDNweN8aGV7+mA4Z8vnuOgmtW76I2IaGmIqo4=;
 b=lKRR+uFnS+aikuZVowSkowoM9JeOy1kaT3fF1zd2nywzyXpCr3G7xYU6P3PweojAJiKHT3d4B5Tc38rbFUsQoo87mVDMEKsMTk6t6DQNUNtnFGWJ13DQebHECdTIITyLbmZ+76e0wCgIQ4YB5jeP7tqdllIJl0flinDQeucZB+s=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8353.namprd04.prod.outlook.com (2603:10b6:510:4b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.24; Wed, 24 May 2023 07:29:00 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 07:29:00 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/2] mmc-utils: introduce optional --verify argument for
 'extcsd write'
Thread-Topic: [PATCH 1/2] mmc-utils: introduce optional --verify argument for
 'extcsd write'
Thread-Index: AQHZjPfc9+/gs2EG9Ue9V5nzs2yQGq9pCHsg
Date:   Wed, 24 May 2023 07:29:00 +0000
Message-ID: <DM6PR04MB65758F2FDA9209F713F9546EFC419@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230522215310.2038669-1-ejo@pengutronix.de>
In-Reply-To: <20230522215310.2038669-1-ejo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8353:EE_
x-ms-office365-filtering-correlation-id: 3ed53115-bcf3-44fe-c01c-08db5c288af2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/SGRF0SIUVsnNVDmYuv8W+/sEi5NLs8eCiQCgnLqbnziq7hAe/XI4zizKb72NjEKzl31dbF7/77R7wy/UMDtzm/BsDFqkmLVJm1sN4cls3UakDYhS3J4w6bJygkNygnNgnASEF9+cCjndTbD8fbwiJZylPByB2P5zRHLfn0csI4KOxv7fA/McbO7Ynuun89Efi/s6vY94ELRz2btsm6Il1UI2q+eqPaprR4Qyo1bMj4sPgLEx4I0c7bh67XnjNuAelCZSEBTL+dEMPhAk1TPPzzfBs9ybyq1dSFCufOdLqcVPr29klBImEVednEW1/B5O4jbM31JmMeu1Qb7G1tOYOmxoRqTUF1I1E3C2+5gwNvli21OaQGkNaSG2l+qtvwx+JiI/Cs+Oa1oANXtwfeFVeVIK3duClnIYrcQNbHW2gGw0ODxWmF4u0gehRALVzgI6iSCbE8nIXGh1c6XWfUEigy8MfKRbhIqxURDPQwEvsOlot5jfJXFzKrDyQ9JfHP77xIn1Mkx4n/7EzkvyXzeOJ0W6AAyTHDmDJEG3zQ6AlxH4VK8cK61389bgtjn+qQhMUFK9148jn6nDmV8d21E5dQyqxRPcaMpdkA2rMns/WxpOkFJF+/+tmC0mD/UDP1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(8936002)(8676002)(5660300002)(66446008)(66476007)(66946007)(15650500001)(66556008)(76116006)(64756008)(110136005)(2906002)(41300700001)(316002)(4326008)(478600001)(71200400001)(26005)(186003)(52536014)(6506007)(9686003)(7696005)(83380400001)(55016003)(122000001)(38070700005)(38100700002)(86362001)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZacv/ZrG5qDtaLyZsgM0mcEKqQcJ+At5d678BjSVNWORTf167Psl3rIcr5w?=
 =?us-ascii?Q?uNlHZCtIBu6YgBMuBn/ImykcvejweS5jQvMgDVNF3wsO218/CanAN57CQJrk?=
 =?us-ascii?Q?LjD1t78CtLIeyARLbHVg0gHB8lGE7tLh9GQx1QArOY7IZzG0ihTzR/njD2MK?=
 =?us-ascii?Q?La0JlJ9sNBC85fjMsp9ebsGyAHcnABuEMNkG5H3vyEVhK1oAqL4qbDgcNN1C?=
 =?us-ascii?Q?q4FGehLI1BKpLFqE3wo3rhtzJVY86/LmZI2Sfvo1Stvw0Ea7kH84vZ6z3mVo?=
 =?us-ascii?Q?DRYvzAKKXaljD8JMPyqBdAXePLgC1VSQnq85Rbd8Y0iICWAla4uqOhChyes5?=
 =?us-ascii?Q?64PhbiKvgrF3X3vdfQKoYhR75w3mnpoxYofgOgbOmBKwUwDl+8sYUwAWY6Vb?=
 =?us-ascii?Q?N+f62JCM7b/hQOVFnOYj7b99wM3cUyVVtp3CUyEUSVgVTnMoCmfxBIFihSEB?=
 =?us-ascii?Q?btbu76xLtAAzba0UV07x22hzyZwmZwjnNXB7uz22Hstm5XdT5qviJZbR5zpB?=
 =?us-ascii?Q?/q/zIWzxa4eAw27CVcQj9thMeyBUCfYNhMi3XxsmMfmxp+TmuOb3oKIVrky7?=
 =?us-ascii?Q?J5CpDcpmfbpOJPYQiCVSxkwQMWnx2e0VQYmpCFVVGW96rN5oMHiHclHTCHyg?=
 =?us-ascii?Q?YbY5/yA9L4VbHEZwQv+K2MidBanJ/XqEK3EMacTwfKNA7LgLkhhBKn1sFTas?=
 =?us-ascii?Q?W7ueqCGmrVbnPPTp0HG2YcY90HBemn0q+ZRITDMAvAeux8dDZX29uN5gv60N?=
 =?us-ascii?Q?hXkiwF0fgq+lA6eFxbSKAeJa8/BiJ6ZzzqwhKb3rZJxmBvpFjlnEcRPuq1aI?=
 =?us-ascii?Q?imUzn3ukIs6VpsI++1WU0AYaqFAegvZtR3SpvO18hGLi2BVP5tl/zqSnKKvo?=
 =?us-ascii?Q?wQGW+jgWfCLiaJH7wog0CI9zSgynMpEl1VnhKUlcisbn+W+4WdlXip45skUN?=
 =?us-ascii?Q?N9XodGHx+N5ArVXFd2QTM7ZMwKanGOT+JZhQCqk9Gvh9vDa7Alu0z6A+8a8j?=
 =?us-ascii?Q?vsiJ5SuPcvWlFgiL8CivGUH/iV658SONObHWsR5M53CLzMhLheOHe1wHU3BJ?=
 =?us-ascii?Q?OFGc6A9AguttQGpBRMMBp/Omy1JYvCxguY8CJed3RbXNQisHePV3vtqk2yzS?=
 =?us-ascii?Q?oTfDm/e7IeJ2jRJHzmHL/d3uZv3qG/ZtmUYIavBg1DcZL8py/SVKgiTblVfF?=
 =?us-ascii?Q?lMs4jKs2FXjU14Nd4TjmxBD+mx4EZsZg+25IKGRznnGnzMM5eHvmM8kgcBe0?=
 =?us-ascii?Q?z2WYscdPrK+FECSf5o/V0XFchmixbj/o2Gs8JmLmf9putP1E/YjOoACTQS/j?=
 =?us-ascii?Q?494MwySEMhUAtvM6dfgnKhZXo6ga8Hf4yS7IiRonD0arlqflZexJCEIhHxX9?=
 =?us-ascii?Q?+zyNzMX9ezGINdPN+waeWgcpDSTvTPLBEVVWjuM6S3F57OWzrxGbKlqG3gDK?=
 =?us-ascii?Q?mpr1/YPpYQm2+k4oO0fPA3wEOKNxbsMFTus+I1y3RykKloUwQ9FJnPcV+G0J?=
 =?us-ascii?Q?MrC2SRf4Wd96F0yyaH3cmVUnbsePBcPr0O4NZf6QMvJS/bD0vXu5LoDyc5rs?=
 =?us-ascii?Q?FbdmRBGqi4DZ0hSAV0VVXSxv9dC9dTBtkDus+cy8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hn5Ap1PCELEyOXxIV/Ri5LCOnxyLqvyC8hy56yDCJiEenC680yibVZXnEEr2QGAc/cxLcIxWomnrtCqNf7w6ZgvAAIofyd2/+O3WrHx6L+6hzUTzb0r/C9xX7mjUuQddFe2f75IjuZ/VEq5Mns+jInausNozYCPcsnU39yFRPGge2PFTm0T7MG2qFr1hqKh8SRAVuh5lZ2hP5e65mktK8uY9q5Pue337VwC3X/A/wb+MxE+2jELdicMrtcd72EGRk8wBm+nw4WiJs556a3R9WHGHBRSUCGkhryMJo4Km3wHZVXV5AogBHSdXmxWcyWemCDBezJ/TykD3GYfc2Jbb04djcl9Zvlz+UCHyqL1xx1SpZPNgZcWwJSL1jGJSuT3MXikAj8DEbvMw2QDuF24Csi5DZkaSSpSkbzVzH9cK0MuFWxT8Ry3yIX49aYdvcSrwDm6CvDol3Fg0xrfWVNqYlw0YrZpfObtASayPmAtXZip8BDP89aq6tYeKZ0CudBCzj7dsRJhCDZVUqTrgdSjJl4UFFkpvAFX7OveNeoe/cyb59TcPhmI5QVhHAjZc5aWHMlOrCAsN3+Kdzyhi8rkXFsb/IyEnj6PDwh5wph9zV3n86rx/qD2Ag3J3GN7p1iAo9aK2VlX7cDLfQBovPZmZEtg0saQ3y6by+4xcvWQlpuZIluxM5jq8G8LbVy0Hzpfvh3jIU8sPW+i8Nazd45ea4XnyW779w9lCZJ7DG7c8ySEgNCPnTE84e5x+fIdIzIVfiANH7IVqvEjvbMXftmBh1RT8AhmEkMYUN/JlEoIfNlXNDaJfpwUpbsYBNGVumdRlF+Gg9yzPXKC4xHEAYkCTtTLNLYS5YgthlTqt9bG94ao=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed53115-bcf3-44fe-c01c-08db5c288af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:29:00.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGfKYOoEfXM3adT73+u/O54M7Bhg+o1ruOhgogiw5JD4sHtcsEvmNtjEWdSyGSTGOFgL+JS8lIc1niBUsHbhIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8353
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=20
> Registers can be write-once but ioctl does not necessarily return with an
> error. Thus it is a good idea to allow verifying the data written.
Yeah - I find this approach more practical, than e.g. analyze the R1b respo=
nse.

>=20
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
Aked-by: Avri Altman <avri.altman@wdc.com>

> ---
>  mmc.c      |  7 ++++---
>  mmc_cmds.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/mmc.c b/mmc.c
> index 795b4e3..3f813b4 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -56,9 +56,10 @@ static struct Command commands[] =3D {
>                 "Print extcsd data from <device>.",
>           NULL
>         },
> -       { do_write_extcsd, 3,
> -         "extcsd write", "<offset> <value> <device>\n"
> -                 "Write <value> at offset <offset> to <device>'s extcsd.=
",
> +       { do_write_extcsd, -3,
> +         "extcsd write", "<offset> <value> <device> [--verify]\n"
> +                 "Write <value> at offset <offset> to <device>'s extcsd.=
\n"
> +                 "  --verify  Verify data written",
>           NULL
>         },
>         { do_writeprotect_boot_get, -1,
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index df66986..154020e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1986,9 +1986,10 @@ int do_write_extcsd(int nargs, char **argv)
>         int fd, ret;
>         int offset, value;
>         char *device;
> +       int verify =3D 0;
>=20
> -       if (nargs !=3D 4) {
> -               fprintf(stderr, "Usage: mmc extcsd write <offset> <value>
> </path/to/mmcblkX>\n");
> +       if (nargs !=3D 4 && nargs !=3D 5) {
> +               fprintf(stderr, "Usage: mmc extcsd write <offset>
> + <value> </path/to/mmcblkX> [--verify]\n");
>                 exit(1);
>         }
>=20
> @@ -1996,6 +1997,14 @@ int do_write_extcsd(int nargs, char **argv)
>         value  =3D strtol(argv[2], NULL, 0);
>         device =3D argv[3];
>=20
> +       if (nargs =3D=3D 5) {
> +               if (strcmp(argv[4], "--verify") =3D=3D 0) {
> +                       verify =3D 1;
> +               } else {
> +                       fprintf(stderr, "Unknown argument: '%s'\n", argv[=
4]);
> +               }
> +       }
> +
>         fd =3D open(device, O_RDWR);
>         if (fd < 0) {
>                 perror("open");
> @@ -2010,6 +2019,21 @@ int do_write_extcsd(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> +       if (verify) {
> +               __u8 ext_csd[512];
> +
> +               ret =3D read_extcsd(fd, ext_csd);
> +               if (ret) {
> +                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> +                       exit(1);
> +               }
> +
> +               if (ext_csd[offset] !=3D value) {
> +                       fprintf(stderr, "Verification failed: expected 0x=
%x, got 0x%x\n",
> value, ext_csd[offset]);
> +                       exit(1);
> +               }
> +       }
> +
>         return ret;
>  }
>=20
> --
> 2.39.2

