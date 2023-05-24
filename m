Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A99C77B7A
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 06:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbjEXGrd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjEXGqp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 02:46:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4110E6
        for <linux-mmc@vger.kernel.org>; Tue, 23 May 2023 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684910762; x=1716446762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eny0Bvwpk7duQpx20SKOS1XaIOe/JjcUSadTXkOOrzY=;
  b=F2I37b91ahCvM9tSt/3mln2+rANHa+sN2C1MYred1kZ8n9M2FnsyVFPQ
   De6yNyijQsnnuNIxN+XJoF7YMaX4yOVpimZncX4W5VpKDpCzoz/ze5myO
   Wqan6C+QywS3OcsjUD0T3nJLGKZGL4PcsGwv/J4c5dun7HksPfWSHdCvx
   FQAYLlAwmQD0bA61M5CGcE8rUdSNsA9ALA5PX6MaZcObk3GprNT+9zzUX
   rxdIoltMXgaHG4JBszDHDoDnlQ65rNLS6hc6TvBH4fcDrcTTEi5AX9VZt
   ZMUkP1c60uqDmnpKn+1f6UScboRIxGsLLTZY97FwoebLjwk25jzWCuj28
   w==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681142400"; 
   d="scan'208";a="236456055"
Received: from mail-bn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2023 14:46:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpc6/0dgBGb0byi8O542E5qopIYes4CMDPAI09xq7eF/yS3qUsxD6vjnSXeCO9QsrqTtJySQuyZ676475bNFIviAt8tWnJIoJ8M7ADd1pXaf/mPeHad0fnjv2zMhLrF5vCTd4w8TqsGD+f0HTXZE/pTsRWqj7gaXcCNNH/dmV4tEDK1Lp0zKpprT9jxmcWU4Md7PKiNh1Mz2H2xh6xuBXAIX+R/aXWzgKpfD/cUHLIGDrwgBINHEiNQhA1GqR7mcrc3JyGhnguwHrQiZOK3hl84OH7xmB5ApnfxINA1kSSNgmElELckZnUVTjpGBXM6g2CYIktDskNlop9/K9JBo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1CoujfyZIS3j1zG/qYbls58q2S0P7LSO40ALlZkikQ=;
 b=GjVQPDrkPbJV/d6xNPUXs1ELYql0142JvlK96gYzT9Giop0AnK8/5Y8GOjVn0RiHYtRa1bpYmG6S1VEzSfPFYK1DItWHsTMWukucTf4LWSuTaMrFQ2N+WU1cDOx8F+Rt5T07lGibbO7jCCns6VtWY4E8pw06dUwDjkjj76US7g3/toWg/feGtjGGeejusgcNmBB/wUhhuPdhLvrfxJOSNUpry6xhSckKaiW1+nL7qjdZZhKeA0W4u28Z/E148P9D0DeF2C+Qz19TihLtS2Jwaf/YIegT4C5B+A1sik9i2kQJooqRIaIlZJAxsiFCwV4mVNH2+zM4elX203PpWdnq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1CoujfyZIS3j1zG/qYbls58q2S0P7LSO40ALlZkikQ=;
 b=ifT/T6m2rjuMWVHrCaGkSJn4sN7S2SUkbQ3sZNZbWU9nATCKadviL+dc+XYZuZRfq+VU6rhcIegKiw4+HAMNrpgP9gdPbd4IbneV7hmMbyXkqPwZHHOQ86VEqT/Q//rx1MOr/2TwTwGfk7g8ataUZo5fYxSB/9NokE6Qb/6zjXc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7951.namprd04.prod.outlook.com (2603:10b6:408:156::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Wed, 24 May 2023 06:45:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 06:45:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Enrico Jorns <ejo@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/3] mmc-utils: fix printing OID for mmc in non-verbose
 mode
Thread-Topic: [PATCH 2/3] mmc-utils: fix printing OID for mmc in non-verbose
 mode
Thread-Index: AQHZjPc+sKQ67bv4GUO5O+efGZ+Ar69o/IHw
Date:   Wed, 24 May 2023 06:45:59 +0000
Message-ID: <DM6PR04MB65758B9B6DBCA3861B9BB475FC419@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230522214818.2038252-1-ejo@pengutronix.de>
 <20230522214818.2038252-2-ejo@pengutronix.de>
