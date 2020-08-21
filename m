Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B3C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34302087D
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JefX3ngp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHUIFd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:05:33 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:58702
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgHUIFc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 04:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsOdx24LRidbXuSasj9eTUqOvtfnN1qRuqLTCgtpb0VosOV0rf+lslNZah3vb7kqZQj+VWO6Gi3wNYWtfz9JClD0UuzxrI7WZsFUXlM/hpujr9/NfgmEyq5/IIwmZztLjQgYhLvlWENl/83Ki9IZnuh4nXuT1Zh0xWFbMwRD4/ip6vc/k+/UvgS1itzXKdSIvE3YpHkJtkWuZpSmV0fPk7AJ7gETzqlrlXXh9svePJSKdCFZzhqrltA2sEw45Ofn5OKePsplvp+h8TLlVkzllqwijJ8oYFeIuJPINpCls4RlHFwA20hQE7UT6a09NupPMlMzakMRoReAtB073BNgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAlZqVJcRvvzSR5u+x+yLzEz+H6/pkaXjts5QUDqXPI=;
 b=ZF1RNFsMueSf4/kLxvvXNAf3CkcUHuF/+WeiDP/lcjdDJ+3VATI+WoGu/Mf0o0cm4HmsPe+I0HBUT1mpQrXbQo8cqIHWutu69tfxjB2/EWc5M427G4LQiCibiuBrUqnUhJ/8JjZ3Hoho51P5qhgWS3Ckd2SgKo/zWkVqj7XE5qL/x+ME1BSuNe89N7jOXdTWv85RMdNpu5FJPH4esqiFRG/3SI7zcmPdedX9hboMJIqL2M1CvAPcGhbJycv29/LRO5wWXGiQgs0zjN+tsK4BuXIXqjQtEQey8r7x0o2uXGwMs5nK3OHRfZ12FhXmOM9XzKpvrfF/ZbAcMEa7uwGfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAlZqVJcRvvzSR5u+x+yLzEz+H6/pkaXjts5QUDqXPI=;
 b=JefX3ngpCs+2dIJxvZDnGkdU63+vO6YdWQpY8vhzc9C10fE895mE/SNvm7e3E6pT3k9fpexkRqsstRh3PTxJoGD7WByGOlElZ6s28pasmp7UVVBuT2/rugxsI2q1C6zv4+0sm+eTukGDUW/B7LmnOTzdkm7sAUFO2I48P4Tg8Ls=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 08:05:28 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::f858:cc14:2a9f:e8ed%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 08:05:28 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: RE: [PATCH] mmc: sdio: change to use system_freezable_wq for
 sdio_irq_work
Thread-Topic: [PATCH] mmc: sdio: change to use system_freezable_wq for
 sdio_irq_work
