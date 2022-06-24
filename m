Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE8C43334
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jun 2022 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiFXNxS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXNxP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2022 09:53:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC973EF38
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jun 2022 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656078793; x=1687614793;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=EtcgARB+uUU4ZXDz/Zzdi7e1eO0JI0VmxsEG3yzae9g=;
  b=eTG+fHLKdrJ+jfwDNeil+LDPCo02JHWoQTZTYeJ6Vx6hJdUNk/QgZvKV
   jeV/5jg2sWY4Rwj7t7nbuGyjqDQk9mkedGghaGIN3bnbdGauM5BkBb/JU
   R3XmyptWhQ8yX9ae38n1L6l3CSH3RdJSz80+ccKjlRcJeWHJizs4PlD7G
   MgkGA4f3jjLjVOiuY6aFGIbmyzZ8rNohwRNi6Fyim93bPEa/yaT6mFeCE
   rxGeEpk+l2O8hsy7yXaLPSb8SbGNUeIgd3/zlB8YgMQcTaCB/CIjCcBqF
   FN3vFxnXOTEBtlFYknksZmimwrxoo+ReAGeaD0PaPvRDI+PU6TmG8Q4uj
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,218,1650902400"; 
   d="scan'208";a="316122823"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 21:53:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN69e2DeiLpRHivtQ9InTc+6UymdYeoA9JOkZcdrlqHEOmti9SGC9384SFGn45ZZKhUKehJjq9dybG7SN7/IOSAh1UHrmnTWrwnpagu6bj2fKhjaU032wzDsZL6lQu+zmO/ycpxlabyupiHQeLtWOP26q+9iO8pXq063Epph3vg4eviycdhigBIgF79p8CP+bjje0ZwWIobXwcccyieWum16YdqpoxNpmrITAvpHECczQH8RUFPQnFDDeUXTHk1/a3nqPiM+ze64IaXdIz4whnakfVyQtbmddmRfWI3nYEIYMO214zfBn/gyj9FuLO4SlAJJ0+cAhjcyADvfEUCVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlDqsds6++Em2UYNZiGyXbCBU5AsI6lAsT5izpjnMUU=;
 b=PyPqdNLBlPYra+sKPodzbLnuQrA4AHjkutBCVCr6qQ+datmYzFQstImaP/zx8S9KOZh2Cfpw59ahdCzMD5txeIqjwSpKhZMMWOHgFVFj08Ww16pCCWFKDtJ583I+zciOQ3hXW7cQ/vK+8HbR0HP+tgYPIFeA8+urK4iSUtEdoZGCWqHGJEJqqlufgk41b7MPmXfjy7OTwyVvhBprSZk/OmzRvII93WPWGpeHyWMOCBDennec74CnURJYngCJkCqYHLVmmqLEWWxKIZ4GrwFKvSf5aq/8SrsIS2KGieRG3CEuXj0nqYSeFVOLD4W6G9egVZ3br61BpgCrO+FO9M2LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlDqsds6++Em2UYNZiGyXbCBU5AsI6lAsT5izpjnMUU=;
 b=J1XaEYeghGXEfP+/vrA+TaaEg78VRdxR6KrN0aCO+XJ8ScOZwsS/zZ/R9U2YyOgcSHuz7wSS6QITArpEgVNUa6GsUfQZVtTEtdJmJzzsolguD0STD2RJuxIIX1Wgsv+INVKmfUvBhjsx1gump3nDqng7cJk3ZXOafFNxnM+/aMw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7710.namprd04.prod.outlook.com (2603:10b6:a03:31a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 13:53:09 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 13:53:09 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCHv2] mmc-utils: Fix 4k sector size block count in FFU
