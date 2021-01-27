Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Jan 2021 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B7E2074A
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Jan 2021 08:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhA0IcQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:32:16 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:47713
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231452AbhA0IaL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Jan 2021 03:30:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me2Yu+DOYjN/ohWK/cEgjz26BWvVdslr8mUslVVIAqT2jNBWBWziTnTUuzClGtO/7EmeRLQ3vayNGBV5nbJAIH1MFvSWbESNHaoK0RQjX5VcHj5XwAu2qYDNzTCKhCyxutnx+qM0dmiiaXdMlgsHOzdBNbn03/Ywv7zvALhJl3M8sEZwiZFFPMeXIN2aBn/r6SmW6kqT155wRc6E13OEl9ewY4SqSwYtx+pUqAmPTza603xrw9N9v6HKINuak6sKrGgcrWoBSbMDHXBXe+S0ICrWVWvouNg8FwtAWQZOUmxyC5QeFibxZrizz63IavInmSiYynUKLy/YD8+4gZr0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2APbPrcAngYikPF7NKC66LzOrPWQfGYVqMQE0ZFMNMc=;
 b=SxANK5D1J+oC9HDla/dprewSKz9WG1T1H1NKDeFt9dwoIqxMWuw/7ajbSCngmfAVElVAm2dsJ5DINH+TdHVbCNVYpn95atLLaHCK6RxJXhVbGGtzTDup3DWFjXe1di7deibPpt+xodqDJD5nm6qahzs+/zFpx3za1BG4C1A3vUcSm6W1Y8xhdFglMVACQ6QvPgk7Sg5YmX4aCxxgmwkiMVcGjYSw+CCWrtVm253BctGWyVbaFHC7FYBy8tkyRbc7r17OXMm5LKgt7vr4hDIvaLfQnLJFcnUfsCEb+g9KaQ1IZOZdxH4PgFYBLCjWeg4OsAu+e3RK8Lg3bPsD8/IjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2APbPrcAngYikPF7NKC66LzOrPWQfGYVqMQE0ZFMNMc=;
 b=GmriMSs/537qfCMVAL0KV4/rgmGObUIzORaUSFgjElPT4azBtfCxuN/2kpuS8Ye3T2ugM80048gXn+AScF7YZsWNefVfM27rlOaOm2+xxD6VItDuJU/svvDNlxtBKS7hjmlHx2HwPAB5C1f7VSQufE6ohu3E6cptCNaTx7mvEm4=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 08:29:21 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%6]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 08:29:21 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Topic: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Index: AQHW7VI/XCfffnuP3USlljEPQMf6YqowiQuAgAFKvICAAEN0gIAJDFEAgAAL1YA=
