Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A9C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 02:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657AE603E7
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Nov 2021 02:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhKLCFW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Nov 2021 21:05:22 -0500
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:25249
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhKLCFV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Nov 2021 21:05:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr4UVXBX4OkPlO+llEl1F+HYGiwj3ctx5uziAQMbzpxXLuDcnf1L92ovLbthUBwJduvC718N37h3IylZkurf3ro4tu/Sw9D9dfJQt81iK3R8gWXn63vzKank//11AwM3q1oweskt9RgP2Tm88wHVNfkWPQxKDiviOAX+mMKy9+WMK5dbCZRoN2/32MiSC4Z5uVg7ZRcUIxTzNoSmG0Xksg2krLPDaYFz85b7D0yzl1sUH0oOGVc2G+PJSpx4Zp3o03PsA18uMaIPK5Eg4txQIYJs7TK0A5YnsWhUC+gira7VIMzf1orznpeXqKgRyEezY7ewVXib7rZgPFFBfApuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qWOgYupH1B1REQYJHn+GSjFJ2HB/7uA87C/9wwg3Rc=;
 b=iWDwwVTfnDm+C0mKzrXJHtBYKt0EmxVzVG0hjR8q0e6dT4G+cIflZfatd/Q2YT7+ERjLq/jA0royxmtatcP28URG8mRasQb2bz1/9chQeMrABxsjEu02MnvRr1iYcQghZx4G1dawfy/WYDqv5GtqH1nlUJcKvJY246qsTJbe1P/Ov5YyMAPZiDugMZbSOd1tDjmJqUaQa4zFAPsj4uVqaAZvT4+c1me5WBzTELU+l8N52l+UYasP3c7sODXhJ0RBwZYSmWY1w20H53W+1+UPcF2CuU5CsitG3L5ifvQ1P7FuoMC0cQHwNVjKksLgx1iSdBMGANNZJxgkb3mnWmZwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qWOgYupH1B1REQYJHn+GSjFJ2HB/7uA87C/9wwg3Rc=;
 b=P+Vaxca6+T7UChblte80+8ahqSW4N71bdYO5b9PPzBOPVaAozpO+2nkGWAnM1ZTjP7r40PqwZQ9LNk7f7d2xCC6ngzRtgQzAGsbMskXgBh/JNNjuLPfGRE2MtqzIuknseuowtzm5GF4BOcgJ++9HY5yf4ws3AdN8euKBKRzfQsM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB6380.eurprd04.prod.outlook.com (2603:10a6:10:10c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16; Fri, 12 Nov 2021 02:02:29 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::94cc:8972:12cd:5bef]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::94cc:8972:12cd:5bef%3]) with mapi id 15.20.4690.015; Fri, 12 Nov 2021
 02:02:29 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
Thread-Topic: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
Thread-Index: AQHXyuCSPXRr3b+NwkGp+YnL4lotMqvmVzEAgAOGDyCAERhJgIAERmNg
Date:   Fri, 12 Nov 2021 02:02:29 +0000
Message-ID: <DB7PR04MB4010CDB8977130CEB5DD23F690959@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <1635302841-18997-1-git-send-email-haibo.chen@nxp.com>
 <34233159-2931-b02a-ef16-1029d8d7829a@intel.com>
 <VI1PR04MB5294AFD5A60F98A73E12A16290879@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <74c896b2-5e9e-b1c9-485f-9c4ffd7d7072@intel.com>
