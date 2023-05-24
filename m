Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F37C77B7A
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjEXHlC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjEXHlB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 03:41:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6EB93
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684914059; x=1716450059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5kyVle/XHlYI4G0fNCxnWXn53m5TmuE9yiNJnVEF2UY=;
  b=fx9qgv5tCY5VkqT5n+0zRfh1yxMQ8f2sQuvf5SaY7jvjFKooGyJWDKVs
   0o8tq0gZCivbqMiB4iBrQyFI0s8jRPfGvgE4OBFtXcCgYHobrZGr0UNa4
   +u3+B9hjD/Es0Ko7WQEE4i9cI8y56T6FE3E/uQ/aT0q6f6Hq6zHdLYOaG
   TkawuZo2BSQLpvjBw/P9f0ZBYC1U88cxWWp3drEUnjMQ76nNBafNg8pDj
   gw40ULm7yR3akIpPDxaFEXnwdVicHFKOH0VhscVvpRymBDKjJtCtNNnas
   PBx8XrwZdP0pVcN8WQICz1x77EEoyNg/hGmhXh3srxx0K1SP184mncm8R
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="231534383"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 15:40:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8/kHlPUesAe0Z2bRc8tagSldM8vT+4t1d54Z3wPi43X+0OrIhXgT3BmjkRfKLhY4pbQij111qoa8h9p3fpRjL2XRV5iRCRx+QWu4pcmtj6DAsQIF2lx9rSlEzzk8nMyv65TrpIkTUmN5mGD6jUyy0s0XXKVrS+XNBEtGwC0pvJFe54XDkXtuJIX92C41QB6KTslu47BbqFTYSY2H3oUSgflV9jiTPqZzxzyfns4p1H5gHZCxm9TyUKMHec/NTNFGGhMl8ssr40yVKMT0GyE5KUMbl89tGjjPlSxPNyks1ZXi3aliGvcVsEHzC1CWSmHU/OAV1bBinSItmckjYFJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35XCxUCYiMuSdtF+1gFxyHETRgCIqsyArdbNn2PJPa4=;
 b=A1ITcYE71LCLUPw2pgxVXrEQujxeMEmPXR0i9WTCH0/AmRozVOeoHAwsb/utHaZH32xE1icc/GuDIOkOIewCBRRF/ONSu34tp8QKa9+y0yKO7IAI2WZ9Z48rDtZHVJ5KDitMefjFGWxxRHjZg22zhceAKaZnAImAA3bW2WEn8gHHbIfcSMGuDbSFveAIZeJbdSez40o6Temuo71ywUxo49d1gFLedLkpLDkfSEp1pe63HFSVGNgT4YecBTo0uhpx/19jB6xaqIfpKFCrfXMM5OzB9UfDhUoZ1Du8b7Uv92bkOSyX+FgxvbqqhGbnsygso77BAlZe8PTJb7McGqafCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35XCxUCYiMuSdtF+1gFxyHETRgCIqsyArdbNn2PJPa4=;
 b=a5GftPh8owxbWIlHf1UYAyHzrJhU/m0KUxLkIv0g1g/fx9GWccFv67hpqjet0RtsAyzWqERbv5S730GpUq10pyOSi+9vtxXO+AxlTV8gfZlx14VI8N2z+YoPYvOOrc8NmCLuF1sHR1kgbYNHwBjWX+NttsfiYlp62QfFYwyH/GI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Wed, 24 May 2023 07:40:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 07:40:57 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/2] mmc-utils: add error handling to 'extcsd write' input
 value parsing
Thread-Topic: [PATCH 2/2] mmc-utils: add error handling to 'extcsd write'
 input value parsing
Thread-Index: AQHZjPfcelSVieNA0U2EQ9VhMauYAK9pC1Mg
Date:   Wed, 24 May 2023 07:40:56 +0000
Message-ID: <DM6PR04MB6575BF84B56F421F07AF73E5FC419@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230522215310.2038669-1-ejo@pengutronix.de>
 <20230522215310.2038669-2-ejo@pengutronix.de>