In-Reply-To: <20230522214818.2038252-2-ejo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7951:EE_
x-ms-office365-filtering-correlation-id: fc66f2fe-e9b9-452d-8e66-08db5c2288d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuwL4pka7CZwQ4s4HaJqrpcCID0S6zpuPZ4A4axIDF9ZTDAYjUpXJNSCcHXBFE9/qpNc5AYIdVL27wAAxvGgDvdxHtvG5fQDTr9ulmkCdUirOBAYh6h8R8qChNt6Kxx1twpIL2OkVYbRCKZvMqkrjusEgVjrH9efA3f823WyRzfWXa04DRN7W9z1ZhiR/2f6a28BZFzHPyGOCvc7fvVUyjlMCU8twW+ZF2LKUUY/m/5AODfXw7iuQzHm9rGQKEYOfWLUZR+I6lzpWvkDeZdvyDGaG0Huus1r8BGp9IG7bI7SjencElpM8SqIAkgvCtsXbDAlX/EaJr0T2CVWbRHv7xzZtzNXrPjxTsQVL9hEr6iIBaU4HrxeKUdR9+RB1VyZWzVf6fl284tAwogP4JaMw5LVPZRN5f4t1/9qaz3k4TpfRXrKA2HQVq7jHZKkWRMRgdfnP4uds7PXp15ip7WRkd7hOQCSLGnpZGdACT14WE5/QoCK2rYyvi9myKYxh8Yvyk61//h2zZ4ZB4DBBxkP0EQwRgEL90PvswRQbkwpbnWmPeUmNphC5Bk5JFM7EM+1f3mtFD4McVfvCwnCE8t9imeuzp6yXinmSutNFy7zLZUlDOUY912jqaW0TqjDVzhS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(82960400001)(9686003)(6506007)(33656002)(26005)(186003)(38100700002)(122000001)(83380400001)(2906002)(55016003)(7696005)(41300700001)(110136005)(316002)(71200400001)(478600001)(64756008)(66476007)(66556008)(66446008)(66946007)(4326008)(76116006)(38070700005)(86362001)(8676002)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXLN47c8isk9MMsPYbREClxUiqQE4ZDdDUKSn5dOElaawdiCh1dAuqX8z5AA?=
 =?us-ascii?Q?LNinwV3hOssW4pzxj8gP496OGT19zt1exiGAIki+1hZfq/kMBXbUvr5Fc9JB?=
 =?us-ascii?Q?ToDn5mh5aJxJQbYPX6cFJoZdEzc3bfgImIXzs3/YZsU7nsyFUedkFaBAvaHd?=
 =?us-ascii?Q?PHr6vN/UpJzzVOUjtepEi7iK6M9z7z1mYP8WFiucinRc/3Ku6TjGwQCxBZv0?=
 =?us-ascii?Q?5GaxhvYhhSQ1BL69hQ9D2z0bIdo9ZtVzVaU7wCXx7FpOXj2zuBS0BvdjmXhU?=
 =?us-ascii?Q?ZhJcQB4ZrXyHOH1PLr9JqSnKshJmZ3PjQcOeznhikDlKetjUQH6KhE3+xjYl?=
 =?us-ascii?Q?wy0NDq19FR2mo/XcRoBhe3oP3m/LwWKkmv8WaOsLgAEsJtdjoKs1oiCvI505?=
 =?us-ascii?Q?jLfvpWPFRsI3iA106WuXamEHCcGoBt83+fYgmJwXjKnFqxzW4rowrYZwSY0E?=
 =?us-ascii?Q?EPXBVMbE1eaNOhtKVnXXkeYr+RaLhn9JxmiHImuaDU01II6yr4t2LMHj/Hid?=
 =?us-ascii?Q?kceMWIub2C5lHXSiLBaeZsiFz+KwCclr/+pkJI6nLRULdswsBOWve0bf4UEy?=
 =?us-ascii?Q?xWDFQrZP9MfXZf2a5N4nl/GxWxIxwPhexPTfUl5/7W4vHW/O/Wfc23Ra9JYS?=
 =?us-ascii?Q?1cE3xEAQe5VztiVwaY9ZCT9ZiYwJLTEiBO2QEQvVirbcLriwsAjtBvwZ1RxA?=
 =?us-ascii?Q?gOdhty+o8Qc3Wcl55FO2ui9wTX4imXMpLz6IMSjsGq1uS5zIGLKGAWZAeYn8?=
 =?us-ascii?Q?IcnHHkWIlEPeJwq76zUYBP+0fUaE5PYf5YlfYea23yZKFVWdNIveldto+77r?=
 =?us-ascii?Q?69J4v4vsfyDCYnFWm4O28TXkm9K6obAN515DZcPsDLAzR4us4dHE/hG6Rdy6?=
 =?us-ascii?Q?eJEuewZ9g0zuLrPjbTZphr4QGmV0DVO//ECJdSdaGEQhJFJhQye2w2bsHVqi?=
 =?us-ascii?Q?qlDgcCP83mmFryyhmDkCa8Mjwy3iffEEJBRSl/82dEO2WmNipKW7rS8hyeKB?=
 =?us-ascii?Q?tsIIcGJy6CcCblxAQaseCj/FG0JbR9/Wi3VHrL4uya8lumJ93RmQp5pfca6e?=
 =?us-ascii?Q?nXnDIsjv3KoYstnZCCI/dFEgoqJ+zEwxmFNthzDebf4CsQNSUOe8Q2L9aUcY?=
 =?us-ascii?Q?FfcehRlI1TxtpmkJL0+5QgcPGERWt5/0Uwk/b/5UhhFZoG1M4sAvkk7/rEB7?=
 =?us-ascii?Q?GIgV5+5djcRiLNm2nAEzcN3UXkDpTL9lOxIXTTRtHnho7aMzD1QluRoY2J7O?=
 =?us-ascii?Q?zW2LdpWHkl9r9VUWShKpkJHnH9WW5P9QSOpMuhkYZNJP+nvEoJqryLUUPpSx?=
 =?us-ascii?Q?Et1TZu1bak+d+MirX0mJGdFWJrnp6t5KjLuCSbAyNt0nXhplMJi2SHrosqDe?=
 =?us-ascii?Q?8/TRmOnFAKbdc+QsMO1BXQjLbLtd2h5wHi8Dmz8nuM9nI4AVp0tpjA3d/GHe?=
 =?us-ascii?Q?f2YTIRrovY0G6Q7o/f1MPECbDqMrNyvwECYBeH32rGHZsT5pP2HnvEEeye4k?=
 =?us-ascii?Q?1hLvg5S1OjiSc5oLsi2/xvx/UnpiVMqfEO9ANUBf40808AtE+IORRnbyrhWt?=
 =?us-ascii?Q?DH2ogcs15K5PIWCz7ScFb44xVbb6Cwhjo0A4p7Fk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TAnbtiJ+IQexCyrR0KMltC9GWU4s7I9dCbDAQxV+OBfLY16tk/oK7Nr/gQDYaMYZzbpXDFUOnFNU3KVKJ8udtWL0g1ZbyOAY6wG9sOq8eePpY4xifkAerWmYWwIxlt9r53us5BGO7WfJ7KpbxZfEM3Kfdzcy1GLEbpbIgW4ZeJvsqmvHh7Wf0DCpvAmihS51b+rlvo1SHYY9ZUpL2tZLGbOVXSLwADGmvxkt9biE/gqqWoITSjwkwO27iba7HG9XWy29nA8mchGnezZ0dcymfCRDY+vIjuRb2x0udYiEdxZqbQxX8LKpEiTmBCI5HeU37lnWhrkCvawOGlJxjLINJI+2bL6nYCdqufBrSCm/Uoa6s2LBQ4YCrHgRuQs4tB9EUc3d1XLHVnn0Hfr2rQBYoMudeYDSDNutbezNeFtLFhKIKhljNvHy5cHTT2YNFrHYVaNiMbifZ/HNRC9zmY4eAHOQphovBFGCcT8slF3YZ3fSYjkjptPhRpqqRjZYGxnnos33xlSm2a6HNw4A6rnIBWRvUDsEp41/SECN7vjzWTC7MsqGXw+pZufhf36VGfc9OXhm1RiImqFc8QEnd9mvHsyFqyD5EdSegEdNFoXNXfYDmWerF/dpF9/kVZXpfArXwfRb7XJNfDbtBaHuqjYE2g8N6eT9VUjf+zkyo0kCDLWTF0/iZ6vYtDq0KLk8WGYlH4VZU+fhXGDFlkxzmHfEVrq561Ob/LkWkrH2SzQvvg6T/5bMmXUcw7xhbmU5i8P2j91KwQf/QvUyxTbZLPQDS9vSKPDln3vCK9HjoYDz09uhKSrG1shNMyBcyHdwdAjc3Mj2LFTs5Kzvofu+45IIoBBQVv3QgJnoERxKthtbQrI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66f2fe-e9b9-452d-8e66-08db5c2288d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 06:45:59.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgnImwZiUeTXl3aOIYD/gp2HqIrWyeA3Iz7DOH9MwGr8CTc0SLhhnVUpFRpG9urd+l1Nit7nY8+4rbDahA9jtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7951
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>=20
> It is parsed as an integer and printed as a char which does not really
> make sense.
> E.g. if OID is '0' (which does not seem to be uncommon), then this
> prints a '\0' character and makes output nearly unreadable/unparsable.
>=20
> Also, do not print it like it would be a string, instead use 0x<digit>
> format.
>=20
> Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  lsmmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lsmmc.c b/lsmmc.c
> index da9d69e..cea43af 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -636,10 +636,10 @@ void print_mmc_cid(struct config *config, char *cid=
)
>                 printf("\tCRC: 0x%02x\n", crc);
>         } else {
>                 if (config->mmc_ids[mid])
> -                       printf("manufacturer: '%s' '%c'\n",
> +                       printf("manufacturer: '%s' 0x%01x\n",
>                                config->mmc_ids[mid], oid);
>                 else
> -                       printf("manufacturer: 'Unlisted' '%c'\n", oid);
> +                       printf("manufacturer: 'Unlisted' 0x%01x\n", oid);
>=20
>                 printf("product: '%s' %u.%u\n", pnm, prv_major, prv_minor=
);
>                 printf("serial: 0x%08x\n", psn);
> --
> 2.39.2

