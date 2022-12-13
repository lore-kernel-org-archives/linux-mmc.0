Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61100C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Dec 2022 14:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiLMOAJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Dec 2022 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLMOAI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2022 09:00:08 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455DF587
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670940005; x=1702476005;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/9Hl/jTUlajWh5PHYlgTTyGfmDBQBQugV3IwmcBHlZ4=;
  b=a4EaQJIfP3GOGWpIgmxUBypYeB7DhgVdYKxlVXKez4NchD86AB4lziCQ
   lJ91APdoTSBPfmZJwM6FtXvWzjyNogI7dmicgOrCiEN8jRiVIWzNC45HO
   nbBqKhseLuOpkJ5VQQpAgjFRF+jWB8tEjT0m2uO5dK5lOFSzHddujomSo
   Z6KFgKMGS+p1E+vrXIDOR1LOfnZQQCWtYuovSj31Hp+xtvoHaBa3ceO5R
   eUpdYwtibRddzj+uOz6dhPNVEnSdLnIg6z6xNL7Ts3adv3lOeU1sBSzPG
   /THThSMCqC3hbrU1awf08tMKDRGCjNDgmpUEjuAJFWQUq7C+E/4fJWfYV
   w==;
X-IronPort-AV: E=Sophos;i="5.96,241,1665417600"; 
   d="scan'208";a="330633243"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 22:00:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDVV3v5jmfxdo8C5fJbtcWgsUQ/dwOXrmYX50QbLzdtqGfaHGL4AyhXtqGN0/UUO2IDrqBUrF8Yz11TP/Dn01ptCHL0n1C/DqoMSbh8QHQdpzFcjtAnVcG3plbEKklTRExgxY5t7KJPisb2HgCdZRjS2QxW/wotGSiIsjzwjd+F4pUUZHqPYnyYTOAfaQkVQT6p6uP2ap3vcl8yaQwiR7h1pV0pXLff0MHpEr1JKkBO17N0/tpUwJjWz0xZaaCveg8aNDDqIEsvxYT1mL/tbDiDPKn40MdetVMmwhAwjYkH9QYn8a+2Pltq0+bIUEEfdZWLPDSu4fWeQGsSrTRW7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+2wi5snSBM4GLCxPINU/l6moUdDR48iWMEgzKp9anM=;
 b=MtDA2DjQQISij6miMNvwc7QuwwW9f5rNxCrFNnGGC2c2mtu/b8JX6bnUlh71+TXuivptp9YmIyvvVu1xCcTr6K237FZiBKFuZwYxzNVzM7K+eD9+ctrd0ChUKigppvLcMOoHPWxapH3bd+5cGH+UBoS7B1kX3WSiouuLRR2ozZfNkQ4tpm1zwKJa3R/o+aKg4P/4tYcJcBqJKiIV6eigJG1TXwGL+4CRKeDSoz0FFV2VS2zKVnD5B1kJO2jzjj5BYFnp9wHgX4i3uL9A+3L96Sb1vFlv27wm9D1PSYZEF7jgzm7JLKMcwsvpfo2KCJnqArDRQlGScPQRk8gPblXqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+2wi5snSBM4GLCxPINU/l6moUdDR48iWMEgzKp9anM=;
 b=TniIvGeIWwYGjn8vETvM3gD3OqgJbzqWaEgAYT3nwVIieZWaFsIf3kLDJfGV9QOzkv3cApLoCWz9lpVlHOvY04GyDhkrhwmRAZRPk2IIpucEpaeOQv9SHVl9EPxQUq0jFgOy6XON8UJjyY9SdptU+JkCr5WBGzEaAvDgNDk8hPA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0763.namprd04.prod.outlook.com (2603:10b6:3:f9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Tue, 13 Dec 2022 14:00:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:00:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: AdkOCrPej0mSjhUcTiSz6oCfSEK7ywAJPclAAACQQLAAADypIAAxzoEA
Date:   Tue, 13 Dec 2022 14:00:02 +0000
Message-ID: <DM6PR04MB6575C12FBBD33AD36B8290D6FCE39@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <16c9b85406034bd6b3c526070b9fd995@hyperstone.com>
 <DM6PR04MB65756CBEFE329BB16361ED2CFCE29@DM6PR04MB6575.namprd04.prod.outlook.com>
 <1f4cb8a2e7094b249a8f40b7f4eb01da@hyperstone.com>
 <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
In-Reply-To: <21e4fd1b824f42d890df9a965a46344f@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM5PR04MB0763:EE_
x-ms-office365-filtering-correlation-id: fb569a1c-937f-40aa-3961-08dadd1254e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPdQTsQZjpJ21ECTF6Xzks66JdajKqb7SDcVqSOcuW3y0QulZCPvcAoWGa/haI5LRcN2l78Tsw/Lssm6O4NjWy6DNPbwkVBAN2VWRugfnP4hxaVMcznu28cYDFwbq1X4c+sek6C0WwAQb2MclaSaiqK6u7qcxJJczMJxv0+IOt4JEkZHNuV5MedQND03vUAL5n5jy3mHMPXSu6QHFOafYmSNG3ZbtU00cqfDn0Y01zRd3wgaRIdiU0uZVNHs3CIfvz1wr7JP5LM1I11qBE7lujS6fkf8LaM+mRfIc9ZAi4WtJZ2d6SfdlPev0Uj+KFwZ9+ZjSs6fj2uYWcI16Vitm29qXC1weWckHyGSrB8SSV8YOLUr+5ha0hYl4BHW+O58Z8XKgyc+FYu3s3l1Dyc7JjlHLVG6HuKUIC5LI7sWX8a/01citND/7/yIkiUNU8Vdet5hzmfgb4L4DFh9J3jAoW47GFzSHLW56hdtPKRniXlvDvsvykF6czpJD0Rze1FYgPhOmz2rRNLZWiGW4T6l6GToQlIDYtRvbUVZtKrguicUpxh00i4p6MWdQ7aFcg6S4JJuELDdVlNT8xyjSd6DhnARl2zR8t9el9xtPBg8k5UDzkZVLe3tQ7EgZLIHJOjUfTsvhZh3XVcM8oM0E/kKXtHyfBJQR+i+OVPEsH8tFBY+WV/E8RYhgbKzhN3QWhvChwegco5auNeXD6jLypn0Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(82960400001)(2906002)(38100700002)(55016003)(122000001)(52536014)(8936002)(8676002)(26005)(86362001)(7696005)(66946007)(6506007)(76116006)(66446008)(9686003)(316002)(38070700005)(5660300002)(110136005)(66556008)(66476007)(478600001)(71200400001)(186003)(83380400001)(64756008)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4tEupbfsqNillazDeflIAU66+8uptbcd0YT68s1ZPbNzPFKgNG0DqRQMp6?=
 =?iso-8859-1?Q?sDmDQTHUOBbirbmqXwuyleUIqvgoz4WSrlyPitCAzwoQgzmtnFNhy4nqQ2?=
 =?iso-8859-1?Q?kPPF9FTry2Luq0R6UIm0kn+GZ9zRK/sVLqbT9qdOGUR3Fq8Q9B3MVBomq9?=
 =?iso-8859-1?Q?zVOIFlw6r8e5c5NgYi5XM61Vg3mLGI+3VNfqSShW4jjV5LfNVId79XV277?=
 =?iso-8859-1?Q?nk1RT4TKJOYyfIhkz6j8buxEjUPq5WQdwUEMRJMaggDSwKckFKVWjvT3DK?=
 =?iso-8859-1?Q?biEKbd9Xwar/zks5EibI5t5KQ/b5RgKXHhT159Pg6R+IfWlEYtgIsBez0B?=
 =?iso-8859-1?Q?+Pv3wB3RcW2qFWKZkdhVv54Vc1c6Wk1cABI+ntzfXCnbq8OKG3l5AbE0je?=
 =?iso-8859-1?Q?L489z+c/kI/SvKfRK+DyhAjnTeE0bsKuhTDmOP3nYP1DfksdwrU8TxrssO?=
 =?iso-8859-1?Q?cIXWadkru29ecaBvfQN5SbqlF+oA1v8z0Mr0FOLXATElnmxEXV2ZtqV/Sb?=
 =?iso-8859-1?Q?bgqH55d10bYcJhsVZhQdy9PN8AL+8I7w7arQxeGc5W8kMmOohCNuAx9caE?=
 =?iso-8859-1?Q?Omh9H0/2BwoXAKKNJsbvVwVnfjQ+LDLgUFG9gv0Hpt8f8FQFp6OTHQSyI5?=
 =?iso-8859-1?Q?wPSCdWmGoqnntEQicdgO76J6t7t9SOFNStgmaqfmz6dIFVWaZ7MQbMGW+c?=
 =?iso-8859-1?Q?lKXTHkgUVn1Y78xBEeUOZER6ZkFq1GOeQWAWXkzFs39tapnbwvz2/3BoEM?=
 =?iso-8859-1?Q?Vnr81U8Rj1iok92Ig6GIA6ebRwr73Qrw6fzR0H6DKuyhdimX6AMoCirj3m?=
 =?iso-8859-1?Q?ig70IPiYfGou7N7Bv8N0+it7HvB6Gw3mnz/dL1jSO5gqql23k9zIfga4BY?=
 =?iso-8859-1?Q?k999PQJdYp7J2ycFTy6U5m/kNjdZsmRfnX6ythLoP9M4tZblBn1zgyvO0j?=
 =?iso-8859-1?Q?7TQagG0dkpMmipVmBz+5SyHGJ2zvRZHzPD7JDqdlnWpuBIVI79J9qYS16j?=
 =?iso-8859-1?Q?Swrk1H9C92c83ITbpIbpzF8fZcjxiSeW3KqVXpfhpwVma1YH5Id5Fqi/IB?=
 =?iso-8859-1?Q?aPdyEYpQHqjtv2kVRxST2dv7+76t54YHAuP2oulU1gjrvxzo8e6YSGVeMg?=
 =?iso-8859-1?Q?h7uR2Ew++C4m8hO5GnHzWIY7PP4bWLfh9uU0Ji3k1YPY2t2Peqz4GdnZuj?=
 =?iso-8859-1?Q?NtQz/MwRm39tzZNKCpvqWIRMU0xHsmKW/qjiPyH5px5xclnMYnkxi9oQ1A?=
 =?iso-8859-1?Q?3ieGYSmHxegC+jvt0BOM7rNysvEK4+OYREWMCrXEHgsgA0cdG4B46sLgr7?=
 =?iso-8859-1?Q?Xwjcxc0ychz70bajCeSZNyDm1haZP8ZYgjcGPhqEWmByC3fh7+WCT+kltc?=
 =?iso-8859-1?Q?x49qesaMo6K1DSx/B6HOZrmQZD+EG7XjSjlKP3FhJl6S31VBEAH6nAWWn7?=
 =?iso-8859-1?Q?wJizaZWFjMfS4tKGKpIAyPmpuuAl8tL7fmhZ2Pi+ftk4ityPXCnXAPSpQY?=
 =?iso-8859-1?Q?inTTPjNgsFsfAlLO1hTi7r/t3UhC1oYghOQtr5twbxfkYfss3u3Q6ggKyr?=
 =?iso-8859-1?Q?nmOlgTdilsMu+V1Pc0EqK8Q00L7MPJMh7EWo3uSdG8y2F/YTbMNYS+UTIK?=
 =?iso-8859-1?Q?97VEall0c67s83hlm5Gk98GDorHon7igKL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb569a1c-937f-40aa-3961-08dadd1254e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:00:02.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AW9fvz8zqrrEyvs5pc2JLfhYaiZFrQmzM9D/5xItoYk3XpuHt7d39vobhz5mPZIuMnunX7u4S0lwAZYJ5mdVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0763
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > For SD a CMD13 after CMD38 is required, too.
> > I guess I can add that.
>=20
> Just realized that sending CMD13 is not sufficient as the kernel will pol=
l
> because of R1B and clear the error flag.
> Anyway I have this kernel patch for a write flag bit that aggregates erro=
rs
> during polling until card is in TRAN again.
> I will send it then, since I don't think there is a good way of solving t=
his for SD in
> mmc-utils, please consider this patch on its own.
Leaving SD aside for now - I Still wasn't able to get an expert opinion - h=
oliday season etc.=20
While waiting however, looking in Table 70 - Device Status field/command - =
cross reference, I can see that :
- ERASE_RESET - is not reported for any of cmd35, cmd36, and cmd38
- ERASE_PARAM - is 'X' for cmd35 only
- ERASE_SEQ_ ERROR - is 'R' for cmd35 and cmd36

So potentially only ERASE_SEQ_ ERROR may reside in those commands responses=
.
But mmc-utils uses multi-ioctl for that, so there couldn't be any mis-order=
ing?
Which error bits you see in which command responses?

Thanks,
Avri
>=20
> Regards,
> Christian
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

