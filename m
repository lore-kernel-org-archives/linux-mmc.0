Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1118C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70A260EB4
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 10:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhIUKPj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:15:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27457 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhIUKPj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 06:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632219252; x=1663755252;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EhmNbTFPFL3kxU/4Lhf4u/oORwHsEMz6bjOOp1hAt4w=;
  b=zjnqsE2HwAP2wDZvgWhlG9j4PlaP1ReJxDR1f/7k1UgOS/uwQ3zK8V/C
   ZYaOJkLMY2kPTUAmc7ERTujJUzffznnBrki9sW1MxzmqBmEpD4DdBZOfY
   T11cyD0E4phOQwpEHbAmcMMoO70Kx90K14MqtMODL8KusNF0N/Rob+bG1
   9s260RpAqwG991TtE1s5f1WAPI9rTnL3tVu667TOo+cxht2J7qWUtLkKD
   FmSbjmQua7azDfA5eL2FEhwhCd5UX+cDD1upPg419SpdvCPfJzQbj1Azx
   uEXNjGs5IpEL422UejkmmGFaWC0BWzTWVmAoYv/f8fwQSRfWYERjEjQT4
   A==;
IronPort-SDR: xzhrOQw6AsX5g0Br2NPbeYAbBrdSNiKx8tsgPHTtCiodQz8xJqe/9nIfhOnQPw/TLsx3W8mrMt
 7vtDaDiswoGmseh9vFHRJr6qkLLSgbEM61CKetTY188BHz9kBhDmwZU5IUvPw0PcgSSIErwOng
 Z2ICPb9Izvok7l4oilJ7QT/HOIoCLvsk1MG52UysGqjFcqT1wJm4IoC/A3WwlFKdoJnF2x71yb
 0ad/WJ/2Wv9kkwQG6IcqqPyujz0bF/cQo82WLN4k4KU/+uVms7dOVCChujaza9jnco2KFyDQVG
 56MzvexjmdMGKWPemmkLtTcv
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="136739211"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 03:14:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 03:14:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 21 Sep 2021 03:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8jytolzhwR1JAkkLy2b1Y5mxlOncymvzDVc66Q7KgCvgX3qI+yK005BEt1ISBmSEFiuc+pKtUij39Nd7dGNW2u3aWSpIGwpOGhufg8wh1bKjHqDpklEfGjHdpKGL/d1VgPUrSorlXgZX8PBZr2wvV0Wm8Bsyr9pWmVVzCb3/hD6TntqADJLA5gLOwOgHcvoSo9pTOQ645WKXYoTn5uYR1VPAkj07LkJ4dLozfQ005uyKWsNyxAtBbTxFZyBVIpcAnzvjRLAthWqgtgIGcehkD8dioFPQysUYj6X0VJLUoW9otHmYS48BHqrUp6UeRxGoQgJhGhplVK1Ee+6zGUyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EhmNbTFPFL3kxU/4Lhf4u/oORwHsEMz6bjOOp1hAt4w=;
 b=ccjYtD5YFYWUGv6rpjZZYYFBZRLwahQGFet4ASBO5qSJbSvZlyYv6QoiwIWuxQtOhVsUrWLf4xesDORypL97LFEpdIisk+PXlUe1ZNWdPx1baIAhrmLupoWdsHPIOq5wUT18iWlio2zEGxd/C3YBtQ9Gjj6OkPKK1V3QKrowBVJ9CJvTPyjHoWrUDlKrqYpAPFl/Y5pfEK1VWPFFmu2c6QzayVTH7/pM0JWOiCRHDtzB+P4TO+sNWpFjJ3NNSU2ktYzVbxnaE25l0eOZI2bgTs8Ib/HjJG1/5kTon9J1s84chxwPMR/J+MZV3RZHlw0zrO8bJGXUUt1o/c1m7/e3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmNbTFPFL3kxU/4Lhf4u/oORwHsEMz6bjOOp1hAt4w=;
 b=n8qmQWWl7oWn8sa+qSCh+C4nA0BKbXj5TMu4nucaNhYaHpEWAS7FFc1KgfANQonheUaWqxX5YkMAGuY9W2KU/vmqJIZtGF1uqky1xQa1RWDafJT9E0epcf/5t+9mg+30eAv9BOm5EOOGWo3AAlxQDjp/ZGFBdufxdevzA2IupMY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR11MB1469.namprd11.prod.outlook.com (2603:10b6:301:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 10:14:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::c02e:ee5e:8da8:b99e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 10:14:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 6/6] riscv: dts: microchip: use vendor compatible for
 Cadence SD4HC
Thread-Topic: [PATCH v3 6/6] riscv: dts: microchip: use vendor compatible for
 Cadence SD4HC