In-Reply-To: <74c896b2-5e9e-b1c9-485f-9c4ffd7d7072@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5944a5fc-a988-4660-6200-08d9a5807b81
x-ms-traffictypediagnostic: DB8PR04MB6380:
x-microsoft-antispam-prvs: <DB8PR04MB6380ED38299C32073CB6D0D590959@DB8PR04MB6380.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdzuWWEXAEoLi4itkbcsA8VJuunhac96m/V56vBCNce9LYTvz3FMgjgigQlgxD8TIgowd/gAaN3uqFfpAOk/kyZ/CvRb8XzYzH5XBlw3+bqcib8YfbpbmqGB3q5vUlbue2Kk5MaiCr6nxwPDvM7z+KSeN99V2/cfW85sN8JbfJDpdCPYV8N/1QSkIZjH/NHyOUKcTyBAOR1ntABvwDMWQkjDNzYghx30VVyI35J8xJWbx1rCSUNztA2Lqmkha17gG4ohSC49109bRqlB3YWm+RjMiPdLNIHV7IqZgT6nQ4LfFMUQq6IvqNb0qSsI6t+eZfG5kxi4yfEHMdXuXmUX5cigILXXAVqfVmIHohnzmy0946OuoMFXuobr6o3ihNoY/BC4Yjw9AGKt51X8Y+5ZbvRStEyu3LkuP/BG+HYISHestWL/13BjTkuf3mXs9NM49RoRIuQVHuYZBu68witQndZu0x/t4bXlCRiwHh3T15T+9CKhdAK834Wx+EsHn03KKtXyYfuqvD2pjf8qjIHPDS4d4DVG6EbTD/7tWQ2qISoKw7tyUwViKTm9hClYW0r5tixz99loMxpluBPqgR2LPPsml21RMQZHs61ug/lsalriy6LzmUguu4y8tAYJ5l1FmuL7RNszDsjDROo1leulMizCknae9rihHp8/Vku6nUz29N1GeYn2tPT47MFKKSkhoAOoI/EbyPRuQCxH5zAtjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(122000001)(316002)(64756008)(66556008)(66476007)(7696005)(83380400001)(66446008)(38070700005)(55016002)(86362001)(38100700002)(54906003)(508600001)(26005)(66946007)(8936002)(9686003)(52536014)(5660300002)(71200400001)(6506007)(99936003)(2906002)(8676002)(186003)(76116006)(33656002)(4326008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?by9HVzFKSUdIOWlhTHpId05jZll5TnQ5WE02OU9HcndEVHdsa05mSWR1czFy?=
 =?utf-8?B?WFlOSzE2TER1MHFNQllNL0hhZTVTT3lmVGZzVmhuZEZBMkFXV0FZOHM4S2V6?=
 =?utf-8?B?VUNWS2Z5ZnR4VDJhcDcvcjF5WG83WWxuMVVrOHNOOENsM1paZjMyT0U1a1VI?=
 =?utf-8?B?WGM4SHExY1A3Wkh3UGdpTzNJZ1ZjRCt0QjJJWXc3YnNIUW1LTlpvc0tHdWtt?=
 =?utf-8?B?WjB6V2NxRWN1NDdFamRKRjNiNmxDL0YweVVzbFBKMGx3VExmR29qdFk4eEZ2?=
 =?utf-8?B?UVpMK0lyS2NBcDZqOE4vaUQ1MnVTU1dFL1ZlZS9lM1BmTm9UK0RwTmJFV012?=
 =?utf-8?B?bWNnbDJWUVJwditmZGt5ZHEwamkwQ2NZdThOZVlzVm4vWWU3SWZPbmswcnl2?=
 =?utf-8?B?N29BT0gxclRreXRyOTFGSS8wbkhQYWVXeGFzaHN4MW5yWjROUURvVThHMm1W?=
 =?utf-8?B?VmhvU2xqbnVYWW9Ya0dlbUQ1em02b3ZQUzF6RHAxbWdXdzJrTWJzOFE1OTBT?=
 =?utf-8?B?U3lOc1BkZlZXOWcyU0RHMkxsL3RwNG9xdlpnOHlxcFIyQ2pENG5aTFluemtu?=
 =?utf-8?B?emdqOVovRzBxbjhlSHRXVjFTcW90bFFWMGNmVkYzR0MxcnRIVVgxM1BabnNQ?=
 =?utf-8?B?N1VIUGRrN0QvYWhGSnhFT2FSN2lQbVJUZ0pSZG9sNzVPdXl1dldlV0YrSmRr?=
 =?utf-8?B?azl0blJQQXhGVk8rSUxWS0VyeTkrYSs0cFpwR205K1ZKM3ZsUW5qUHhOQ1Rt?=
 =?utf-8?B?eGE5dVY3TTR5REVHbVBJdlRldDFEYkYzVmRlRDRXcDhyRE9CMjFVRG8zWXpx?=
 =?utf-8?B?dG1zS1lORDZueXVuVUE4bmhuZk5mNUttKy9OYXFMd1lPN3FlaUlaVGtNek9U?=
 =?utf-8?B?N1c0b1VaR3kwSyt6OVNPRlNvamF4dUJ3ZDFYam1UcGE4KzlualV2VVk1RkdL?=
 =?utf-8?B?dFlCRDZjdUhBbWxscCtDa255YWZ6QjJncU1YdWRVd2R3ZGRSRVIvQU9iOHhx?=
 =?utf-8?B?elovdGxWR3lOVzBzWlprSFBpSWNOVHBIb1cyZXpJVzlNRXB6aWJjUFlMS2Rz?=
 =?utf-8?B?M21iNTd3eS9URVIwSVBZclNUU2RPMjNLQkEyYUFrVmZqbzZtYzhSNkVmUGhJ?=
 =?utf-8?B?RFlwRjhsL2FkeCt3NGRKVmIyV01TMUJxaXVwZlMxcmFMZ0p6WEtuYllUTG9L?=
 =?utf-8?B?cDRwQ2lzZGh6a3NVRnVzdFRLWlRwanhKaUZOL1JyTDJ5K3VNN0VIdmFmT092?=
 =?utf-8?B?N3V0MkU2Q0w1YXo2U2NiR3dKK1B1QngvamVFTEFaSlFCZU9lbzZBME5kcGxU?=
 =?utf-8?B?bnlCcUdxb2I5cXpJbnNKaUxPaVB4eHdIOTVIWlJiakJrSlNBVFFVcHB0VHVJ?=
 =?utf-8?B?c0lPYjY3dG9BNFl6dVZhbm5XZDBMR2Myc2QxMUtxT2RyRlZiTDBKZjhEWStM?=
 =?utf-8?B?K0Q1Y3cwU0g0YVF2NzhXNE1uMFBZWEZiWTgxWlhlUU9IdGVVMUJtdzR3MmVG?=
 =?utf-8?B?WTJIbmY2ZWlnODBIZlRFSzdpRjB5OXo4c3huem5RRmJ6WTI3ZlE3cDB6dzNB?=
 =?utf-8?B?KzNLRzRWdUpyOGtkaS9WZncxNDRITUNyc2NZNDlOSVdYZnFYQ3k4VjQyaENU?=
 =?utf-8?B?bTRXWFJVVXpVUzE1NW5kVU91cFhKUHBkSmtYSVIvS1FYdGpDQUJ5TDdDSFp1?=
 =?utf-8?B?YUN5MyttcFFQZDFIZG8yWVFWZ3R6b1VnalR2TzlJSmhhVVk0cmlybGlPUzFn?=
 =?utf-8?B?ZjVXbXRlN3BxbEZlSmduWlMwM3FpN0wyRExpNWJEN1Y0T3JOeUtWd1g1L3o4?=
 =?utf-8?B?ME9LVDBZS1U5cSthZTlBTnBFcFFrSnNZTFRGZDN4d2dmais3Sys2TG1NZkht?=
 =?utf-8?B?OTI5dHpCaS9lZGpRYjFFb01jZ3FTUENHai9oSGhKS2ZkWTl0WTJtQ0hiMTVN?=
 =?utf-8?B?emJ5OUF3dTlsbEc5L1E1MmNBeXM4RHlxZ0JQazE0ZzZ0Szk2aUJNbFBkZU1M?=
 =?utf-8?B?VFZrektmSklma1ZuQVk5WTlZOXFHZDc5TzZ0bGFFNHg0M3ZlRnRmRTB0MW1L?=
 =?utf-8?B?bzVXRUptbjNiVEhaZzN0dzRtVjN3MDR5cWhFOHE5UXpTdmtEOEorUG9ZQ1Zm?=
 =?utf-8?B?cmdlTzA1S1pmWlFkQUY2TmNibUFHNTdpakZaZ2FxRW9seDdaakdaSy9pNDE2?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=SHA1;
        boundary="----=_NextPart_000_0261_01D7D7AC.64D7F3E0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5944a5fc-a988-4660-6200-08d9a5807b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 02:02:29.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+neZg7Apnci35pcf7rvIkMzAjP2JcpPgkBNqB8acZNazexBvWE8fuuDc9rBbD7J+tgw6JGuqlieYKoUY6lfnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6380
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

------=_NextPart_000_0261_01D7D7AC.64D7F3E0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: 2021=E5=B9=B411=E6=9C=889=E6=97=A5 16:42
> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
>=20
> On 29/10/2021 14:40, Bough Chen wrote:
> >> -----Original Message-----
> >> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> >> Sent: 2021=E5=B9=B410=E6=9C=8827=E6=97=A5 13:50
> >> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org
> >> Cc: linux-mmc@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> >> Subject: Re: [PATCH] mmc: sdhci: disable ADMA when PAGE SIZE is 64K
> >>
> >> On 27/10/2021 05:47, haibo.chen@nxp.com wrote:
> >>> From: Haibo Chen <haibo.chen@nxp.com>
> >>>
> >>> For ADMA with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it
> >> limit
> >>> the max segment size as 64K-1. Currently, linux kernel support
> >>> 4K/16K/64K PAGE_SIZE. If choose 64K PAGE_SIZE, sdhci in ADMA mode
> >>> with the upper quirks will meet issue.
> >>>
> >>> Though mmc driver give block layer the max segment size through
> >>> blk_queue_max_segment_size(), but in this function, it will =
compare
> >>> the argument with PAGE_SIZE, and will choose PAGE_SIZE if the
> >>> argument is smaller than PAGE_SIZE. When PAGE_SIZE is 64K, finally
> >>> the mmc request queue will get 64K as the max segment size. Once =
the
> >>> sg data length=3D64K, ADMA will meet issue. For this case, need to
> >>> disable ADMA mode.
> >>
> >> Sorry, I didn't look closely enough at this.
> >>
> >> For the 64K PAGE_SIZE case, did you try blk_queue_virt_boundary()
> >> with a 32K mask instead of blk_queue_max_segment_size() ?
> >> e.g. a hack for testing purposes like this:
> >
> > I test on my board, this do not work, I still can see sg data_length =
=3D 65536.
>=20
> What about tweaking the logic to write ADMA descriptors?
> Something like below for instance?

Hi Adrian,

I prefer this solution.
I test this on my board, it works fine.
I think you can send this patch out with my Tested-by.

Best Regards
Haibo Chen
>=20
>=20
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 269c86569402..07c6da1f2f0f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -771,7 +771,19 @@ static void sdhci_adma_table_pre(struct =
sdhci_host
> *host,
>  			len -=3D offset;
>  		}
>=20
> -		BUG_ON(len > 65536);
> +		/*
> +		 * The block layer forces a minimum segment size of PAGE_SIZE,
> +		 * so 'len' can be too big here if PAGE_SIZE >=3D 64KiB. Write
> +		 * multiple descriptors, noting that the ADMA table is sized
> +		 * for 4KiB chunks anyway, so it will be big enough.
> +		 */
> +		while (len > host->max_adma) {
> +			int n =3D 32 * 1024; /* 32KiB*/
> +
> +			__sdhci_adma_write_desc(host, &desc, addr, n,
> ADMA2_TRAN_VALID);
> +			addr +=3D n;
> +			len -=3D n;
> +		}
>=20
>  		/* tran, valid */
>  		if (len)
> @@ -3968,6 +3980,7 @@ struct sdhci_host *sdhci_alloc_host(struct =
device
> *dev,
>  	 * descriptor for each segment, plus 1 for a nop end descriptor.
>  	 */
>  	host->adma_table_cnt =3D SDHCI_MAX_SEGS * 2 + 1;
> +	host->max_adma =3D 65536;
>=20
>  	host->max_timeout_count =3D 0xE;
>=20
> @@ -4633,10 +4646,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * be larger than 64 KiB though.
>  	 */
>  	if (host->flags & SDHCI_USE_ADMA) {
> -		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
> +		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
> +			host->max_adma =3D 65532; /* 32-bit alignment */
>  			mmc->max_seg_size =3D 65535;
> -		else
> +		} else {
>  			mmc->max_seg_size =3D 65536;
> +		}
>  	} else {
>  		mmc->max_seg_size =3D mmc->max_req_size;
>  	}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> bb883553d3b4..d7929d725730 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -340,7 +340,8 @@ struct sdhci_adma2_64_desc {
>=20
>  /*
>   * Maximum segments assuming a 512KiB maximum requisition size and a
> minimum
> - * 4KiB page size.
> + * 4KiB page size. Note this also allows enough for multiple
> + descriptors in
> + * case of PAGE_SIZE >=3D 64KiB.
>   */
>  #define SDHCI_MAX_SEGS		128
>=20
> @@ -543,6 +544,7 @@ struct sdhci_host {
>  	unsigned int blocks;	/* remaining PIO blocks */
>=20
>  	int sg_count;		/* Mapped sg entries */
> +	int max_adma;		/* Max. length in ADMA descriptor */
>=20
>  	void *adma_table;	/* ADMA descriptor table */
>  	void *align_buffer;	/* Bounce buffer */
> --
> 2.25.1
>=20
>=20
>=20
>=20
> >
> > Best Regards
> > Haibo Chen
> >>
> >> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c =
index
> >> b15c034b42fb..4c3a9d999500 100644
> >> --- a/drivers/mmc/core/queue.c
> >> +++ b/drivers/mmc/core/queue.c
> >> @@ -376,8 +376,7 @@ static void mmc_setup_queue(struct mmc_queue
> *mq,
> >> struct mmc_card *card)
> >>  	 * both blk_queue_max_segment_size().
> >>  	 */
> >>  	if (!host->can_dma_map_merge)
> >> -		blk_queue_max_segment_size(mq->queue,
> >> -			round_down(host->max_seg_size, block_size));
> >> +		blk_queue_virt_boundary(mq->queue, 0x7fff);
> >>
> >>  	dma_set_max_seg_size(mmc_dev(host),
> >> queue_max_segment_size(mq->queue));
> >>
> >>
> >>
> >>
> >>>
> >>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c =
index
> >>> dbe87995596c..47e0c0156b94 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -4187,6 +4187,12 @@ int sdhci_setup_host(struct sdhci_host =
*host)
> >>>  		host->flags &=3D ~SDHCI_USE_ADMA;
> >>>  	}
> >>>
> >>> +	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
> &&
> >>> +		PAGE_SIZE >=3D 65536 && (host->flags & SDHCI_USE_ADMA)) {
> >>> +		DBG("Disabling ADMA as it don't support >=3D 64K
> PAGE_SIZE\n");
> >>> +		host->flags &=3D ~SDHCI_USE_ADMA;
> >>> +	}
> >>> +
> >>>  	if (sdhci_can_64bit_dma(host))
> >>>  		host->flags |=3D SDHCI_USE_64_BIT_DMA;
> >>>
> >>>
> >


------=_NextPart_000_0261_01D7D7AC.64D7F3E0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
MjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIw
S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhw
LERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlz
dHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VD
QTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCC
ARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVy
cHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9i
YXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0B
AQsFAAOCAQEAJpGYHveFzmgLQ4J62fcmPkd4wJ8urL46itMWCgyLBPRARYB9oArCqPd4j0Yl0RmS
F1oNZgVDYQTy2aLoe+YGm23TkdJsTx1ExTxtv+njRnvvlSXMMULlOIt25/Vj+vTZ/wjFDq6PJOSZ
MSQHaVHSUrkLBT1H0pBmCA1Ecjuo7gUpG5T2NqD5KJP083pJZ+nogA9TVC9Ob+jNx0d/UR7UgRLf
KOxBG05AakTa4luadPIRktiULtjzG20WDhvAIg4M9w1+9SV+LpvvqBtkovpCfj9Rf4pNRV1CjjTY
AFIH0s3Q11HnFd1UNHKUvpp7/SrTyxaCXBO68U5aJz4zDjwIPzCCB+swggbToAMCAQICEy0ABsdV
/0AV+3f0TucAAAAGx1UwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMTA5MjIwMTMw
MTRaFw0yMzA5MjIwMTMwMTRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
MjkzNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6VTRRCbJgUEuoR2bppNZQc3ghr
l0pDEZjK8uaayFYadelTc6iWe8EBLWrrOWd17yNeXc054yw+Yu8eI1IWMEE/mo5l93Kw+BkuCUda
vpqZUMOvaPDKkHNPBNPJ6AP+vmZW8p/46dxo6Nx6xGzkpbUZ1Ju1a9LuxeFQBNNvV54wYbFmoKJF
eQQ3RZdEafNucOw8ukTyWurcC8fPUQwqE1sFRdtjLeJWZBtrvNim4oikb5UFxcmoaQkJ/sqoJGZL
+bR3ZZx3101+Y7RJp56hfqT1eqkJkc7OTz+tsZx3p1a6r266NCB/RBIGVD2cFmhUs2Uitp/oB+9k
BhycuX8wowECAwEAAaOCBAowggQGMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwQQYDVR0RBDowOKAiBgorBgEEAYI3FAIDoBQM
EmhhaWJvLmNoZW5AbnhwLmNvbYESaGFpYm8uY2hlbkBueHAuY29tMB0GA1UdDgQWBBQY587dMxoS
HzI5SkUyoLrumaVa5jAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSC
AT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1
LENOPU5MQU1TUEtJMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6
Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBr
aS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCB
uwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlB
LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24s
REM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
ZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2Vy
dHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAsjJuJnMzvA59CAlY
87eQCOafWbMF4HfC4oobtAqboB48BtCZ5dOeo+X4XQRaSmTwFJ2hZjX614KFnRGXLk/nDIY4pp8+
fqfgHKUdY1ceVqs+Kjtabk3gY8zq7PtFUsAkwp4OW23kwphh7Awx1tf3XRZeOqwiVuk5V57GT8Tu
dKNiOZqut3mrcdZINNUsqjt7ZA82r4ov5MbEBHeWVjo7CeWbgZFZhKhMKC9+2DKEUkdDJUcDYqxz
+Rh+6B+dgxeYkTGIqHELhkMjMCC5SwRNHfCxXCI+qRy4zIAo2K3V96zs3ungqiFZuFrpatfSBfAL
d86AIrOgsHhvOB0UU1W//zGCBLMwggSvAgEBMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlz
ZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3Zl
bjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0ABsdWyH4wxYEw
yQ4AAAAGx1YwCQYFKw4DAhoFAKCCArkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjExMTEyMDIwMjI1WjAjBgkqhkiG9w0BCQQxFgQUvDJfd6JzjuL1oN52Qi6f14ZG
/y8wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgd8GCSsGAQQBgjcQBDGB0TCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMIHhBgsqhkiG9w0BCRACCzGB0aCB
zjCBtjEcMBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoM
CE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzAR
BgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNj
b20xCzAJBgNVBAYTAk5MAhMtAAbHVf9AFft39E7nAAAABsdVMA0GCSqGSIb3DQEBAQUABIIBAAbj
URJoM1l3M6yrg71XgblCkh1ApdcG5L6Mpkp03RRjEp2odmQWAt814hvCe2/sLmtII+Fl4533Pfm4
MZUpjLb0s2oKGk31OGSSNNHN/O5WRKmj+IfKVusGkWS/lkXQKBhqJP8fJ7/VbFFX4SqaLIptJmB3
g2z4785CD4s2HXw1sKCYLdi99TkFB0Em8pq2+m8voS85YN5k0I5qQ8RfgCUtSyvSzc2s0XKW3sMu
+lFGKPQTjdrsaUcvGq5ewAcAOqkHYCU1W/CRGW7PCNB/ATeFSCYHuzDlbNHTVkzhHlJ0ihcOnosO
t/HLbDTGSVvIMDN+hIZtpXH9SH9a/dfx7oEAAAAAAAA=

------=_NextPart_000_0261_01D7D7AC.64D7F3E0--