Thread-Topic: [PATCHv2] mmc-utils: Fix 4k sector size block count in FFU
Thread-Index: AdiHzKkF75C3NmKTTRSsXIOfFip8FAABMYtQ
Date:   Fri, 24 Jun 2022 13:53:09 +0000
Message-ID: <DM6PR04MB6575DE769DA8225F91F31955FCB49@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <54477cf05b9148109996dd85c9afc30f@hyperstone.com>
In-Reply-To: <54477cf05b9148109996dd85c9afc30f@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47528193-57e2-4286-0996-08da55e8df93
x-ms-traffictypediagnostic: SJ0PR04MB7710:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kte7MOoV/z9GvNBFF7a6y1+z9EyRpIP++/15qrVvJf0uRVyt7ztBr51h1DPbI7B1X+pi3RZwGqqHqUXvgwfVBvJ/XxGkn1vBp4PT+MsYvSrVNTkOd9AHL/hbByriUDsdLWh1oftJdjZA86XXPz4S/UqDwbWdvCH5I4tm+JSmylvaEJK0REHrR13dnaqbRkh+Ent/DTwZ4gnl5qI8YOXKDqa0fwY/o9/rlYAmMeFnzpYiMZcl1XjpbZivyQMOATGuvmZtCxTElsmpJLINqg4QPFFukoRRMwxwRKMfNQjzOH5V6g4ihJ1+8BGEf8EY5yGo5thvt6+VkbJdX5YcKxRXdxqS6ufu9278PhmgocawKu6wsjn7OA/dgVz1YU39dWpAQUH5b08FZ2W44LkNtWcIaHRul+GFjIRsMnZge+hIBkKST0DExYaiD2P0wNmT71wAt6LKCW2yNCs9EGMqnfTJIAUOwneo0HPMiSlCxKk7sK0LsYsLmv91yQjt1NsQ8nDxPS4sLNfmVkMBRweaPRrMaCwFrP5QCUVc5WgqAkq23nXa0FLWS0jJM746GVF0w3lNAG/no5LXQqePzMlCuxclA67BJja0owjlJBo8T6/z5UYa0SPKgg4WLmNhPItGXX391slW4ZJpWTGlsEI8E6r2EUWVSswlqyyA32v2XaVXfrvI7wP4T/aEixzBsRWQxuMoBCc5Kkv6FzDU4QlzfntVtFw4NGEbARJUHspOAFw7na56Yg/g1syEwk6/PbjpdhcgDMBGqlhCzslKknI9O2ftwcSNdhn4LVm8WCLyy6sj/N0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(5660300002)(52536014)(2906002)(76116006)(478600001)(8936002)(64756008)(38070700005)(86362001)(82960400001)(33656002)(110136005)(71200400001)(66556008)(66476007)(8676002)(66946007)(122000001)(66446008)(316002)(83380400001)(186003)(9686003)(26005)(41300700001)(6506007)(55016003)(7696005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NA2rixYcT+r2/ZvNj2qXWmrsz7/D9enbuqbuQxTpm03bhnIgZ9ZJABxZQa?=
 =?iso-8859-1?Q?Qok9RpU1v3tLyV1mER07mxSrmDz2xU/XAIN32yETDyyndx2qN8HyKLsR2D?=
 =?iso-8859-1?Q?6JZJHwXqWmldRUDS8Lr3PS/zFRWuxLaP4/XW3E66qBorVzKT3pvVIj6ICt?=
 =?iso-8859-1?Q?5NBOiMNKRtOF/Mh2N4z5MCIZIuGbXecM24uFxwqJ4QB37wo24uOJAXJbG9?=
 =?iso-8859-1?Q?yVcMl7V07uwu7Eudc8vDLfO+ckSmsthPc3NN+Ho0GutfJnnLPHPpzXJ41F?=
 =?iso-8859-1?Q?zxjRRV7/ESGsMHjPRthTxQ0zehhLumxPfByzZxr78olNdfiUAT/xUAOILo?=
 =?iso-8859-1?Q?yALL3ZWur4rccQ6TO75vRtkgv2kFGIQ+Y4C9Hm2gq3uZMYsNz7ny9+1eiS?=
 =?iso-8859-1?Q?pV1hC4pbIRYf9E4/CL24b54N9iHqQrKMTKBZA7XpGkkMjcS0QQfNzEl92h?=
 =?iso-8859-1?Q?ulhnXGY+/aaKS7xgwLuEfDmbYNQfgo24jg4lKe8Z8r3/j4IFtVc59D64hB?=
 =?iso-8859-1?Q?ZYqHYWHoesiL8hUdhQ5znMcO0BmH+uxL7LXDQiqvmEeYYX13oTlA4crXvu?=
 =?iso-8859-1?Q?QENMUIBCI4A24Cke3JLSY/5EAhb12hFzq4k+/4b7vGWo88MmNGjHkySRAD?=
 =?iso-8859-1?Q?nZDPsGpYUWK7lj1Au+tTUXXaiOrQfWAINhrzZSOf5M1zOZUaiRVMCqvoHN?=
 =?iso-8859-1?Q?7/cBE9BIjoquTVPz6DEtaFlufSUzCfEckneLl8U+xcw5unaZjriGA0e7k3?=
 =?iso-8859-1?Q?N+BnsVX+2OZkEgssfSd2NFOialptf8v2kkjs0311D3Ch1dLP/DcjOoL4I4?=
 =?iso-8859-1?Q?ix29dSunOlf4JTOdoffOZulX8x+QNw1QqVSxZeG5CflRLi2Ho3RGKnz28H?=
 =?iso-8859-1?Q?CjvEv393SCXM1v3v9+aIio6cMZj3fj7xJ+ypDljiSWwMqChBuuxDn6Rcbu?=
 =?iso-8859-1?Q?URcaTP3LqDQs1lQhZdT9Cb4BdYFqszFHsJlglOT44Jj3AH5ulYTU3I73FS?=
 =?iso-8859-1?Q?nZZezRqOtQbf15v5+nz0a+BTpnMEHXPS3F2++zaYSsNpIdyybJV+LVkPXj?=
 =?iso-8859-1?Q?jyp3/Jq3l1S6NRgPh/mLKkiZ0Q6NVYTqMa+eCiSWb3gS/R8K+hpb1JYib6?=
 =?iso-8859-1?Q?pk6FYcGsRxJodlapW+MnI6UGDaSzPctM22+U1mUe6zBE3Ta0aBe1pTy2kL?=
 =?iso-8859-1?Q?gUJNNQ6xR2DUNPTz9oShzwgGiwsAcSRYm4b5MFEAXAU32uZ/EmDtV+J0j7?=
 =?iso-8859-1?Q?TkwLG1rzROa3iizzfZIDFLNQ0bD4AMeRgRIXpOC30uQ1ihyeUOMuOHtTqc?=
 =?iso-8859-1?Q?uXhWdHdWDP5krkeG5RJBta3GrDjGe/kNGT/jaw9QUBb9S8M5AViFMf2fNz?=
 =?iso-8859-1?Q?jNjixEHRKv0vrQPUkomKiLB6zrgTxOod6BdVPK6fLfvcUlEybAbX6YHA/v?=
 =?iso-8859-1?Q?XVWxGNbX7miK43kCxKxdUwO9wmqOwLdO+0QGo305dkppJQ42AhNiU84XzN?=
 =?iso-8859-1?Q?4KvuI75vd9t0ZJy+jgjZrruCZQ1S+OqdBuf13cj8+exHF7Hzc4yNBs9K3Z?=
 =?iso-8859-1?Q?czik16BJx9vG25G9PeW3E3Gs8rv72hqsWfdGPVrxZYb6lk+GaVihO6GC+0?=
 =?iso-8859-1?Q?PB+B1GlyYywzcb+423w3hIIqdLsZKwsUCg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47528193-57e2-4286-0996-08da55e8df93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 13:53:09.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1irf+I6PTzPhXRhIVlEDPSWepSsFIL7TvUaauNOjtRuItUOsfzycXO9sxVL2WOaE+LFoyM29+F760B/TuuAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7710
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> FFU used the wrong assumption, that CMD23 work in
> 4k sector chunks when setting the block count.
> Instead the CMD23 block count argument just needs
> to be a multiple of 8, which the fw_size is anyway.
>=20
> Fixes: 89cd01ed865a (mmc_utils: add ffu support)
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks,
Avri
> ---
>  mmc_cmds.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index bb0f022..12b7802 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2768,7 +2768,6 @@ int do_ffu(int nargs, char **argv)
>         ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> -       __u32 blocks =3D 1;
>=20
>         if (nargs !=3D 3) {
>                 fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblk=
X> \n");
> @@ -2826,15 +2825,13 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>=20
> +       /* ensure fw is multiple of native sector size */
>         sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
>         if (fw_size % sect_size) {
>                 fprintf(stderr, "Firmware data size (%jd) is not aligned!=
\n",
> (intmax_t)fw_size);
>                 goto out;
>         }
>=20
> -       /* calculate required fw blocks for CMD25 */
> -       blocks =3D fw_size / sect_size;
> -
>         /* set CMD ARG */
>         arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
>                 ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
> @@ -2857,13 +2854,17 @@ int do_ffu(int nargs, char **argv)
>=20
>         /* send block count */
>         multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
> -       multi_cmd->cmds[1].arg =3D blocks;
> +       multi_cmd->cmds[1].arg =3D fw_size / 512;
>         multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
>=20
>         /* send image chunk */
>         multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> -       multi_cmd->cmds[2].blksz =3D sect_size;
> -       multi_cmd->cmds[2].blocks =3D blocks;
> +       /*
> +        * blksz and blocks essentially do not matter, as long as the pro=
duct
> +        * is fw_size, but some hosts don't handle larger blksz well.
> +        */
> +       multi_cmd->cmds[2].blksz =3D 512;
> +       multi_cmd->cmds[2].blocks =3D fw_size / 512;
>         multi_cmd->cmds[2].arg =3D arg;
>         multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
>         multi_cmd->cmds[2].write_flag =3D 1;
> --
> 2.36.1
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

