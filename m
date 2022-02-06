Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B2C4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Feb 2022 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiBFIDM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Feb 2022 03:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiBFHuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2022 02:50:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C8FC06173B
        for <linux-mmc@vger.kernel.org>; Sat,  5 Feb 2022 23:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644133803; x=1675669803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pB4A/pn3d48z+ivZuwP5P8/FnEb0iSIhsC1FeyWoRIg=;
  b=H/UduTwWWyz/UEWFfvQZiNQbwsYafsNMVpAXKScbG1aLhXc+eCPR5NS5
   IBQkm9zdw8j660pP0drakXsyS+kEA9aIkSTg6Bx9qtMihQCr/kbF1J9a/
   ptI3Mi/OTXzZ3esji9FHFMV77hQaf2+kqgovX/l1EdaZ7qEkozwqmh/PP
   SjgRrjl98f+uc3FpnfEIrAyyCNEeludvoDQ+Hdr2q+mDa4Ls4lEM+fQWB
   fJRSctVN6D3RlgZJXHJyMOKCTlGMaLXM2GjCYOCcfMdLypSquWYr7sKoa
   5L5Taw9JzEZEy6PveHq4wkFjLcbLUwcZ/L159SFzgwSWDZlDeRMTIZLpH
   w==;
X-IronPort-AV: E=Sophos;i="5.88,347,1635177600"; 
   d="scan'208";a="192253401"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 15:49:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdGZ9rA6GVNk8rDpwh9JDXyVtm51bk3RkotCJPCVR/B7Sa1bpMBrz9tk0uBqTVgP3FVYWyvFRKsHNK5KvZOambMkulhB0gP5svPFufWK3Q72cvDsPULiZ/2rA04EimnrbrIHsUW9y7P5NrvY0eYLI6aTF2Zds3qhH+71zUHq69leOcDYCrTaYUYYkNjiVw+yMIpKnAtIVNJLWUV1DhXtPORO7q4nADDL/JwKf1s9cJ4wcdQB83ZlkPVQrktZ4qAVV2L/Qynmeze2Zq16Zj/Sl5X3cEA57FEg1IGylyXAEliLl8eUW0b+7u6L1iuNPm88t700oNIGtpktB4R0l1HEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJD8GquLxcQXQmoFVERjqr9hiVqupbcH+QTEyvdIqTY=;
 b=HlcaPWgiRGKKSnPBPo7PIm3gnvvn+cWlEi/80gf325IIo6f1hIeFY2MZX5gIByF6clWyuJcEG6crV8vrbsVIdKwDMDmPFA3WV0Kxllw4/zfFvrCUaRbbSi5QNcEyaiVqV6MKN5PS+dqWRxiLTAcohugblRMutiHPbrVuKNZbgQPqQ/vVRptf9mnIwwSo+0JCmqk72ZaetObfU6ydOcnylDq/xfebJH6f0KUAfAfN0wqZUtcodumniVTIib1JzeuY0sKpXb4DRZMCctLVmN3u53Al2hlPAyZbtnB/P2btheCyT6f1Q7jADqiWqaJOLXp1QIQnD3Ob9H9TQMr2L63EyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJD8GquLxcQXQmoFVERjqr9hiVqupbcH+QTEyvdIqTY=;
 b=wIoK1rlSW7AATinzjmzqsL2nrzPIv9vwzn/RVKWPGqMEhUgiuZDXZoIyThkMODyDi96aE0yFeMS7PFV4WOyS19WcqYMXiXTGZonAJ0fzR0VhTirMfat5gFxBlBrvMUVf8GG76ou5zLNfLva9fI3pM4lLmo5UmTfeOfBXw0D6O+8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3529.namprd04.prod.outlook.com (2603:10b6:301:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sun, 6 Feb
 2022 07:49:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 07:49:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marius Strobl <marius@FreeBSD.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 3/3] mmc-utils: Display STROBE_SUPPORT when printing
 EXT_CSD
Thread-Topic: [PATCH 3/3] mmc-utils: Display STROBE_SUPPORT when printing
 EXT_CSD
Thread-Index: AQHYGtL1CZCVHpEG4UC4VQzETBjk9qyGJiaw
Date:   Sun, 6 Feb 2022 07:49:01 +0000
Message-ID: <DM6PR04MB657509D6E978EC8E435C68D7FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220205205647.7677-1-marius@FreeBSD.org>
 <20220205205647.7677-3-marius@FreeBSD.org>
