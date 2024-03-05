Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C118639
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668141; cv=fail; b=fscfnSpKb2n8iRt/Uji3ggmXDXrfYN3YpGOLH1YD73UA9X7/lRt1W0F6GRiu759xdR9O7b9ysdaia1P+GOMis1LQ5ewVCQ3bE2tE3VWgx5rfjfZ++gm3/v6QI8tUrTm5ZIF5hnHtBc26lGrx6iDfTOK1azmddG1BOjH6eCKoaDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668141; c=relaxed/simple;
	bh=4oiw3qNQPmvxSEWYuWaqIOd+VtugqguzfG0h4SwRYAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C6as3pOYp6jLalMJCyc6ENwsUGDV9z8/8lj4IHGo3aOo2/snNCVsTkNWHMTHAZDfo4fSlP2CgFGZHbE+4wx1F/BfPLzOaTk5UuVrXg2HW9HtZbd6ZTrJlSwY3+Qo0c/20aQpVxl1xLTfcUzeWM6m3kpCgYHyCbJFP9FGM/skFkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HfVjumkd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qyAEFm9n; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HfVjumkd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qyAEFm9n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709668139; x=1741204139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4oiw3qNQPmvxSEWYuWaqIOd+VtugqguzfG0h4SwRYAs=;
  b=HfVjumkdU24TrKm/H/VYdCyNQV+UB86a8tdwuSl44ZjHwo0uKi2RAv41
   5LdYUX6x9jdIlak0eAMcRrizwc7hD7OQcGTUgCMGUvco+qn+Zzm7hy15r
   LnBkj4ieADtITeNTwh4Wv2q5WSuiuQpe/rQtYa9tfkpkytXIgRlSTca+B
   6PIXh4E5nn6dg9xJXb2Z6jf2wXsPhN9/SO8Xz94jCT5QGdm1grqWd6hqh
   tJOQg3v84KVKfAJZdLrgsKg+ojEr3XpMogEZWI09djVsUtHocl0+r3KB0
   dDyRcdKpTKKAv0os8OUB1Zhb4UQmS0hiElCHbFgWoaosjCZd1KUAkUaEQ
   g==;
