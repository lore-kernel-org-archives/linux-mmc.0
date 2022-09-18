Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A45C32771
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIRMev (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRMeu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 08:34:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1B5FD8
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663504489; x=1695040489;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=e2AkElM1azo4VsWWT4h5gx63pzM+wWVZANgOsV1mBhM=;
  b=G2Ya4tRKDliABDJKiNJK24gMZEFnVwyedPfmkJV3VzC2Q/8nl15aEVy2
   vl7MqzdBs8uQG3QRVJQ5jn/Ue+Atu8fDZxjFxs1N3nfTlG7LW+OJYVueg
   H3uxiABmCJ/MlBvFmQEdrQvI6nd0qX9P7j1giE+E8B2N86evvHUN2tOQJ
   g6Mag6abalNWqXMVikOfR73aPp6KurnUPVr8o9F86lJGk2g8zck8djxmD
   zWsrptReG6xFyOEJ3FnU/v2tAFLdXRp5vMxfhmdxsKZgQMfaq2hS20J2V
   2EWCbB3fcURr6O7smNrSnbVpKUwdLtVcdHVJtHxOAhrQ0dMdX5K+2EO9F
   w==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654531200"; 
   d="scan'208";a="212080631"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2022 20:34:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEMvN3AYz0w7QGXCXQRHO7FOJ0CX+M29vnZcsmyOgX+5WNB882suhviB3eVsCBKoC1r2zCbHscUr/sev/JwfwuamUefYcIweUp1vHDMUekAr6xM/Imm45iocBG/QTo+jEBPUGNgqG44JBCFLlHVv71evOOGRp9uXV63LfoFQni0S+v0U4ZbJ2UacU+oC5BxYFH0KSGZ3gfdfKzoyrV31DQEvIU9FD7nH+CuqepI8C/FugsEJS8cR/72gEFm5NhXcAY5F/gdLSiQdS0sC9COJ6JUM/No2aa6iT5U2sojb7VwjY23M42BCq7k70e5ZCw3tpZe1lZsoc54uvWGn2XvHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN8eZ9xI5xFvzkNtJZPtCpp1QZUbq5VMOywhzIPPxi8=;
 b=CHMyHbEOinGbs4bQ1Oh7bo1wR8t+DFjjFgmEANrRgVU3OYyPwP40/tzpjVEbspKE8cQ81oxFheEqHy1zo09+l9jl5Klbbxq3a/y2wyDyCi/7IjOHM6NLYHsaGjTJ4G4k6JPGpXYJpXEr1TaV1J3UP2Uk9OOITLSGqqTMpnOS/pHhHKnK0/AUZEksK0/rP7ToN2NzJmys4YnsaqJr2HppQrDe3JioSQR/i6azrRXSBqs/i0p/LUZ9e8vKuGOuWwTSRnxZiP/2qE093tN2g1lKDiUUcReM3bkyoQavz/cL2msX+Yg43XnRHD3tXdskb1RbMYnkzVlK79xjEd/a/91yRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN8eZ9xI5xFvzkNtJZPtCpp1QZUbq5VMOywhzIPPxi8=;
 b=fCTDZiyGSJPjcJv3gpKUOKfOogq7/dc2mt5FlmXRJrXCk4DCb7hjC0ZaEac5C0gO48xIX16ejbY7kG2asGRPOhyclA2CN6S94EH8GyRmh6QQ8NsCPwoLisjbHZwBHej/UdndhTqtxz/200FSwS83WA4HcHB5jNROmp+Y8kNdjjA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB8053.namprd04.prod.outlook.com (2603:10b6:8:c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.19; Sun, 18 Sep 2022 12:34:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 12:34:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc_cmds.c: fix warning on uninitialized 'cnt'
Thread-Topic: [PATCH] mmc_cmds.c: fix warning on uninitialized 'cnt'
Thread-Index: AQHYy1irKi3fwcF5lkO3HRr0TTHvSa3lHuCg
Date:   Sun, 18 Sep 2022 12:34:46 +0000
Message-ID: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220918121637.1101135-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20220918121637.1101135-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB8053:EE_
x-ms-office365-filtering-correlation-id: 95f2b6f3-4700-4768-6891-08da99722bd7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyim458N31facXdc1jKNm3Msstj7FYXg+SympT7sgV6lfSNlVijfYvLZvU/sOHYR3YAAxaULqdNrzK+FS9pdGtAu7IMMIkg8lwoaO8H2UPJsmqk7Axk7BiYp3Ldiby8zlBz3mm9kdM4E7rXHWmFfs0vPYXHL+vo7UmGHp3oYaZZg2jK0PfT48oI/QyRa9ZFUliOCER6HfZ8Zrv+PszUjVrxFdzXQvzJF9ryb70p16epUWuqakPi8uYlPxBpwd/sVf3oS08JIQx90JfuY8WtGtTkqocpqlFpzq4IJATYaptTNmbZ99wSdqE/GSrQqH3f1pgFWW8KJi+KUbuelofcF0/RKrhHFJAWC4+k+dPch6uvqp47wu5f9kr5AHNI/Z6ntBPOScNCGpBgMSqWJ6lZMIF/tGnNaPzw96YeihuvKwdbsfvMvfzlLLWdbPjBgSeSkB6JFu7zCaY6imrCnVl4+KmoscnGk/G5pDT03RrWDJUi1ZHIMjC/2ByuHRPcw+RZj4WBhEuKDFmGvLJMTPUlXBZb/lP6kzpZtCff0WfYNjAkaz8bYNAq5tQ8ZQaPZYZAB/s9Jbd6tE4IrgFw7RfJIwNqqvgWOLNu/Hu36Op3IzjfTPcct5fQYKcXSSUUt+TZzZ8zwwNyv79PmEpEdmvO6jNKpqhc/La1u4/qTflNB9B9hRVgi0Ofefc5ZFzTowPAEKo4Sj4KtCHUckOuzkYcR0Y5l26PUHsRgf/MYT6aSQ+KFLaLdONrQKUa8AhlT3X/E4OmqX142qij7OFXdAw3N6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(9686003)(38100700002)(26005)(122000001)(82960400001)(55016003)(6506007)(33656002)(8676002)(76116006)(2906002)(41300700001)(38070700005)(7696005)(86362001)(186003)(71200400001)(5660300002)(8936002)(478600001)(110136005)(316002)(66556008)(66476007)(66946007)(64756008)(66446008)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mh5cbeDhVGpV+ChQ3CeKQvohDock336iIN9h341BrC8ovACD3lfjoxzKQRJv?=
 =?us-ascii?Q?bST/Nwc/VZkw2x4aXwjeHrXIkmWlVlcDFAQMAEX9XLuvXv25x0GtSU1LwDmQ?=
 =?us-ascii?Q?fPzchfJF/6yGw3/oxUJLexMs2dU/yKC6IQoOnE1IhfBUBDNYApGqKgtr/j8A?=
 =?us-ascii?Q?+bSxetzxxm6FpiUTxGN4eOUMP9uEsjPghgN6MhAufm7jSPlkOsqWB9Zq6SHL?=
 =?us-ascii?Q?2tvf/2dL7XDZ9rdd2s6aP7SSQiQ90zVGx5xuV3UoksP5NE8JwqFH5VfyNUpS?=
 =?us-ascii?Q?vY6ed9YB3sbbjCDr4IE1pZuj9XMp3fljhDp0m4HcNej4dJmwFWAhcA9BqHax?=
 =?us-ascii?Q?b9JNkuaCTVBixzbaGaqRNXQSVBl1rLxEFmZnlhcB5DbtdK52J3KtO7v4uXMC?=
 =?us-ascii?Q?ovbuCD1ji+Yh9qaFUpuDN/7gs2GbtFKJhQ7GxYwGYpV9P6786MmWnPubHD7y?=
 =?us-ascii?Q?WkAUX7nTiHLah+0cgohIfF5UAPyjWIn/1XwLePu68JXDvHlWo9I2/RdA8PfI?=
 =?us-ascii?Q?WTBOdcXDo02/b5fhFyRgSwDZaTO4R/5ZY6rfKJ1DpJl3dbClrtlE5mLW66ji?=
 =?us-ascii?Q?elzin2eYtF0jtsMhj0ZgIe36TDMHZ8L0wpFARrCaQaQOG4pkFqbLTzgF6DK3?=
 =?us-ascii?Q?729PLtHoUlFlk8mW1qgp5te0FYjw6N6rh/kUrKVgnzNeP2jE3XyzkNw2J4oH?=
 =?us-ascii?Q?nkcPYKKsXZFngHTVeiHEMS3dLT3Vdppt3dj52roovOtMX8BstelP6yqmXAiI?=
 =?us-ascii?Q?PMPy4Ba3FPXAn2LXIMpqqkryaqzKEwUJ92z8axaQEGmb/X4+RrT31MvAvWVd?=
 =?us-ascii?Q?bVKT9huLL5WwjWHwk6rVkY2HSFdiTL269ciNyKWJrrXE8AY1wXJ1xeCO8e0r?=
 =?us-ascii?Q?matytGK7s846h69w+4llhZBhGMSMIvYJb9AGB18WivwNgSsgw+8fNgpZM/oC?=
 =?us-ascii?Q?X5zdR2wldVQ+v8Zzcjn8YpugIQjAxSs6dgU+El+D0oSj8IPs3TKRmVZ/hNrV?=
 =?us-ascii?Q?JCrgQdaqCHsKP9kJ4IzZLTyygPXdMq5Mu9QoBddye3Q+JqeNZnz85BeBcJnn?=
 =?us-ascii?Q?b5JcbZYbgKOKvWgCenS2GX3KBOm55IKICHH2h/oulGdHowtp4CA4/dXW29nL?=
 =?us-ascii?Q?5ch5SdmXjeH8X4ObvbzQ1+ksu5hLwVdYoelED+6jRGGC0bkE21CF1IH7ADox?=
 =?us-ascii?Q?pHrd7w0hcdrfSPF4mkSJ61ie1KgKpcUoaFVd9SH9Nb6SYTYZJfGVFYbL/0I9?=
 =?us-ascii?Q?cEPn6YrcuVBFv6/4Y4KZjDO+8UlPODHDaPTWkwuzuroKLHP8HETGCZdfOTgn?=
 =?us-ascii?Q?cC4OF47tMrhza5LM7enQCrBsDVeYUVpxJBr1D1XIjmT0409H+JhV0YKpBZZU?=
 =?us-ascii?Q?Qz9eqMs9oU4UevJNW+EgurgAFTEIEeJJ9/1i1c19XrqAyPIMkz/oFuJBwBQz?=
 =?us-ascii?Q?y4/6J/1/N5f//jMAxv4tzoMe9BYzgVrRnC3Lx02+gdQ68GxQ32P/Y0sPj0aK?=
 =?us-ascii?Q?I0XZXcUuLDAnvmRsX+6sesxIK7QAN3PmbteKr+FFb/WV/najrTjUyN3ukCMS?=
 =?us-ascii?Q?ZYq1w6qWbj/49D+0QRBvV56t0EHiAtMUdkyawh/R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f2b6f3-4700-4768-6891-08da99722bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 12:34:46.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnvDRHfCpVrs1TYYDRLGSV4W5N5CSrOPbbtZRK0Yx2kz/aXcXsiJyOsvm6IXQbub4fldRz2621kyY9Zk4CGM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8053
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Since -Werror is enabled by default build fails with:
> ```
> In function '__bswap_32',
>     inlined from 'do_rpmb_write_block' at mmc_cmds.c:2293:27:
> /home/autobuild/autobuild/instance-15/output-1/host/aarch64-buildroot-
> linux-gnu/sysroot/usr/include/bits/byteswap.h:52:10: error: 'cnt' may be
> used uninitialized [-Werror=3Dmaybe-uninitialized]
>    52 |   return __builtin_bswap32 (__bsx);
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> mmc_cmds.c: In function 'do_rpmb_write_block':
> mmc_cmds.c:2270:22: note: 'cnt' was declared here
>  2270 |         unsigned int cnt;
>       |                      ^~~
> cc1: all warnings being treated as errors ``` So let's fix the warning by
> initializing cnt local variable.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Please prefix you subject with "mmc-utils:"

Thanks,
Avri

> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..777d649 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>         int ret, dev_fd, key_fd, data_fd;
>         unsigned char key[32];
>         uint16_t addr;
> -       unsigned int cnt;
> +       unsigned int cnt =3D 0;
>         struct rpmb_frame frame_in =3D {
>                 .req_resp    =3D htobe16(MMC_RPMB_WRITE),
>                 .block_count =3D htobe16(1)
> --
> 2.34.1

