Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C1C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE6E619C6
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 13:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhC3N5L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:57:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57488 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3N4r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 09:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617112607; x=1648648607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qida0L11wxFfBywllpjA6MEZevp0f0ukcU3a5tfHhi0=;
  b=QBj2TGN2zAucxyF0wMTapwf2yEUF0XuwmYxPjLULRYndvLdNmIVlZzOq
   MhmYFlQkgsL7jadYCVrEV2PtSduWiSkhBHUxPRqpcUNL0cwSQb+9ZIOj3
   myMpQQvKAOwO9fWmO/o1Hh2calucMtVksK9S6oY4spnJwRJx+O2dh0oTu
   lI2c17DS2kQcSs1lFgvEfcPuGW8kzg2rSU7o4y/veWeL8av4ro8Veo3AW
   V+HsleN7a2FrqdG+gXae+ptRU+tXFEg2hfIS6srvF545JEqpsGKpiI2Ax
   cPtQJf9D/L9TWeiKZGxJfQ+RzNGYbfODAaqIXQD+s7CKNnlRmN1pJIUos
   g==;
IronPort-SDR: PqISq7kB6zsRSMfzMNiw6ng1vgpAy44K11c5Qtf3zwrtDBlhj3Z/yUS8mlj40ivmBCbBtkgZSh
 TPiaGICC0bvqQ+mBWYbNsj7lYoxaNSWCBP6XlF3+a0XPWahhhR8en8pYQmFZXLGoY54FJOYq5m
 WqYSAGk88BooVDR0Kuddh7XuAN77viii8HU3FKWLTjBB5wzgc2fQhUZKxpyXqi75Y7PfrcBJkv
 MNCNQ0akklHg5vNJ4Dqoq05EGplJpR5ECmifzIz7TJzRTwuQ3fo5ikvhffoenlja5KqghlpwPP
 gBg=
