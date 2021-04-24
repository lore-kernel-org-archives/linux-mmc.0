Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A4C433B4
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Apr 2021 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F7B613D5
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Apr 2021 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhDXS3V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Apr 2021 14:29:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54929 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhDXS3V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Apr 2021 14:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619288923; x=1650824923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8TDKEzGSwYJawA2CWgIFva0n8GmA+p6w17SMq3sqRDE=;
  b=WHlmSbrYxaHPkJVY0By9zAWImdTRJzlnO7u9M5jmQnmjPdiW+nhl6nAu
   q7fd5LU1rbCwClW3TYlGaOgfungW5DXH7O6mtBB4FK/QDKhPGQOxYRCKB
   XxRroQ0i7Hba1WWyXSD13RE4jRuqTnUZPFua0IT7v0KfjABFI87c6XAN5
   Zx5BMA0syiTCqH5iWOkRymI7eD+U1FwiIlyEy3UTHMPYENDbxc2ei+j+J
   SIh2MbabiPlnTvzj31v4F4jyfBj7tokcexghce0+2tYMpmRjeF4R0V9Wm
   Ps1Sc17Ord1lKhVS9k0a66zIkkbFnsXUvQ1Po4AiKjS0EL1+YyNZu2yZr
   A==;
IronPort-SDR: zCjpIMkI6vOeQ9QMPmVNy55DZQP2p4TEogeyMGUkPkB8AlQDofuvITAQqehbuTItnU+p6ysDhu
 OE7dZlVeesCF1LYMQ4VViB0cP2mxQ9BbjCYA9ttKvVMT8EL4o00YrTZMns1dkW3n/rHMXDQ1Ml
 VjB6hVlO6qXXVu5NXOgVLYeFXO5t7Khsm1oA+7xbpkFkiWM5JHNjJjThONWxiLfdpZV+48XUfr
 +BOntrYDYyIx/3A/P061DhVDGspfJY4zK9vVExAxvu7DPyTh+1begGAv3YXQCs7nmxh/eI8AxR
 6NA=
