Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA1C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 06:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288A3611AC
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 06:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhEFGpJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 02:45:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6016 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhEFGpI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 02:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620283449; x=1651819449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pLN+n2iOgrGYNudBByWBQ+s+oYBJqJJ2gopoGVm0j6E=;
  b=G/3d1Vu4NFfqxc/3FhtWuB0MusaCx0VAUhNW9LjQkTYcaknXpaABtEFA
   5ZrsDQ0XYWdaJagzw8QFn3CiQPrXuaFLwqrsLJxTFgRUU/S0QPHcTtzY4
   Txv6Iock/lSEsKnwNituwkrqCXj4gFJJ9X3UMpEbmoYAuBDRUyqs92505
   CQSYy0XYLCHiIST1n3SX+EIoM7MU03Dff29oeMHn5twakmUZ/akHageAF
   RaZCgz8z/C48xNBlxNyi6pcmKmQ6iNvWd1fuch0HhZLnwnVoM8L03cxXa
   tw1b3Tw8ykThPrm/Ulzj0g3x9ATBoODrc+FqqrEV/L+oIKjF2RyPzkqYO
   A==;
IronPort-SDR: 7WnbDC4CB1Ht/O+ejlXjjshyau8DxEBCTntnI2S7h30aatPiXh6LooW8LQ4w8XzJcBUXCDypek
 73EBBIL9KAGMFT+/bYn+q9COTYnULmeGFTnRSp5IeIW8LXwylYmMp782f2eyt536L84GRBV/eT
 GT/HKgrGnsXoemoWzTkU4VxhyI/dauNJeSi/iMa8I+yF1MZZicguCA+Wd735c2edFDrtzjvQwU
 j2Q4XY6OrCYsvUMf0rsRfWKBQCsW2mC6ev7ER5Vjoav0rZwKsLcDHkjEPlFeji0+Qo+Wj6wlOx
 gdY=
X-IronPort-AV: E=Sophos;i="5.82,276,1613404800"; 
   d="scan'208";a="171844633"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2021 14:44:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPrE235HcAgs1I6K8tA2N6pi060sYF4G1u4HEwpzUwN98NV51KWFyXAoqf5OSZnSAIQXq00wvobx/a6Abp2SQmputH4MfBVq1eVF7wiMzunOH3NlckE4xIAsUkcPF9yOdlhcgz3j2eDU9zm78mgnE+XPvFrdM6tMBVKSN8McuyNbBkJuj7xj8hCqS3B07cM8ZMRaVem3dgBvW7PwXg5WG8qbhrZcPlcKSmN7/kw8WGdtcNtVJnpJum2XdffyC42wnc4WQa2GvD6bOxhuKdUCyQ6iJG8yr2OlUbAy4bnHptg6wlztr02zJ8GcGTZK2sJJ3eestompfLQM6rzI13ZgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlwsVj/rAhphyNCVdayjE6oHTVIR85dch6gMzT85HZQ=;
 b=a2ON4VL44BkWILVsnYjRzsH6oRauco26lANLimrnbsYDwkWphNWKF48o/3VSHw8QNo2qkRiIK2R5jWxTNm1ICeHYR0VO/j4DGi2EzrO5lpY8v3EhxJN/QnKF8fG1qfOCCdYdDnNR++VuE/VwgJHCrGhMC4zntiH1vAwxi7WU9c9uAwefPX0p6jdOeYbbFXt7r91GuE9uZ6aJGhIAn3oqCN3bdXCQPKOsz88/x5o28pgTvBD3+7ZSjtCgOHGydOUG7Rlr45Hdpx8+nnjG3IuHHifUkQ3p+CRyC3HsAZeYlLZoo1h5rXXUCzVUHilIofdnXrCKJLvojwGG18WTCqc3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlwsVj/rAhphyNCVdayjE6oHTVIR85dch6gMzT85HZQ=;
 b=ZPkogF5lqCLpsZc4n5fJ8QsLMiJJ/1mh5FM9/Uu94TcsX5Q0ggY0zEkypRMxco3+Eiq9zyfSQbfL5JrZW5gu4aQ5BhzCC9H5ykpr8T5keG41VMHB+KSeBo21tdK9dqGkucKsi5Bb+gOPzL1CVo2D7aQ2d0aKWsd3fiExmVPowt0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6509.namprd04.prod.outlook.com (2603:10b6:5:1bb::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Thu, 6 May 2021 06:44:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:44:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "oracleks043021@gmail.com" <oracleks043021@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v4] Clean up and show effect of ERASE_GROUP_DEF
