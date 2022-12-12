Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C747C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Dec 2022 13:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLLNqH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiLLNpi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2022 08:45:38 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10272BE4
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2022 05:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670852701; x=1702388701;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1e3lybZ5TdCLwWMCCcnh/DrS7YaWAAH9rEY5rAkQVbI=;
  b=W0wL1pLneIHm1jEOw0As4YtN/pulU0YYuYsoh6tkSsHggtd2TKXqw9I1
   wewJEBkSwqBPzBdj7uiYc9yJjtSR1DIsdr9wBClu7iZ1ILBdtLT/Bsjia
   8nSSdqpzQCbhjS3RHOf0zajwSxR3Oi+eFmcUVI6AW7JxwDkYPQjxF/6P6
   b4KwFmeeQYeLQUZQERM3SZoNvfzS1fX0hUb+emU8nbvvQ7kYm2yW0bSUm
   VzpdgfKPY7nwm17bgNYSbO+idynKA15iuSuQqNL4RNKBhhXATubnSPQYc
   R0PwtI+pDsGt3iFM8lz5SrBors38Mm49uzKekvNbljgPuyC/tcwk/vIA0
   g==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665417600"; 
   d="scan'208";a="223599514"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 21:44:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWv/AfIVEvhNlgn5TRUwUWtxkZENgO7bgcrUGZUq4ImJVf9hZaJIHGXXlixsIP9174T1ikJdMM00TF+6NC0LjP8tOkdhCx5FdzoAutzjsmsarCid/NDUVyjOs1E7C6CKaIA0Ieg0+RkWHsulvuZADcrAXtFGOWyV4nVJrMkHlrdfIeBSHYPG4pvw+eCYjWT4+COGLdsEjDnuBvNNa3xYbAnSDoQwAnMX3YwMVoAlFSzF07lVX3L6WzYaM415XVRDaIRANuOMVwHjpgQvDQcRdqxumQA/nXWQ/nWSE+EWRgOkO0Vasz8Q0JEKF5QYR8L2m9wzf81pLtzmkCUASIG+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agLC/9kZ1SMza6YSgDluQEhQiQxhAWJisf///NhVOok=;
 b=WrejUOY/XEQEyQGgNu4XA2Iclxc7cTpi4wnzEeXF7qsDcH4KLY+4j+KRRh0Le3EQtKiTL206D73FKSgr8o/d50/eLWpJadU2SkK+Lh7eVQdehAyio8xkHxgJXLoUoCxFExhpbmVnrTgMx7JwHVWfUHYBp6u3A9Qk/gJnGQ9DUm4kxPU5D7JT3/WEbKZt2YE0MN3E2jaytA8Yjsd/diqZ2PW1aLlr0wnYiNMWaFmKzhHHcyXuY7CCpI19qvk/Qo6Ug5atGQiVAIK1cqAxOTpOyVaifkFS2+9cC65hneywEk4gdYpeYsUU54t2ApOlgImckJxpZ1TudP9vacQ2XYeHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agLC/9kZ1SMza6YSgDluQEhQiQxhAWJisf///NhVOok=;
 b=s+eHrk3ZlVMTn6g0bAazPyirPkP035U7QkyDsMC1QWeIL08hVQbnayFHvGGbw9husNSQsh571QE7atbY1hruvPNX+4V6LUZeXVpW4eaNbX/gbvpJxrLpYT+99TBLZ01pAeCGv/5XpXiW2jcPQUYxzOMeyvkjLGU518oY38G4KJg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5291.namprd04.prod.outlook.com (2603:10b6:5:105::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 13:44:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:44:57 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclA
Date:   Mon, 12 Dec 2022 13:44:57 +0000
Message-ID: <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
In-Reply-To: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB5291:EE_
x-ms-office365-filtering-correlation-id: 66961332-aaae-4877-65a5-08dadc470ec7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BxEOc9aE1honR3oViWSet3ct1xX9AorHFqlNqfug52SPPncER1ICsInOZvw4RoNBJejuRKFXelSY9N+44aOkglMPn1JciSjb24qzinya7qMtcOVAxr/Sfo2hEjM379Mfih5x1MtBdTkVnxRmJY3flpiPdwMpvHHxnabman2ryXxVBUMI84ufoBShnzE89/f/gCm7k8RuiSVdjdEjw1oXQ6dPrNBVCFYSPItn1JxF98xoI/GUxSqeDYwNL7wlKdRs5duVrXem68mmJ+kv/lsahAxGt+47pX/UfzMU4Q04sABsx4glVzh1vg3BclRIwmK6/eg/sFIpmjQPJk2keOMSzKvMgd0pW2JlD/3V00Fpcmb+dajuq4LmrVayPF0JhbWM7h4/prnIiLq8901cnVI4WEhIUEYIYNjpScNt1bd7mC1fsLd4i3f+4ngimnJJm92kJ+0uem8kHR5XzMYJd5JFh/TGPldbH386w3VRQucmCnjT2rHsst/eHDiEElekyxi+zcx62Kae1ILj9wv6eEfyeZVb38tC/s9HzgJ47GSQBmkZs1ySTFRefw5n1VwfkKjadjb8JEIsNtXhXzQtZVQnzTdlUt9cQ2bWZwclg3KDgGqroQUE9dx9WfwWaBgLOpVeVXxEC231TlfDbFhmS1qyk9Y02C3p4IJE6oWHoVqvlyGJSOWyTLhw/ap7BNg0ALzNKT+zs2vV/il4ZoNkeLzJwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(38070700005)(5660300002)(86362001)(52536014)(8936002)(55016003)(41300700001)(186003)(38100700002)(122000001)(2906002)(82960400001)(26005)(9686003)(478600001)(6506007)(7696005)(71200400001)(33656002)(66946007)(66556008)(66446008)(66476007)(76116006)(8676002)(110136005)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EPIHS2U/37PSlzkw2t5/pKNAa/yEG7cXPw5oL8cjfHMfAVrpnZwjcoESf2?=
 =?iso-8859-1?Q?KB1RgCOSyeizYf1y70vMDleIyoia/zNay+r+HYa1uJn4nwPWcbV2g3WiVv?=
 =?iso-8859-1?Q?7k87c10LSJe6SoDCO5iVDF2lwTrF1cmYSBYBki6u/rR81i53EQYWCFBQtH?=
 =?iso-8859-1?Q?H7jP0zHb4uBVYRYsHSLDpOZerZLq3g0EzfnrHgOucFUv7MEUkVSeW7BAjm?=
 =?iso-8859-1?Q?ISG75gRgPQ1zawde3d3pgNs/8prEn7ysH/HoeFsKSELCr6JIqOU20+lD0f?=
 =?iso-8859-1?Q?p9jWiMYzWFln8YxsQQGsIDEjBevbd0QR8PCyHFblxDJxg4a40vuAChJNnG?=
 =?iso-8859-1?Q?pn57wgzdtbdoNaTvpMkgPnOHgfiR0l+MD15uyfFNHxm4Ai0SlwCQQYqd8G?=
 =?iso-8859-1?Q?LKhrbIx2KFWztbyhIPunIRcA9fV9IijLAUu6P4XIMRLJI1ziNDq2Gu4W8w?=
 =?iso-8859-1?Q?v0Bf5h8VDs/Oci7OuYDey7R8Jev+c1QCnONKY+BE0vvuIsSkRE81pP1ZPl?=
 =?iso-8859-1?Q?ZxFF5NS0DmsLAx2uMk/QOl3URUeqplejqd52NJb+kYYbTxE0OBjfp7DNNs?=
 =?iso-8859-1?Q?xQr0XNBu9mgftSGnfha4lJJLNqMC2YEsbvqnKaa/adpUw1LHUPPrqSOaaw?=
 =?iso-8859-1?Q?h1iMhkLgdLuZ7mB3cbwIXLvd1BgKOHL6JzQOmtkzxGEZTUj5w46D82amz8?=
 =?iso-8859-1?Q?se6y8hK12/es1wFvJagxiAIyEae1xBsjoIMuVqqtSXCMcr/w79m1tc5ss/?=
 =?iso-8859-1?Q?Zkvg5IBq4fhzWGACjC7U9kEoMWB221C3j/coGtrJE19OoqRudes/PTGflB?=
 =?iso-8859-1?Q?xS9N7/8io+rlBUO7F9sk+J7ZxG334DYrBHwCM19PtLdHfAQ61M3Mr0W+HD?=
 =?iso-8859-1?Q?8k/v2eJ1u2ELI1CmscZeY+dCKHU3xxAMtmuIau1PrX7MgTq64XbWmsCDlf?=
 =?iso-8859-1?Q?2OomMSupM53p/4sFpcKYBierwMQq4BwQiAHokMrJlazklX3JgiyfFpOksx?=
 =?iso-8859-1?Q?TQWLc0EQCBwqi4kgrUg/9qCIydfjH7uD1eDYgFIeDxBooEogYo+sf9Bme5?=
 =?iso-8859-1?Q?/AUthh+9VOA0FeOF2mc+kaPCsFcEkNTKRDe2doq4T6UQNxTdUeQv6w+zrb?=
 =?iso-8859-1?Q?ywuS7aBlwFdCWRWBrVZFuo/AKggNPlZHXg+/iXefhytJwBmqzkkhvopMCf?=
 =?iso-8859-1?Q?eyz08NRx/MPBJPMKHPkitwxYNbEhkcxRWWapQLda/Xy5P32S0vnGJ79E+q?=
 =?iso-8859-1?Q?1K6fNB7OT3h3X+G6RdOTZ0lQq8U9d8j4dxddE9/vse/FWFWi3uOYbm1uWq?=
 =?iso-8859-1?Q?VxPe7vah64uK6eVKnhQQYAifndZIlXGSon+/vcEQdhYHyGHNMkw9KsS3Vw?=
 =?iso-8859-1?Q?o3CBgAOELdbKmyHNl1kOy9GdgZT2zwObFXmmelIzJscTAjg/mpbm4Fmp4x?=
 =?iso-8859-1?Q?9O7OGQ0onC7zucQrQ8ratxc91ds5/HFMweSstDakGJRJ7FSTo6ICYa8Xxd?=
 =?iso-8859-1?Q?CCnKrLlPMw8D0Zo/7G33gPG+866NYK20Epw2xVdyK+tuh7yKt83s6VYyzK?=
 =?iso-8859-1?Q?2AO4a7UausixUf+ouUcMeiAEfuVNBf6XA1e68pEkCW56Hz6CELiAzOex38?=
 =?iso-8859-1?Q?1a2MbChmpwPNorIlwG0D5F7umiOzFBz6iv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66961332-aaae-4877-65a5-08dadc470ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:44:57.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOomnAQLXPo/jHMUF6nzJY386PZVbBI/9UEDMy1Vu7VyM5FGSh41CKc4bLaTFwG+3GG+bnb+NqCGgcG3DYbEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5291
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Check for erase specific R1 errors so e.g. an OOR erase is not
> reported as successful when it never executed.
>=20
> There could be checks for more error bits but R1_ERASE_SEQ_ERROR
> on CMD38 should catch all that are reported by hardware anyway.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  mmc_cmds.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index e6d3273..c00fe5e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,6 +54,7 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> +#define ERASE_R1_ERR_MASK (R1_ERASE_SEQ_ERROR | R1_ERASE_PARAM |
> R1_ERASE_RESET)
>=20
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
> @@ -2668,6 +2669,23 @@ static int erase(int dev_fd, __u32 argin, __u32 st=
art,
> __u32 end)
>         if (ret)
>                 perror("Erase multi-cmd ioctl");
>=20
> +       /* Does not work for SPI cards */
> +       if (multi_cmd->cmds[0].response[0] & ERASE_R1_ERR_MASK) {
> +               fprintf(stderr, "Erase start response: %08x\n",
> +                               multi_cmd->cmds[0].response[0]);
> +               ret =3D -EIO;
> +       }
> +       if (multi_cmd->cmds[1].response[0] & ERASE_R1_ERR_MASK) {
> +               fprintf(stderr, "Erase end response: %08x\n",
> +                               multi_cmd->cmds[1].response[0]);
> +               ret =3D -EIO;
> +       }
> +       if (multi_cmd->cmds[2].response[0] & ERASE_R1_ERR_MASK) {
> +               fprintf(stderr, "Erase response: %08x\n",
> +                               multi_cmd->cmds[2].response[0]);
> +               ret =3D -EIO;
> +       }
> +
AFAIK the device will not set those bits in the command responses,
but those are only available to read in the status register.
Let me check.

Thanks,
Avri

>         free(multi_cmd);
>         return ret;
>  }
> --
> 2.37.3
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

