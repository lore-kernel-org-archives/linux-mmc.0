Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE66DC43334
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jul 2022 08:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiGTIFA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jul 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGTIE6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2022 04:04:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204023BF0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658304297; x=1689840297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3TzcJCwfY35AQ8z0ElHP8PnZFSZ9g6lIFgxhZbGcONY=;
  b=gO9t1nzcCk8a0hhQe/BvcJv5Ud3FBCp60O1dIX06sPaZr5Hpec2jJyrS
   au5wuODCYRzKdQiP6a3lOSuDW+H8B17m61xtd1ly1CGEUqQY/qqksmTLv
   RjUHnuWLzghi+1q76yUmkjGGd61R31Rs1PS5dsMY/KdJtZWc+hfZym9th
   y2s2zO+IQwas3GlqQ9HH0TdOhwi9OQUadmH1hb+3qyDSYmCVujctqPmUg
   pu//m8Zv8J9lE+a0ooHD53RvTEDssomwLCIVtb/ZNlj/8j7x+465jEDef
   ueYCoZcgeA0EJjdvwLHOANIk2ld8smr2+2TyRbiLF0Yi7IeumI3OH57E5
   A==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650902400"; 
   d="scan'208";a="318510384"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2022 16:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip1ptek6zkLvJOLud4KT/DylhN8g5OIY35WDWXv8pAjqjEoiDUNBKCJbNn+cWrGRg8kLosa5iNYkWs8AYJ0pL1/aSVW6w9HDYZQmKHVWWMllbkmcOCAAH3doa02Bl2ofP9IDJc6pusf45Ydkgqp6RfexImc4JrGQgt9EWVbhVNzI7XtyZazkSZbeUDMee+ILm4IGzaGZiPRSnkUqUvoNdS8By1gRGPEs18NAsYBlk2KJhmBeDBhZOeUzFunHhT4Mh7vmjvC1Zbhl4j0Eb5HyS0yBIPBawr+2G4lPSmfbhdbXq6m63nN70sHuNJU3J8ND+Elht3FGE6CBgmS8PMAF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PttyUwp5+hzj/A9aVAaMnholMbTOJmTQ5FWRxsW56Vg=;
 b=TSGol2I1Guyzxeala3U7izoIGsoq86MItSdJLgvzEk/DLY+MevVP3TUxvJbhZcQ0cvZr20Xb9O0SFe0RemLYcH03PfbnX3fPpGfiCV3MpABWq6HxvBgP6r7mNz2HVmK0+iZNXukKwadRZw/0MZeW+aBGEoQRkTWY15N7DB618cFuaswyIFtRIrIk2Ye9RKXPnbxjmVc8sLjwiO0xaHzPWmMetY1u7GObv0/YDC1eGfHoPTaeTSGeKAIVhNxkm99sLzdfS+RVXibuT4M5bwhrQkNgE0X+3o18+EwjypxwLq3znpUJ/Gzzv7oIz+nBKz/kvsPbUg5L7nAHHuPfZ7zBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PttyUwp5+hzj/A9aVAaMnholMbTOJmTQ5FWRxsW56Vg=;
 b=kyyr23HtaOrYy34SOk+QWJJxzTJfn1o93JKHvIDZIyfSEFMSpVqN2wDQ+TbHaXAVkip0eGBEjR/X/1c+kG7yoC0v5liqV98Nx/pVGwnbt5qhpcqxCNWCVux5s0NjGihLSwMj5QNan470bwr/zK2oTIAzCd4YhVQrao9z7s2Gpak=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB4527.namprd04.prod.outlook.com (2603:10b6:805:a3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Wed, 20 Jul 2022 08:04:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 08:04:53 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoA==
Date:   Wed, 20 Jul 2022 08:04:52 +0000
Message-ID: <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4fb3919-6356-4c99-e919-08da6a2686de
x-ms-traffictypediagnostic: SN6PR04MB4527:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JqNAFF6uuJEH5lvVasOGQAugkQVcqWpCpMYsFXRRGv/laniivrWN1beHeYW/+obg8e7r0Tmnl+aa5MEbHFOZvc0Dg3iHG8qK1byNhjt58a6pHCuACCTUwFr4WNNm5lNVtxoKuvSFhEE0M+Hpg7P+AA3BWaQuckJOnkQVNqKcLuRJpHEZHeZdWRQv4Y6Cm9pOSjgMVvIeUF7+SOqvueDNRaVkepb5WTRBLZcaoJuwGKcl2qm4ZtagQsN27kpGhju7aw60TwpigSMm+488vVJbN4+VhwbGD5CKEi5u0bZiK7KAn4OmXOHnsbnz0zU5XbCs6t7K7ediqg0ayPuBDhRpBh5rU9f7OkLKLvwSYAIBAg0qznBAHSKJxwMJlDT5YR1l33YUFqtCTFWgNPVyPUUIBTdAKw+fFFDqXPuRoNXZGQCcAHT4ZNjo21hbom38DH1YRp7yF0cQKpxXSuaDrds1bY8ftIJ3Zc8tGCAs9zNv4MhUHHGgUWkxR1FXQFtgjskRSi8/sMuEfKsERLHz1aYO5CZ9666el6XV7qO9D+yPgEWKIzHrDn2pozC+MdI4nZZcIaMrydcYW4IawLuPJmhuKaT2muwSNDyvR+tPbdWYjZGbRpBBr+ZMDLUgWyw/7AdsYApLFcGDjcZTkwRXA6qBFHIwIzhXKgAf6iO133YlBMnGgWCKL+pUV6Z17GMO2DpsqZBhoGLZDghe0JsdoIhlGss0AN4FgGw5/yOZW/k6UYW8eF1agbbbcMo55wtYXqLWz1b/sxM95mQY8+v0uPlVwz8xVPFPvyNq+2+DUQN82FjVHf8BAjwf2ohkioVxSwh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(122000001)(8936002)(76116006)(66476007)(66556008)(64756008)(66946007)(66446008)(8676002)(4326008)(38100700002)(6506007)(26005)(9686003)(83380400001)(7696005)(82960400001)(38070700005)(186003)(41300700001)(478600001)(316002)(110136005)(54906003)(86362001)(71200400001)(33656002)(2906002)(52536014)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?GNwMcWUdwXfKflk69Z6y051nIfcVktCadhmh2Fv7Hj0G45hgQ6IewoKqXq?=
 =?iso-8859-2?Q?RghLI6ybjkrtSpDOj30P5gBnTivvK6hR/aPVHN/Owhidas2u3RC2RUL4iO?=
 =?iso-8859-2?Q?nps1pzV/YUYpfOnwcHTQLd1AcMfrVQQg+fnyTY1j3FhCBOUsUNGYzOMtG6?=
 =?iso-8859-2?Q?U7cslZmV+6Jy705ihTNRkoU5rY2SDhJ6MsaRmpKE7mkhpGVbq3T6501iIn?=
 =?iso-8859-2?Q?IQHSjlNaYbyNRMdlZp/tbvK96G3kgxgbt66uhuXkE0a1kYq+1DH6PglRrg?=
 =?iso-8859-2?Q?d2OM29XSm0y0HEk7HomoA7iUD1pzxekylncmQbinJC1NS0G8rO3nXrJe+/?=
 =?iso-8859-2?Q?UK7DQXMoF7hAgD3RVBfm1F3/QOvbx6/4XWa1/BeZSx7zrH86OaFmn9shvB?=
 =?iso-8859-2?Q?4h8dloNrCDdygMXUS4agIhOFVjJr4mDgs0Nqc73OjEHEqdAOhPV/cItJcD?=
 =?iso-8859-2?Q?kLg5o4sBsKIMjaMv5rFWtfvgd3bUlqLb1JyDNxtnNXvI+k3mIhUJbaNfzC?=
 =?iso-8859-2?Q?SU3aR9PO2u3tpnPLOXTJFrzdTsxF2xN7DGwXXH5HbGB+8dLhrTg+k+0Nj0?=
 =?iso-8859-2?Q?CMK3dcoBRV0qZ4sim+4ybcjxO/EFG5cIZ9dg3hKImw8OFMu2blzV9crBD/?=
 =?iso-8859-2?Q?oi6TA0ip9cBGDf9ZkCj5Kip0iRnjXclr+e67NHoH3LkLdY/qhJcGH8aLGV?=
 =?iso-8859-2?Q?c8951/b1siVDX4/7X+phucHMr9Ib/DfCFGxQlxbvL2HAVa4IyfQtBmrEds?=
 =?iso-8859-2?Q?OHVzP8cp411EhssoLfUVeZx9zRbBXjvnt/NJEiJn1/ICcmUE9g332QdMX8?=
 =?iso-8859-2?Q?zwJD7SfaBR7oymWwX6/3cwi8QexOXv406/GGkhuLZbR/3/3uRxuI2MfBy9?=
 =?iso-8859-2?Q?8SFAtGnu79jIiRRckQFvFG49EpxQnSA++dNIaSc3byCYwS1qzVd+N1ETtS?=
 =?iso-8859-2?Q?IiFTiPD8zlxdnwLA6G2Y8IYzICbQ0YkeQlV7pMFzXYG6z2GmrnjY41V09g?=
 =?iso-8859-2?Q?Hgvi5C/BZRCgrmGrlYMUXqY/ukRjciTcHV0HbYtNkSsjK0vS6NvhAjl0+W?=
 =?iso-8859-2?Q?oysdbpG55B4+2SQC6GaRHELmZG7lN3i8AMv+jNgJAHuzz8e6GaMq4UJajX?=
 =?iso-8859-2?Q?IvRVI9eoHEysXt2mL031z64r2lONCnvcH3Jmifc8QkjrlLIzUCYhwBgN0f?=
 =?iso-8859-2?Q?c7I6pxXw8ScvVIQwSIgYOuk/pLfzXoJurytdUDkiWKSeHnPuN3+ng5PBjd?=
 =?iso-8859-2?Q?MRz7G10XSvdZR5FhxLypoPoxm3X5A2j6k8WuBgf32nFOyXNofr7ZeICCL+?=
 =?iso-8859-2?Q?MCxRhkSRUM2hYQTnawS7ofLZx7wlz5UhQqgDtLs1ZFxYbysE79a7QvxFhS?=
 =?iso-8859-2?Q?LElySwxyYDEEMOIpFBfBDUtBGGMedx10FOkwbO9mYPTldLtgZrv5sEw8UO?=
 =?iso-8859-2?Q?UY2fdvGowcAXlabjZAWtu9UUC1/FCBkJ6T6d3DCLUkZJFnA9WkiWiCnfXG?=
 =?iso-8859-2?Q?1p90InCI1npxyHUi/qG53x6AWgvznhrMB62jKIcLtFlNCmde/o4otMZNAf?=
 =?iso-8859-2?Q?LdOKcRVBYE+/9zNSj1FYyF+u58IPKrx8eo/qErotXxjEmcEpA5sPm11DQE?=
 =?iso-8859-2?Q?GXSeqSC2HFWghr+ZQAwiuGNB+ozm9OEb+3?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fb3919-6356-4c99-e919-08da6a2686de
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 08:04:53.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zajLjgZeN2tOZlE1vVpM2ZD6oqR3sJWkOO/GkLJ2vWo0B7BDb5Fbte8JCH0Ak8EEX6w5XXJ/BxlufJfGef+fPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4527
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Bruni hi,
Thank you for your patch.

> Hi everyone,
>=20
> Here is the rebased patch.
>=20
> Add the check if the whole firmware was loaded.
> Cleaned up the leftovers of handling the file in chunks.
>=20
> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
>=20
> ---
>  mmc_cmds.c | 67 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 8d7910e..d017b64 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
>         __u8 *buf =3D NULL;
>         __u32 arg;
>         off_t fw_size;
> -       ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>=20
> @@ -2926,45 +2925,45 @@ int do_ffu(int nargs, char **argv)
>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
>         multi_cmd->cmds[3].write_flag =3D 1;
>=20
> -do_retry:
> -       /* read firmware chunk */
> +       /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       chunk_size =3D read(img_fd, buf, fw_size);
> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> +               fprintf(stderr, "Could not read the whole firmware file\n=
");
> +               ret =3D -ENOSPC;
No space left?

> +               goto out;
> +       }
>=20
> -       if (chunk_size > 0) {
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +do_retry:
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /* In case multi-cmd ioctl failed before exiting =
from ffu mode */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> +       if (ret) {
> +               perror("Multi-cmd ioctl");
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               goto out;
> +       }
Why do we need this hack?
Why would the last command is prone to fail?
If there is no good reason - Lets remove this hack - as a 2nd patch in this=
 series.

>=20
> -               ret =3D read_extcsd(dev_fd, ext_csd);
> -               if (ret) {
> -                       fprintf(stderr, "Could not read EXT_CSD from %s\n=
", device);
> -                       goto out;
> -               }
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
>=20
> -               /* Test if we need to restart the download */
> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << =
8 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << =
16 |
> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << =
24;
> -               /* By spec, host should re-start download from the first =
sector if
> sect_done is 0 */
> -               if (sect_done =3D=3D 0) {
> -                       if (retry > 0) {
> -                               retry--;
> -                               fprintf(stderr, "Programming failed. Retr=
ying... (%d)\n",
> retry);
> -                               goto do_retry;
> -                       }
> -                       fprintf(stderr, "Programming failed! Aborting...\=
n");
> -                       goto out;
> -               } else {
> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect=
_done *
> sect_size, (intmax_t)fw_size);
> +       /* Test if we need to restart the download */
> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +       /* By spec, host should re-start download from the first sector i=
f
> sect_done is 0 */
Can we use here be32toh or get_unaligned_be32 or something instead?

> +       if (sect_done =3D=3D 0) {
> +               if (retry > 0) {
If (retry--)

> +                       retry--;
> +                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> +                       goto do_retry;
>                 }
> +               fprintf(stderr, "Programming failed! Aborting...\n");
> +               goto out;
>         }
>=20
>         if ((sect_done * sect_size) =3D=3D fw_size) {
>=20
> Best regards,
> Bruno Mati=E6

Thanks,
Avri
