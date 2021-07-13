Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5FC07E95
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jul 2021 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9437B60BD3
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jul 2021 08:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGMIDQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:03:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14762 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhGMIDO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2021 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626163225; x=1657699225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ept+Ha9sY4vaL5+D7yGS9Of1XS1oXIqMU2fTYBJprks=;
  b=fnFd88m9rK0JaCZqlnK6uEqYzvjSl9ug7ihX8r1UGGtlVxwSWNRPt1uQ
   kum1hVTqOkSKW9NU3agWY9IplBiltx+Sy9F/ttW+aZTwyvsvmJTZpvMOj
   l4H2vMGQGTu9GHJws9nwULGcswUdOi9NPQs7XHM+7RCg0ayoLb8MAWqFY
   EKOntjlgevpvetaG1QCM2uE6Oz/SOAp/gGOIjE0NaTRhA+NjVqrWM2Rgo
   FEP+dthoy8GrWTHheDwbrmsYiCdllgQuX8JK/qFGu+w0b/kFSP/kQGfFl
   tRKCykK+blmDrIiyvyBC6xy6sx2Bkwv+jtBoE5+RyIoEX3W2wfIZqD2wl
   g==;
IronPort-SDR: 8ZMRd4Bu/rH0m2o4Pz+BPsndzUSUZegV1QJauWbS1uzptfS1QaLQnIzL3DWakH3hEvPrVUoPTU
 AYLibmVppCin0uG+XOl6XGgvDiQKWeiAJxTsq8hNt0Jg9E8vHmLvGtLCfguAiuHKJZmH7emd4+
 vX35UMpbny/Auc6eY/dXhXO0eLEmy2JgKQ7TOrerkSj/lzjydXMf8uOEETJ3ZtD61LRjTW60JB
 +OMrs/D+ZtG7Jgki3nn9QoD3d8kPCpH5q17jTgP8wklu7fqfhcfq02kdjW0GjccfD1Ve5Er+Xn
 Geg=