X-CSE-ConnectionGUID: H9bV96NlSfKYZwMdOxsdAA==
X-CSE-MsgGUID: ffMWeaA0TXGyJb8Bpi4eCw==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="10419647"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 03:48:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es1KMpTxhYbzu9OYhfOppRTvHjYNEsiTVHrMW5NzMdd1WwUnnmINDeqaMF8jnPpnSgtcxV0oQpcdI55gc1bnsprvlGMGKfDg5EiNAsprGRRy7a0vRdxLLLhXw4mEi/LTpYY1wjVI3+4uZyvIOTfZWPihvor+e0dpkNZ01wafBqA51kNwZ+iY4uE/K/Zqv86JvzhGpmC7MiFwEry9Q4Nx6ua2YzP733+a2dO/LqqWBvjadbwaRlIfHKCciE4BBUvulOYr5JfN9xaTZiy+/+rdvNUzaqEeXwr/ndhxtpmDYrS0QV9VQ38RwMI7jMwoWdhR380B0nY95QJ86t3sE1wdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WP4RDhzjxSWZyVm2Ay8Epd/+cdktw3393ZRFGraZT8=;
 b=HyCd8rNIYd8G/Vf6wUUagoqlmvdBdRVezCfwxWHEv5NVIQRpAWR7Akc832d3iXvDAZBfMPJEwuLqniUUFY9p0ynebeFguOqXIC6Oqivb7tts4wZmDV5v0f9Ae6ao33yUAauYET1g00RRNpwUunVJM1diLvAbzJtKcrik5sMhfOPQ9bXuTvdlxPkVijWKkcIpJezcOwDFTD8mgSBaIdKB4XMqTy1G/nnUKKdm6v0xQjPnsFKhxf7p0sHC7qGWyb/rqXH6g0FHx5Ajnr8Dj9IPPNhjhSqv3jTRY2QHwPvh93bW+uxrAvlr9+6Yeoge5h5917wX03zX9Mec7HnIXj5wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WP4RDhzjxSWZyVm2Ay8Epd/+cdktw3393ZRFGraZT8=;
 b=qyAEFm9nkgXEbu7t0hikF0a8HqMPt4YFbJw86T90S5j27hKRooj8XcVaNGcnsxZyPa9aHcBinCfHyi99g8AmYUNfnej1BmsGZpgSXHIZeNzsXyBy5p+UIcJV/MdMn+dlUB0qAXZ0nzMOYSgOkbib/zvaiqgrp7er4d+n8molrbY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8561.namprd04.prod.outlook.com (2603:10b6:806:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 19:48:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 19:48:50 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Topic: [PATCH v2] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
Thread-Index: AQHaby1InTpEnKbknEWgWdRqId5MyLEpjQow
Date: Tue, 5 Mar 2024 19:48:50 +0000
Message-ID:
 <DM6PR04MB65755D5A537F55EC35F1786FFC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20240305184513.400364-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20240305184513.400364-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8561:EE_
x-ms-office365-filtering-correlation-id: 5b529653-24c2-41c7-4c10-08dc3d4d47ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KWeAFjQHUcBGMmnPkpk0P2D03cmWqHMu3aVL4i5s5s0lKVS1b5lmI38dMvW5q68230cNe+IJ2h6vWeFz+gG6B/ijvqudUR5D2WPua6c9jMnbJIUb4P+x/lH3ieDkA1pl9ITkwqJeyQdhZevwulpfrAXJg/DEeQgmV8zt2wK8qAclHNjvj2hNtqpTCfoaFRssFQlB5D17W1VsnvA+fUVZsszG2fbqRJhpea6x+WX7+Q6KSdOjaZWKUza+lG418Sd65anbjUo91eBaIPvq1c2VJX2vLgy0nwk0UKE188Xc+gCBApcV9epJCqNyuASvn7kH3Vl855ArYtDtnQqsz/fnqQjutGxPKEEkoe5xrNSPY5ysvKuwkIfvg9CXLYBgkKo+l1Fjo83YKGXsAMsKMEb6AiHUFSqstbd7T4HlT4wQz5Uh4tkzal7/QZQd6rllSh3UI6A9lc3eQuIEalFTqCNl6bAcAt4IGZftuwFpUDquBBJHjjIIrm/DHd0BcgpwLx13/LiBOrkNOSeA+WpulIzNzKSb3STTB/SjySrAD7Hj002RIc6G2tTGK6CSdQ5rzsDRtXVHAMsBRwPbVHtaB/WR+jPdPMm5Gs7SHgNRk8C0Qipu/vGT7I8x+9O8/67SILkwTF99MCCUFQ+4RYtqGZO2DxaS6mBAp6/VoE0MY4IIbx9SoRmvm7QoSwAh4k5JRSvqqMw7oYv7P5wyj4h9y3utz/QiIXcwfnzrO6Axe9aCrzE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QzcYJp1h0YOjzO7x11wUDi5jlwudHePpiVkpx9ilAcKN+HipUOkIXZnX1YvA?=
 =?us-ascii?Q?8hLHa9YjnhsZVvXslmr5kB3/VcQWHnSoodyCTpJz44gyhkkOqx55Nrod0pWR?=
 =?us-ascii?Q?/xXueKxTG3zTdqH7PI5/8flqr5tZCxHbI6+K+XDYUCBZSPdv/MGxCCNIWcwA?=
 =?us-ascii?Q?su2KUvr9ShUB/e4/evNSP6NC1Ap0FsgEI99baPyAoe8i3NpbDosWApcUkGn4?=
 =?us-ascii?Q?ty0JgMAAFi/sncaDgq6Bi/VigopP0dP2gSgiwFUT0kToYdMGKNsMOSOADTNl?=
 =?us-ascii?Q?7HACkLer4b3iVJk07JLnAgWPpR9AQn4bWFN90dZVnOKtRyn8XbvZ+5Co+fcv?=
 =?us-ascii?Q?8vDw8usLCGn0IaJBM84a3aI3Cp1Q1CCw98JGbUGafmaWZWFWWZl/U5X2Q+Oj?=
 =?us-ascii?Q?yafb1owDjpGc77m0aaAAlDneFn+98xtULFXJVdPlvqdvsEUZRHys4SpMLmog?=
 =?us-ascii?Q?Yu8w4g9Wg48C0JpdruhD9+xsg30Sa12ZlJJLWJtQobVQr4Qxn717Hms+vfKH?=
 =?us-ascii?Q?5s097aiZdrqH5kJfVHKVSBzNoFGURspxtBB+8BjzPJLFIh4/ZSTrfygs1Zyq?=
 =?us-ascii?Q?7t0/3+5EW9kcjYh1nPnBq2t1MeNa+hS+NIPtMWzZWwqG82StYdjnPbQ+PfZ3?=
 =?us-ascii?Q?ZDFwM5X55WL1Qm0KEiRzYegfYtMD54WkHrxAOq84+qWDRkR4AayKkuXQfkPK?=
 =?us-ascii?Q?uRRUXVEOkOGB68nE71b7H2OYV3MUnDYVyufZx38zpyrx6Bk2ovyXlVfC45KD?=
 =?us-ascii?Q?6rUZEpzGlJwvO93uq6v3IXkmcgyZNSibZixxMwzadcV/KOUK36cci0BEbPGv?=
 =?us-ascii?Q?RO1aA5TX9yS0Lcq2+4m1tSJI3y29Z4MF2CXa4Vn2C6JucF+2N6iLKnn8PzVl?=
 =?us-ascii?Q?mGsHau7A0ebfFVBl2U7F7wo8neK2H9ciOaDx1tFylKX2tnSawfg/QmQC8lzM?=
 =?us-ascii?Q?dWZrepySGbIrYfemI4IrYPpQjR550PnWlKu27PW4Ps6Y8W3whZh6Q1y5nFiG?=
 =?us-ascii?Q?TvVBjedsA9mm5X5VLJldAH+mCoDvV3HuipdQsLPgmOi6PYXi92oz5jHfxi5y?=
 =?us-ascii?Q?fJR1HVVNxiBbn44Iup5/U43XoTTfQYcg8TqMwbznDroLK8n2lLQQAcQWQUow?=
 =?us-ascii?Q?BNWz2n6rxeAwM1wA3zqM9DfH0nmbmRTr+Uq71YAtQwrJEY6Pp6606bRN+5+4?=
 =?us-ascii?Q?9oYZpKW/N8k5r8yb4Cdl88G30Y8Syg+KSO/Pcy5dt1A0rr26EMKUp1bD82x9?=
 =?us-ascii?Q?gqQHulDYHaEXNMkGlOW+g3M1WkFQIqRhN75UiiteufoQIXFMQ3A7y6NW/ti8?=
 =?us-ascii?Q?+7xQpvwH4qErZXVrOyOgmmnJHFKFyf9IsgnqRJAbX1xuL/sSvfJO7hSxTk9g?=
 =?us-ascii?Q?eU5uIGJEqsMGfPSdglV01Zqt4xWtbrg/Trj042hGWvu3HVEFJpMr18zqxvkf?=
 =?us-ascii?Q?V+bAlT4HY+2vIg9dHebl5Y7V1vWqpOvPrIUNBWRoIr+rkZNZH5pncu39Pa/4?=
 =?us-ascii?Q?3EEPX+KarMQPZh2M9dozlWTiPtyNue15chV602GkAfNIfWFaqgmVSoAcy2yW?=
 =?us-ascii?Q?RCIx+vT0nQpDGtzyql9VXCaG5ChmC9aa3E+62bCM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	On4N0TqClZV5QlmCV73eaLO6iURvOL3O96Q1S5i2JJvPmKYCuycDsMPx/c9Ki8kAyBMypktoBbeRgNNDcDcMTuBejFiuvwbCee0bDBGTXDooTrmV4TNBvFsiG00iK6weHRcFzkgSWpznZHWTxZqpv3KKgarDu4bjfh8omy/qMLrwb8bJvfse12pTt95NlI52Ud8AVJCYqy6htzRSNuFEP80PCAeUP5uv01Fff7JIRrPeVGs3GSkBI7rDTmQCYqX2A+1K0GURuFLlc6j2+u1Sn5U7lTKtaD2t9eY/OG7dEfaeil9YSRIa107nJHsYsfZhu3Ytz0kQZ3ByZToFKkPLQYhErV0smjqI0nl1treYo9Z92/ELhYTst/DaDEDZSdE72CU2gBCD6DSFtC97Gsi83YJQDFRj0dqjD55rsqNZy78BZpQ9CiwxbvOQPvNaFtB52gURSlhdArszTqKwonl0afepIlW8VJVkFKqa0BVkxe/Knco0lUoSeQEMmvF2gstmcAHSc/SN0vJrHNqJTx14lhlka1ZxxFBFJl34DfES0UHKviaGlzQMf7Pcqy+/fHxig3w0JrdJ+bw1SxlmWzUPlybqlAPpHTSjiKbBx2gjnSfLC3eC6wGQv+8zKpcDUOW2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b529653-24c2-41c7-4c10-08dc3d4d47ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 19:48:50.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJ+CQHCkAcA7dstsiNnwMCdgCwITfKo1ed4KXGV0EJ9vrZy5QDPZsiUTC7fbpnXf6D1bTgjqOc2q8PObce6l/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8561

> When building with -Werror=3Dstrict-aliasing error is thrown:
>=20
> mmc_cmds.c: In function 'do_ffu':
> mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break st=
rict-
> aliasing rules [-Werror=3Dstrict-aliasing]
>   sect_done =3D htole32(*((__u32
> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
>   ^
> cc1: all warnings being treated as errors
>=20
> Let's fix type-punned breaking strict-aliasing by implementing local
> per_byte_htole32(__u8 *) and use it for the 2 present occurences of
> htole32(). Let's also change sect_done type to __u32 for consistency.
>=20
> Suggested-by: Avri Altman <Avri.Altman@wdc.com>
> Fixes: a1b594ca735e ("mmc-utils: ffu: Simplify ext_csd bytes parsing")
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> ---
> V1->V2:
> * implement local per_byte_htole32() as suggested by Avril Altman
> ---
>  mmc_cmds.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ae7b876..936e0c5 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -58,6 +58,11 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> +static inline __u32 per_byte_htole32(__u8 *arr)
> +{
> +       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
> +}
> +
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret =3D 0;
> @@ -2807,7 +2812,7 @@ static void set_ffu_single_cmd(struct
> mmc_ioc_multi_cmd *multi_cmd,
>                                __u8 *ext_csd, unsigned int bytes, __u8 *b=
uf,
>                                off_t offset)
>  {
> -       __u32 arg =3D htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
> +       __u32 arg =3D per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
>=20
>         /* send block count */
>         set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> @@ -2827,7 +2832,7 @@ static void set_ffu_single_cmd(struct
> mmc_ioc_multi_cmd *multi_cmd,
>  int do_ffu(int nargs, char **argv)
>  {
>         int dev_fd, img_fd;
> -       int sect_done =3D 0, retry =3D 3, ret =3D -EINVAL;
> +       int retry =3D 3, ret =3D -EINVAL;
>         unsigned int sect_size;
>         __u8 ext_csd[512];
>         __u8 *buf =3D NULL;
> @@ -2835,6 +2840,7 @@ int do_ffu(int nargs, char **argv)
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>         unsigned int default_chunk =3D MMC_IOC_MAX_BYTES;
> +       __u32 sect_done =3D 0;
>=20
>         assert (nargs =3D=3D 3 || nargs =3D=3D 4);
>=20
> @@ -2968,7 +2974,7 @@ do_retry:
>         }
>=20
>         /* Test if we need to restart the download */
> -       sect_done =3D htole32(*((__u32
> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
> +       sect_done =3D
> per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
>         /* By spec, host should re-start download from the first sector i=
f sect_done
> is 0 */
>         if (sect_done =3D=3D 0) {
>                 if (retry--) {
> --
> 2.34.1

