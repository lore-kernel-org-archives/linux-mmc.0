Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEFAC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9FA61183
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhIUKmN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:42:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19664 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhIUKmM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632220844; x=1663756844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LCNRx89MQ8nh12o3A1C0QoEi1wvVunfwRrYWnfXLqzY=;
  b=bJ3AtsEQCs32WrbdtsBbqInCgsW9pho6+ltNy1sQVPTS7NGLTweAixn1
   qH3Ec6ZUHrm4mgTGaZKjGotJgoKHwycnwfvjZlXy3VPPbWqC2c5irvbFT
   PN7S9fnMliLW270XtBKFly8pxoak6NrRZbF97gnz+yM6ajI2jpOC8OYuU
   22U120bBShrmCXLCchLgSZyB4nVJJTwKYsuH8j+CF3jTCrQLEu5wnDEKN
   zJs39VjtjUjvYQG3nWq+UVfqGdZCPUSfAcMhtRXteb7KCA6wpypPt2IGm
   CZoErUIJxBNpjXDik4JYQonuBVXJz4hO4Q0q7dcE2FBTXRidxipjw8T07
   g==;
IronPort-SDR: IQFixpjzbzjo/ckhmytljFyOPzvOgB0CBkGkIdvcvd5mOpiYqHLUG2jTATP5PbyxUdvbaDgKGh
 +b1Q04m5BXoLTOITOVAJjLaJV8oaZ0c8zWsAygKveHtCLYNqSdg+DwSGuWZ+C9cQYySuZ61XgO
 YTJuQ3z/iCalkGUjm0L5LRKUAaYgl2fMNO/iGnWXb2Gxh+MKbeD19yIX6toByqA2JAfA8O2ycy
 2zLp5WU6z68raikDifd1Jckp+W8JpaVnD1SXnZvv8/qyY60tBEBJNwQhyYMT836MJzNvjBTNhh
 oY+zcZByuk0K2ywsMidFhJ1i
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="137341001"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 03:40:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 03:40:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 21 Sep 2021 03:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlQ1gu4ddigT5L0B5VER5g1raLRPW0dBs9bau6d7Odgujw/0EGXdnecwf+BPfd1aJvQnRSB5CUvotZL7aYRK9XgtgH/YBz2UI4tw9xmevysvgSp6D+NxuM6n3AuikoIARiSIZjukwOX1C1xiQr2vwH35nx5HanoaXIJBIyS0vK+MW8kQedtxFjZnC+Vwlv8+BcY3SDAj8iYi6qlThnkMYs99opWU+BGVMahukjrtIIkNwdeaMbSdWc6MCRcweIe+iwEgrByH+kfJwJSOLY+mLKAEtPeLPwbuFkSJwntN9vokDMeH0SVdlYq7tu4UD4ofTaYDOYZh9G71GKCidugQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LCNRx89MQ8nh12o3A1C0QoEi1wvVunfwRrYWnfXLqzY=;
 b=hSvoBOtdip5kX+eKQwVnSzA39hfQktvEMzSRzNvMiGDIDLqX4bgQDGJLi3nKvV5dysZHDOVfcHJ+YTc31skszE0HbG94+rMcbvSlNf19B3ucT30ocYKJeSHj+teKtiG03t7Z06DWXg79zXDlcvLY50WseYiTiknAZRWIqs9dbNIpRgTLDzIPz4E8emKzBuqdESihAMFrJhx3mdIRCj4hfijeBEfiQSAbB47m5m5xQNJiFyYLzPCLxZbGHKcIisw95oF9TZxSpiyanmvRMsurSTN0vYqItfbgU6Z3QuVh3C0yG60jqYKNS/cXnXxLSyyFQ9NKzXIwF604HCkGt4oHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCNRx89MQ8nh12o3A1C0QoEi1wvVunfwRrYWnfXLqzY=;
 b=BKfMxoxIGJkgtkQ4W/S9ZtdcEJQDY/cuNkjCBlEIdsldBfytXL5mpxEoYJL81PaukFRqeBWuaX7WmLpPXWAwnYOCRlGTyIvS3rk8fwmho/lmvLYAT6pm5yzquT8BmT5Fh5h2pAdOtiTatwFLwdlmYUhLthcy5xtI1lI2XFgtIpo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1822.namprd11.prod.outlook.com (2603:10b6:300:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 10:40:40 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 10:40:39 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Topic: [PATCH v3 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Index: AQHXrjGL7H7SjRHDDkuJmN4bIc9/5KuuTdgA
Date:   Tue, 21 Sep 2021 10:40:39 +0000
Message-ID: <b83355ee-cce3-0a7d-a048-147dcb44b012@microchip.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
 <20210920150807.164673-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-4-krzysztof.kozlowski@canonical.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48ecc45c-b6a3-4052-c573-08d97cec4136
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB182238D3C66B45CBBC96365098A19@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6PfpORHmJLrEAgRAKRD1WpGeswiVh7wIULpFJpJfJaUnTT8dciIf/klWquovqxNBGKOSVIdnuj+08AVj0BEHUhaGmJyWK5YiVrTERkEHF7/D5ebtwbh5kfw0RgoXOKfudNAUq1N2nbYrs8qpJFgU8KCb3diN0JPbG3lF85gKCqgD6PGv0zxwyxwl841BCmKzFAh/HA8JGKsXcxU6UkoGHHlv8NdCJ6tq4Y4VThz93pju7CUNigyKU+fx7bVSUrqTUFw8bDK9dNwkdP06IBRln4XomI7gxjPsG7WhWYAIj1T7qxUGji1cPwCLlGAA5bM9/6hRhsRQurHd0Ax03Kmi5cIgNe02GFDnhbVFwExa/HU0bUAei8EnEfv+8zueQw8iIdX9wfcICD6INW104Dj647P+yG6SCQof690htPZBWZwxTpja2nniT7lj4qvpfrv+AdD3HunKLEem+AIeWa+D9D1xPR4YORSIE/hKgM0aQVbqB5r2BQp2oW0Th2En8HRTQFowF/c05Iyu9cB8AbG5C+GrPETTKtSWIV4S74U95Y0ti3Qi1LqYcLd85m55Hr+fWFxbH+NFlbv2otG5TxpqGtISBN3LT585jNKC4GPezTY9VFkfgS/8qtdFL6R+jCQne5sUP3JpPpPK9UeGjdFOmtCOsBO1WWJ9iGZO2lNUZh2RBn0gmZL2YsTT/B0qPw9tKSm+cdlg0F7EFBWNFZ39B+eURsAo7qSgtrzhQdi56bgKjLPnPE09tq3F4cTekLbv9fKrLonHGeUrorkMKOMAGSIu/xsrzjjGifyZi/kdSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(2906002)(36756003)(66476007)(508600001)(6486002)(5660300002)(8936002)(38070700005)(8676002)(110136005)(122000001)(6506007)(66946007)(66446008)(53546011)(71200400001)(66556008)(38100700002)(316002)(91956017)(86362001)(2616005)(6512007)(921005)(31686004)(26005)(76116006)(186003)(31696002)(64756008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNybWFMMW45bmFBWkU0bDBQSDhzNFFuRktXY1k1OW5ScnNlSWRCaVBMWU85?=
 =?utf-8?B?YTBtc2E4SDgwUk9JQ0ZmQ3p1anFUWmxCNFJ3ZXNzUjBXaWZwdHBTd1d2UU02?=
 =?utf-8?B?aGN4VnRtMW1NaWd3K3VWOGdVN1U1UnBzM3pad3NNVGVwNDJGNkhteEZPRi9G?=
 =?utf-8?B?eE1rb0dsbE1sVVlZd0lzL1pEaGwyWTAxd0MrWU9mUy9LUUhCQW9oVWgxSWt4?=
 =?utf-8?B?eGROSE1ydWhNLzA0NEk3akUwY1p0eVdlYnFieEp4SVlER0g2aG9XcklmWGhh?=
 =?utf-8?B?bWc1VmtKNENGOElzbE5XZnVTRDRqWkdZRjBsSWhLWlVuV3l3eDV3VG1uTkpr?=
 =?utf-8?B?a1hHdU5EWHRhNndIc0trb3AzTmVvWFhQbEY1cko5elNCclV5cDNjYitNcFpE?=
 =?utf-8?B?d0xXSm9MMVVtZ2x6T0lnOEhyT2hERzFOQ1dMUGIxY3NHWGRqVTlodlBnQVBV?=
 =?utf-8?B?T3REaldxbkNIa0N4Ti9obXB3Z1c1ck9qSnVmVFBCdmdaaFNGY3FXVjVvYXRB?=
 =?utf-8?B?YW5EQ3FraHJ3dkFLblNUY2ViaklmMVA0RFFnVE1BejFaSi9rR3RVTXowbk1t?=
 =?utf-8?B?RS92RnZMV3M3ZEJsZC9KMVBuV0d1SFpZUVc0eHhhaEliblNFdFR2ekN2czg4?=
 =?utf-8?B?Qmw4UWFDVWxtWHhxVm1qVi9KRlJHYnArb3FidXB3Q2p3bjhaK0x1dEsyNEpQ?=
 =?utf-8?B?dVdHK2RYcDhkRTBMVFJvczJvZmZERjk3a3FOb1ZROWdTeGN5RnBNSnVQTnZS?=
 =?utf-8?B?U2VXSFVqUS9JZnd6SUY4QVp4cnBoZ0Q4NHVZcG9kMDhYdk1MNG5pWWVabmV2?=
 =?utf-8?B?OWx1OUptZ3dmN0pIQTcyaHAyQVo2aUFTWVVDNTV1dWR3KzA0cG1za091ZWRk?=
 =?utf-8?B?NHlNU0lTWEU5eXZhWmdhekltVU1uclBHVVV0Yy9GMm1zMVZ3V2wya0pEeXpD?=
 =?utf-8?B?dnlZcEhvRXd5SktTdGxzZHJYNG9jMS9kcHlVMWppL1ZuSEZ2VFdEVnhVOE9O?=
 =?utf-8?B?MVZwd2pZUndZVXZTdFJzekxOS0NFWXp5OXJkcDhBNjUwTlpRcHFwQUhMekNB?=
 =?utf-8?B?dmY5R08rMElZQWg2My9OWGZVZmh1L0hnWkh5dHVBL1VtaThoR09yZUNiNTgy?=
 =?utf-8?B?UmRIblZWUWY3MS9yYXZ0eDRQSDFaMFpKaFZWa2lEZndncG1DMzBSVW9UUThI?=
 =?utf-8?B?a0RYUlh4MEJ0bEhSWTZ0M1loSEZLRTdDZ2MzazhOek94NmxOQm51RllGcDZE?=
 =?utf-8?B?UUhlYTg3cElLb24wMmk4cmdjMUR0aFRNM3pmT0lyeVh5YldWbVV5bG5ESmNq?=
 =?utf-8?B?ZEtXTDVqWGZSTTZiOVlRdUttQjMwQU9IenZzRDhwVmFGeXNQNUpKSTlSMW1a?=
 =?utf-8?B?QVAydnliNno0Ris3RDcvN1N3ak4rRjV3aEpXZlpIelVJQzJhY29rVXJiREpK?=
 =?utf-8?B?RTVsSjhnZ0VBYUtHbjloOExWWk10eHdlOC9BOWNaS3EwUHliNDZaSzlrSEpU?=
 =?utf-8?B?d2dZSm50a0ZJdU9tcVZoQVdNMGQ0OUFwZ2NJV1VKR0Y3MDZkUkp5RDhzTngv?=
 =?utf-8?B?dGM3bG5POGlpUXh1YldVdjNSbWNKaVhOdVNiUjhVNXdGWlM5YTFyKyt6azYv?=
 =?utf-8?B?Q2dPUmdHS3kwcStpNkFFd3NndENVZVNsK3AwdVZTeHBDUksxZnFwbEt6WlRj?=
 =?utf-8?B?OUUyRVJGMEtsZlpGaXRwbHNYME0zNXgyaEpZSGxWMUpueGFRczZPUi9tNEpI?=
 =?utf-8?Q?+m2CqqmLiwZrqhQT48=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <91254886019AD34D9ED9E3F9870CF96C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ecc45c-b6a3-4052-c573-08d97cec4136
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 10:40:39.6466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeupWGIVXXDReAGrsXdBpGKLTlkst7efcBUxEXVXFLcBCfSYL3Kc9T8R/HUu/WdXRb3JWjwwod9NULbYvYG7HXP5UF8/S3BS3OKyC+5Q14I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjAvMDkvMjAyMSAxNjowOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IERldmljZXRyZWUgc291cmNlIGlzIGEg
ZGVzY3JpcHRpb24gb2YgaGFyZHdhcmUgYW5kIGhhcmR3YXJlIGhhcyBvbmx5IG9uZQ0KPiBibG9j
ayBAMjAwMDgwMDAgd2hpY2ggY2FuIGJlIGNvbmZpZ3VyZWQgZWl0aGVyIGFzIGVNTUMgb3IgU0RI
Qy4gIEhhdmluZw0KPiB0d28gbm9kZSBmb3IgZGlmZmVyZW50IG1vZGVzIGlzIGFuIG9ic2N1cmUs
IHVudXN1YWwgYW5kIGNvbmZ1c2luZyB3YXkgdG8NCj4gY29uZmlndXJlIGl0LiAgSW5zdGVhZCB0
aGUgYm9hcmQgZmlsZSBpcyBzdXBwb3NlZCB0byBjdXN0b21pemUgdGhlIGJsb2NrDQo+IHRvIGl0
cyBuZWVkcywgZS5nLiB0byBTREhDIG1vZGUuDQo+DQo+IFRoaXMgZml4ZXMgZHRic19jaGVjayB3
YXJuaW5nOg0KPiAgICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBm
cy1pY2ljbGUta2l0LmR0LnlhbWw6IHNkaGNAMjAwMDgwMDA6ICRub2RlbmFtZTowOiAnc2RoY0Ay
MDAwODAwMCcgZG9lcyBub3QgbWF0Y2ggJ15tbWMoQC4qKT8kJw0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+
DQo+DQo+IC0tLQ0KPg0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAxLiBNb3ZlIGFsc28gYnVzLXdp
ZHRoLCBzdWdnZXN0ZWQgYnkgR2VlcnQuDQo+IC0tLQ0KPiAgIC4uLi9taWNyb2NoaXAvbWljcm9j
aGlwLW1wZnMtaWNpY2xlLWtpdC5kdHMgICB8IDExICsrKysrKystDQo+ICAgLi4uL2Jvb3QvZHRz
L21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpICAgIHwgMjggKy0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2No
aXAtbXBmcy1pY2ljbGUta2l0LmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21p
Y3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzDQo+IGluZGV4IDA3ZjFmM2NhYjY4Ni4uZmMxZTU4
NjlkZjFiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNy
b2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21p
Y3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cw0KPiBAQCAtNTEsOCArNTEsMTcg
QEAgJnNlcmlhbDMgew0KPiAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICAgfTsNCj4NCj4g
LSZzZGNhcmQgew0KPiArJm1tYyB7DQo+ICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gKw0K
PiArICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gKyAgICAgICBkaXNhYmxlLXdwOw0KPiArICAg
ICAgIGNhcC1zZC1oaWdoc3BlZWQ7DQo+ICsgICAgICAgY2FyZC1kZXRlY3QtZGVsYXkgPSA8MjAw
PjsNCj4gKyAgICAgICBzZC11aHMtc2RyMTI7DQo+ICsgICAgICAgc2QtdWhzLXNkcjI1Ow0KPiAr
ICAgICAgIHNkLXVocy1zZHI1MDsNCj4gKyAgICAgICBzZC11aHMtc2RyMTA0Ow0KPiAgIH07DQo+
DQo+ICAgJmVtYWMwIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9t
aWNyb2NoaXAtbXBmcy5kdHNpDQo+IGluZGV4IDUwODRiOTMxODhmMC4uODNiYzE0ODYwOTYwIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBm
cy5kdHNpDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1t
cGZzLmR0c2kNCj4gQEAgLTI2MiwzOSArMjYyLDEzIEBAIHNlcmlhbDM6IHNlcmlhbEAyMDEwNDAw
MCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAg
ICAgICAgICAgICAgICAgIH07DQo+DQo+IC0gICAgICAgICAgICAgICBlbW1jOiBtbWNAMjAwMDgw
MDAgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImNkbnMsc2Q0aGMi
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjAwMDgwMDAgMHgwIDB4
MTAwMD47DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JnBs
aWM+Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDg4IDg5PjsNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtjZmcgNj47DQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Y2FwLW1tYy1oaWdoc3BlZWQ7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG1tYy1kZHItM18z
djsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICBub24tcmVtb3ZhYmxlOw0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBuby1zZDsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgbm8tc2RpbzsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdm9sdGFnZS1yYW5nZXMgPSA8MzMwMCAzMzAwPjsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gLSAgICAg
ICAgICAgICAgIH07DQo+IC0NCj4gLSAgICAgICAgICAgICAgIHNkY2FyZDogc2RoY0AyMDAwODAw
MCB7DQo+ICsgICAgICAgICAgICAgICBtbWM6IG1tY0AyMDAwODAwMCB7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImNkbnMsc2Q0aGMiOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVnID0gPDB4MCAweDIwMDA4MDAwIDB4MCAweDEwMDA+Ow0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDg4PjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBjbG9ja3MgPSA8JmNsa2NmZyA2PjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgYnVz
LXdpZHRoID0gPDQ+Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICBkaXNhYmxlLXdwOw0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBjYXAtc2QtaGlnaHNwZWVkOw0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBjYXJkLWRldGVjdC1kZWxheSA9IDwyMDA+Ow0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBzZC11aHMtc2RyMTI7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNkLXVocy1z
ZHIyNTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2QtdWhzLXNkcjUwOw0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICBzZC11aHMtc2RyMTA0Ow0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAgICAgICAgICAgICAgICB9Ow0KPiAtLQ0KPiAy
LjMwLjINCj4NCkhpIEtyenlzenRvZiwNClNlZW1zIEkgbWlzc2VkIG1vc3Qgb2YgdGhpcyBzZXJp
ZXMgb3RoZXIgdGhhbiB0aGUgbmV3IHZlbmRvciBuYW1lIGluIHRoZSBWMS4NCg0KV2UgaGF2ZSBi
ZWVuIHJlZG9pbmcgdGhlIGRldmljZSB0cmVlIGZvciB0aGUgbXBmcy9pY2ljbGUga2l0IHBhcnRs
eSBkeWUgDQp0byBzb21lIGNoYW5nZXMgd2UgbWFkZSB0byB0aGUgZGVzaWduLiBQcmV2aW91c2x5
IFNEIGFuZCBlTU1DIHdlcmUgDQpkaWZmZXJlbnQgRlBHQSBkZXNpZ25zIGJ1dCBub3cgYm90aCBh
cmUgaW4gdGhlIHNhbWUgZGVzaWduIGFuZCBtYW5hZ2VkIA0KYnkgdGhlIGJvb3Rsb2FkZXIsIGRl
cGVuZGluZyBvbiB3aGVyZSBpdCBmaW5kcyB0aGUgaW1hZ2UgdG8gYm9vdCBmcm9tLg0KU2luY2Ug
dGhlbiB3ZSd2ZSBqdXN0IGJlZW4gdXNpbmcgdGhlIGZvbGxvd2luZyBzaW5nbGUgZW50cnkgaW4g
dGhlIC5kdHNpOg0KDQogwqDCoMKgIMKgwqDCoCBtbWM6IG1tY0AyMDAwODAwMCB7IC8qIENvbW1v
biBub2RlIGVudHJ5IGZvciBlbW1jL3NkICovDQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgY29tcGF0
aWJsZSA9ICJjZG5zLHNkNGhjIjsNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCByZWcgPSA8MHgwIDB4
MjAwMDgwMDAgMHgwIDB4MTAwMD47DQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgY2xvY2tzID0gPCZj
bGtjZmcgQ0xLX01NQz47DQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgaW50ZXJydXB0LXBhcmVudCA9
IDwmcGxpYz47DQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgaW50ZXJydXB0cyA9IDxQTElDX0lOVF9N
TUNfTUFJTiBQTElDX0lOVF9NTUNfV0FLRVVQPjsNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBidXMt
d2lkdGggPSA8ND47DQogwqDCoMKgIMKgwqDCoCDCoMKgwqAgY2FwLW1tYy1oaWdoc3BlZWQ7DQog
wqDCoMKgIMKgwqDCoCDCoMKgwqAgY2FwLXNkLWhpZ2hzcGVlZDsNCiDCoMKgwqAgwqDCoMKgIMKg
wqDCoCBuby0xLTgtdjsNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBkaXNhYmxlLXdwOw0KIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIG1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsNCiDCoMKgwqAgwqDC
oMKgIMKgwqDCoCBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIMKgwqDCoCDCoMKgwqAgfTsNCg0KQ0xL
X01NQyBpcyA2ICYgdGhlIGludGVycnVwdCBudW1iZXJzIGFyZSA4OCBhbmQgODkgcmVzcGVjdGl2
ZWx5Lg0KDQpDaGVlcnMsIENvbm9yLg0KDQo=