X-IronPort-AV: E=Sophos;i="5.81,290,1610380800"; 
   d="scan'208";a="163267745"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2021 21:56:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5aiFHY8824FrTXn2snGSRlmrzCFtiD+74Qji2FSZxWNtXMi0LpZKKNUPnCl2RTT5BmikOCvJDJYCaT9K19zCSbMQZhDOV1N+g7z4SX0FEFgHOGGHP063g8P69a952b48Ztg9p3CENfhRzyPl6f8V6y3yl4ix4mfargIcmhcv8nAs4eL3Bo7y3E4grW+l0HLNzdDwuRUPrO+VR17oopy2Y2Cmp2Jv+jLB7/XfOfi6I94dsmljCBoyx7Pm0Hudoc+GTKMdnDPYbcXn6Qyi8rffU7c+HKo9vdBZK7FUI+3Aq1AMiqF47YwhGkXcfxcY6Q6UBUNFrJl/ixCLZpRJd3YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qida0L11wxFfBywllpjA6MEZevp0f0ukcU3a5tfHhi0=;
 b=ifM092yLeD27aYghzt8OsERQH4qzksdV7hGFa/Jpr7DXduCY9foMY2o372iQtUGpTP04aphttmvM6WTyyiYWJU7ZNZkntV7DHaKq+/2vf0PkTPTNoVxFXevf5ZCV28HdOBWL8SmkDOJ+24GdqIMiYXLpo06FyU7Qp+IgJPcllXoyWZ23PGGvv/d00j3lTbAMY9rVG0wxsYBk4+47jxCw6LVZjuFDR0MDPb/rWC1rEQrPrqWsr4FJuorpg6M1t7JyFign2Auaq8/BhtyOwc2j4dJYWWDUeD7hK8/rZPPOfYx2RGuMkXtWbbyqH6pW3aawQiX8dkJJPaMmU0QcD8RIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qida0L11wxFfBywllpjA6MEZevp0f0ukcU3a5tfHhi0=;
 b=FS4VseOUYFXQF7KrK8DwIlJzDisIc6nAAxZgp1dz65/O37EseRvi0MYhxMqnxtIcwfS8MBjLNjfDNk3T8qn5yhxk7/tQyyRIKfoJ5Nu6z7XXywmY2qO0RQXbgKSr56KU89UfdRI1/oXsqIN59HdzgfhuD080Rf5Gsy2ldhgi/cA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4491.namprd04.prod.outlook.com (2603:10b6:5:1f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Tue, 30 Mar 2021 13:56:36 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::e824:f31b:38cf:ef66%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:56:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Xingyu Wu <wuxy20@gmail.com>
CC:     "jwerner@chromium.org" <jwerner@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "wuxy20@lenovo.com" <wuxy20@lenovo.com>
Subject: RE: [PATCH V2 1/1] mmc-utils: fix messy code printed
Thread-Topic: [PATCH V2 1/1] mmc-utils: fix messy code printed
Thread-Index: AQHXJWSh4WFlnTdn9Eq2k0xzk46GEaqcia+g
Date:   Tue, 30 Mar 2021 13:56:36 +0000
Message-ID: <DM6PR04MB657527125A887F6CA613E482FC7D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210208022642.7823-1-wuxy20@gmail.com>
 <20210208022642.7823-2-wuxy20@gmail.com>
 <CAPDyKFq2AVb7tA3W73MeCyxxsqaGrw-3nMV9_V3xue=S7O+Ppg@mail.gmail.com>
In-Reply-To: <CAPDyKFq2AVb7tA3W73MeCyxxsqaGrw-3nMV9_V3xue=S7O+Ppg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15851a20-d9eb-48e6-3bd8-08d8f383a25c
x-ms-traffictypediagnostic: DM6PR04MB4491:
x-microsoft-antispam-prvs: <DM6PR04MB4491E19650CD83386E32EF2EFC7D9@DM6PR04MB4491.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZ/qOlolnSws0CDUTBk8fxFZgPLRBSUt8wW1eQjdqBZY0iAVx+6BPxEgzRKELExm7LgBSJEexNqTDfDTkh0keOfZuRBhGmL31g8cBERryv2o/XiZ1elVqWJEYzw9R9nBoAbyTdif5pobXvOPz7nRX5XGOaEdIO+7Gv5DyQ1PXqDymg+98juL2nzNA9RJ5AlJnl/YF2YAojnxEemq1+gqOreqsVTOXgP0tLoU0C3W0zxGSwAJKXYjgwe2g/xzv6Odm9Dva0hIoi0a/6pVEHcaEreLghlhSeXj3SQLQK+C9VmLqvLVqru8KeodTR29vf5ZDbDPdOyShx8K2mbjAt5KAGpMZgPYy8LWDeZIBmlMIDBUaskvMdCI/vUWAHct735Ax4KxrzIzVP0mIRVqWz+uxg08gGwpw1caPkhPgByWD/UbAeGHHCAghu2Ga71uEoHSZBzQSUGQraEng+Qp41Fvx/cYIkcbib9+ZGmeYlmwJZa3PuYxJTLpswNfJQ3qG+S2gV9oygN/9nz+dusD6nCqYIxnsh3IoyDZUoIAecKmaoeZW6s9wlTuNj7vxuITWMtqCOUUbtEEU8I0VqllE/LZgNn7nKku6re9xN9yRN9OVNgIFD44FkDN54yjwW247KyyGnsr++a/mQaXl/lDDQtcAoOIfgd/SuU9WMH7K4xgzrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(5660300002)(52536014)(33656002)(2906002)(66446008)(8676002)(83380400001)(66476007)(6506007)(55016002)(54906003)(110136005)(4326008)(478600001)(64756008)(26005)(186003)(9686003)(71200400001)(8936002)(86362001)(7696005)(316002)(76116006)(66556008)(66946007)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0thWTZBMEtzdW9xUk5QLy93eXlzNHZ3TGJRSGVjNS8wVGtGZUNOVTdSZEpW?=
 =?utf-8?B?UmVEQTV3N2ZnOGw3MnR3V0VkMzBiUkphOEV0SkRXdUN3VkZKYUxtZ0J0aFB0?=
 =?utf-8?B?QkNoNW4wWk9YeWlOVmNMeEx1dnBUN01Ta1lDeUtaK2RSbTJHUDRqcWtaMkVH?=
 =?utf-8?B?U2lzMldaUHZ6eVVQRkVnN09iNVFuMUJSNk1sNFFxM283NGU0a1ZLMS82QVdu?=
 =?utf-8?B?dUNUakRnOGpRVkZXWTlJZzMxTk85YmVreHJGaEZhNmdFaTZNOW5ZUmtMQ1Zn?=
 =?utf-8?B?NU1aU0RmUythZjVzcHV4eUxzMmdiMzJwSlpLTUJNZE02OTdVVTJxY01IaDNF?=
 =?utf-8?B?ckdzcllKNGhyY2o3ZG45WEY5Vlp0Qmw4S3laUVNLOTFoWVgzTkxpU2hFeGNz?=
 =?utf-8?B?aEVzcnBTVE0wV1BQZGpYblAwckI4VmIzckhSaWhRSXFmUGJ6T3VvYWUrUUpy?=
 =?utf-8?B?QytqMkxjdUFuMGJBcHZJbytoNXp3MzV2YUN2cDVKbXM0YkJybHlVOFdtWC9D?=
 =?utf-8?B?UTRxUnZPVk5aaFB1UVBwQU82dWVEUGc5TE52U2l0RC96bHB5dlBmaFYvQVN6?=
 =?utf-8?B?NnI1MzIwdjVXYkIxM0dCUEJKWmMvRlpWRkhJNVAxR0RqdUh1bS9PbmdYcFBo?=
 =?utf-8?B?OXVzdmhuWFJkYk0vNllubXZVS085bk40bVJoTG1adzRVS3VHSHpoTG4wMXRk?=
 =?utf-8?B?Ui8yYWxrTUpheWFieUQ4RU5Oa2ZpT3d6QklhM0wzdW5FM1JzTzFNSkJlS2dp?=
 =?utf-8?B?UGhYSlpJNm10eEJ2ZS9MYXVDS0ovOGdFWG04VXJOTVZoOUYrSWRjT0VRYXdo?=
 =?utf-8?B?VG5wU2tXaTZnSEZMajZpZWI0MGdhaW5WbnZxbUtOZDJZNmVjRXh5NTU0Vmtq?=
 =?utf-8?B?VHBrN1ZCZDQzMmxTRWNiRzExRTVOSEJOaTlFY1dUVTNER3pIUFQvdDZxYTYz?=
 =?utf-8?B?UXg4akRHUFhWZmdqaDNuemtQa01tV1krRmZqb085R3RYVXVxMUlTaTNkeWts?=
 =?utf-8?B?dzVxdWtSQkcwQTcxSmVIYWVNbERsK25JSE54Q2I1dlVZSmttZDRJVVFKN0x2?=
 =?utf-8?B?WHkyZUxEUkpIMFRpM3Y2Q2cyc21VRjVabTVScnR4S2tUNWZ1dkF2YnJYYUFm?=
 =?utf-8?B?dllYL3hCeGR4YlM5S3FrVXovbHFoRk9OZzdORjFjYmgzU2o1SVVCQXM3NFRv?=
 =?utf-8?B?bDNFMCtzVVF3aHJ5YVNISXRTSnFmMkJUMEV0bXUvaW14OHplakpxK25qOWNi?=
 =?utf-8?B?UTZrc2l4bXdrZ1JjSVVINlNjQlJ5LzgwUkhZOWlYYkRUSWlmOVNGWkptQmdv?=
 =?utf-8?B?ZlkyaURCMTlZSE5BbmxXUHdtb2k1TWhuZWREZFY4MWcxOHd1alJ0R29UVnlO?=
 =?utf-8?B?a3FoMzI0US9oZ1NsOHMwbDRLUUFFd2hqNGNpRE9DUS9HUVRzRmlJZVNSNUdX?=
 =?utf-8?B?NEFhNnRZNG1DMm0rdXJZS1VKZVpaekJRRGVNV0dmU1hLN21DblFHeC95bDFu?=
 =?utf-8?B?cE93VUNvVmdDcnA1RkMzOGpLNENLblFCVHhCV2hoZkd2UTZpRGpsZUxtQy9h?=
 =?utf-8?B?c3B1V3Q0d0pURm02VGpCeVFjTFBsejNFV2E4VlE3M0tET0pPQTVKUXNmV0ds?=
 =?utf-8?B?OU96UmhpQk15ZFlRaUU1UHF0SGdHSHlVcUgwT3JPa1c0ZmwrRXBQOTBuWm54?=
 =?utf-8?B?QXNhT1p0ZDBublhHNFpuVGpUZ2xnOEdBWnIwbmhZaXRNdnBROThxNnJocjdr?=
 =?utf-8?Q?GLF7TZSiZiJGwUDQvg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15851a20-d9eb-48e6-3bd8-08d8f383a25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 13:56:36.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lC1FyPYXA7GRTsCWN3Y4v7MhU+zRVPHXzaNPy056BS55dzOMeVP4y8qzGTadOkvegXdyuXHH3JH55+A8T4gw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4491
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiArIEF2cmkNCj4gDQo+IE9uIE1vbiwgOCBGZWIgMjAyMSBhdCAwMzozMCwgWGluZ3l1IFd1IDx3
dXh5MjBAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNvbWUgdmVuZG9ycyBvZiBlTU1DIHVz
ZSBkaWZmZXJlbnQgZm9ybWF0IHRvIGRlZmluZSB0aGUNCj4gPiBGaXJtd2FyZSBuYW1lLiBJZiB0
aGUgRmlybXdhcmUgbmFtZSB1c2VzIGNoYXJhY3RlciBhbmQgaWYNCj4gPiBpdCBleGNlZWRzIHRo
ZSBwcmludGFibGUgcmFuZ2Ugb2YgQVNDSUkgKDB4MjB+MHg3ZSksDQo+ID4gbW1jLXV0aWxzIHdp
bGwgcHJpbnQgbWVzc3kgY29kZS4gVGhpcyBjaGFuZ2UgY2FuIGZpeCB0aGUNCj4gPiBtZXNzeSBj
b2RlIGlzc3VlLCBpZiB0aGUgZmlybXdhcmUgbmFtZSBpcyBub3QgcHJpbnRhYmxlLA0KPiA+IHBy
aW50IGl0IG91dCBhcyBoZXhhZGVjaW1hbCwgdGhpcyBjaGFuZ2Ugd2FzIHZlcmlmaWVkIG9uDQo+
ID4gY2hyb21pdW0gcHJvamVjdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpbmd5dSBXdSA8
d3V4eTIwQGdtYWlsLmNvbT4NCj4gDQo+IEF2cmksIGNhbiB5b3UgcGxlYXNlIGhhdmUgYSBsb29r
IGF0IHRoaXMgYW5kIHByb3ZpZGUgY29tbWVudHMgb3IgeW91ciBhY2s/DQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPiANCj4gPiAtLS0NCj4gPiAgbW1jX2NtZHMuYyB8IDEzICsrKysrKysr
KysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW1jX2NtZHMuYyBiL21tY19jbWRzLmMNCj4gPiBp
bmRleCBmYjM3MTg5Li5kMDkwYTI0IDEwMDY0NA0KPiA+IC0tLSBhL21tY19jbWRzLmMNCj4gPiAr
KysgYi9tbWNfY21kcy5jDQo+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPiAgI2luY2x1ZGUgPHN0
ZGludC5oPg0KPiA+ICAjaW5jbHVkZSA8YXNzZXJ0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9m
cy5oPiAvKiBmb3IgQkxLR0VUU0laRSAqLw0KPiA+ICsjaW5jbHVkZSA8Y3R5cGUuaD4NCj4gPg0K
PiA+ICAjaW5jbHVkZSAibW1jLmgiDQo+ID4gICNpbmNsdWRlICJtbWNfY21kcy5oIg0KPiA+IEBA
IC0xNzU4LDggKzE3NTksMTYgQEAgaW50IGRvX3JlYWRfZXh0Y3NkKGludCBuYXJncywgY2hhciAq
KmFyZ3YpDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGlmIChleHRfY3NkX3JldiA+
PSA3KSB7DQppbnQgaTsNCnBsZWFzZSBkb24ndCBtaXggZGVjbGFyYXRpb24gYW5kIGNvZGUNCg0K
PiA+IC0gICAgICAgICAgICAgICBwcmludGYoImVNTUMgRmlybXdhcmUgVmVyc2lvbjogJXNcbiIs
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgKGNoYXIqKSZleHRfY3NkW0VYVF9DU0RfRklS
TVdBUkVfVkVSU0lPTl0pOw0KPiA+ICsgICAgICAgICAgICAgICBwcmludGYoImVNTUMgRmlybXdh
cmUgVmVyc2lvbjoiKTsNCk1heWJlIGFkZCBhIGNvbW1lbnQgdGhhdCB3aWxsIGV4cGxhaW4gd2h5
IDggYnl0ZXM6IC8qIEZJUk1XQVJFX1ZFUlNJT04gWzI2MS0yNTRdICovDQoNCj4gPiArICAgICAg
ICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCA4OyBpKyspIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBjaGFyIGMgPSBleHRfY3NkW0VYVF9DU0RfRklSTVdBUkVfVkVSU0lPTiArIGld
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaXNwcmludChjKSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiJWMiLCBjKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChjICE9IDApDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwcmludGYoIlxceCUwMngiLCBjKTsNCmVsc2UgDQoJYnJlYWs7
DQphbHNvIHdoeSBkbyB5b3UgbmVlZCB0aGUgXFx4PyAgJTAyeCBzaG91bGQgd29yaw0KDQpUaGFu
a3MsDQpBdnJpDQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgcHJp
bnRmKCJcbiIpOw0KPiA+ICAgICAgICAgICAgICAgICBwcmludGYoImVNTUMgTGlmZSBUaW1lIEVz
dGltYXRpb24gQQ0KPiBbRVhUX0NTRF9ERVZJQ0VfTElGRV9USU1FX0VTVF9UWVBfQV06IDB4JTAy
eFxuIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBleHRfY3NkW0VYVF9DU0RfREVWSUNF
X0xJRkVfVElNRV9FU1RfVFlQX0FdKTsNCj4gPiAgICAgICAgICAgICAgICAgcHJpbnRmKCJlTU1D
IExpZmUgVGltZSBFc3RpbWF0aW9uIEINCj4gW0VYVF9DU0RfREVWSUNFX0xJRkVfVElNRV9FU1Rf
VFlQX0JdOiAweCUwMnhcbiIsDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