Date:   Wed, 27 Jan 2021 08:29:21 +0000
Message-ID: <PH0PR11MB5077F5514775B94CD4B8085695BB9@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
 <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
 <VI1PR04MB5294AB4D2C810A6278F1D83B90BB0@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5294AB4D2C810A6278F1D83B90BB0@VI1PR04MB5294.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [192.103.52.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b160ecac-1928-4ed0-d18c-08d8c29da566
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-microsoft-antispam-prvs: <PH0PR11MB4821CEB917C1CE2D5CFFB7B295BB9@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKchrcCXYQJzKzie7AwVrlwKBhEH1ftjxllQ7UIv5q7ZqLXdklLfT/4o5y4B6yrL/OnXsqOqUK8KZAPUXKlggZ1H1l0LjE17iD2OKkN1XsmOASVS31faF6I09hie0Vusvjl5HHoujeynXqet1MaLoZcBuWt1ZlVOZwUlZ9+VRnIPQIsobdm5wfvq/3mQquyAL5ytdolqS/1h0xURujDgwkcWF5KCx6UJQTnEHCDXT+ED1ZnDwga7bPZ/W4/knCPd1u9P0zfC9cdPOWjuq5iIb2j9vedyPp3C54L5iLqz+4TxAKHKshSpyoOWUjf34gIrallJnjCPoVh1Tal0pW+GOutBj8/dRBC2lvZBOApqAYjainwnSNWMtUVKkEy9+Exy2vu7JgzQYM4tf4JHroVuZZTa9+ES43Ru2YuZ0wRMt9SrZQGfHAft1bSqe+Q37VVOsNetO+gviQY90bA/DZN5uZiRkgBqnx6UoDsXnE6h46uMHSOURMOG/amNzOfkbNYVZ530UYoCBOihq3LlgCfgog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(346002)(366004)(376002)(64756008)(66946007)(76116006)(66476007)(66556008)(53546011)(8936002)(66446008)(4326008)(54906003)(110136005)(186003)(86362001)(83380400001)(71200400001)(66574015)(6506007)(8676002)(26005)(2906002)(7696005)(33656002)(478600001)(316002)(5660300002)(55016002)(52536014)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UzBJQ09RNUVPSHVUYW5GVmNQQWNlZTZqSHdWWVBQVU8xWHppeWt2TU50OXNJ?=
 =?utf-8?B?TnBRUURPN3pkd2l6ZTdrdXdqbE9kUEdRajZoQ3I2YzM5dmV1cHZ4VStMMkpE?=
 =?utf-8?B?TFhQdkp6QkZwdWFSTU56TG0xZHJSTE1oSDUxNVJHaENSV2p4NmN2bXo0ZUl6?=
 =?utf-8?B?RXpEdWJMY2tmN3RWVURhNmViWWc2MmZSbit6cFc5WWRTN1A4c3k3ZnJNUlBq?=
 =?utf-8?B?UkUxTGl1U2djNGNWQlJLMzAwbHJrUzArRUVHOWJST1JhV2NhN1VsenFtd0Vw?=
 =?utf-8?B?ZjhZSU14cys3clNSWS9tYWtuNlBoRC9TQ1VVVUpDK2VLMGFVUEhNeFBkTy8r?=
 =?utf-8?B?QU91OHNESGJxVXFsMWxqS2ozVHdZV29kSWtIaXloYVZKY2VRRFRhVFFxWlln?=
 =?utf-8?B?ZlVLRkNZdXpvbWRuLzJ6WVlHaEJmR3kyMEFhY2dOUUVOSWdvcC9SVU9VTjVC?=
 =?utf-8?B?a0thdUsrU1RGMldSaGhnWFRHazZtbTArS0dlT00wb29PQVN0YUdzdGdEckR3?=
 =?utf-8?B?bDZsZUhnR0xadmJoT3FFKzdUM3IxckpCN0o1dDJqUm83c0pyWjVBQmRZSUpM?=
 =?utf-8?B?UktNY0oySncrMW5oelkvV1d4c1BiaERENVBRZ1RXS282OW9Ccys4U2xRSmtl?=
 =?utf-8?B?VEF0TG1BRHc1czNYREt1TlNLQ3gvMnFJWjh0VGRWRnNzVkorbURid0ZtM1RR?=
 =?utf-8?B?OFpUMTVyRklZZTJqUHZZYk0wTS9WWFZSQnpBNmFyaGhzRzFRY3ZESFRwTkYx?=
 =?utf-8?B?L3RRRWZ2UFVLWC9MNVkwMlJ1WFVXQjBacE0ya1ZTVUpkektGYTQrVUxocnJY?=
 =?utf-8?B?N0RKMjZ1dXd4NlFueDNzT0QvQmFJZHZDOUVxbnVPTXd5cEJSVXduaVVRWjdS?=
 =?utf-8?B?VlFYb1Vzb21sU2lJSnZWVm1LSWtvUHZ0RVFUTDI0NGtDemQrN1huL0ZDVk54?=
 =?utf-8?B?WFk0dVd6eGdJMVNicEE3eTExaHRNdE9LM0pyT3dnTlhlS0VOd1FacXNrQUtN?=
 =?utf-8?B?MXlEUDRhN2VZUFBPdndTdWNFdDgwd1RUMG9RUko5OGNtcUpvSFIyTzdNTEkx?=
 =?utf-8?B?QUFibnZsSkxRTGFlOEFzSTBjaG1KVFFXZGQwREdHQzZ0NXhPUVI4L0tpK2hV?=
 =?utf-8?B?ck8zRXZObjc0SVVQV1E5TmhsbG9ZYm5XNnBDcURJekQzOVlpRmNWa29PTU5h?=
 =?utf-8?B?elRwb1kweGQ1YUNYTmo1ci9IN1llQ3pKUUJycHdjRWRkOHB3KzRHUTNkOEpR?=
 =?utf-8?B?QjhzdGgzRldrcFRGOHQzOGp1dFYyNlRubURsRFIyMlFCczBuSFplazJlS0Z4?=
 =?utf-8?B?UjlhNTg4Tjlxb1RqbUpOSzYyUmNxVUkyZTFrRHEwZUlQSEtWNGJGMHdncGlQ?=
 =?utf-8?B?Zk5xbzRxQmpGSzRGbmdGZTdQeHRzOFZ1UnE3OUlwK1I2SU8ybHl0eDZEeFI0?=
 =?utf-8?Q?KIndvct5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b160ecac-1928-4ed0-d18c-08d8c29da566
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 08:29:21.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68wA+gMEWNfJXVNgh97o6o/WCKbQbtnIy8WtjR+8d4SxypKLOOEnZAqrOaaFYAsP8XDoZ6un1zrTPWu7EpcmZ6Qzot1BwUrXC+yinSAuLsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCb3VnaCBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDI3LCAyMDIxIDM6MzYgUE0N
ClRvOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IFdhbmcsIFhpYW9sZWkg
PFhpYW9sZWkuV2FuZ0B3aW5kcml2ZXIuY29tPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPg0KQ2M6IFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5vcmc+OyBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgTGludXggS2Vy
bmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6
IFJFOiBbUEFUQ0hdIG1tYzogY29yZTogQXBwbHkgdHJpbSBicm9rZW4gcXVpcmsgdG8gUjFKNTdM
DQoNCltQbGVhc2Ugbm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBh
ZGRyZXNzXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5z
c29uIFttYWlsdG86dWxmLmhhbnNzb25AbGluYXJvLm9yZ10NCj4gU2VudDogMjAyMeW5tDHmnIgy
MeaXpSAyMToyNg0KPiBUbzogV2FuZywgWGlhb2xlaSA8WGlhb2xlaS5XYW5nQHdpbmRyaXZlci5j
b20+OyBGYWJpbyBFc3RldmFtIA0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz47
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+OyANCj4gbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCANCj4gPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogY29yZTogQXBwbHkgdHJp
bSBicm9rZW4gcXVpcmsgdG8gUjFKNTdMDQo+DQo+ICsgRmFiaW8sIEhhaWJvDQo+DQo+IE9uIFRo
dSwgMjEgSmFuIDIwMjEgYXQgMTA6NTQsIFdhbmcsIFhpYW9sZWkgDQo+IDxYaWFvbGVpLldhbmdA
d2luZHJpdmVyLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaQ0KPiA+DQo+ID4gPkFyZSB5b3Ug
c3VyZSB0aGlzIGlzIGFuIGVNTUMgcHJvYmxlbSBhbmQgbm90IGEgbW1jIGhvc3QgZHJpdmVyIGlz
c3VlPw0KPiA+DQo+ID4gPkNhbiB5b3UgZWxhYm9yYXRlIG1vcmUgd2hhdCBoYXBwZW5zPw0KPiA+
DQo+ID4gV2hlbiBJIHVzZSB0aGUgbWtmcy5mMmZzIHRvb2wgdG8gZm9ybWF0IHRoZSBlTU1DIGZp
bGUgc3lzdGVtIG9uIHRoZSANCj4gPiBpbXg4cXhwIGJvYXJkLCBiZWNhdXNlIG1rZnMuZjJmcyB3
aWxsIHVzZSBzZWNkaXNjYXJkIGZpcnN0LCB3aGVuIA0KPiA+IGVudGVyaW5nIG1tY19ibGtfaXNz
dWVfc2VjZGlzY2FyZF9ycSBlcmFzZSwgb25jZSB0aGUgcGFyYW1ldGVycyBhcmUNCj4gcGFzc2Vk
IGludG8gTU1DX1NFQ1VSRV9UUklNMV9BUkcsIHRoaXMgZnVuY3Rpb24gd2lsbCB0YWtlIGEgbG9u
ZyB0aW1lIA0KPiB0byByZXR1cm4gLg0KPiA+IFRoZSBwcm9ncmFtIGhhcyBub3QgZW5kZWQsIGhh
cyBiZWVuIGluIFRBU0tfVU5JTlRFUlJVUFRJQkxFIHN0YXRlLg0KPiA+DQo+ID4gSSBjb21wYXJl
ZCB0aGUgbWtmcy5leHQ0IHRvb2wgdG8gZm9ybWF0IHRoZSBmaWxlIHN5c3RlbS4gQmVjYXVzZSBp
dCANCj4gPiBkaXJlY3RseSB1c2VzIG1tY19ibGtfaXNzdWVfZGlzY2FyZF9ycSwgdGhpcyBpcyBh
IG5vcm1hbCBmb3JtYXR0aW5nDQo+IHBoZW5vbWVub24uDQo+ID4NCj4gPiBtbWNfYmxrX2lzc3Vl
X3NlY2Rpc2NhcmRfcnEgYW5kIG1tY19ibGtfaXNzdWVfZGlzY2FyZF9ycSBhcmUganVzdA0KPiBk
aWZmZXJlbnQgY29tbWFuZHMgYW5kIHBhcmFtZXRlcnMgc2VudCBieSB0aGUgaG9zdCBhcyBhIGJ1
cy4NCj4gPiAgSSBkaWQgbm90IHNlZSB0aGUgZGVzY3JpcHRpb24gb2YgdHJpbSBpbiB0aGUgZGF0
YSBzaGVldC4gQ291bGQgdGhlIA0KPiA+IGhvc3QgZHJpdmVyDQo+IGNhdXNlIHRoaXMgcHJvYmxl
bT8NCj4NCj4gWWVzLCBpdCBjYW4gLSBhbmQgd2UgaGF2ZSBoYWQgaXNzdWVzIGxpa2UgdGhlc2Ug
YmVmb3JlLiBTbyBiZWZvcmUgDQo+IGFkZGluZyBhIGNhcmQgcXVpcmssIEkgdGhpbmsgd2UgbmVl
ZCB0byBtYWtlIHN1cmUgdGhpcyBpc24ndCB0aGUgY2FzZS4NCj4NCj4gV2hlbiB1c2luZyBNTUNf
U0VDVVJFX1RSSU0xX0FSRywgaXQncyB2ZXJ5IGxpa2VseSB0aGF0IHRoZSByZXF1ZXN0IA0KPiB0
YWtlcyBsb25nZXIgdG8gY29tcGxldGUuDQo+DQo+IFRoZSBtbWMgaG9zdCBpcyByZXNwb25zaWJs
ZSBmb3IgZWl0aGVyIGRlYWxpbmcgd2l0aCBidXN5IGRldGVjdGlvbiANCj4gd2l0aCB0aGUgaGVs
cCBvZiBpdHMgSFcvY29udHJvbGxlciAtIG9yIGlmIHRoYXQgY2FuJ3QgYmUgc3VwcG9ydGVkLCAN
Cj4gdGhlIG1tYyBjb3JlIGZhbGxzIGJhY2sgdG8gcG9sbGluZyB0aGUgY2FyZCBmb3IgYnVzeSB3
aXRoIGEgQ01EMTMuDQo+DQo+IFNlZSBtbWNfZG9fZXJhc2UoKSBpbiAvZHJpdmVycy9tbWMvY29y
ZS9jb3JlLmMNCj4NCj4gPg0KPiA+IE5vdGU6DQo+ID4gVGhlIGhvc3QgZHJpdmVyIEkgdXNlIGlz
IHNkaGNpLWVzZGhjLWlteC5jDQo+DQo+IEFscmlnaHQsIEkgaGF2ZSBsb29wZWQgaW4gRmFiaW8g
YW5kIEhhaWJvIHRoYXQga25vd3MgdGhpcyBkcml2ZXIsIA0KPiBsZXQncyBzZWUgaWYgdGhleSBj
YW4gaGVscC4NCj4NCg0KPiBIaSBVbGYgYW5kIFhpYW9sZWksDQoNCj4gSSB1c2UgdGhlIG1rZnMu
ZjJmcyB0b29sIGZvcm1hdCBhIHBhcnRpdGlvbiBvbiBvbmUgU2FuZGlzayBlTU1DIGNoaXAgb24g
aW14OCBwbGF0Zm9ybSwgZG8gbm90IG1lZXQgaXNzdWUuDQo+IEkgYWRkIHNvbWUgbG9nLCBjb25m
aXJtIG1rZnMuZjJmcyBjYWxsIHRoZSBtbWNfYmxrX2lzc3VlX3NlY2Rpc2NhcmRfcnEoKSwgYW5k
IHRoZSBhcmcgaXMgTU1DX1NFQ1VSRV9UUklNMV9BUkcuDQo+IEZvciB0aGUgYnVzeSBkZXRlY3Rp
b24sIGlteCB1c2RoYyBoYXMgb25lIHJlZ2lzdGVyIGJpdCByZXByZXNlbnQgdGhlIGRhdDAgc2ln
bmFsIGxldmVsLiBTbyBmb3IgeW91ciBtbWMgZGV2aWNlLCBpdCBzaG91bGQgYmUgdGhlIG1tYyBk
ZXZpY2UgdHJpbSBmZWF0dXJlIHByb2JsZW0uDQoNCkhpIFVJZiBhbmQgaGFpYm8NCg0KSSBkaWQg
dGhlIHZlcmlmaWNhdGlvbiBhZ2FpbiBhbmQgZm91bmQgdGhhdCB0aGUga2VybmVsIHZlcnNpb24g
SSB1c2VkIGJlZm9yZSB3YXMgdjUuNC4gVGhlIGxhdGVzdCBrZXJuZWwgZG9lcyBub3QgaGF2ZSB0
aGlzIHByb2JsZW0uDQogVGhpcyBwYXRjaCBpcyBub3QgYWNjdXJhdGUuIEkgd2lsbCBjb25maXJt
IGxhdGVyIHdoZXRoZXIgaXQgaXMgY2F1c2VkIGJ5IHRoZSBtaXNzaW5nIHBhdGNoIG9mIHY1LjQu
DQoNClRoYW5rcw0KWGlhb2xlaQ0KDQo+IEJlc3QgUmVnYXJkcw0KPiBIYWlibw0KPiA+DQo+ID4g
VGhhbmtzDQo+ID4gWGlhb2xlaQ0KPg0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPg0KPiA+DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxm
LmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjAsIDIw
MjEgOTo0MSBQTQ0KPiA+IFRvOiBXYW5nLCBYaWFvbGVpIDxYaWFvbGVpLldhbmdAd2luZHJpdmVy
LmNvbT4NCj4gPiBDYzogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz47IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+OyANCj4gPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBM
aW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IA0KPiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogY29yZTogQXBwbHkgdHJpbSBicm9r
ZW4gcXVpcmsgdG8gUjFKNTdMDQo+ID4NCj4gPiBbUGxlYXNlIG5vdGUgdGhpcyBlLW1haWwgaXMg
ZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10NCj4gPg0KPiA+IE9uIE1vbiwgMTggSmFu
IDIwMjEgYXQgMDU6MjcsIFhpYW9sZWkgV2FuZyANCj4gPiA8eGlhb2xlaS53YW5nQHdpbmRyaXZl
ci5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFIxSjU3TCBtbWMgY2hpcCBodyBjYXBpYmls
aXR5IGluZGljYXRlcyB0aGF0IGl0IHN1cHBvcnRzIHRyaW0gDQo+ID4gPiBmdW5jdGlvbiwgYnV0
IHRoaXMgZnVuY3Rpb24gZG9lcyBub3Qgd29yayBwcm9wZXJseSwgdGhlIFNESU8gYnVzIA0KPiA+
ID4gZG9lcyBub3QgcmVzcG9uZCwgYW5kIHRoZSBJTyBoYXMgYmVlbiB3YWl0aW5nIHNvIHNldCBx
dWlya3MgdG8gDQo+ID4gPiBza2lwIHRyaW0NCj4gPg0KPiA+IEFyZSB5b3Ugc3VyZSB0aGlzIGlz
IGFuIGVNTUMgcHJvYmxlbSBhbmQgbm90IGEgbW1jIGhvc3QgZHJpdmVyIGlzc3VlPw0KPiA+DQo+
ID4gQ2FuIHlvdSBlbGFib3JhdGUgbW9yZSB3aGF0IGhhcHBlbnM/DQo+ID4NCj4gPiBLaW5kIHJl
Z2FyZHMNCj4gPiBVZmZlDQo+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvbGVp
IFdhbmcgPHhpYW9sZWkud2FuZ0B3aW5kcml2ZXIuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9tbWMvY29yZS9xdWlya3MuaCB8IDQgKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29y
ZS9xdWlya3MuaCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmggDQo+ID4gPiBpbmRleCBkNjhl
NmU1MTNhNGYuLjYzZTAyMzkxYzEzMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2Nv
cmUvcXVpcmtzLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiA+
IEBAIC04OSw2ICs4OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVwIF9fbWF5YmVf
dW51c2VkDQo+IG1tY19ibGtfZml4dXBzW10gPSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICBN
TUNfUVVJUktfU0VDX0VSQVNFX1RSSU1fQlJPS0VOKSwNCj4gPiA+ICAgICAgICAgTU1DX0ZJWFVQ
KCJWWkwwME0iLCBDSURfTUFORklEX1NBTVNVTkcsDQo+IENJRF9PRU1JRF9BTlksIGFkZF9xdWly
a19tbWMsDQo+ID4gPiAgICAgICAgICAgICAgICAgICBNTUNfUVVJUktfU0VDX0VSQVNFX1RSSU1f
QlJPS0VOKSwNCj4gPiA+ICsgICAgICAgTU1DX0ZJWFVQKCJSMUo1N0wiLCBDSURfTUFORklEX01J
Q1JPTiwNCj4gQ0lEX09FTUlEX0FOWSwgYWRkX3F1aXJrX21tYywNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgIE1NQ19RVUlSS19TRUNfRVJBU0VfVFJJTV9CUk9LRU4pLA0KPiA+ID4NCj4gPiA+ICAg
ICAgICAgLyoNCj4gPiA+ICAgICAgICAgICogIE9uIFNvbWUgS2luZ3N0b24gZU1NQ3MsIHBlcmZv
cm1pbmcgdHJpbSBjYW4gcmVzdWx0IGluDQo+IEBADQo+ID4gPiAtOTgsNiArMTAwLDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtbWNfZml4dXAgX19tYXliZV91bnVzZWQNCj4gbW1jX2Jsa19maXh1
cHNbXSA9IHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgIE1NQ19RVUlSS19UUklNX0JST0tFTiks
DQo+ID4gPiAgICAgICAgIE1NQ19GSVhVUCgiVjEwMDE2IiwgQ0lEX01BTkZJRF9LSU5HU1RPTiwN
Cj4gQ0lEX09FTUlEX0FOWSwgYWRkX3F1aXJrX21tYywNCj4gPiA+ICAgICAgICAgICAgICAgICAg
IE1NQ19RVUlSS19UUklNX0JST0tFTiksDQo+ID4gPiArICAgICAgIE1NQ19GSVhVUCgiUjFKNTdM
IiwgQ0lEX01BTkZJRF9NSUNST04sDQo+IENJRF9PRU1JRF9BTlksIGFkZF9xdWlya19tbWMsDQo+
ID4gPiArICAgICAgICAgICAgICAgICBNTUNfUVVJUktfVFJJTV9CUk9LRU4pLA0KPiA+ID4NCj4g
PiA+ICAgICAgICAgRU5EX0ZJWFVQDQo+ID4gPiAgfTsNCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjEN
Cj4gPiA+DQo=