X-IronPort-AV: E=Sophos;i="5.82,248,1613404800"; 
   d="scan'208";a="166705348"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2021 02:28:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp2/cLZ9kI9hbsZLrNle6Y8uFFcSYzFWNEwEKu+QkyWwrbETbrn64GcvvsvFD3rz7jeM+gJEmOBXx9aY0Idg0WdkVRmdpyirgeljFkfS8qmYWle8fxKfUgwaZGBwaUWKyJDJSnYpL52m6bql/1zCmI3GpaNPW/K5cKlyHlXH9QSfUPsaa0rT9M3qNcVdoWP8rtUm4oeIJR6047g5NmQLL3db8d0eQVfg8xe50s5vKB+80ZanCgwph8NQ3gRzRVxlwl4pUrzeSTcjTbuQY5CokIHkmmG9wx6NdNdKEYErA7CkqpYVh2Lu9GecTtvDNeaDYr6R4vvM7yrthPy3q1H4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TDKEzGSwYJawA2CWgIFva0n8GmA+p6w17SMq3sqRDE=;
 b=OVNskw2z7wGYqQZvYST+XN2+LrpImS54Xqwgdfk+CflX1y8Nk6YmYGFxTTSfMkFdFhHq8YZn2RSdW7gCuhUuaGN80a3wIgd7ljeC0SPauISKlnGUqxQAljtp4A5WBTGOLMkMQAY94Vhkg1OUPGugb9R2jKlZRftXjWZ1RGqYDIpvU126gIppiUXU8GPH+H+GA3hMQgT8aUS7YFkCU3Sg8koTYykTTHQ2Wgl8kIprFWmUgWgMfOW1VaHf3R/RMhxLe35EHV1+/f6iv7E3BrZp4BdmMfIo0wygWAjwTSmS80yOr1VpBnCcZMQmumcEt3aEK8V25nLofjTCn3oEUu5Fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TDKEzGSwYJawA2CWgIFva0n8GmA+p6w17SMq3sqRDE=;
 b=esF0aAXdDtxDXBFYgV6LenPQLxokB200f7N1SYbBhXUiCDLB2RWulH2a5NNAmzt1DAkGQR+nFbBo+D7WAZYrymrDAPWge5eNeDL8eh3LLA5h9chwjQy4JDPaLgKFK0TWR7TZOaPIk4fu2RoPK+jov+lx2CddmQwri/qwdh8lX+k=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4555.namprd04.prod.outlook.com (2603:10b6:5:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Sat, 24 Apr 2021 18:28:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.4065.025; Sat, 24 Apr 2021
 18:28:39 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Subject: RE: [PATCH v4 1/2] mmc: block: Issue flush only if allowed
Thread-Topic: [PATCH v4 1/2] mmc: block: Issue flush only if allowed
Thread-Index: AQHXNeuipV08XZ47N0eF2oz0lz2CBKrBxXWAgAI9e2A=
Date:   Sat, 24 Apr 2021 18:28:39 +0000
Message-ID: <DM6PR04MB657537C632B237572E6A4F7CFC449@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210420134641.57343-1-avri.altman@wdc.com>
 <20210420134641.57343-2-avri.altman@wdc.com>
 <CAPDyKFoejcQz2jPgqzc+2W+mfaXOatGCdd8CdNYsk4FsUEb=7Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoejcQz2jPgqzc+2W+mfaXOatGCdd8CdNYsk4FsUEb=7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcca96f7-cdf0-43b9-c366-08d9074ec851
x-ms-traffictypediagnostic: DM6PR04MB4555:
x-microsoft-antispam-prvs: <DM6PR04MB455571E7814C0B980099C345FC449@DM6PR04MB4555.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1HqSr7AAR6gQLI6ZjDCl/UFHp2h27+R7B1uMs4K6scdraboUWwTrEUA4O8kpAtv0IL081rgP7g4RmodZLW088sBc8gn8uxVt5ksRHj3B0UHhpySe4wTEHJ+NTbJk4eCS2hV7h3vqGDJ67HZJujpf8DwFQundF0eGtXwQwju+nQySN/WliZYrCxW7ndFMskbJOmoo4a2qgE9jdSEGRBK55DxOya28Xprq8Yq19AK5C/L1Y0oA/vlgK6L3rwv5dHhkBE7hDXmXMffNa8n7NtjoEZg4QGS5WtfG/qU0Pfwv+vQId7DN8yJue441bW74uYQk17KvV1Y8q+CVWjoqlKgzUP/P4z1EZnL4TaYh2X3yhYiZZzfVpnGMmwE6PuHb9T1JbHRh5UOnfzckhltKU5g+qDVYp/58uj622j2I5KrgjLhVwgkYDKrRb4MBwAlp+nHuIJg5msRQ/WZqHcoUSs3fndBeF6gznqCR3YDu0noKW8x5KmWhiF2QgGU2BI+T+CifJVodIO3lUja2JhaT1fd4XRwQOGdW2SeghD4VXrYWVewDqdALS6Cspy6rtZCWBe+DOmlrsemzdQAXc4YqoiFAbeYF8rvvrsLklslJOjz7kc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(86362001)(8676002)(5660300002)(7696005)(71200400001)(55016002)(6506007)(76116006)(122000001)(26005)(186003)(6916009)(33656002)(38100700002)(54906003)(2906002)(316002)(9686003)(83380400001)(478600001)(4326008)(52536014)(8936002)(66556008)(66946007)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTJudTZNQlZPb0JhWXJ4K1hLRUc2UlVBREdFT01mTGErTXl1OHhsVmR4YU92?=
 =?utf-8?B?YlJsUGFycE8ydjBRK0Jla0ZLcXhDYWlCaEpEWnlJYml0NVZkOUx0alBmOE5K?=
 =?utf-8?B?NlV3RmhmRnpnV21BVVAzWVo2ajcwZTBOemRrZllhM0k0RE5VTnZ1bTZlOTd2?=
 =?utf-8?B?blk2UjliUzRTb1BVUjUyRDFZSy9PSkFJMTFtZWNDUFNXUVlpeG14Tkxzc0xY?=
 =?utf-8?B?STMxVUY0UXhXYXptSHVoUXVFUHlOMHk2WEQwdlNlUTRsZnZ4K0J5ak52c2ZG?=
 =?utf-8?B?cXB5Y3UxVzhmVmwyb0huc09sT3VBdytyOFRQaGRsYUUyWVh6ZlNZRWthYU13?=
 =?utf-8?B?OC9YMERGcGxIb2V0dk1QV2VEYVkzbmhkaW41QXRxbzVIWmVhOGg1dlBTQWxu?=
 =?utf-8?B?dGFuVHovNEN4ajdPYktPQUlwb0kzaHdkTFY4czkxU090YytXMHhWbE5KdE1l?=
 =?utf-8?B?d1UxN04xNVRHRU10R05nVEk3Q2twUFJSZXVFQXRJSFBPMllKUWd3dnJCQUlo?=
 =?utf-8?B?K2xkSUNCNS93QldoLytqNmFyV1JoRS9IMlh5VzRtbEE5dlBpMksweDl6SHE3?=
 =?utf-8?B?SXA3MlVWKzFmNmtsMFNEQ1Q5dERtc0xqeVFzUDBkbW5VcFA4ci9hVWg2ZVRF?=
 =?utf-8?B?a1RhUk5sWnM2UXhVbDQ5dUZjTjMxN0kwYzdHOTFDTlRpVTJ6UTRvdnRGSVYv?=
 =?utf-8?B?bGhVMXBrNkRLeXNCbVEyamJWT3ZvZkF1bkU5YUFHVm1jSUhLbHdBcU5PUGkr?=
 =?utf-8?B?NE9sQU05UzhodlVWcml3VUV5aFNOdVFSOGxRaXdidmlheHN0MXhDREhuOUZw?=
 =?utf-8?B?cHdvQnVLdnNRWmZaN0I4a0JjdXZwVkhoSWFaVGN0VmgyYVo2M2dWY2E4QzYw?=
 =?utf-8?B?QlRtY1p2TUZCQndzN0FxbWVaOTh1VkF6Q1lvSnlwMnlMT0E5V3ZseDlMZkRE?=
 =?utf-8?B?MFlJYlFjeHRKVUtTRk9Lb2liUSswV0tMM0JjWUllMG1wYkhXbFJXTjQyNFE1?=
 =?utf-8?B?eUdsdmIzcnR6a2NvVEJkejVOZHBPeU5nbHJHTjg5RTIzUXhhUjBMQmplZXJw?=
 =?utf-8?B?aG9EOG1JZW5ZNlRuUitUQ2tkS2FBVW4rTzhhUDhaWitVWmplbWZ2YmpzdlFF?=
 =?utf-8?B?TTNGZEFLeUE5TEpoVVZTUGVieEptUm9QU20wZmJNb3hScVRudVRWYVh4SzA4?=
 =?utf-8?B?Z1h2RWNIT0dmYysxN3JXeFViUVh4NzNVR3JpcHJNNHRzSDlRN0NiRGdQSXVU?=
 =?utf-8?B?QkRvTmtGOVJRL2V1bHlUUVpTa2gzQnlya3J4QUV1TW9xUEc4aUZJUWx4dGVa?=
 =?utf-8?B?bnlQMGpWU1BvTy9EbFhHMVVsRE9qYUpqVU96d1lSR2tSb2dGeU16MjdSQjJt?=
 =?utf-8?B?RWRTazFWdHdwclkzNHZCdUJBQ3FSNmNqSTJrc2pYWkVGR2JTMXl0Y3o2OFVl?=
 =?utf-8?B?cUhNZFFDNDZYY1VIUDR6UXcvTGxhZ216QlRlRlJIZnV1ajRVYTBGNVhXcGNZ?=
 =?utf-8?B?cHZ6eHdsWk5OdFRDZzRtREVmV0dvZnZHTVJoNTdrWi80NW01L2lvdU1UNGhM?=
 =?utf-8?B?YzNOV2tIbjFhSUk5VDVkRDFrQkxiMS9FMVpCSlhWY0pIell0RXh6bVNmR2NR?=
 =?utf-8?B?WnpaL0tWOHZmMlpyTGpPTE1FMEk5TkNleFdGZ0ZCMWhhWWVnQmlmQnMrcWhK?=
 =?utf-8?B?clFkSHlzeitITVgwNld2QXozaUpqelk1RGRQMVNCd1NJc1VHbjlnU244dXRq?=
 =?utf-8?Q?AR2zgBPez4vK1aqacE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcca96f7-cdf0-43b9-c366-08d9074ec851
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2021 18:28:39.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Unh6Kx9mwwjmJLmSuHhxfEkkTTRkBbwArHtFxxZ9zHcHd399zpLngYhMr9H/1Al0n94pegizHlgE8R0ScqcnlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4555
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBPbiBUdWUsIDIwIEFwciAyMDIxIGF0IDE1OjQ2LCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY2FjaGUgbWF5IGJlIGZsdXNoZWQgdG8gdGhl
IG5vbnZvbGF0aWxlIHN0b3JhZ2UgYnkgd3JpdGluZyB0bw0KPiA+IEZMVVNIX0NBQ0hFIGJ5dGUg
KEVYVF9DU0QgYnl0ZSBbMzJdKS4gV2hlbiBpbiBjb21tYW5kIHF1ZXVlaW5nIG1vZGUsDQo+IHRo
ZQ0KPiA+IGNhY2hlIG1heSBiZSBmbHVzaGVkIGJ5IGlzc3VpbmcgYSBDTURRX1RBU0tfIERFVl9N
R01UIChDTUQ0OCkgd2l0aCBhDQo+ID4gRkxVU0hfQ0FDSEUgb3AtY29kZS4gIEVpdGhlciB3YXks
IHZlcmlmeSB0aGF0IFRoZSBjYWNoZSBmdW5jdGlvbiBpcw0KPiA+IHR1cm5lZCBPTiBiZWZvcmUg
ZG9pbmcgc28uDQo+ID4NCj4gPiBmaXhlczogMWU4ZTU1YjY3MDMwIChtbWM6IGJsb2NrOiBBZGQg
Q1FFIHN1cHBvcnQpDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogQnJlbmRhbiBQZXRlciA8YnBldGVy
QGx5dHguY29tPg0KPiA+IFRlc3RlZC1ieTogQnJlbmRhbiBQZXRlciA8YnBldGVyQGx5dHguY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgICB8IDkgKysrKysrKysrDQo+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgICAgIHwgMiArLQ0KPiA+ICBkcml2ZXJzL21tYy9j
b3JlL21tY19vcHMuaCB8IDUgKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gaW5kZXggOGJmZDRk
OTViMzg2Li4yNGUxZWNiZGQ1MTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9i
bG9jay5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gQEAgLTIxODYs
NiArMjE4NiwxMSBAQCBzdGF0aWMgaW50IG1tY19ibGtfd2FpdF9mb3JfaWRsZShzdHJ1Y3QNCj4g
bW1jX3F1ZXVlICptcSwgc3RydWN0IG1tY19ob3N0ICpob3N0KQ0KPiA+ICAgICAgICAgcmV0dXJu
IG1tY19ibGtfcndfd2FpdChtcSwgTlVMTCk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9v
bCBtbWNfYmxrX2NhY2hlX2Rpc2FibGVkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiArew0K
PiA+ICsgICAgICAgcmV0dXJuIG1tY19jYXJkX21tYyhjYXJkKSAmJiAhbW1jX2ZsdXNoX2FsbG93
ZWQoY2FyZCk7DQo+IA0KPiBJdCdzIHRoZXNlIGtpbmRzIG9mIHVzZSB3aXRoIG1tY19jYXJkX21t
YygpIHRoYXQgSSB0aGluayB3ZSBuZWVkIHRvDQo+IHN0cml2ZSB0b3dhcmRzIGF2b2lkaW5nIHdo
ZW4gZ29pbmcgZm9yd2FyZC4NCj4gDQo+IEZvciBleGFtcGxlLCBuZXdlciBTRCBjYXJkcyBzdXBw
b3J0IGJvdGggY2FjaGUgYW5kIGNvbW1hbmQgcXVldWVpbmcNCj4gbm93YWRheXMsIHdoaWNoIG1l
YW5zIHRoYXQgd2UgbmVlZCB0byBtYWtlIHRoZSBjb2RlIGluIHRoZSBtbWMgYmxvY2sNCj4gbGF5
ZXIgbW9yZSBhZ25vc3RpYy4gVG8gZG8gdGhhdCwgSSB0aGluayB3ZSBzaG91bGQgdXNlIHRoZSBi
dXNfb3BzDQo+IGNhbGxiYWNrcy4gVGhhdCdzIHdoeSBJIHN0YXJ0ZWQgb3V0IGJ5IGFkZGluZyB0
aGUgLT5mbHVzaF9jYWNoZSgpDQo+IGNhbGxiYWNrIGluIHRoZSBvdGhlciBwYXRjaC4NClVuZGVy
c3Rvb2QuDQoNCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gIGVudW0gbW1jX2lzc3VlZCBtbWNfYmxr
X21xX2lzc3VlX3JxKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBzdHJ1Y3QNCj4gcmVxdWVzdCAqcmVx
KQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgbW1jX2Jsa19kYXRhICptZCA9IG1xLT5ibGtk
YXRhOw0KPiA+IEBAIC0yMjI1LDYgKzIyMzAsMTAgQEAgZW51bSBtbWNfaXNzdWVkIG1tY19ibGtf
bXFfaXNzdWVfcnEoc3RydWN0DQo+IG1tY19xdWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0ICpyZXEp
DQo+ID4gICAgICAgICBjYXNlIE1NQ19JU1NVRV9BU1lOQzoNCj4gPiAgICAgICAgICAgICAgICAg
c3dpdGNoIChyZXFfb3AocmVxKSkgew0KPiA+ICAgICAgICAgICAgICAgICBjYXNlIFJFUV9PUF9G
TFVTSDoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobW1jX2Jsa19jYWNoZV9kaXNh
YmxlZChtcS0+Y2FyZCkpIHsNCj4gDQo+IEkgc3VnZ2VzdCB0aGF0IHlvdSBhZGQgYSBuZXcgYnVz
IG9wcyBjYWxsYmFjayAtPmNhY2hlX2VuYWJsZWQoKSBhbmQNCj4gaW1wbGVtZW50IGl0IGZvciB0
aGUgbW1jIGJ1cyB0eXBlLg0KPiANCj4gRnJvbSB0aGUgbW1jIGJsb2NrIGxheWVyIHBvaW50IG9m
IHZpZXcsIGl0IHdvdWxkIHRoZW4gbWVhbiB0aGF0IGlmIHRoZQ0KPiBjYWxsYmFjayBpc24ndCBp
bXBsZW1lbnRlZCwgdGhlIGNhY2hlIGN0cmwgaXNuJ3Qgc3VwcG9ydGVkICh3aGljaA0KPiB3b3Vs
ZCBiZSB0aGUgY2FzZSBmb3IgU0QgdGhlbikNCkRvbmUuDQoNCj4gDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBibGtfbXFfZW5kX3JlcXVlc3QocmVxLCBCTEtfU1RTX09LKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBNTUNfUkVRX0ZJTklT
SEVEOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICByZXQgPSBtbWNfYmxrX2NxZV9pc3N1ZV9mbHVzaChtcSwgcmVxKTsNCj4gDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGNhc2Ug
UkVRX09QX1JFQUQ6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9k
cml2ZXJzL21tYy9jb3JlL21tYy5jDQo+ID4gaW5kZXggOWFkNGFhNTM3ODY3Li5lM2RhNjJmZmNi
NWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiBAQCAtMjAzNyw3ICsyMDM3LDcgQEAgc3RhdGljIGlu
dCBfbW1jX2ZsdXNoX2NhY2hlKHN0cnVjdCBtbWNfY2FyZA0KPiAqY2FyZCkNCj4gPiAgew0KPiA+
ICAgICAgICAgaW50IGVyciA9IDA7DQo+ID4NCj4gPiAtICAgICAgIGlmIChjYXJkLT5leHRfY3Nk
LmNhY2hlX3NpemUgPiAwICYmIGNhcmQtPmV4dF9jc2QuY2FjaGVfY3RybCAmIDEpIHsNCj4gPiAr
ICAgICAgIGlmIChtbWNfZmx1c2hfYWxsb3dlZChjYXJkKSkgew0KPiA+ICAgICAgICAgICAgICAg
ICBlcnIgPSBtbWNfc3dpdGNoKGNhcmQsIEVYVF9DU0RfQ01EX1NFVF9OT1JNQUwsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRVhUX0NTRF9GTFVTSF9DQUNIRSwgMSwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDQUNIRV9GTFVTSF9USU1FT1VUX01T
KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWNfb3BzLmggYi9kcml2ZXJz
L21tYy9jb3JlL21tY19vcHMuaA0KPiA+IGluZGV4IDU3ODJmZGY0ZThlOS4uMjY4MmJmNjY3MDhh
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jX29wcy5oDQo+ID4gKysrIGIv
ZHJpdmVycy9tbWMvY29yZS9tbWNfb3BzLmgNCj4gPiBAQCAtMTksNiArMTksMTEgQEAgZW51bSBt
bWNfYnVzeV9jbWQgew0KPiA+ICBzdHJ1Y3QgbW1jX2hvc3Q7DQo+ID4gIHN0cnVjdCBtbWNfY2Fy
ZDsNCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgbW1jX2ZsdXNoX2FsbG93ZWQoc3RydWN0
IG1tY19jYXJkICpjYXJkKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gY2FyZC0+ZXh0X2Nz
ZC5jYWNoZV9zaXplID4gMCAmJiBjYXJkLT5leHRfY3NkLmNhY2hlX2N0cmwgJiAxOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICBpbnQgbW1jX3NlbGVjdF9jYXJkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCk7
DQo+ID4gIGludCBtbWNfZGVzZWxlY3RfY2FyZHMoc3RydWN0IG1tY19ob3N0ICpob3N0KTsNCj4g
PiAgaW50IG1tY19zZXRfZHNyKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCk7DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0KPiANCj4gSGF2aW5nIHNhaWQgdGhlIGFib3ZlLCB3ZSBjbGVhcmx5IHdhbnQg
dG8gdGFnICRzdWJqZWN0IHBhdGNoIGZvcg0KPiBzdGFibGUga2VybmVscyBhcyB3ZWxsLCB3aGlj
aCBtZWFucyB3ZSBuZWVkIGEgc2ltcGxlIHBhdGNoIGFzDQo+IHBvc3NpYmxlLg0KPiANCj4gQ2xl
YXJseSAkc3ViamVjdCBwYXRjaCBzaG91bGQgaGF2ZSBjb21lIGZpcnN0LCBwcmlvciB0byBteSBw
YXRjaCB3aGVyZQ0KPiBJIGFkZGVkIHRoZSAtPmZsdXNoX2NhY2hlKCkgYnVzIG9wcyBjYWxsYmFj
aywgYXMgaXQgbWVzc2VzIHRoaW5ncyB1cC4NCj4gDQo+IFRoZXJlZm9yZSwgSSBkZWNpZGVkIHRv
IHJlYmFzZSBteSBuZXh0IGJyYW5jaCB0byBkcm9wIHRoZSBwYXRjaCBhZGRpbmcNCj4gdGhlIC0+
Zmx1c2hfY2FjaGUoKSBidXMgb3BzIChJIHdpbGwgcmUtcG9zdCB0aGUgcGF0Y2ggYWZ0ZXIgd2Ug
aGF2ZQ0KPiBnb3QgeW91ciBjaGFuZ2VzIGluKS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIHJlLWJh
c2UgJHN1YmplY3QgcGF0Y2ggYW5kIGFkZHJlc3MgbXkgY29tbWVudHM/IE15DQo+IGFwb2xvZ2ll
cyBmb3IgdGhlIG1lc3MhDQpEb25lLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEtpbmQgcmVn
YXJkcw0KPiBVZmZlDQo=