Thread-Index: AQHXrjGfi8MR+9V41kKXoVDW1yl+RKuuRm2A
Date:   Tue, 21 Sep 2021 10:14:05 +0000
Message-ID: <abb0b273-4a60-f2b3-4e40-99d3ebfc024d@microchip.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
 <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
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
x-ms-office365-filtering-correlation-id: 90e41f8e-4118-45d6-ad5b-08d97ce88b28
x-ms-traffictypediagnostic: MWHPR11MB1469:
x-microsoft-antispam-prvs: <MWHPR11MB146955D5A541E8295CF3A2EF98A19@MWHPR11MB1469.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Khadxeg1b2RbbhF/M+1xYqCJnMpMx4xYiXwWctm0vSgP5G7SRt3um/lg5c2HgfTZpy82aHWOVgH9CEe0g9tYWKXbaHBZBigyHbpaRD+HJQauC7WakPkhiVUlg/3NL30P+NElhKDH9N3YvqC7X6U6I4M79ZwkYuLpkbj3T890gsNmD9DSkZBC0fUiTTU6RBAIhf+TnglQPfbY8UxIMqs52O7zvOYqmWp0h6ygth+1Vw8cwL/tr+LNnz+kBc6BWcnXPOTXrJuG3K8DSFIoVVf1mhdAz0mWwTGgg8Teds2qX0pHu7jzB55kyC1OFz5/wdnf3r00Ik9DJGdxTVX6WogAfY0QOHiqN1L2wVQaxi2U9mDuBLwXb4Zs1jS0mQH0P3st3b/M3ljdlxPY5Pl6RR2fCSMgfdlMw6EmFoMJHjanxt2anMeZk4maDy5yQFkcYXbyXEP5He3ZXmZIcWS8y6MIAtLqSTYI6Q8zLM4zkwoIhftXVYeNojUqzJgJKDp4Fk8RU7llwrejtWwsd5vElZSh5Q3eIXhqYSKhEb+YxUIGLI3Jn5H+2fwJbzCsTQjNHu2uyFmm3XkprFNbMNp9CIAMwF5fjleB/00v8jxODNpZIdnpRVMj2ZFHFbiUdyebeFipsddTwBLVSFKvjjW6O5pgapEU983aRWNz0JE9qS3gdnhxcnMHN4CeEVmMQ879QpYEHQXngHdXIXJuinNjpAoFPwZZQuhDfkmWiex4Qv00v1fRP9LoDf8dEtl4BH/TN9iTHzf2oh0abddgnR4VFITnsOdq+uv+xtIhzKG7uOOGxnWpvgTb05ln8yQ1ztO4J4y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66446008)(66476007)(66556008)(38070700005)(64756008)(66946007)(8676002)(36756003)(91956017)(8936002)(122000001)(6512007)(316002)(38100700002)(2616005)(7416002)(6486002)(508600001)(110136005)(186003)(26005)(31696002)(53546011)(83380400001)(921005)(71200400001)(5660300002)(76116006)(4744005)(6506007)(31686004)(86362001)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3lacTV5dXZDZTYzaWFKRDY5eEJmYW9pdm8vKzFOcWhmRmNZNWhJaDk4ODBN?=
 =?utf-8?B?Q3R6VmxhWlpnRzV4RkVHMUJReVNLTVcxYjJlU1J5YTcyc1g0WjA5dFVZdFdY?=
 =?utf-8?B?WGw5WERDVGtjUDg0b1pzS0tscGNLcFp1Z1dOMXdCL1k0RGtMQmRRNktaQ0lN?=
 =?utf-8?B?ZE85Ky9YYUZueGQzQi96Ny8yODNuZ1V0Nk5CSHlCelR2aGh2N20vSkg1VjM1?=
 =?utf-8?B?S1FpVGV5ZmNFdnQwdFRtUE5pdVE0SXpOY29QOUgzYWFUZlVsT3kyeTk2U29a?=
 =?utf-8?B?aHZ5U3NFRUEyRnYvbXF6c2xOcXZGeEFjRHAzWXB2cDFoRENhT1lWZUVLY1pp?=
 =?utf-8?B?djFaMmMxbGFmeFRXVXlBejdCZVp5ZWxJekcvOHpXNmlxOWNnT3RLOCt4QThq?=
 =?utf-8?B?eHdORWQxZUVQZVVNYUEyNy9hRTZ3SGZGNGxXWFMxa0czM1ZTZ2dMNEFGd1RM?=
 =?utf-8?B?aTlSMU1ZakxLSlF0WXFraExKRzdScGFMWTVTVW04MGJKdUcvSHF1RGlwK3Zi?=
 =?utf-8?B?blg3cEN3ZE56c0EwZld0YmFRYzFUVTVoUENqSnZvV3dFbGpCS1ZERDZLaDF2?=
 =?utf-8?B?YXkzOUZxVURSVVl5T2xid1NxZkY0TTVxeVNUK3hqRVROTXhNTnpnVFppeGFT?=
 =?utf-8?B?bVd4bDVrbDdzR3pEUElxZDE3aWR3b2ROUnJoV096QVdTRk5LOXZhWFlxMUtX?=
 =?utf-8?B?YUdnVm4wa1Jvc3p3MW0vYnc5ZmxBZkQ5ckNmMm9sak9yZkRpSmhGaURmVE53?=
 =?utf-8?B?WG0wUWV0d2pOMWp2QlpVU0toN1pXTHB2U3hEVllUdXlpLzBHeDVkK0ZpVzc5?=
 =?utf-8?B?dUtKa1BLb3IvS0dsNDdvNnh5bWF2bTgrRm5UbzdvYTNQTWd2bzJEaHVoa3lw?=
 =?utf-8?B?aUhOUUd1Y0Q5WWd1UThBNVVVa3FpQzVyOUF2UHllSmJlWUp0R1FVcHZGYlJC?=
 =?utf-8?B?QW1YYkxSckNZaHJ4elNpT1FCdWpPVFB4R0ZRS1VMU3RQWGVJcXFCUmp1dVhH?=
 =?utf-8?B?Y1B0am9nQ3FVSG5IcG1KamxaeVdHcFRBbHJSZkYxMVViSHcvYlh4bGQyVWRz?=
 =?utf-8?B?VmJ1SGNtMTBmQ1AwWlhMZTVCN2dVbXUvSHpobGhzVFpSa1NGU3Nrc01BN3FR?=
 =?utf-8?B?RjYzSzRFcDBIOTVEZ1VuSDE3Q3ZEcm9TL2JFN3NnU3E3SGlnblZRdk5XL2F2?=
 =?utf-8?B?YVZxbnF2UVZ6YTRNaTF3R3BXOFp1aVN1bHVYaFVQU0ZMMkJGc0FOMjNhZUhN?=
 =?utf-8?B?eVlsZVJITGtVY05OM2lyck9zWmVBUCsyTWR2c3JpbGw4ckxPR3RhRnVWWGZC?=
 =?utf-8?B?K1FkRGFoQlc5MDNOeWJ0U1gvMDU2ZE9CM0UrZzZUSHUrOS9iWTJ5dzN5UnpR?=
 =?utf-8?B?cTZaMFJ0UjZOaENRZTVSR2ZjVzBQTXRxYXdYQWJleFNFdVA1U3FmYkI2aEcw?=
 =?utf-8?B?ck9lV2FVV3lab3N6RGtpUUFFRDJma2tnL2VzWTltdnVWUW1sd20ybWVBL0JE?=
 =?utf-8?B?czR0SHBxY1dOSzhrWkhuYUplY3U2bkVwQlcrUEtjRFZNUitrSHlVR3dWWUNo?=
 =?utf-8?B?dklseFBYQmQwZVYrVGJLc003eGNzTUtJcFpiOWU5NDJoZ2c2Vi93Q25NU2J3?=
 =?utf-8?B?S2FMZ1pEQ3JBQVZXVlg0UjZPd1l6RnJPdFBTNWd5TGxrN2ZzNXk5T1c3K01M?=
 =?utf-8?B?KzBnVmZnNVo2WGpZdk5sUEg4N2ZNc1VzbnRBdmJSMDVhQVhFWENKT3dmOGVD?=
 =?utf-8?Q?oC6Bsn9cKJiNPG9DJQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0FE499AF4AFD14AA3BB28D1194F4E4B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e41f8e-4118-45d6-ad5b-08d97ce88b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 10:14:05.7954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHtBDxRVglxDS7fb8QNnkETHyCorhCVzdEtQRSwwN+rudm5iZgqq3mQxIrULZoX46SxQduFbVfx1C5XCSAXo2thutEZj3YhUK0mPAZFOfFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1469
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjAvMDkvMjAyMSAxNjowOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IExpY2Vuc2VkIElQIGJsb2NrcyBzaG91
bGQgaGF2ZSB0aGVpciBvd24gdmVuZG9yIGNvbXBhdGlibGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbT4N
Cj4NCj4gLS0tDQo+DQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IDEuIE5ldyBwYXRjaA0KPiAtLS0N
Cj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpIHwg
MiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlw
LW1wZnMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZz
LmR0c2kNCj4gaW5kZXggNTVkODZiMDc4YzUzLi43OTQ4YzQyNDlkZTUgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gKysr
IGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaQ0KPiBA
QCAtMjYzLDcgKzI2Myw3IEBAIHNlcmlhbDM6IHNlcmlhbEAyMDEwNDAwMCB7DQo+ICAgICAgICAg
ICAgICAgICAgfTsNCj4NCj4gICAgICAgICAgICAgICAgICBtbWM6IG1tY0AyMDAwODAwMCB7DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiY2RucyxzZDRoYyI7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtc2Q0aGMi
LCAiY2RucyxzZDRoYyI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4
MjAwMDgwMDAgMHgwIDB4MTAwMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVw
dHMgPSA8ODg+Ow0KPiAtLQ0KPiAyLjMwLjINCj4NClJldmlld2VkLWJ5OiBDb25vciBEb29sZXk8
Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCg==