In-Reply-To: <20230522215310.2038669-2-ejo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6733:EE_
x-ms-office365-filtering-correlation-id: 6c5a63f8-6e3c-43a6-21f3-08db5c2a3629
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E7WC0YjR45yJlnbkATLN3KGMyBfn8EChP/MnVhJ4GPGrCA8aT11JRglEZpLr4QqU3URVb4Vu7dd+mwcF6NrqlC+cINFM08h7yy4f626Ll9AcEDOJE6cFSpY6vPkj1GGQgGPigcyp7e714A9+YJsOD4CZujuzPJBPwXsjhHt7VEhmGIyHbO4/aT80TOU8TFwsDqTr/tPeU6bvP8uIBn9F+hWckcscsmhot8l5925QxrZBfeqsj1TG+p0ybIlF9B3dEYV1OsNwmDsdqYg5dIlbjgXECVBHmJZg04q0trX3NtYX0HtWV3/bM9Qon2+9soRZ5RGdgSxkH3115gtY7gsDOKgj3XdZJ1fvKLvP9VUTgTn1k0wptWlCUu3y/R1R1PeGKhdqAm1cChMrnuAM+G6Xk9VIFGuQrPH4pQpriycR7v7xWUd33YgtFaSqfga6rOTQUwNYy7BfwFpnPhnOd5JwYcLSLfV1Hj5US5UuOgSCpd6PIiQBLb9vjqjpT404/j2kHhkede3g9oBKEmfPV2i4KB0pz/wwVp2jjSOCHnVkELXzYceAqoCVp7o2JrLPuRW+57mvjdB0KI3ibjtbRrkUJdhnGou8VWj4PfeWNS0fhrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(53546011)(9686003)(8936002)(8676002)(66899021)(83380400001)(38100700002)(82960400001)(86362001)(38070700005)(33656002)(122000001)(55016003)(6506007)(2906002)(41300700001)(71200400001)(66476007)(66946007)(76116006)(66556008)(66446008)(64756008)(316002)(7696005)(4326008)(110136005)(5660300002)(186003)(26005)(52536014)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NdYb4X52VJThet5RFjL/wotIFrzpmsinqtKCgWnWZO4UWbnuVQabfISk4kyc?=
 =?us-ascii?Q?xwex7XlAu4znQ0j+p4OW3JEns6WxbTcnr5S2ITmC92NNjQuF9VPoViy1xZo9?=
 =?us-ascii?Q?F9W19keOwzbkXRx336fe7SSmDg9Ak8xZ6nvddAPD7RzoOnSLo2YgFhz6Pf/x?=
 =?us-ascii?Q?BMbsUUsYFNXVk+5mwWLtGL1yuK0pA1mX0vJyi81cf6uQUN/upxr0HhkyQ/LX?=
 =?us-ascii?Q?/HVJxM5qA9VWNjrX+7SFifcaGZ1KxbnohSS3i7Yo29bM0Hh+4zy1MYzUahrW?=
 =?us-ascii?Q?voEtlDbIm5HL16Ueo5/ap9eMVQJ8UM26jVHAZvDzAGHOrQM/T6mjRwH2d0xM?=
 =?us-ascii?Q?ah4puFJkamxizh86GcHu2/F+HINrSLnS50ii7clRuQddHGoj+QIS+MFTtFqk?=
 =?us-ascii?Q?gP936jtVfo8ZCejzEzizjw67vB2mkIY0sw1nTSsUN1vTXXuJWP9VLj6b5jhq?=
 =?us-ascii?Q?KV7OkzFUpKhmnWhLTh+Pgr8UrQeT/Ck0jx5770PTJC8Wifz9c05jdJtBezLc?=
 =?us-ascii?Q?0zttPqwcx254yPJYTM1nTeuJpDeiCSViZ/UD5xQ4N2SpkYRKWk6N6BC4InBE?=
 =?us-ascii?Q?j3Rz8HFfz7fKSHlCF3LVRMPwP95To74ReZW+WxvoE64P4gVYxAcYL32UTXrb?=
 =?us-ascii?Q?CBVPBonHENeTl3qmhCHLTaWkggXzfSwdhWzDyAkxcb1qMAiPcTiAF6LPsERy?=
 =?us-ascii?Q?A/okrA04FuHieL7awQC30V/JWFmph2PoMGc62fPfsl9x/H8952NbHtByDw7u?=
 =?us-ascii?Q?zhyMddWmLBp69MbV40TfaXuFtBTPJNj/Uzen7dKlTcNvoCc24LVN/iX8V+ZO?=
 =?us-ascii?Q?SRHHB4JMMDpeHqU3+Ay71V9OltAsb/CduUSxUrlxlkcvQnID6hoKy+Z8H7KA?=
 =?us-ascii?Q?9MR9pke/Rse2qh7kUOq9MzHXGFwTcJjGsKaaQW9sxmdQD+oJnAuMdAG9d2Sm?=
 =?us-ascii?Q?X38v4OQmOims6aYKKkxhSYS1QgnSWsezZTJoYiPg5xbANNn2+F67Tltb3kc1?=
 =?us-ascii?Q?hprDL4/DnXcCwEryNhC7Eu2FfDw+e2HRN4sj/aTUNUO21eFMLkRDgeqgmOkx?=
 =?us-ascii?Q?eGtXH1OroztalV/VXkxeidzrMZJv31VCoRJmsHxiXL5cjwvy5oQVoTP4s8js?=
 =?us-ascii?Q?2OwdMCYtdfAui75Pup3ThwAzzZyhijLcSS0rro+DNUOqeE0pMYM77kMkSCGb?=
 =?us-ascii?Q?BEmv+6UAR12KgnysRprrhwbvmGXvH8ArmqrezUiSWHSU6eUsPo6ogPVjIAIV?=
 =?us-ascii?Q?AaVQ5h6OGSq19YyB2sftlT91vq4BR2IMdPpuZl2QnBuUWfGIqR+iRMr+0A05?=
 =?us-ascii?Q?C+GUtEoGuSiS0Gi6P+YjZg6lGp5UyDemqSumQcIHfqkn08S05XShCSXUjodR?=
 =?us-ascii?Q?UHLi43CfW9Y/S1BnbCBovSFPKb2m18+WHOdeRR/bSwEXlXroLVLO4uNQk8sX?=
 =?us-ascii?Q?uVhFiRMv0tpwwS3Wy3E5u6OlWW3X4He0DOlNmDX/Cw3McBlqLUNh0RvJj+uV?=
 =?us-ascii?Q?mOeZvRSEDSHOWcNFWPE5bjfhQmqRU+tJ0jY1q2vBHCuJoNAqWfQzMUOHy67/?=
 =?us-ascii?Q?P//Acv+qoFsh3uCiXFWetDGNDmtlMlKAnQ7Khw7D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: srci8pHf4SXT6qA0n+DkvdyD0JzmwlsgD2YORlLt2pceQTWREmvCYl6qhGwnL5dmcG0Qc/i/uOFd7vJS/cn+jgOh4I/aHtf5/YCTrdNvfUmpuYQu1WyU+UcbiNrgH4kU17u4r1ZOio4CPU68xj8lt2NOZn4tTFpIMVZOpaSfCcuxTqd/WJJMLtsE8LFDjDQLFWBhYu7Q22cUl+PUEByG8tWbjW2zGk0UhnUtEyVhBriT7a2tkQM1iUQ8eCaGHZFo+LpRmKYqRkPBifkk39c4hLGd5QNvSjgoNiR/00KlhCdZEW5+pdAv5uCwJ2OGla9V28au+J50zZCcEl9l5y9E98+lt2VErBMVEKOPWFipuhae5ZxzdLA2tvCcL6yAOPjhHv6jLAjwsLl1O2WBrt2LbpH4BbeHKNOiONxf7yqf7B9uD0BR/LM7xrUK31XxqzynG8zhQHk2yO5NQsGR2Hzgr7NWo/qdc8B8XEKGOwlaIR7ZVaxQhK/e7tc3aO3kYd1IGvXlNKyDIXc6hzxHEGIz2x4yAerTXBgICCivTYnvGqN8HSn0pebQPbfabxwjGxZW3ltSz2IRfWx3+efC2o+DG+JOTGuOfzgy4q68ay17sOKu2PQBZ9WBaXYjJX1PwfCq1lNVt7+h3qAp2I4DsHX7YzivJj4GqoW3kfJr/Ty+56wTZLvYwKnFNhOGELmJevF1WzdLkH4QC4OZc7QBeXt0tsLdLzZ18H6eAXqf0ZYpMW/lEwilJ+3+LT+S2R8b3fPIAHjf0O6ySKw9jjcYUZ+T5zpECzd74zk+PxXsAMTOOeyMborYZelFfSzDLuJAVTP4qpWsPD39kTI7dQOiHR9ltXmZjCXYpWx8aihddTdpDQs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a63f8-6e3c-43a6-21f3-08db5c2a3629
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:40:56.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeSNznH+070l0Op5Pr708ABpFD17GgeIClCSw/3n719yam5jfB+IWzFTVSeLPW3Jx3OzL8SP6p2LhuehNNUobQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Enrico Jorns <ejo@pengutronix.de>
> Sent: Tuesday, May 23, 2023 12:53 AM
> To: linux-mmc@vger.kernel.org
> Cc: Avri Altman <Avri.Altman@wdc.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; ejo@pengutronix.de
> Subject: [PATCH 2/2] mmc-utils: add error handling to 'extcsd write' inpu=
t
> value parsing
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> So far, any value was silently accepted, even a
>=20
>   mmc extcsd write 0x100 yeah /dev/mmcblk1
>=20
> which resulted in write of value 0x0 at offset 0x0 since the parsing erro=
r of
> 'yeah' was ignored and the returned value of 0 was taken unconditionally.
> The 0x100 was then implicitly casted down to the expected __u8 input for =
the
> offset and also ended up as 0.
The largest writable offset is 191 - maybe use this for valid offset.
There are writable fields that are more than a single byte in size.
Are you still allowing writing those?