X-IronPort-AV: E=Sophos;i="5.84,236,1620662400"; 
   d="scan'208";a="173676889"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 16:00:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKEcl+VL7dY+nReMHmpvhJHRrgIkZqlaLNlXLVJnSDF8flDHwOTTPUYunLMcWpw1uRdwI9gwlBkhUW9MrvvYbNJFaebzBSfcJBJUNxUA8Qcl7THQnEn7DVRc8rnVnP6KRj3JLPMmjv/0AXldYA35wWRArsnHDz4HcS6kQKZvx+SsJULSGCNCEEyjIXK1FzCIBg41n15KQ5W9/SsUh8/GEQJ42dHIZKwePGV2CZosLkIcDEOdCWS4DM0yrtaL8jR/y1quHt6c+hkpRNjkfRH13dlkZdhpXbIJQRZrZgcElZXMAN7CKtS+Lqw+S3FJxiUAqCiKoMwIzZHOcp34wESwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVUCdKm2SMo7TZy9sKXc0QYKpBRtMXqNqSjSDsUa4U=;
 b=KwphPPwKevIdGLzjgmT8gZ/BjD6yKjTdtJ1xlD1N9oSqo/1aG7/u77eEaj3GW3pliKPkfmWME39kGcmAWZy70AD02jUFlWx/383eF9a81MpA3gNkU70zQokX/QhzL1ydZ/sUmxll9HgRscGoR9sIQy4K1oM6YQhoFtDI2wd8LGRvz4TY4jWDAbrWw3QPJaOBY1qquPZ9ClWCsbLVYSDsa2XO8AonFaMoWwzD6ZqNsDwWr9n6abYw8FmtLPr8oVrkOOZZSTz4azYarBXknFw7NWLOOZ5UmEgKN3XdeMlwAaeCG42UCowujldSVlsBPcWZJ6Q14eAz4Zovq9QiL2AJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVUCdKm2SMo7TZy9sKXc0QYKpBRtMXqNqSjSDsUa4U=;
 b=tQQA8Lp/nTLvKKJ/OI9Xo5kKNZL2IDOxwEvAqOtObysT4+mrBqyWUQ411lx0UVw88agnplzNImEp/d4lZGyKE+/UUJxR7YhJRpkoRt0gqAa9ZwzR1HXvhNBJvysD0BW2/nyjlz92xiAfpIIyayhbquUSIVDZ1kyLLnEaNd0DZwc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5676.namprd04.prod.outlook.com (2603:10b6:5:167::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Tue, 13 Jul 2021 08:00:23 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 08:00:23 +0000
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
Subject: RE: [PATCH v1] mmc-utils: Fix for Firmware Version string printing
Thread-Topic: [PATCH v1] mmc-utils: Fix for Firmware Version string printing
Thread-Index: AQHXd6jZuUgr4o2JXEGNxXFkZDju7qtAidaQ
Date:   Tue, 13 Jul 2021 08:00:23 +0000
Message-ID: <DM6PR04MB65754DC90E423A79D80263C1FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210713053458.1441-1-oracleks043021@gmail.com>
In-Reply-To: <20210713053458.1441-1-oracleks043021@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb3a20ec-5da6-4e65-5367-08d945d44482
x-ms-traffictypediagnostic: DM6PR04MB5676:
x-microsoft-antispam-prvs: <DM6PR04MB5676F8FEE443BCF2AEF71E74FC149@DM6PR04MB5676.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfFCWPwOhtYkTaWVwcTFr4sFOz82IFiHyHg6LGAJwW26VnT/dC0iFmxjfJNRWfA+7yK3kTkMr/rw+kmxZXoI0zYLl/tHdyqmTjhDVDA9BOcbGvYPe+igoChh6mcRgNBf5wSC/stIAoAt5czJBFSrlwOXsOuzR/BuFeZI51Ku79BPXYGIKGiKa0D3uRfuInBbtWzNFMHNCZHnQykJKqr7WqTOlq1xnkNQkaUr3soQtonVPTfY1H4oC8OyBOd0s16bN5+1FxBPBrpN4U3Eo7MU2cd+X5GxcFBDr4PRmjIycMAjZ70Y7XEV2ruGlmxIchYq77WlpUufup4XBY9QObU9wc1THWJbNq8Q9vgtkV8KkZ7LpElMtv7X+pKUHLCAZh8YjmLL2rh5dbKA/gX8YJsVN7BxTn1xjSQRBeca5JNibgvnFQf+y+cMa1jjuc77vZJspBbc58joiKIwgFyIVJxX7L7N71lTnjRGq23vfQWYKsi2Sh+pv8mDRtF6D9NHmBzzk0AWdBPe73AnfOFKYdgNU0qMf6ypcQiHHrW7FDWq6YuPzpzUK4BotWuxhlRFHCwTIg736vvi9OICseFuSBC3CEiij7Ye0hYEUM3flgSTMp/MkDUQ9h4ffS7DUVeyTayXEbXz4JNHJhNtPaBuP7+mQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(8936002)(33656002)(86362001)(38100700002)(316002)(186003)(110136005)(4326008)(26005)(8676002)(6506007)(5660300002)(54906003)(7696005)(66476007)(55016002)(9686003)(76116006)(66946007)(64756008)(478600001)(66446008)(83380400001)(2906002)(122000001)(71200400001)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ka4l+86LcOHRlV/ZNikYAIiD5QL5FEvvlDVcSA2GPHpebMNgzRpXGB9+Cgk0?=
 =?us-ascii?Q?HG1is7NI6C0B98xrpcJ+rw/kE+EwOyokk8LO67l9/pHhsYS2iwQBu9jfVpoM?=
 =?us-ascii?Q?lFVFunQBk814QDMlpJrsjQEmsVgRGAeVOYm47O9si0GB7y3kzOS58gAxDFNE?=
 =?us-ascii?Q?GihHq0IyLjd7ZppXMHmq8wRqP4qH3u3LF3Z+qVuHej2ANfbMmYBiJy8w8Glr?=
 =?us-ascii?Q?iuM3ok8vdrqC4OW3ny+Icg6Dp+mGF2wMfs5FHwjcixJj/7xde0HHd147bMZl?=
 =?us-ascii?Q?5OaGcCxjUyi35g2qcGbTQJOws86zgpM8rGbj5jCXfXkWjdIzdheM8JOYuevR?=
 =?us-ascii?Q?2xg8ppfeqojrNo4jYa3XLnSsnoO4dI/8XPc7BTVkVqR+IvpAg978lJ/T1j/D?=
 =?us-ascii?Q?apJzvegGwc34OpgKoe1uNR4ofP9NZ2n+1YZhPt4wjB6O1ORLJTOQ3zek4VLn?=
 =?us-ascii?Q?WLhzDYHmukYAvcR7WB/Ysb7+uVw/6FaxNbOywnwcIMChz7SQlWhXFUxsQ/yF?=
 =?us-ascii?Q?gtRrXXvgcCVWJAso/nUFUKMpEJR9lCV3j1Ea6igHKiy/EV47r3AZxlgSmmjg?=
 =?us-ascii?Q?uN70CZrGHXEGE/8EswvyGeVg3wUKuQ72Ni364HET9G5a1/7mS0BXaRKqFlu8?=
 =?us-ascii?Q?XnAtT1JCwG5O/80mUaQ2wuewfkkBR9d+3ypcsPmrv0gVDpj8YufVlzs8BkMM?=
 =?us-ascii?Q?ow3Y7EsMS6r6JmemXvWSkQ/XXrRpBVkuEe3FUzqWK4Sacq9yy07FBlibqKyl?=
 =?us-ascii?Q?SDXRECeZlnL7XXGTsvEQuWTlFEphxVDFd5BdeEODBMUKP8wqw/MGZb1m+eHr?=
 =?us-ascii?Q?JyVkoFqNxM308s5M/bgg2CjQ9GI95k4nCO6/zP/cf1Qq2TEf+YwUZzl6/dST?=
 =?us-ascii?Q?1piUZ0652sMDTll5HQl5wKfXIchkKzmtpyKJa737o1/3wfKUTgDi3n9DB/V1?=
 =?us-ascii?Q?EMy2WJq7l7txvsRNGeO0mkfTulgAg7T8IXOmLQIMo3IwHjLpUsL2VU/nb20D?=
 =?us-ascii?Q?r+22S+x/1EJMVX0ytlym3Va3NsiZLsY9/vwyStE/+MC8JDA9AzRTX8AWMjHg?=
 =?us-ascii?Q?VavKNGZK3NalelPwKDUfMPCzkr0+/UYAmP6NWrntiOj0lplPf4M/302wFPrb?=
 =?us-ascii?Q?ZzDQfujh59Ea5B8nqSDKMELAebCJBIqFCQNtK3GZhU6PUTb2VFYwP4xc0McM?=
 =?us-ascii?Q?NhWQtRLYPXZhl+NJO9zXaE8LFt7Rf2AhA5M+gi0mGLBaDOsV8I3cCozy+Pqb?=
 =?us-ascii?Q?nL6wdQJAHiwC1a83AfHcqIB3gkbcven4tv+3UV/1/fTwFmlUHyZL4ooRp5eO?=
 =?us-ascii?Q?V4nD5RFFp1fgzxL4Iz0HWfeH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a20ec-5da6-4e65-5367-08d945d44482
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 08:00:23.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4IVN55h+225aM6lDFS4tW3vZ4hiulF1gxzSK2AeNrPstk9osyCXuxF0nsfUXy+VW5iXqKKwPBIDpHq5UgoWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5676
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> From: Kimito Sakata <kimito.sakata@oracle.com>
>=20
> Added a local buffer to create a NULL terminated string to print the
> Firmware Version instead of attempting to print directly from
> ext_csd buffer. The last byte of the Firmware Version field may not
> be NULL and the next field may also not be which may cause it to
> print garbage.
>=20
> Tested on x86 platform.
Fixes: 89cd01ed865a (mmc_utils: add ffu support)

Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  mmc_cmds.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index afa85b7..205e6e5 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1392,6 +1392,7 @@ int do_read_extcsd(int nargs, char **argv)
>         __u32 regl;
>         int fd, ret;
>         char *device;
> +       char lbuf[10];
>         const char *str;
>=20
>         if (nargs !=3D 2) {
> @@ -1833,8 +1834,9 @@ int do_read_extcsd(int nargs, char **argv)
>         }
>=20
>         if (ext_csd_rev >=3D 7) {
> -               printf("eMMC Firmware Version: %s\n",
> -                       (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> +                memset(lbuf, 0, sizeof(lbuf));
> +               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], =
8);
> +               printf("eMMC Firmware Version: %s\n", lbuf);
>                 printf("eMMC Life Time Estimation A
> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
>                 printf("eMMC Life Time Estimation B
> [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> --
> 2.31.1

