Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A7C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5F66137C
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 08:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJEIYI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:24:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6047 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhJEIX5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 04:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633422128; x=1664958128;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fHNUL8waXePhv9G2xbIY2RnTFLfSrV1S2l2tpFWCe4Y=;
  b=QgXuxQWcp2KrcdyQE8TpogpXT+5mp8ORTwZkGQm3IFN+ON9vdItTBlt8
   2ztXXlAuG424+1topJtzkIRoGNaWPfWyMOrLs8hNyBfh2mvxBCBlrhdlr
   MkgiLR6P8TXuaiwdl9EFdc2YC5pAxprI6C9enxnxj1vw44CKBC3Yhgg9q
   wUkMGT7r7MDoc92PN4jYq8X3EZIwJheM2Kqgko8xlct0pyy3zbXPCA9TG
   CUw5gDzWV0D2Gwo78et2A62WzhVkKM072Hyn7psVO30az8OLFOKNLcRt8
   LPjn0Wu8jx8mK5nzPL/x4HAJPnQCCHH2Nroyzaq5NwOiUwVStZJ/LzrIM
   w==;
IronPort-SDR: 7fjCO0+kT3NcQlW8iBzm2+hGaaC5VSJBu5J15/B2egDAk4fvzG0oRZvNH3lAOEENlsS92w3uVI
 GoVKFOXqHA0Fyy6KVW3vSNmQ7HTXV0EcdqBXgOrlAcEVtr8ZrVhqFQO+/mg44zltKdOwewK3uI
 dw8zC8waVl5DgMLsxiuuSBO9n1vpv2vHtPOrDz4i1XyuLu6zg13+uAP/owDtwLnrZiTf+M2vbw
 Aj4kLk+yTSTLwUr3o9V63V15V8sr+PcC+Ol82eNEJIBrxGTRtjR3W2KPLOdUytzWB7VYyHek5v
 kWCjnX5kEfPNqJ7u02dU5+zi
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="138485717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2021 01:22:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Oct 2021 01:22:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 5 Oct 2021 01:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt0NQrDvz2/h5b/lqRLx5ATw1KyaEJz21CysDs5FLpqBwILQlW4jaz7BecqdHkenbLLEyQMDIJkCAQ7Wt0ldIjkObnAKsL2cdgWdLORSOuLCTfLQtnfITiiVVRxaQ7TE53kyOtn2B3Mxg0C2It/pUtKXVdsPWg7nGEux+w+QV+OgkmonvAGi2ZVVbx5nei2TJC+0eihUgBwn0jozDZzLuVx4m2xUgdBWXX2wf30Ktf3nBSvmlNcwTu5N5v/+EPk8sX8eNY1Uc768Z6+ycgd5knzNOkZjctdfgLJoJn3G+3cRZ14MK8S3BRQncXLCgWDvReEnWf/+ShvGXX3UYm413Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHNUL8waXePhv9G2xbIY2RnTFLfSrV1S2l2tpFWCe4Y=;
 b=IKzlK8r33XSgr88rKekGL3CiNQ2YIrUoKN89vpdhY5Z5V2AagvTDb5sTEd75DjAYOLJUEq3ebPFXp9Fu0BkGNTcAmzao3WT8hZ6OGb70ycA0paseUgq5V/FjopG120FGcHw1XH82ZEoZuYGIBpCt7H2ukrh5UDlRyJJ1Hz6MAplxHnBUXf3+BNafR50AV5DhtWrlQ/1EVJD0NeDtx2VEdNy43pZ+pAsCmsp5H9ebulwvHMTQLxiCxN7kR+gUPkwv7nSTzeu0mAEPpWpl0s84bU3PsN0PQkXCAEOoWuR1jtueJDQesbfFqrH5ZZRZ12jTkKynU4uSDiD8TRQ8EySI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHNUL8waXePhv9G2xbIY2RnTFLfSrV1S2l2tpFWCe4Y=;
 b=X8EU9oF3o44JtxqVARwjqd2oqQAAmQEy4s7E5bx7RHWV0QAFt3v7vaHj5elODqNRfra/qJN95QIV3HI5C04pHCzr5U4LE8bbCD8eA6Rk/jEwMNfdo8fLlNYXpy6fcP/St20WFxO/P3ifr3yZZkrL1p0BsoMVNU1grpVbJaZEVKk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 08:22:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6111:3d29:64ad:c763]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6111:3d29:64ad:c763%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 08:22:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert@linux-m68k.org>, <yamada.masahiro@socionext.com>,
        <piotrs@cadence.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Topic: [PATCH v4 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Thread-Index: AQHXs55R2guPC/TgQEO8NaYle2BPvavEHPiA
Date:   Tue, 5 Oct 2021 08:22:01 +0000
Message-ID: <1ed22834-1b85-d8d7-dff5-6bab6df0c06a@microchip.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
 <20210927125044.20046-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210927125044.20046-4-krzysztof.kozlowski@canonical.com>
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
x-ms-office365-filtering-correlation-id: 1dc37723-8897-4fa4-156f-08d987d9353b
x-ms-traffictypediagnostic: CO1PR11MB4865:
x-microsoft-antispam-prvs: <CO1PR11MB486562F855C44FCC392FE63098AF9@CO1PR11MB4865.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6R01QB3kMB3HR48z0LJwXl6/XgzqUz/1rU8SgbB/DFB4XR3jYhQvZtoHJ3WrH5oyYH5Xo1vWumfMk+Zr0MuwSaguFSH3tmLqaXemeQNECr3oxKWhZnI810IFSeUR4SuAyLN0EVq7RHWR6LbnVmwSGdMGgCdjnRqR5besGkbQkykIse4SKPbqY6stbegROAqE6+kejf2AmFQLsWNdqUwqfTfHOTbNKmfAkWkQwJPb8l45k9rSLQWhyKFFk71JevhLPdSmsxa1tGD+IW2eAV1Q6+d/ghPg1oCGKr70aHsWzu/B9tNmJWDWdRER2gLa+wd4a1jzqUc4uyE09O3l6clCTQauz7mQy1o1Yg58jZHRYpb8Ecs0XmQ+50RgaL/s486SKtypqJe+SelwDcAoxwJiKyF+n2pyzlBRUan8PoHzPR1mqcxT52CB7j3eUTnebyqayJps7KIsCTpsi6RtRYpyT4+uP2pSiGmvq7CDJuyDycmRB3dMsUkuC8Zk3m018IFhyptyfp06G5MERo66SLSZYnqGRE8b1ulM4jL9YHd4ltJgVbKb9opoLCAM3hRSoffl8nbWThWsTM94zLiRTKsR0upDMOoEi0sT4klViIndS64WHtPQC3SViYf3hH3Gvmj7IPpgcDgyvXP1YABupwXldfN6JEcS25FBv/5bjyKxpYveFW83CZcrzw3G/ogLNjBuKVvPfbJYTX1tD2lJsor9VVszt+TM7srRCm49GJynvGtdcZhcVmfmnEs4rvyFAFck7/3khO1uhoShNGNHCy/fbkAwtUtqihbuJaTrzpcI6kQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(921005)(38070700005)(122000001)(71200400001)(53546011)(2906002)(38100700002)(86362001)(91956017)(76116006)(5660300002)(31686004)(26005)(83380400001)(31696002)(66476007)(66446008)(6486002)(186003)(7416002)(6506007)(8936002)(316002)(508600001)(6512007)(36756003)(66556008)(2616005)(8676002)(110136005)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlZyeEJ4U01pNXo2Wm1GMkFBOXZQZkhVOVFldGxRbXVvRlc1R1cxbEVjN05S?=
 =?utf-8?B?bkFHMnB0TUNualRsQXdhZTgxYWQzWVZuQmJGa005b29FVGdWNDhzMlRuNmxt?=
 =?utf-8?B?eDlnV3ZrYS9VSU0rcCt0aUxkWVJzdElYc2hwRDh2Wk1aYUNjS1crMFZEYWp6?=
 =?utf-8?B?MEdKUzhaeGh2dXRZRmdsUmVkeG5kSXdDcGJrTitxcUhCYW9PelFjdHBmdTVH?=
 =?utf-8?B?Mmd5UVVpU256NlpJa1p2NG1Pb0dod25XS2NldUhBZFVuSzBpRUJLSm9jZVRM?=
 =?utf-8?B?c20zV1pLNEozcFZqcHlKSjB4UFJpNnRSWUxEQllHTDYvbjczSmNRTEZvdnln?=
 =?utf-8?B?NlJLSmtWWkIreE1LVm5iK1ZEQno5bHNSU2dLVzkyaG0wK0tNM2tiT2U3V2Q4?=
 =?utf-8?B?UFh6ZUFxUWJlVGRQYWRmSTBvaGlwVzQwMVNUT2p1bE00RUlFVVJaVDhnU1dB?=
 =?utf-8?B?ZGVrWk8rdDEvYUdWbURxUnlDVzYyTVRPVFFUWmFFUHhyVHpiWlBzWW5RVjln?=
 =?utf-8?B?cEgxTEg0WnhPOTNlSStQMVUrSy8xLy9mejZDQnpDV3Q3S3c4bVJQcU14aTk5?=
 =?utf-8?B?RS9EZ0xwbzhBelBLdjBUUDlhZktYNERrNG1Mb3ExaEMxaE9UbGpqZXc5UU1k?=
 =?utf-8?B?NFVTNG8wMGFFMHBnUy9JRkxxdCs2ZHZuTWk4aXlXdVVCbXpYU3o1SHBjSFgz?=
 =?utf-8?B?RHJMdUhuTE13TlpGNHViTzV5Zmc3eVg3cXJTaFNuR2tsdzRLcHNLRzV1SWI1?=
 =?utf-8?B?MzZBN3JCV2JoVVhWODlDMWhLNGh5UmpoVVZUTUZaMkFPaTErVWZYamIrVmds?=
 =?utf-8?B?SjVhRXY4cUtnYkFiMG1GaFdnOEtzT0h4dVZjS2h6bVBJb0Fac1UrRzE5ZmFW?=
 =?utf-8?B?U0lQVDc3UFRVTHhDanhJQmc5M25rV1Y5U2N1cVdKMjBUOHJRUC9PeEM4M280?=
 =?utf-8?B?SWxVc3hrTXRsbDdWMi81WTFpQS9FVUpHQnJKdVpEMWl1VUQ1RlkycGtRNEpV?=
 =?utf-8?B?cTllUlVXYm1adnpCSytEL1cyeVFVOWVNSzBiV3BzS3BqeHE0M29oUnJLR2NR?=
 =?utf-8?B?TFp5RDNHclRrQnZJdTBJRmxuamFHb1FsYWp4enQyMzNsYWZRQitQcGc3eUNP?=
 =?utf-8?B?MzJ4cmQrZ0NaK1lnYnVJa0ZYTkVtdjhRZUdBNmpIelMvckZQYjRCSDJiaGIr?=
 =?utf-8?B?M0VkdTZPVDdDZVpzWUcvZ1RRY0dRMFA3YThybURzYVc3a1lqOVdNR1J3Wmtl?=
 =?utf-8?B?Y045M1JLdUF4dWJYcWlqd2J5UUZRemF1R09xSXE1RmRwVnNaWFU3YnlJSk8y?=
 =?utf-8?B?b0d5N3hDSHNNOEhLYTNINDBZZGR4c0xUbGtpOUVwN09Galc4T0lFazdIYWdx?=
 =?utf-8?B?bHBHbHVmeUtVamV4TUdpSFRhbExmciswNUFicStLV1JZN0x2NEpGM3RxMGRZ?=
 =?utf-8?B?Y3dXcGwyei9IYmp1Mm44TFFmMkxEY1NPcU16b0VXVXhubFR0OHBqZEdtbXo0?=
 =?utf-8?B?TmxtcnlER2l6Q2F1cWtKWU5BUDZjN0UyOCsxaTBjZS9vWVBkbk9JaHNNZzRm?=
 =?utf-8?B?V3RiY2hQZTNqc2duaUk3dWtBbldMV2xWOVdvWFlidXQrZU1vVXdBcUNUQ09G?=
 =?utf-8?B?Y1h1dHpwUksyMENITjJ4VGxVbU9HQ2VWeTYyMUpRaTFmV00zSlJvQ2FXS1FW?=
 =?utf-8?B?TC9tM0hiZFI0R1krZVFXZzFOYkJOUFkrZDZaVnZybDVrNTE3Z3QzTXUwRXhB?=
 =?utf-8?Q?6UwJJAQMhHaiSLuf3Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <81A521710199A049B00BA0D9A3FA8942@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc37723-8897-4fa4-156f-08d987d9353b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 08:22:01.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1qiaZgvPa+AClNZfG5rkKxzltikX4iEtOXH5RvXI7Yy7rzP8aAfGwI77zCUIZvMH21SeoYrug7+WpgRCBKY4t0ODYL0UOeGmOxFzE8NLIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMjcvMDkvMjAyMSAxMzo1MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
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
DQo+DQo+IC0tLQ0KPg0KPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiAxLiBLZWVwIHR3byBpbnRlcnJ1
cHRzLg0KPiAyLiBBZGQgY29tbWVudC4NCj4NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gMS4gTW92
ZSBhbHNvIGJ1cy13aWR0aCwgc3VnZ2VzdGVkIGJ5IEdlZXJ0Lg0KPiAtLS0NCj4gICAuLi4vbWlj
cm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzICAgfCAxMSArKysrKystDQo+ICAg
Li4uL2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpICAgIHwgMjkgKystLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMjgg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3Jv
Y2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLWljaWNsZS1raXQuZHRzDQo+IGluZGV4IDA3ZjFmM2Nh
YjY4Ni4uZmMxZTU4NjlkZjFiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21p
Y3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2
L2Jvb3QvZHRzL21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy1pY2ljbGUta2l0LmR0cw0KPiBAQCAt
NTEsOCArNTEsMTcgQEAgJnNlcmlhbDMgew0KPiAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
ICAgfTsNCj4NCj4gLSZzZGNhcmQgew0KPiArJm1tYyB7DQo+ICAgICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4gKw0KPiArICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gKyAgICAgICBkaXNhYmxl
LXdwOw0KPiArICAgICAgIGNhcC1zZC1oaWdoc3BlZWQ7DQo+ICsgICAgICAgY2FyZC1kZXRlY3Qt
ZGVsYXkgPSA8MjAwPjsNCj4gKyAgICAgICBzZC11aHMtc2RyMTI7DQo+ICsgICAgICAgc2QtdWhz
LXNkcjI1Ow0KPiArICAgICAgIHNkLXVocy1zZHI1MDsNCj4gKyAgICAgICBzZC11aHMtc2RyMTA0
Ow0KPiAgIH07DQo+DQo+ICAgJmVtYWMwIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRz
L21pY3JvY2hpcC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+IGluZGV4IDFkMDRjNjYxYmNjZi4uYjE1
ZTkzZDE3MDJiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9t
aWNyb2NoaXAtbXBmcy5kdHNpDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlw
L21pY3JvY2hpcC1tcGZzLmR0c2kNCj4gQEAgLTI2MiwzOSArMjYyLDE0IEBAIHNlcmlhbDM6IHNl
cmlhbEAyMDEwNDAwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPiAgICAgICAgICAgICAgICAgIH07DQo+DQo+IC0gICAgICAgICAgICAgICBlbW1j
OiBtbWNAMjAwMDgwMDAgew0KPiArICAgICAgICAgICAgICAgLyogQ29tbW9uIG5vZGUgZW50cnkg
Zm9yIGVtbWMvc2QgKi8NCj4gKyAgICAgICAgICAgICAgIG1tYzogbW1jQDIwMDA4MDAwIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiY2RucyxzZDRoYyI7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjAwMDgwMDAgMHgwIDB4MTAwMD47
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljPjsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8ODggODk+Ow0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrY2ZnIDY+Ow0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBidXMtd2lkdGggPSA8ND47DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNh
cC1tbWMtaGlnaHNwZWVkOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBtbWMtZGRyLTNfM3Y7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgbm9uLXJlbW92YWJsZTsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgbm8tc2Q7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG5vLXNkaW87DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHZvbHRhZ2UtcmFuZ2VzID0gPDMzMDAgMzMwMD47DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IC0gICAgICAg
ICAgICAgICB9Ow0KPiAtDQo+IC0gICAgICAgICAgICAgICBzZGNhcmQ6IHNkaGNAMjAwMDgwMDAg
ew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImNkbnMsc2Q0aGMiOw0K
PiAtICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjAwMDgwMDAgMHgwIDB4MTAw
MD47DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JnBsaWM+
Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDg4PjsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtjZmcgNj47DQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGlzYWJs
ZS13cDsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2FwLXNkLWhpZ2hzcGVlZDsNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgY2FyZC1kZXRlY3QtZGVsYXkgPSA8MjAwPjsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgc2QtdWhzLXNkcjEyOw0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICBzZC11aHMtc2RyMjU7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNkLXVocy1zZHI1MDsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2QtdWhzLXNkcjEwNDsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIG1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgICAgICAgICAgICAgICAgfTsN
Cj4gLS0NCj4gMi4zMC4yDQo+DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5PGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KDQo=