Thread-Index: AQHWa8rwHWjasl/vTESepA/fPmOSkKlCR7uAgAABXfA=
Date:   Fri, 21 Aug 2020 08:05:28 +0000
Message-ID: <VI1PR04MB5294AA06AE6BDCACE79ECF6E905B0@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1596701944-31965-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFpoxoamShoQJThggR7HJAFbi3JcVUEocey88wQyzOYRJA@mail.gmail.com>
In-Reply-To: <CAPDyKFpoxoamShoQJThggR7HJAFbi3JcVUEocey88wQyzOYRJA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 870225e4-b4f3-441e-b596-08d845a8f7d5
x-ms-traffictypediagnostic: VI1PR04MB6944:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB694457573BFA4A317894282F905B0@VI1PR04MB6944.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOC1t8NRN7ILO40oUNsklmoaF7u+YCrO5KWBmIIuCu9RDNxhR1TG56UuV3asv+B5NTNKtmPK4mzbEAZLhosxouuA2dRy8kn7rj+G1KdD7f0x6ZMSzbdRf3LRzUFpR1mSUr3+fNDBPxr9SgsdWoeFax12Ib8w+1YHhKr0imLZCst61ht6ak1pJ8/yWJLZXaw7aIAYJENdqjjgIiPgn8ZKGZyyx/xmePQdq0raru8oSKcGRhC0aey6IpWJtRs4y4b4fOdGxSE2jvis9NxWydzbGSBuZVcvxI5GWM9ZlKTHWjHxSEgv4aiHm6OnZaq6cZK2B1s+TDdzZFf0LdmzCbDW0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(86362001)(478600001)(9686003)(55016002)(54906003)(53546011)(6506007)(7696005)(316002)(26005)(186003)(66946007)(6916009)(76116006)(33656002)(5660300002)(66476007)(8936002)(66446008)(66556008)(8676002)(83380400001)(2906002)(71200400001)(4326008)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QQLvMyh0u8dSzFVKZJRqDi8JfsLuajA1SiWwB3fnoaobYKB6/kFT4qFdAyv0vW/tL3DLrYyExIW6c5xXLn4HUbDrHiK4Ljz4gmZun6a3+sJP4Pg2OHN4p8Xixp1670W2AkL9ripahvzkseTVQGJNIpa5dHqxlnNEekT/2URxT0YgKvSKdys+ng18OS5SZLUmmQg451QC7fU+tpZdr91Z4fk5LFknBeeptRV2TbC7+4SuE4PqrGzkTgLFUZAn2RQZnCz5bR8XjfPiC5Ug/SlkWnIWm4wUYdaTe2j403oLO3M1TM7zMjB/n3MbV/9/imH+NdczUBqQiUAwqav1+LqqgBkROSOl+7SlIKm8gsVjoDB4hVOIjajRCW8QZYY4F3M8DYpzn5LX5I9rvALIYfV6J4KKI5nrv/q6SrOm6mhgZOc9s1mE+U721HZZXiJvVujPUkOlHhtiWQf/dY+OxOnzWa+cpw9gUeHC3bk0MyzHbKZtZjnZnoL8kXLQ1Hku18H+y1lu3Xv8XRFRSHBWfXUSyq9CC4x6qOxzI/Gm37nfF34mC3AJQQy4WbVJHIPJKCr4zcU+Maq73B8jtJYgaKX53dJJYMJS3CZXIGTF12aBrSWwcgF/Yk7n5T/H9AXclS87+YTddz01jcGdrKWCEo+Kxg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870225e4-b4f3-441e-b596-08d845a8f7d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 08:05:28.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpL1byt1dn8g7MWsdjEhPVuLrvFWe5HPCTSR3ZrwAW7LFczukuSmIxb13l4VarKhKVUeM0rFtKOzErN4S+ZSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29uIFttYWls
dG86dWxmLmhhbnNzb25AbGluYXJvLm9yZ10NCj4gU2VudDogMjAyMOW5tDjmnIgyMeaXpSAxNTo1
MA0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogQWRyaWFuIEh1
bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3Jn
Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgTWF0dGhpYXMgS2FlaGxja2Ug
PG1rYUBjaHJvbWl1bS5vcmc+Ow0KPiBEb3VnIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RpbzogY2hhbmdlIHRvIHVzZSBzeXN0
ZW1fZnJlZXphYmxlX3dxIGZvcg0KPiBzZGlvX2lycV93b3JrDQo+IA0KPiBPbiBUaHUsIDYgQXVn
IDIwMjAgYXQgMTA6MjMsIDxoYWliby5jaGVuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gQ2hhbmdlIHRvIHVz
ZSBzeXN0ZW1fZnJlZXphYmxlX3dxIGJlY2F1c2UgaXQgY2FuIG1ha2Ugc3VyZSB0aGUgcXVldWUN
Cj4gPiBiZWNvbWVzIGZyb3plbiB3aGVuIHVzZXJzcGFjZSBiZWNvbWVzIGZyb3plbiBkdXJpbmcg
c3lzdGVtIFBNLg0KPiA+DQo+ID4gRmluZCB0aGlzIGlzc3VlIG9uIGkuTVg3RC1zZGIgYm9hcmQg
d2l0aCBicm9hZGNvbSBzZGlvIHdpZmkuDQo+ID4gV2hlbiBzeXN0ZW0gcmVzdW1lLCBzb21ldGlt
ZXMgdGhpcyB3aWZpIG1lZXQgdGhlIHR1bmluZyBmYWlsIGlzc3VlLg0KPiA+IEFsbCB0dW5pbmcg
Y29tbWFuZCBnZXQgY29tbWFuZCB0aW1lb3V0IGVycm9yLiBUaGlzIGlzIGJlY2F1c2UNCj4gPiBz
ZGlvX2lycV93b3JrIG9uIHN5c3RlbV93cSB3YXMgZXhlY3V0ZWQgYmVmb3JlIHRoZSBicm9hZGNv
bSB3aWZpDQo+ID4gZHJpdmVyIHJlc3VtZS4gRHVlIHRvIGJyb2FkY29tIHdpZmkgZHJpdmVyIHNl
dCB0aGUgd2lmaSBpbiBTbGVlcCBzYXRlDQo+ID4gaW4gc3lzdGVtIHN1c3BlbmQsIG5lZWQgdG8g
c2V0IHRoZSB3aWZpIHRvIFdha2Ugc3RhdGUgZmlyc3QuIFNvIG5lZWQNCj4gPiB0byBtYWtlIHN1
cmUgd2lmaSBkcml2ZXIgcmVzdW1lIGZpcnN0LCB0aGVuIGRvIHRoZSBzZGlvX2lycV93b3JrLg0K
PiANCj4gTW92aW5nIHRvIHRoZSBzeXN0ZW1fZnJlZXphYmxlX3dxIGRvZXNuJ3Qgd29yay4gU2lt
cGx5IGJlY2F1c2UgaXQncyB0b28gZWFybHkNCj4gaW4gdGhlIHN5c3RlbSBzdXNwZW5kIHBoYXNl
IHRvIGZyZWV6ZSB0aGUgcXVldWUgZm9yIFNESU8gaXJxcy4NCj4gDQo+IEkgZ3Vlc3MgeW91IGZp
Z3VyZWQgdGhhdCBvdXQsIHNvIHlvdSBwb3N0ZWQgYSB2Mj8gTW92aW5nIHRvIHJldmlldyB0aGF0
IG5vdy4uDQoNCkhpIFVsZiwNCg0KRm9yIHRoZSBWMSBwYXRjaCwgaXQgY2FuIGZpeCB0aGUgaXNz
dWUgb24gaW14N2QgYm9hcmQgd2l0aCBCcm9hZGNvbSB3aWZpLiBCdXQgdGhpcyBwYXRjaCB3aWxs
IGNhdXNlIGlzc3VlIHdoZW4gc3dpdGNoIHRvIHVzZSBNYXJ2ZWxsIDg5ODkgc2RpbyB3aWZpLiAN
Cg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
PiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgICAgIHwgMiArLQ0KPiA+
ICBkcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMgfCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgaW5kZXgN
Cj4gPiAyNmNhYmQ1M2RkYzUuLjI2OWFlNjNkMDllYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L21tYy9jb3JlL3NkaW8uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4g
QEAgLTEwMTUsNyArMTAxNSw3IEBAIHN0YXRpYyBpbnQgbW1jX3NkaW9fcmVzdW1lKHN0cnVjdCBt
bWNfaG9zdA0KPiAqaG9zdCkNCj4gPiAgICAgICAgICAgICAgICAgaWYgKCEoaG9zdC0+Y2FwczIg
JiBNTUNfQ0FQMl9TRElPX0lSUV9OT1RIUkVBRCkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgd2FrZV91cF9wcm9jZXNzKGhvc3QtPnNkaW9faXJxX3RocmVhZCk7DQo+ID4gICAgICAgICAg
ICAgICAgIGVsc2UgaWYgKGhvc3QtPmNhcHMgJiBNTUNfQ0FQX1NESU9fSVJRKQ0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHF1ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsDQo+ICZob3N0
LT5zZGlvX2lycV93b3JrLCAwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZV9k
ZWxheWVkX3dvcmsoc3lzdGVtX2ZyZWV6YWJsZV93cSwNCj4gPiArICZob3N0LT5zZGlvX2lycV93
b3JrLCAwKTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICBvdXQ6DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbW1jL2NvcmUvc2Rpb19pcnEuYyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpb19pcnEu
Yw0KPiA+IGluZGV4IDkwMDg3MTA3M2JkNy4uOWQ3ZWM0OGJkOTYzIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvc2Rpb19pcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUv
c2Rpb19pcnEuYw0KPiA+IEBAIC0xMzIsNyArMTMyLDcgQEAgdm9pZCBzZGlvX2lycV93b3JrKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd29yaykgIHZvaWQNCj4gPiBzZGlvX3NpZ25hbF9pcnEoc3RydWN0
IG1tY19ob3N0ICpob3N0KSAgew0KPiA+ICAgICAgICAgaG9zdC0+c2Rpb19pcnFfcGVuZGluZyA9
IHRydWU7DQo+ID4gLSAgICAgICBxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmaG9zdC0+
c2Rpb19pcnFfd29yaywgMCk7DQo+ID4gKyAgICAgICBxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVt
X2ZyZWV6YWJsZV93cSwNCj4gJmhvc3QtPnNkaW9faXJxX3dvcmssDQo+ID4gKyAwKTsNCj4gPiAg
fQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChzZGlvX3NpZ25hbF9pcnEpOw0KPiA+DQo+ID4gLS0N
Cj4gPiAyLjE3LjENCj4gPg0K
