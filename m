Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24368C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDF42399A
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 09:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbhAUJzm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:55:42 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:34130
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbhAUJzQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Jan 2021 04:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVLnZ1/ap3ecvFRuDbO8Ry6mtUBlxeicA3XI0Vy/3oIwJJAMAbwxe2VxeZNvMQc4Oxa75xyP2zlRRC2q4ViSET5Dr0byM4YNbctCyIyK6GWk6cFcJ+YHobGOUeD+ztH4gu96h7nZyRbPbK9lVbb5qLy5X67sCQaL9rGbb02PmXiEnzpG8smI58L5VId5hXNJPLJF2XqSF+BlSlSdXyBBgZ/8Qlo97Q70KvdjsYgoQhJ6nvqzHdq2vJeDNk9r/n9zBuey/xtz08SHfnSdosxS0382F6fR8yIgCLUoSYEjxus2fYWXgOlpmNNNqxUEok859DKEwALTARaRLABLqcBg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngqBtc5JuHiOTdgJvXwuZ6Od6LKi3A/9/U/lLC20hco=;
 b=H7iFlj6/mtRMu6A9O1CxxJeWn23lrwe7cKcigGbC3fPL4GGHANJQJWs0JDXvMrxDOsMEmsdWE5mYdBQtkmPhiPw5tY/SL7QNY+jiSLpyP6PgznWHfK0ByyAFzLRJ7rmFnH/7JWz2DoZkJbkMWliUwx4ZCRNv5mwK/aSoWpK3RCTkdcKmxBN8/tc945LpwvaDhMfry8qF2DG0+pIhNMZwnwDfC+sc4yqTzy+94s9OwtQtC6dKY4fmRf3gHxyXRB4ZaogYmcNX4uUh3CPHg1sMqA5iNIyr+XPtQWbjwuwRQnvvFEUpeY7JOK7cIZhZ75YVShPuO4LMXLXfHszD0LwhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngqBtc5JuHiOTdgJvXwuZ6Od6LKi3A/9/U/lLC20hco=;
 b=AeRAZ6aAwrLmpDC7oqm8daeYOj9pEc0SjF09vlsYaIwPM07QFeQN2B+29R4Dsl/HBuYdzhrgvcSpMh9EkYxtz/jYROGtpdPWuOjm2Qw1SjeHHrRZNvmz097VNJ5GlMVL4aRTMPdvO8Z5KYzaQ/FTgwBuxMo3RcTlpb2UJWwDvfg=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 09:54:03 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%6]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 09:54:03 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Topic: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Index: AQHW7VI/XCfffnuP3USlljEPQMf6YqowiQuAgAFKvIA=