Thanks,
Avri


>=20
> This is not the behavior one would expect when dealing with eMMC register=
s
> that might, depending on which we write to, be writable only once in the
> eMMC's lifetime.
>=20
> This introduces the str_to_u8() helper function that checks if input valu=
es are
> parsable and have a proper size. Internally it also uses
> strtoul() instead of strtol() since input is always expected to be non-ne=
gative.
> Also, use proper input variables (unsigned long instead of int) to remove
> another layer of implicit down casts.
>=20
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
> ---
>  mmc_cmds.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 154020e..e348651 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1981,10 +1981,28 @@ out_free:
>         return ret;
>  }
>=20
> +__u8 str_to_u8(const char* input)
> +{
> +       unsigned long parsedval;
> +       char *endptr;
> +
> +       parsedval =3D strtoul(input, &endptr, 0);
> +       if (*endptr !=3D '\0') {
> +               fprintf(stderr, "Invalid input: %s. Cannot parse to 8 bit=
 integer.\n",
> input);
> +               exit(1);
> +       }
> +       if (parsedval >=3D UINT8_MAX) {
> +               fprintf(stderr, "Invalid input: Value %s too large 8 bit =
integer.\n",
> input);
> +               exit(1);
> +       }
> +
> +       return (__u8) parsedval;
> +}
> +
>  int do_write_extcsd(int nargs, char **argv)  {
>         int fd, ret;
> -       int offset, value;
> +       __u8 offset, value;
>         char *device;
>         int verify =3D 0;
>=20
> @@ -1993,8 +2011,8 @@ int do_write_extcsd(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> -       offset =3D strtol(argv[1], NULL, 0);
> -       value  =3D strtol(argv[2], NULL, 0);
> +       offset =3D str_to_u8(argv[1]);
> +       value =3D str_to_u8(argv[2]);
>         device =3D argv[3];
>=20
>         if (nargs =3D=3D 5) {
> --
> 2.39.2