In-Reply-To: <20220205205647.7677-3-marius@FreeBSD.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0911ac2e-5355-4c4f-4813-08d9e9452449
x-ms-traffictypediagnostic: MWHPR0401MB3529:EE_
x-microsoft-antispam-prvs: <MWHPR0401MB3529617B6B9318E245D02565FC2B9@MWHPR0401MB3529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P67zymXG4vZ/I76MOpMf6/uFuuOYx8DQBMiOU4JgDaSQKwx5gq4+uoVLqKZKZ7+ofaoZa+pwNPC1x1cVVCqVeq/uv5B7M5U2Q6uZ8LmHIz+lYY2O/75FsNNOZ3r4MhufduIugQcvOejkta7VHeVbForQPOqkW0Q6akzKPsbNB38HtA/VG4syWuipGSKBnzzsIaj/cNFMwPxvShE5soXwbgM6kDkn/T0leml4IY9AGrQmF4kmLk2PQUEwOHrsipz7t8ufpONcnJBtG5pemmZXpM2B1i8gju/B/ETi6NShyt1F66KUMAr63rnZvqtGMqZE2ueiLAU5/7z2v7ByI1L+6OKG8rDmlQlA4bD4thjNrxPioimFCAn72ZY6QzTOCuLr7dspp08I6GOlSIep5RKPvliVcqw1yueXg2noYnyLFDBVEHet0nEpabxJIHzjRkiqTcV4VzyAOrmr1bGcs39uBbrk/B1JxmtPZgaQZQ5nDMc4xFO7aRB6yGHFeNhIgJ/ZFvHxOZlhkdP1/kPYdBrSCiN19tXCu/5yFUJX1bpWLTZp+HIjjexCqw0jOhBVvhnjFXF9Cj9QhtbPkHYT6kI9btRLWg8gOOp8cxYBD1BLjLdytwn2o/edTgk7j7qL+u3Nf2p/onhQrdoks00Zsm3Cljd9uMSE5RrOrJDERKPcpHw/cR2FEoMW2UL6m9CmdlSqBHpsXpO/fwGqzE5m69IAQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(9686003)(4326008)(82960400001)(76116006)(66946007)(508600001)(38100700002)(8676002)(8936002)(38070700005)(52536014)(71200400001)(64756008)(7696005)(6506007)(66556008)(316002)(66476007)(110136005)(2906002)(122000001)(55016003)(86362001)(33656002)(186003)(26005)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DupWPbTCWGFb2CcX33AIjxgOoQwOjfHrVzZEHprG4g2h81v1DqWGj1CjsOBY?=
 =?us-ascii?Q?d12cMfEbZKmuVg4Unx6kmM61C7b4YwBjk4dQpPezFM+VaeX3xFXd1gXzLBH3?=
 =?us-ascii?Q?qOneiHB0WRynnwU+ABIEN/HGNkIdi5YRJQnptgh19Ync254+Bmpm9AkCE52P?=
 =?us-ascii?Q?mIIGb++6H6FBtQxFGbqPvoo9dd+uFvR8+ltm9Rytb/9Y2yOlZh3GUkeHH7rf?=
 =?us-ascii?Q?WaRnL1vHkQFtzLql1XtdLTDl6nxVHNaZ+Glkb1J6XJ/9M8hiRV5c3oNAHRxS?=
 =?us-ascii?Q?YEd6F0kyMfwH1dnXGsfPI44bt9D3+5o4cRCH0NwyTmfhbd4n/MoTO80fUbsK?=
 =?us-ascii?Q?FJwQ/csP1FulU+7om9JmY2f6H1T8WXhPWkVutCPMCcpUhitmK7QtIH4RfbRN?=
 =?us-ascii?Q?NG0H80Li2eBRX4Py9cXrUa3iuuLimyDTd9YgMAb1YJTy5vDm+vYoyhdxkRG1?=
 =?us-ascii?Q?YGeIVN6IDvCD7udT0FX21N7oHiWqDWy2vyeqcHfiQx+vqmY4+oLfHQqDszW8?=
 =?us-ascii?Q?2JLWCA1jRB27voWX8x4oWINzhET7jj0iu6NP79FFXEES573D2AFx5f9f6Xf1?=
 =?us-ascii?Q?yXt5ein86q2hPVACivJOt56X0MWgtWHHc9sygcthIGBFJWEo9vdMi7U/C+J0?=
 =?us-ascii?Q?3xKUJGrCn+fi4SwHCqlCaKwbTv+yEpaRWXazdrO2Lcba6up4ei8XyKQhylV9?=
 =?us-ascii?Q?6O/0F1r99ekexqJZQ7c6PmZPMogWGNATOG42/2zpiqMGK2ULVQhcMiD5CTIQ?=
 =?us-ascii?Q?r8XaFQ5vMbu1dimyMaawH43SULv6MAhB71gx6QHFrQbg3q6O8IqcVAE9GbkQ?=
 =?us-ascii?Q?Bnv6iX9nA+vwCCSf2WkVAbgFaoADXt7MIcEC18b1mVk09v7n151m8NKnReP7?=
 =?us-ascii?Q?BOdEs6a10gLWL5P/2HmhTM+MdInzVbC0rscpe9+VKDD+o45Iiiuq6d7uvuPB?=
 =?us-ascii?Q?V/Fi8NuV/IU/bsQNma2fH71IRew9aeuZ+2SvmbvPQnL5XEF8jvey+7QTB0Ex?=
 =?us-ascii?Q?yULDU0/39jPctwaRdpw3Iao2k/paJjTJVolZE3nMZrYaTta0IktB2gxAr0gb?=
 =?us-ascii?Q?khID/yfugUjW3SV0f0nBwNpiB133TEbew3beKZieG4pJheeybJp/Uf3YXBXQ?=
 =?us-ascii?Q?ljAMVmroRnM9+HumK8hse1Bx/nxJoLbmeWFSX7jIC7PvecD3oqXiQkIohKTx?=
 =?us-ascii?Q?dqN9nOeKiLDgNO4Gz7aB5WvaxfntvU7Xgtv8uY5axlHkNxE0xmn9mXLTcqrV?=
 =?us-ascii?Q?F5B+TvL9RPt3ko6SUWDZKozZzwJtbfXZGcuiqbqrxps8ReYZZplJVVB80r/d?=
 =?us-ascii?Q?EHiA1x5yszbR6SZMLDhIDovGNZkrXg9NDgNJ64BR6bRBAVOUCICJP47VEwwD?=
 =?us-ascii?Q?ffDbRpgz1ZP7X3ZnCrQk6w9RGD0szDxfMZnq2TliGtepU3ditX4Rn56tBub4?=
 =?us-ascii?Q?l8TG1szZ4vO8tKMv2ZxSxwAJWQjDptC6CBmQaVcLMJIVYb77/h+ffnYceV2Z?=
 =?us-ascii?Q?BWxMnqd0uT0fiLCEaD8qyq5fUMVs22ntzPgb3dv2rvucgMx0mD65mGaKgYC/?=
 =?us-ascii?Q?rvMHL2Sg3WJbb1Bd+yus0mrHx7OXgmgBmrcTKzeJUoAf37rd0EUiER14C6Fu?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0911ac2e-5355-4c4f-4813-08d9e9452449
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 07:49:01.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tm8rEWE1Zq0pN8O6UBvxLfp+D0nrcKXCUfiikW0lCtn6yfU6Gru8ZFkE8W34+t7rpaE7KvSf5omWBWk0lgXmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3529
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Support for Enhanced Strobe mode introduced in eMMC 5.1 JESD84-B51 can be
> determined via EXT_CSD[184]. Along with the identification of
> HS400 data rates added in commit 3969aa4804ed ("mmc_cmds: add HS400 data
> rates"), this allows to differentiate support for HS400/HS400ES.
>=20
> Signed-off-by: Marius Strobl <marius@FreeBSD.org>
Looks good to me.

Thanks,
Avri

> ---
>  mmc_cmds.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index f024079..508ddad 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1628,6 +1628,9 @@ int do_read_extcsd(int nargs, char **argv)
>         printf("Power class [POWER_CLASS: 0x%02x]\n", ext_csd[187]);
>         printf("High-speed interface timing [HS_TIMING: 0x%02x]\n",
>                 ext_csd[185]);
> +       if (ext_csd_rev >=3D 8)
> +               printf("Enhanced Strobe mode [STROBE_SUPPORT: 0x%02x]\n",
> +                       ext_csd[184]);
>         /* bus_width: ext_csd[183] not readable */
>         printf("Erased memory content [ERASED_MEM_CONT: 0x%02x]\n",
>                 ext_csd[181]);
> --
> 2.31.1