Date:   Thu, 21 Jan 2021 09:54:03 +0000
Message-ID: <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
In-Reply-To: <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 533a8c23-e293-41ea-7a64-08d8bdf27c2b
x-ms-traffictypediagnostic: PH0PR11MB5208:
x-microsoft-antispam-prvs: <PH0PR11MB520886154E9D45BBD704441495A10@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4030gbqtHL9Yndk2PPgvpPAv1HfcXF8GZP1dzrfBRJJ2ba4qWdqAm2L6RcbOMU7Ax6tK9EvBYaD8YkIUfAbNM7VrnbljM62++zbCHfZYLxwULK8RwBFwvFvJqRnzZIXXmF/F7IypjLdf/pWDnrRClFmOACaSEC5Pvdf2bcKHP9CWBq32i2gDQaQZyFSlFM5JdyD+/OHRWhzIoRTo1n6NZvt3dzJ7fgiMirMVWIF3A3MX1vrxjKF56vuhR0ecjUqTfbEiS/bHM1jHy7o8NsGF2u4WdD/oIdBEhZZ9xqhFsMIn1KwEdab5jeYKfVKMxPv07K5jY2kZf6Yk8+WXn06cH8QbkmKZ7WAYY8mlMEraHekUPR8QQ7jsyXuWsZF+qP2mDs/bUZWXtz4bI2Y7PGzcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(136003)(346002)(316002)(53546011)(26005)(8936002)(2906002)(76116006)(66946007)(66556008)(6506007)(7696005)(186003)(9686003)(83380400001)(8676002)(54906003)(66446008)(5660300002)(64756008)(478600001)(52536014)(86362001)(33656002)(4326008)(66476007)(71200400001)(66574015)(6916009)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UjRoN2NCWUx3ZEdxMUsxaXNudDdqdmJieExqS0lybGZuZGZkem8zdERhWVBM?=
 =?utf-8?B?ZzhrY2NIb21DNitPVTVpQ29mRURtT0RtdGszT3pWR0ZEMSt0T2FLdFFKNzJG?=
 =?utf-8?B?U3RTd2VIbFZxV0QyVzNSU0d2dkRnMXRvWXFqdkZFc1dLSFFieW5qYzFjc0hP?=
 =?utf-8?B?MlN6bXNHQTQzaHhaclVuT3B2K1o5RzUvTExuK2xCWFptZEk2Qmc4MzlqVTJS?=
 =?utf-8?B?Q0FEam00ejI2Myt6SDZUTEcrMUIwU2I3UFg5NHdvK2h0TlF1ak56TlFHWVl3?=
 =?utf-8?B?VlNBazJMeXh5cEdlZDAvUXFYWHd0amZrRk9BSGFhMS92WlRXcHNJbmZSLzQr?=
 =?utf-8?B?dmZ4Rko4eEZ1RTFqUkdsK3I0NmxqbUY5M0hUaDhJZHYyOU5pdEZhRHdZb3NU?=
 =?utf-8?B?QlF0VXJNWGRBNTNtZ2psR3hpWU5wWE1zbHRWTVJHT29KcGZ0cmJQMFQvU0dF?=
 =?utf-8?B?M2R2OWE4cVFoVDU2VmxSWUZ0NU5HTElKK2d3UVdYTHRNY1YyRVc2bjUvQnhy?=
 =?utf-8?B?L3lsakVNZjJiWjJGeStMODc4YkhBT3cvVElYNGhWOVlGSFUwUTRwZURLNnVY?=
 =?utf-8?B?TU9JME1Wdm1FamhyRjhZVmV0YTl1VHBKNW84KzFrQ2tITnFZQTZLMEZHSXpx?=
 =?utf-8?B?aWQzcFBRSCtPdEZFRENMNmpZUTBqekovYzZiWFFGc2l0Uk0vQjdKNDJTdmJH?=
 =?utf-8?B?Q1lIdGJESmhmNGJ2b1JsS0hCWjFuMWFHNE8rTlBSVVR2SUNraTltbzRld0pi?=
 =?utf-8?B?S1NYcW5rR0N6V2l5bmYyZmJIQTRtM2ZUd1pOdVpnTUdmR2hzcFExTk9LdDBa?=
 =?utf-8?B?WFM0eEY2MzJWanNsM3F4TC9Yemp0SXcwYzdsM1JMdStUM1FiZGZMN0d5TVZE?=
 =?utf-8?B?TWtoSCtBWjhhNGkzTmJIbGJkRjBERzZUWHNpRm92Znc2Uko1UWVpdHh6U3RJ?=
 =?utf-8?B?UFZTdjB6NVllZVljNUF2cVpsb2xRZk5wclB5YUZoK1FlbUlxdnNFZDczTjJR?=
 =?utf-8?B?bG45c1B3NDQ5UE5vdjhOY3Nodkk3SGhqTm9nejAybTRXV3lERzE1MUYyODc5?=
 =?utf-8?B?REVWOU1VYVZLblI0MWcwVVdOMmF1c3gvOUNrQ3BaL2UrdzRJRk40TW1xbkda?=
 =?utf-8?B?dzdGOUROeGc0TnR5aUEzRHFJZnRnSU1CWE5RYm5oanNQQWJaUmJGNThSUC8y?=
 =?utf-8?B?VHgzYXU5VlVTZElsYS9vaTlaSkp4a2w3RXlGd2xrcDNEcmhjYzlvaCtOdVUw?=
 =?utf-8?B?OW9lK1VqSHE2WVV5ZDRkaW52MXN1dk03Rkk2RDdqMHIxYktYOHNWSnlLeXhz?=
 =?utf-8?Q?CZIEqCSW9Seic=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533a8c23-e293-41ea-7a64-08d8bdf27c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 09:54:03.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOuCjJ8Wola6pyMRp4aNdxSm1mY76VP6wwFCw3L5F7nLSdUnQ/4EYevlzM71DWkDQ0/JLuTrcqwwv6yIA+00nW41AtNxJnw0101EiZGlylk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkNCg0KPkFyZSB5b3Ugc3VyZSB0aGlzIGlzIGFuIGVNTUMgcHJvYmxlbSBhbmQgbm90IGEgbW1j