Thread-Topic: [PATCH RESEND v4] Clean up and show effect of ERASE_GROUP_DEF
Thread-Index: AQHXQigUvNZJ98bPLkavQe25bgO60arV/IoA
Date:   Thu, 6 May 2021 06:44:06 +0000
Message-ID: <DM6PR04MB6575DB4933121EBE949FB297FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506032945.939-1-oracleks043021@gmail.com>
In-Reply-To: <20210506032945.939-1-oracleks043021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28eeb000-1a54-4545-2cf8-08d9105a584b
x-ms-traffictypediagnostic: DM6PR04MB6509:
x-microsoft-antispam-prvs: <DM6PR04MB650943943CF2A23515A1D659FC589@DM6PR04MB6509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIMiX7lHTwwulDDXEzvIArbDjniqR/WxQCrjUl4osy380wBaWv+0yu+LCMeo9cnxbNtjuKisvOM031329KwS7vbISXvuT4mRja7UYgtBJs/Sj7OEzrpnhGOyWutcMTOTBujJtH9P0p10rKLSRJcBGsz5Xbx0r04196FZkDvMmaIzcZasSSnekdI47M6izh84+6vk2ux3e0DYcHlq/TcB0FnAS1PeQ5bXkgwpwyf5Q2uU7ee/iKlpYxrUKh5+y3tYNlRGQd1oxTU9Lqi+YVlyq4KKovTi68Mn0i6SZgkZ5oxmvfDnRfq+XdHODfOe11ylHRFaydQmoaWq/fPJCyx/ROpTgs7XGC2TrMS8FZNvLBzhNqfDpyjynYyXHEiub8cJ2BKRKt756I8z1S8zWZug8KtAgEUlOZoTmicHROb0ogsuNP+lqmtkQ4T/n7Miulqs4CP9jXGlw0drxABXheZff6gXBhnFMxDnVt8OiZVT3ExC3GJdBkhYQZeI5/OqR2HFbrAYsiic6qf7lG1rY9d6I3gI6RMzag1vjl/oeDmhWDNBNuYkFnEI0uJBxr+RkDt30lZn9rK8VAbyhOfFtU43PUyUaoKRE6c58og09CAphNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(366004)(71200400001)(478600001)(66476007)(110136005)(7696005)(66446008)(52536014)(9686003)(2906002)(33656002)(86362001)(4326008)(54906003)(66946007)(26005)(64756008)(186003)(55016002)(76116006)(83380400001)(8676002)(38100700002)(316002)(122000001)(8936002)(45080400002)(5660300002)(66556008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WSyGa75PaE5YJ+DfJtJqQ8RQKJlw+ivsXmd2SWQZX8OhY52CnKyIp/b4qq+6?=
 =?us-ascii?Q?OAeq/doi+Ef/7nhRHQ13bGckGNHvLKBl/JVoLAVG0YhfQ2wjuSZMVuxAD5/R?=
 =?us-ascii?Q?hdauPCnAvIq0fSkSnFpjr5QZgSqODCVDbbgNZG6n1YRleV/YCUZniU8olgDq?=
 =?us-ascii?Q?YgULyjJuqIPW2Pikl/TRd3t+eGIjFNKzAvvbowgwVC1NOf9DTE0FqWKqlDx2?=
 =?us-ascii?Q?TyrR5IKvLL/fFWOpZlK6oPlb2imlPe6JlPKyf4SqCjoAd2wOn+ozAokm+NLh?=
 =?us-ascii?Q?RafM3Cd0+HPmpQ20XyDhLgiwWjMEBnghsFCHWAgPCmV9Xz6JBNfcjza9djoo?=
 =?us-ascii?Q?8MOYyg0Er6BmixA00U0iEfpiKSPoRvYIKvvVQs2FeuU3XlNfGTqSRDaE5hZt?=
 =?us-ascii?Q?/HvKdijLaDYNmSbucey2f2lJbvx2XZoPhOHy08xq5ggT9UPPGqrkMnpN/Sjk?=
 =?us-ascii?Q?zLjcvMqHv6DkYfpDUVBEHtSbO3B2XecxnFFWWGGD34gzZgMeVJylwfBSwmN+?=
 =?us-ascii?Q?7GootODBt39lwMD0lG03mtuH6srqXDrIs2grDpHzjziN/S+/fg1mCarxh7me?=
 =?us-ascii?Q?MEvT09gDLzs45jAGO1V9nmvnlXf/KHKC5jDUInTeBDCIoExF8q9eT7kKm9Kp?=
 =?us-ascii?Q?lc4vBPjIJuBZb3pZMVxQlzSr95UUJKyjo8WB9wTJgOh7y6sQu2fBPLXLgAZ4?=
 =?us-ascii?Q?jtaE2T4DCgIIXS37ZArb+Y9FHvpVB/ncW4V0SeslNxT6Zw/T6gITVbSwwXhi?=
 =?us-ascii?Q?lOHnpEDHGHYGF0ObcUVh1TGwFFp8gMSk4xoHH1ieoJ9fSH9Ukocvrg1u+nZa?=
 =?us-ascii?Q?/jtTkxpuyc6P7YteJpvrS42ZFv93daGu9+UefJ24HsIz8U6OsvjtT2xbBcx+?=
 =?us-ascii?Q?T0/V1WrM/q7w5x6oCiuCQx0x4vmJs5vVo8V3joc0eabo8Asw3GMwrFDGI2L5?=
 =?us-ascii?Q?kpHRV+A0764KWQaBQUJBtOT8DvOj2Tj9JFf95lH092I+nNqD6ZKsqxpY860I?=
 =?us-ascii?Q?uGiJ5MCHarPHGZzzBZg7t7krpVw8npX4YQbDhpvyB2kaKqTQL0gR/3f5DTUb?=
 =?us-ascii?Q?8R22X88GHFx5ra58k/GQtCAAj7Z1DZTXncNtMG5XddgykHkqQ5+xliw4JaxP?=
 =?us-ascii?Q?PFrY9bv1FLfgT3abQkniqP5muOaBBCfNpE3RitILEmy5zVl/Q4C76jTz090W?=
 =?us-ascii?Q?yjk4YAlBFcvXleHO4szJoZT0uwRcnTA+kV0tcNHlER5GPlEjqaXYVWDYi5D/?=
 =?us-ascii?Q?A6170I0bCwNd+A2JLyVmU8JhYFT5mx+HrgRikNbvCAQQR4hF4eY1rl4BhRRT?=
 =?us-ascii?Q?dtQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eeb000-1a54-4545-2cf8-08d9105a584b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 06:44:06.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXr4EUdAT+8cDUnudUrmquVtiDKhi4Hbf1cs0wvQw9l7eNQ/Q9ssqxzoZnjo0TLy/9XCA7EEsegw6IMN1JVULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6509
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is only the incremental change from your last version.
I guess you forgot to amend your changes.

To merge your changes after you tested them, you can use:
#git status
It will show you which file you changed
#git add <the file you changed>
#git commit --amend
Will open your default editor with the commit message.
Update your commit history, with the appropriate v3 -> v4 changes.

Also add my reviewed-by tag, below Kenneth Gibbons:
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Save the patch to some directory:
#git format-patch -1 -v4 -o <some path>

Now send the patch.  Use git send email:
#cd <the directory that contains the patch>
#git send-email <patch file name> --to 'Ulf Hansson <ulf.hansson@linaro.org=
>' --to linux-mmc@vger.kernel.org --cc linux-kernel@vger.kernel.org

It should have the same subject as before, be v4, without the RESEND label.
So before sending you should see the subject:
[PATCH v4] mmc-utils: Add eMMC erase command support

git send-email will automatically cc me, Bean, and  Kenneth.

Thanks,
Avri

P.S.
If by accident you saved those changes as a separate commit, instead of ame=
nding them,
Just squash them into the previous one.
Ping me privately  if you need help with that.

>=20
> From: Kimito Sakata <kimito.sakata@oracle.com>
>=20
> Replaced unused pointer with NULL on calls to strtol().
> Added logic to print High Capacity mode parameters of Erase unit size,
> Erase Timeout, Write protect Group Size if the EXT_CSD_ERASE_GrOUP_DEF
> bit 0 is enabled.
>=20
> Tested on X86 but the changes should work on all platforms.
>=20
> Co-developed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
>=20
> Changelog:
> V3--V4:
>     1. Replace unused pointer var with NULL.
>     2. Added msg if ERASE_GROUP_DEF enabled for HC.
> v2--v3:
>     1. Remove redundant ifndef
>=20
> V1--V2:
>     1. refactor Kimito's original patch
>     2. change to use MMC_IOC_MULTI_CMD
>     3. add checkup if eMMC devie supports secure erase/trim
>=20
>=20
> ---
>  mmc_cmds.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3e36ff2..afa85b7 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2518,6 +2518,22 @@ static int erase(int dev_fd, __u32 argin, __u32
> start, __u32 end)
>  {
>         int ret =3D 0;
>         struct mmc_ioc_multi_cmd *multi_cmd;
> +       __u8 ext_csd[512];
> +
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD\n");
> +               exit(1);
> +       }
> +       if (ext_csd[EXT_CSD_ERASE_GROUP_DEF] & 0x01) {
> +         fprintf(stderr, "High Capacity Erase Unit Size=3D%d bytes\n" \
> +                          "High Capacity Erase Timeout=3D%d ms\n" \
> +                          "High Capacity Write Protect Group Size=3D%d b=
ytes\n",
> +                          ext_csd[224]*0x80000,
> +                          ext_csd[223]*300,
> +                           ext_csd[221]*ext_csd[224]*0x80000);
> +       }
>=20
>         multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
>                            3 * sizeof(struct mmc_ioc_cmd));
> @@ -2559,7 +2575,6 @@ int do_erase(int nargs, char **argv)
>  {
>         int dev_fd, ret;
>         char *print_str;
> -       char **eptr =3D NULL;
>         __u8 ext_csd[512], checkup_mask =3D 0;
>         __u32 arg, start, end;
>=20
> @@ -2569,14 +2584,14 @@ int do_erase(int nargs, char **argv)
>         }
>=20
>         if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
> -               start =3D strtol(argv[2], eptr, 16);
> +               start =3D strtol(argv[2], NULL, 16);
>         else
> -               start =3D strtol(argv[2], eptr, 10);
> +               start =3D strtol(argv[2], NULL, 10);
>=20
>         if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> -               end =3D strtol(argv[3], eptr, 16);
> +               end =3D strtol(argv[3], NULL, 16);
>         else
> -               end =3D strtol(argv[3], eptr, 10);
> +               end =3D strtol(argv[3], NULL, 10);
>=20
>         if (end < start) {
>                 fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x=
]\n",
> --
> 2.31.1

