Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62AC433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F526144D
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 06:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhDWGki (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:40:38 -0400
Received: from de-smtp-delivery-11.mimecast.com ([62.140.7.241]:24172 "EHLO
        de-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240393AbhDWGkh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 02:40:37 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2052.outbound.protection.outlook.com [104.47.21.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-HrlBS9-uNbqkGqzld9qZng-1; Fri, 23 Apr 2021 08:38:23 +0200
X-MC-Unique: HrlBS9-uNbqkGqzld9qZng-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2119.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:84::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 06:38:22 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 06:38:22 +0000
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gbW1jOiBlbmFibGUgVUhTIHZvbHRhZ2Ugc3dpdGNoIGZv?=
 =?utf-8?B?ciBTRFNDIGlmIHN1cHBvcnRlZOOAkOivt+azqOaEj++8jOmCruS7tueUsWxp?=
 =?utf-8?B?bnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmfku6Plj5HjgJE=?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBtbWM6IGVuYWJsZSBVSFMgdm9sdGFnZSBzd2l0Y2ggZm9yIFNE?=
 =?utf-8?B?U0MgaWYgc3VwcG9ydGVk44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgt?=
 =?utf-8?B?bW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Thread-Index: AQHXN+FTXUcmKL1cg0aJQqpoaGswk6rBpbam
Date:   Fri, 23 Apr 2021 06:38:22 +0000
Message-ID: <CWXP265MB2680E0D998AF13C041D18859C4459@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<35677467-4ccd-9eae-3800-2bc7597cfa0f@rock-chips.com>
In-Reply-To: <35677467-4ccd-9eae-3800-2bc7597cfa0f@rock-chips.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b910540-d7fe-44e0-bb36-08d9062263cd
x-ms-traffictypediagnostic: CWXP265MB2119:
x-microsoft-antispam-prvs: <CWXP265MB211989F67ACCC5DED99F2B45C4459@CWXP265MB2119.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: krNvLFlsAkWPnqoyt0JQIObAKxZ4tDhbTR+Q4E0ospf7Qv5xbgMg62mX7LE6NYON1WCt8PIdKkSKzJHoV2bexbWZRr++j4UIckY5++OC1uKeECJY3aVjriCOSVtp4wdWc3l9qOo/5KkqN8QTMy4maUHiU9L2zNetwVQ7jOA1ln6PGqxrj4rif/5pTOb15rkergcgIHri0ajGApDiQ9uUOlsfeWbrRHSmxxSIB7uazjVp7uiJhgxZNoe/8/exiHSOG7Cj51PBAkXIB90QObV3LYvY5qOCIfRork5Je0hvSlwVDFpS8m1msYRL5SYG2T/wdu5FYtcYaRbU1cIOA1GG0R7DDMLUy3qCFsWS4k7u78hpdfQCvC94RmZTyewFVZ9SoofuiXfKIQG3kPmmEGrX1e5UwsznXbgranOairD3QvEQafNCMFIxmpo7BrMMatBPVfLWqaXNi25bUs/EU8E9ambStwYiM+BdMjrWi8W1LRx5St6cs1Zwr4BgrCsUzBlirq4vtWxYWqCGnCJ14/OrXvq9RcJRB4FMJDbPFNAog1jBV0uTN5Ax5W2Hhukam0jrpdW7+bLzJdbaM8DtRbN32/BqJI7IOww1B4zwzK4GqIEsMvjYx+vTXd5zuET/RIJA88EiUmAjNIn/QPR58YVAmN2SxOLL4clROhvxgGa8uztYgpByv0C6YyCex8OJfAXM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(376002)(136003)(346002)(366004)(6916009)(478600001)(33656002)(5660300002)(86362001)(83380400001)(52536014)(9686003)(122000001)(4326008)(66574015)(26005)(316002)(6506007)(85182001)(54906003)(38100700002)(71200400001)(66476007)(66556008)(76116006)(66446008)(91956017)(2906002)(7696005)(66946007)(224303003)(85202003)(966005)(186003)(53546011)(55016002)(64756008)(8936002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?utf-8?B?UXJHZUh6SHFEMzdZeDBqN2Q5WjhXWFpCVXd5aklVMnJwTUt3bHlOQkMzWDNK?=
 =?utf-8?B?clNPWExBMFlyd2tYdFlGL3lEeTBtNkVXZk5BdEVCenI5Q21yc0UrYVRXcWhP?=
 =?utf-8?B?eHV4Mkd5VVZVMEZnT200dE9EQ3FNOFpqTWdDUXN4NlhwWHh5QzRYbUhkOWhn?=
 =?utf-8?B?R3kwUGJFNWpoNlBxd2VPckNrY1c4QmpFQlZJVno1Y2x4RGRtdzI5RkhRbnIx?=
 =?utf-8?B?VURvU1piRG4yaElTZWNiTStxVVc1VG5ObTRJTTJ6UXFMaXlFOHhCRlRyVFZL?=
 =?utf-8?B?dlRmazhNVGY2Q051eTBOUlR0RkRkVnpzbHB0Q3dmNkpJWUFtWUxGYUhqZTdR?=
 =?utf-8?B?OG9VM0Q4K2NTRFB2Z1dxdFkzdkcra3BOWUExTWovdXRDanpWa0phKy9ZMFVM?=
 =?utf-8?B?NVMxM21GZlNQaGZLU05lTXdOZDhXY3JvTGdLYm5SWXNIYmlCalJWU3NKU3RB?=
 =?utf-8?B?cEZLd3JLbFRSUXZTM2JZRnNuVXRhTVBZeHhrRm1reHUvcG9hdFNyNUlsOVNG?=
 =?utf-8?B?M1U3cW51djRwTXdWaElFVWxaYmNVQ0RBdFNGS3N6VjliVFNaL1ZFbWtZaE03?=
 =?utf-8?B?STV4MTM2bHRTUTdCdjl1UTQ1ejdOV2FocVkvS2JRZWFNT2VNZ1VxR1NKVHJX?=
 =?utf-8?B?M2lZZzkvWUZMb3dSWFBHc1J2TjNGRS9tTnMzQjUvTWhUNEZxaERvZVJka1Ra?=
 =?utf-8?B?NndMSWRmaGh3NEcyd29VMlRHVzB4bG5jVUJoVThqY3FjcmlSTitBK3VBenNO?=
 =?utf-8?B?cVloRUVoTWtlWWloQXdDQ21MR1RyUmxKK1NOYU5jSTBOOUJqZkM4Q05IS2dQ?=
 =?utf-8?B?dElxaHBzcnVVQ3hESXNsbk1WejErUGtOSFpzbVlLb3FUQ2EzLzNaSVdzTUVU?=
 =?utf-8?B?Rk9BT28xTWxJdWtxMGZSWVB6UW0vRGNtaUFhb0ZmbllnQVVCNWNmMEVTVkRD?=
 =?utf-8?B?czhSakJpWTNQUXRJS1RoWlRod1JVWnZmNjQzK29hbUhpUE8vODlJbjNFd3Uy?=
 =?utf-8?B?K05heVArWXNNUytTZnN1QXRJa1dIOHNzeFJWd1NXUkVteEZITG1vZU5NSUJD?=
 =?utf-8?B?ZVlCYXpQbENmRG1EOCtsZEtUZzhMZkpDNU1yWXNncG9temZ4OU1KNE5Rc0ln?=
 =?utf-8?B?Z00zRlpGUnVYRmxRWHRMSm1pVXkyRUkzbXBENENKS3FxSXcwV0FFUGhGeU5y?=
 =?utf-8?B?WW9WVEgvQnE0dTlROE1pZjh6TVN0R1Z4OE5KeCt0SlVrekkvOHlkek1scHpt?=
 =?utf-8?B?eUY4TjlTWWJUbjI1Zkd0WjVUbC9wSUw3cUxCY0RlTS9SS2JEcVJKNjZLekE5?=
 =?utf-8?B?RTRob0RjT0EzblNhS09tWUNHQlBaazVlWmxMcmxsMTA4d1dEWmt5N0VHcjAx?=
 =?utf-8?B?ZzdZaFE4VlFoemkwSjdaWmR1ckFyTEppaHQ3NVNSVnlrMXBKWHVBZzdZUjJI?=
 =?utf-8?B?MTZVV0hNRnBDd0pKZWpDclZBZ0dVUEJJUmlRZ2xSWVBOdnJlbzhialhEaGl1?=
 =?utf-8?B?L29OSXR1ZnYrc204NlovRFhBc084SklIVDdiRUkydXVqZXEzQ2tJUnE2Ynlz?=
 =?utf-8?B?SUYrb2lHbWQzVm1wZ3pJOU4xR2l2R3RpajEzTGVoYUVUd0phbmNuL1JLelZ5?=
 =?utf-8?B?eHYwUUVtV0dJSk90b0RzMVAwc2RFeXBBMHQ4bnBZd05qenRiNXU3c1ZhcVVK?=
 =?utf-8?B?am9zendXcCtweG11SUU1SGI4UlcybHVHd0ZiaUVnNzI4VWd2KzI2NklzR3Er?=
 =?utf-8?Q?1pbRqI1D0fO0V2Aens=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b910540-d7fe-44e0-bb36-08d9062263cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 06:38:22.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5HyUAUNbXLaHvp4ntrpRb0IrKr7+1k7ohB/jRn52wvj21glqgZ5T5QsPejWuf1oJfArrRY98N8lqpJF5fJHdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2119
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Q2xhaW1pbmcgVUhTLUkgc3VwcG9ydCB3aXRoIFNEU0MgaXMgcHJldHR5IHJhcmUsIGZvciBvYnZp
b3VzIHJlYXNvbnMgKG5hbWVseSB0aGV5IGFyZSBub24tc3RhbmRhcmQsIHNvIGl0J3MgYSBnYW1i
bGUgaWYgYSBob3N0IG1ha2VzIHVzZSBvZiBpdCksIGJ1dCBoZXJlIHlvdSBnbzoKaHR0cHM6Ly9k
ZS5ycy1vbmxpbmUuY29tL3dlYi9wL21pY3JvLXNkLWthcnRlbi84NzQzOTEwLwooc29ycnkgZm9y
IHRoZSBnZXJtYW4sIHRoZSBzaXRlIGhhcyBhIGVuLiBzdWJwYWdlLCBidXQgaXQncyBjZXJ0aWZp
Y2F0ZSBzZWVtIHVudHJ1c3RlZC4pClRoZSBtb3JlIGxpa2VseSBjYXNlIGlzIHRoYXQgdGhleSBk
byBub3QgYWR2ZXJ0aXNlIFVIUy1JIHRvIGN1c3RvbWVycywKYnV0IHRoZSBjYXJkIHdpbGwgc2hv
dyBzdXBwb3J0IHRvIHRoZSBob3N0LgpMZXQncyBsb29rIGF0IHRoaXMgcHJvZHVjdCwganVzdCBh
cyBhbiBleGFtcGxlLgpodHRwczovL3d3dy50bWUuZXUvaHRtbC9FTi9nb29kcmFtLWluZHVzdHJp
YWwtaW5kdXN0cmlhbC1zZC1zZC1taWNyby1tZW1vcnktY2FyZHMvcmFta2FfMTUyNDJfRU5fcGVs
bnkuaHRtbApUaGV5IHByb3ZpZGUgYW4gTUxDIGFuZCBwU0xDIHZlcnNpb24gb2YgZWFjaCBkZXZp
Y2UsIHdpdGggaGFsZiB0aGUgY2FwYWNpdHkgbmF0dXJhbGx5LgpUaGUgNEdCIE1MQyBjbGFpbXMg
VUhTLUkgc3VwcG9ydCwgdGhlIDJHQiBwU0xDIGlzIHZlcnkgbGlrZWx5IHRvIGJlIHRoZSBzYW1l
IGNvbnRyb2xsZXIsCml0IG9ubHkgY2xhaW1zIENsYXNzIDYuClNvIGVpdGhlciB0aGV5IHNwZWNp
ZmljYWxseSBjaGFuZ2VkIHRoZSBmaXJtd2FyZSB0byByZW1vdmUgYW55IFVIUyBzdXBwb3J0IGlu
ZGljYXRpb24sCm9yLCBtb3JlIGxpa2VseSBJTU8sIHRoZSBjYXJkIHN0aWxsIHJlcG9ydHMgVUhT
IHN1cHBvcnQgdG8gdGhlIGhvc3QuClN1Y2ggYSBjYXJkIHdvdWxkIGJlbmVmaXQgZnJvbSB0aGlz
IHBhdGNoLgoKRGlzY2xhaW1lcjogSSBkbyBub3Qgb3duIHRoZSBwcm9kdWN0IGFuZCBoYXZlIG5v
dCBjb25maXJtZWQgdGhpcyBkZXZpY2UgaW4gYW55IHdheSwKYnV0IEkgaGF2ZSBzZWVuIFVIUyBz
dXBwb3J0IG9uIG90aGVyIGRldmljZXMgdGhhdCBkbyBub3QgYWR2ZXJ0aXNlIGl0IGZvciB0aGVp
cgpTRFNDIHZlcnNpb25zLgpJZiB0aGUgbWFpbGluZyBsaXN0IHdvdWxkIGJlIGludGVyZXN0ZWQs
IEkgY2FuIHRyeSB0byBhY3F1aXJlIHN1Y2ggZGV2aWNlcywgbGlzdGVkIGluCnB1YmxpYyBvcGVu
IHN0b3Jlcy4gTW9kZXJuLCBwb3RlbnRpYWxseSBVSFMgc3VwcG9ydGluZyBjYXJkcy4gYXJlLAph
cyBtZW50aW9uZWQgaW4gdGhlIGluaXRpYWwgTWFpbCwgb2Z0ZW4gU0xDIG9yIHBTTEMgYW5kIG9m
dGVuIGFyZSBtYWRlIG9uCmEgY3VzdG9tZXJzIHJlcXVlc3QuCgoKRnJvbTogU2hhd24gTGluIDxz
aGF3bi5saW5Acm9jay1jaGlwcy5jb20+ClNlbnQ6IEZyaWRheSwgQXByaWwgMjMsIDIwMjEgMzoz
NCBBTQpUbzogQ2hyaXN0aWFuIEzDtmhsZSA8Q0xvZWhsZUBoeXBlcnN0b25lLmNvbT4KQ2M6IHNo
YXduLmxpbkByb2NrLWNoaXBzLmNvbSA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPjsgcGFsaUBr
ZXJuZWwub3JnIDxwYWxpQGtlcm5lbC5vcmc+OyBodXl1ZTJAeXVsb25nLmNvbSA8aHV5dWUyQHl1
bG9uZy5jb20+OyB0aWFudGFvNkBoaXNpbGljb24uY29tIDx0aWFudGFvNkBoaXNpbGljb24uY29t
PjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgpTdWJq
ZWN0OiBSZTogW1BBVENIXSBtbWM6IGVuYWJsZSBVSFMgdm9sdGFnZSBzd2l0Y2ggZm9yIFNEU0Mg
aWYgc3VwcG9ydGVk44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIu
a2VybmVsLm9yZ+S7o+WPkeOAkSAKwqAKT24gMjAyMS80LzIyIDIxOjE4LCBDaHJpc3RpYW4gTMO2
aGxlIHdyb3RlOgo+IElnbm9yZSB0aGUgcmVwb3J0ZWQgY2FwYWNpdHkgaWYgdGhlIGNhcmQgb3Ro
ZXJ3aXNlIHJlcG9ydHMgVUhTIHN1cHBvcnQuCj4gCj4gQ3VycmVudGx5IFNEU0MgY2FyZHMgcmVw
b3J0aW5nIFVIUyBzdXBwb3J0IGV4Y2VwdCBmb3IgdGhlIENDUyBkbyBub3QgcnVuCj4gdGhyb3Vn
aCB0aGUgdm9sdGFnZSBzd2l0Y2guCj4gV2hpbGUgc3RyaWN0bHkgc3BlYWtpbmcgYSBTRFNDIGNh
cmQgY2Fubm90IHN1cHBvcnQgVUhTIGluIGNvbXBsaWFuY2UKPiB3aXRoIHRoZSBzdGFuZGFyZCwg
dGhlcmUgaXMgbm8gZ29vZCByZWFzb24gdG8gdGhyb3R0bGUgdGhlbSB0aGF0IHdheS4KPiBFc3Bl
Y2lhbGx5IGZvciBwU0xDcyBpbiBwcmFjdGljZSBzdWNoIGNhcmRzIGJlbmVmaXQgZ3JlYXRseSBi
eSB0aGlzIHBhdGNoLAoKQ2R1bGQgeW91IHByb3ZpZGUgc29tZSBtb3JlIGluZm9tYXRpb24gYWJv
dXQgdGhlIFNEU0MgY2FyZHMgd2hpY2ggb25lcyAKYXJlIGxhYmVsZWQgYXMgVUhTLCBlLmcgYnJh
bmQsIHdlYnBhZ2UuLi4uCgo+IGFzIHRoZXkgY2FuIGJlIG5ldyBhbmQgVUhTIHN1cHBvcnRpbmcs
IGJ1dCBtdXN0IG5vdCBsaWUgYWJvdXQgdGhlaXIgQ0NTLgo+IFRoZSBiZWhhdmlvdXIgb2YgbGlu
dXgtbW1jIGZvciBTRFNDIGlzIGRldmlhdGluZyBmcm9tIHRoZSBzdGFuZGFyZCBhbnl3YXkKPiBp
biBzdWNoIGEgY2FzZSwgYXMgdGhlIGNhcmQgaXMgdHJlYXRlZCBhcyBVSFMgY2FyZCBub3Qgc3Vw
cG9ydGluZyB0aGUKPiB2b2x0YWdlIHN3aXRjaCBpbiBnZW5lcmFsLgo+IFN1Y2ggYSBjYXJkIHdp
bGwgY29tZSB1cCBhcwo+IG1tYzA6IG5ldyB1bHRyYSBoaWdoIHNwZWVkIFNEUjI1IFNEIGNhcmQg
YXQgYWRkcmVzcyAwMDAxLgo+IFRodXMgdGhlIHN1YnN5c3RlbSB3aWxsIHN1cHBvcnQgQ01EMjMg
YW5kIG90aGVycyB0byB0aGUgY2FyZC4KPiBCdXQgaWYgd2UgZGV2aWF0ZSBmcm9tIHRoZSBzdGFu
ZGFyZCBhbnl3YXksIHRoZW4gd2UgbWlnaHQgYXMgd2VsbAo+IG5vdCB0aHJvdHRsZSBTRFNDIHRv
IDI1TUIvcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxjbG9laGxlQGh5
cGVyc3RvbmUuY29tPgo+IC0tLQo+wqDCoCBkcml2ZXJzL21tYy9jb3JlL3NkLmMgfCA3ICsrKy0t
LS0KPsKgwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29y
ZS9zZC5jCj4gaW5kZXggNmZhNTFhNmVkMDU4Li4yODFjYTJkYThlMGIgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9tbWMvY29yZS9zZC5jCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZC5jCj4gQEAg
LTg0MSwxMSArODQxLDEwIEBAIGludCBtbWNfc2RfZ2V0X2NpZChzdHJ1Y3QgbW1jX2hvc3QgKmhv
c3QsIHUzMiBvY3IsIHUzMiAqY2lkLCB1MzIgKnJvY3IpCj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGVycjsKPsKgwqAgCj7CoMKgwqDCoMKgwqDCoCAvKgo+IC3CoMKgwqDC
oMKgICogSW4gY2FzZSBDQ1MgYW5kIFMxOEEgaW4gdGhlIHJlc3BvbnNlIGlzIHNldCwgc3RhcnQg
U2lnbmFsIFZvbHRhZ2UKPiAtwqDCoMKgwqDCoCAqIFN3aXRjaCBwcm9jZWR1cmUuIFNQSSBtb2Rl
IGRvZXNuJ3Qgc3VwcG9ydCBDTUQxMS4KPiArwqDCoMKgwqDCoCAqIEluIGNhc2UgUzE4QSBpbiB0
aGUgcmVzcG9uc2UgaXMgc2V0LCBzdGFydCBTaWduYWwgVm9sdGFnZSBTd2l0Y2gKPiArwqDCoMKg
wqDCoCAqIHByb2NlZHVyZS4gU1BJIG1vZGUgZG9lc24ndCBzdXBwb3J0IENNRDExLgo+wqDCoMKg
wqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoCBpZiAoIW1tY19ob3N0X2lzX3NwaShob3N0KSAmJiBy
b2NyICYmCj4gLcKgwqDCoMKgwqDCoMKgICgoKnJvY3IgJiAweDQxMDAwMDAwKSA9PSAweDQxMDAw
MDAwKSkgewo+ICvCoMKgwqDCoCBpZiAoIW1tY19ob3N0X2lzX3NwaShob3N0KSAmJiByb2NyICYm
ICgqcm9jciAmIDB4MDEwMDAwMDApKSB7Cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXJyID0gbW1jX3NldF91aHNfdm9sdGFnZShob3N0LCBwb2NyKTsKPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoZXJyID09IC1FQUdBSU4pIHsKPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0cmllcy0tOwo+IAoKDQpIeXBlcnN0b25lIEdt
YkggfCBMaW5lLUVpZC1TdHJhc3NlIDMgfCA3ODQ2NyBLb25zdGFueg0KTWFuYWdpbmcgRGlyZWN0
b3JzOiBEci4gSmFuIFBldGVyIEJlcm5zLg0KQ29tbWVyY2lhbCByZWdpc3RlciBvZiBsb2NhbCBj
b3VydHM6IEZyZWlidXJnIEhSQjM4MTc4Mg0K