IGhvc3QgZHJpdmVyIGlzc3VlPw0KDQo+Q2FuIHlvdSBlbGFib3JhdGUgbW9yZSB3aGF0IGhhcHBl
bnM/DQoNCldoZW4gSSB1c2UgdGhlIG1rZnMuZjJmcyB0b29sIHRvIGZvcm1hdCB0aGUgZU1NQyBm
aWxlIHN5c3RlbSBvbiB0aGUgaW14OHF4cCBib2FyZCwgDQpiZWNhdXNlIG1rZnMuZjJmcyB3aWxs
IHVzZSBzZWNkaXNjYXJkIGZpcnN0LCB3aGVuIGVudGVyaW5nIG1tY19ibGtfaXNzdWVfc2VjZGlz
Y2FyZF9ycSBlcmFzZSwNCm9uY2UgdGhlIHBhcmFtZXRlcnMgYXJlIHBhc3NlZCBpbnRvIE1NQ19T
RUNVUkVfVFJJTTFfQVJHLCB0aGlzIGZ1bmN0aW9uIHdpbGwgdGFrZSBhIGxvbmcgdGltZSB0byBy
ZXR1cm4gLg0KVGhlIHByb2dyYW0gaGFzIG5vdCBlbmRlZCwgaGFzIGJlZW4gaW4gVEFTS19VTklO
VEVSUlVQVElCTEUgc3RhdGUuDQoNCkkgY29tcGFyZWQgdGhlIG1rZnMuZXh0NCB0b29sIHRvIGZv
cm1hdCB0aGUgZmlsZSBzeXN0ZW0uIEJlY2F1c2UgaXQgZGlyZWN0bHkgdXNlcyBtbWNfYmxrX2lz
c3VlX2Rpc2NhcmRfcnEsIA0KdGhpcyBpcyBhIG5vcm1hbCBmb3JtYXR0aW5nIHBoZW5vbWVub24u
DQoNCm1tY19ibGtfaXNzdWVfc2VjZGlzY2FyZF9ycSBhbmQgbW1jX2Jsa19pc3N1ZV9kaXNjYXJk
X3JxIGFyZSBqdXN0IGRpZmZlcmVudCBjb21tYW5kcyBhbmQgcGFyYW1ldGVycyBzZW50IGJ5IHRo
ZSBob3N0IGFzIGEgYnVzLg0KIEkgZGlkIG5vdCBzZWUgdGhlIGRlc2NyaXB0aW9uIG9mIHRyaW0g
aW4gdGhlIGRhdGEgc2hlZXQuIENvdWxkIHRoZSBob3N0IGRyaXZlciBjYXVzZSB0aGlzIHByb2Js
ZW0/DQoNCk5vdGU6DQpUaGUgaG9zdCBkcml2ZXIgSSB1c2UgaXMgc2RoY2ktZXNkaGMtaW14LmMN
Cg0KVGhhbmtzDQpYaWFvbGVpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBV
bGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIEph
bnVhcnkgMjAsIDIwMjEgOTo0MSBQTQ0KVG86IFdhbmcsIFhpYW9sZWkgPFhpYW9sZWkuV2FuZ0B3
aW5kcml2ZXIuY29tPg0KQ2M6IFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5vcmc+OyBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogY29yZTogQXBwbHkgdHJpbSBicm9rZW4gcXVpcmsgdG8g
UjFKNTdMDQoNCltQbGVhc2Ugbm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUt
bWFpbCBhZGRyZXNzXQ0KDQpPbiBNb24sIDE4IEphbiAyMDIxIGF0IDA1OjI3LCBYaWFvbGVpIFdh
bmcgPHhpYW9sZWkud2FuZ0B3aW5kcml2ZXIuY29tPiB3cm90ZToNCj4NCj4gUjFKNTdMIG1tYyBj
aGlwIGh3IGNhcGliaWxpdHkgaW5kaWNhdGVzIHRoYXQgaXQgc3VwcG9ydHMgdHJpbSANCj4gZnVu
Y3Rpb24sIGJ1dCB0aGlzIGZ1bmN0aW9uIGRvZXMgbm90IHdvcmsgcHJvcGVybHksIHRoZSBTRElP
IGJ1cyBkb2VzIA0KPiBub3QgcmVzcG9uZCwgYW5kIHRoZSBJTyBoYXMgYmVlbiB3YWl0aW5nIHNv
IHNldCBxdWlya3MgdG8gc2tpcCB0cmltDQoNCkFyZSB5b3Ugc3VyZSB0aGlzIGlzIGFuIGVNTUMg
cHJvYmxlbSBhbmQgbm90IGEgbW1jIGhvc3QgZHJpdmVyIGlzc3VlPw0KDQpDYW4geW91IGVsYWJv
cmF0ZSBtb3JlIHdoYXQgaGFwcGVucz8NCg0KS2luZCByZWdhcmRzDQpVZmZlDQoNCj4NCj4gU2ln
bmVkLW9mZi1ieTogWGlhb2xlaSBXYW5nIDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIHwgNCArKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3Jl
L3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCANCj4gaW5kZXggZDY4ZTZlNTEz
YTRmLi42M2UwMjM5MWMxMzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtz
LmgNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiBAQCAtODksNiArODksOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG1tY19maXh1cCBfX21heWJlX3VudXNlZCBtbWNfYmxrX2Zp
eHVwc1tdID0gew0KPiAgICAgICAgICAgICAgICAgICBNTUNfUVVJUktfU0VDX0VSQVNFX1RSSU1f
QlJPS0VOKSwNCj4gICAgICAgICBNTUNfRklYVVAoIlZaTDAwTSIsIENJRF9NQU5GSURfU0FNU1VO
RywgQ0lEX09FTUlEX0FOWSwgYWRkX3F1aXJrX21tYywNCj4gICAgICAgICAgICAgICAgICAgTU1D
X1FVSVJLX1NFQ19FUkFTRV9UUklNX0JST0tFTiksDQo+ICsgICAgICAgTU1DX0ZJWFVQKCJSMUo1
N0wiLCBDSURfTUFORklEX01JQ1JPTiwgQ0lEX09FTUlEX0FOWSwgYWRkX3F1aXJrX21tYywNCj4g
KyAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1NFQ19FUkFTRV9UUklNX0JST0tFTiksDQo+DQo+
ICAgICAgICAgLyoNCj4gICAgICAgICAgKiAgT24gU29tZSBLaW5nc3RvbiBlTU1DcywgcGVyZm9y
bWluZyB0cmltIGNhbiByZXN1bHQgaW4gQEAgDQo+IC05OCw2ICsxMDAsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG1tY19maXh1cCBfX21heWJlX3VudXNlZCBtbWNfYmxrX2ZpeHVwc1tdID0gew0K
PiAgICAgICAgICAgICAgICAgICBNTUNfUVVJUktfVFJJTV9CUk9LRU4pLA0KPiAgICAgICAgIE1N
Q19GSVhVUCgiVjEwMDE2IiwgQ0lEX01BTkZJRF9LSU5HU1RPTiwgQ0lEX09FTUlEX0FOWSwgYWRk
X3F1aXJrX21tYywNCj4gICAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1RSSU1fQlJPS0VOKSwN
Cj4gKyAgICAgICBNTUNfRklYVVAoIlIxSjU3TCIsIENJRF9NQU5GSURfTUlDUk9OLCBDSURfT0VN
SURfQU5ZLCBhZGRfcXVpcmtfbW1jLA0KPiArICAgICAgICAgICAgICAgICBNTUNfUVVJUktfVFJJ
TV9CUk9LRU4pLA0KPg0KPiAgICAgICAgIEVORF9GSVhVUA0KPiAgfTsNCj4gLS0NCj4gMi4yNS4x
DQo+DQo=
