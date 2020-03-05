Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B3C3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7562F2073D
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 08:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ketFWkaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCEI5t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:57:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:45277 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEI5s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Mar 2020 03:57:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 00:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="439430041"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 05 Mar 2020 00:57:46 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 00:57:46 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Mar 2020 00:57:46 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Mar 2020 00:57:46 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 5 Mar 2020 00:57:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMhfQmC5vNQg89nO223Jri7FaPkZAIShJoAMgYqnNrYdd0jtF6dqS/MCJMwyJwEL3cIG00MKWM4UNSDdTERfqI0Vt3niHW6PIUakQw1NE20MIA2snjd1TD0RR7PytCR3psW/W4scm07F0cbG4ShSgv4tlEWSYDYXb3ioX9v2CyS+cWkekNviF321dYPWxaI20WOY1Uvgh+G5YEjehaIBMeSKzsY6Pc3xzvMyK8Gu6w5vocylLj3Ew5rgGxoPUv1TnFyu7/C/c468vHUXnQs7gVWNuLwVhH5M4KGh31Id6RFXUDQfSfIX2kojBJImGRjg61atwQ5jrcC+2hgjKFAxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N22sAvqFbPjEu3HquzvYkZUiB/iha8177GPhIkYRlgU=;
 b=iKjepn7Bz7uERg/DIcFMmKyEMRirpHYUaXyg7y9tALkVtTkziqTFR2Km3eM9nRsSTX1Mvxd5fKqLAu8/V8UqvofLcB35MWot20vdUbqzNRPAWR5D4xL/QXzPAO4WZnt4B9ps5tkMZwlSLU2LIhf8+p42jh3R+UDXHeo6cO9Y2YhpRAlEXW/t9f4aw91pBSQA/qNGaI3v8L8c/wEsJ1hCPfpcYbod7HHyHAOcKGf6gB6WwcCpSdqEp4coWUEL9blTHakFFtulHEHAPOwNYKESYzSedABlwPKZ9RgCrpaYrqhx+pNCyi7b8DQ5uv3d9FoSeuXjYmLGDhJF5+qTCDMnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N22sAvqFbPjEu3HquzvYkZUiB/iha8177GPhIkYRlgU=;
 b=ketFWkaWR8noSQVsTvgbtT94qqDAopdPyyHEpisVWJvCIIqUmgXlG9qtrTkYGWm1x77CwUnDqIIOq7QtssFBKviCShpIdcC64gxn12kBmQdaRXD8jN3t1pJ0hKd3q7ghX27lVPX3Zib7Ks4xDVqvMhhdbCe5+QiEZuB+l8TFcVU=
Received: from BYAPR11MB2696.namprd11.prod.outlook.com (2603:10b6:a02:c5::29)
 by BYAPR11MB2870.namprd11.prod.outlook.com (2603:10b6:a02:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 08:57:44 +0000
Received: from BYAPR11MB2696.namprd11.prod.outlook.com
 ([fe80::cdc6:88ed:b51d:fea7]) by BYAPR11MB2696.namprd11.prod.outlook.com
 ([fe80::cdc6:88ed:b51d:fea7%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 08:57:44 +0000
From:   "Seo, Kyungmin" <kyungmin.seo@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
Thread-Topic: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
Thread-Index: AQHV4U3UZQRzu+4KjkaXjUHxMczLpag4Z/+AgAFr9LA=
Date:   Thu, 5 Mar 2020 08:57:44 +0000
Message-ID: <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
References: <20200212024220.GA32111@seokyung-mobl1>
 <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
In-Reply-To: <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyungmin.seo@intel.com; 
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5a7a093-89f7-4ee5-19be-08d7c0e344e4
x-ms-traffictypediagnostic: BYAPR11MB2870:
x-microsoft-antispam-prvs: <BYAPR11MB28703D374D33F039ACA9E4679CE20@BYAPR11MB2870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(54906003)(2906002)(33656002)(55016002)(66446008)(26005)(9686003)(64756008)(66556008)(66476007)(76116006)(86362001)(6916009)(66946007)(186003)(71200400001)(478600001)(8936002)(316002)(81156014)(81166006)(5660300002)(52536014)(53546011)(4326008)(7696005)(6506007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2870;H:BYAPR11MB2696.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdySU+4PUp05SlxZOOcy2iByP5rDd/0N1qUGgfMQDFGp/LEIefaB3+BKT7CiesPEhe/fHAL0JJ5sgMrgFT1x3DyovWBhFgT02yxgwm8z9nLqjynEJV1yZeSTiHGMe7LXJBQj5PikcGGf9Cd+/NWq6jgA9ZjL1DOy/AhQmYppNGVhwNgvJOeBjCRe2oYCD7MB5m4HME9Gx6tjD9dF+Vx0UnMNPibb1a4KYv9GfbKCiCIWyYRqOYttJrNzSbypyirnDm43AjHjSO5gFYob7wOVBnxvJHSvt4vzvYaEv8omCm3tRSOQOioEc27hWLJIHVQ/XKnkfQujI4uN0FWec3wxjOhSuZYqBVc/UQXwOOkKYv5XjfebXn/BxY6L2Odx8NIX0e6yRadIvGzkV+CF/YvN/B+ISmwzD5E2dnTXVTsNAlO6e6jo/RMwLhIST1M+VY0i
x-ms-exchange-antispam-messagedata: AQUKZsdporBEjvqlR/Z0bvrieM0hFCSgwUiXs40iZdaR1tQf2a9w2XadWg9X54ooOdmtJRRO+Z+f5WB8R+DQbnSsZhX5xa1NsFq7PnjG/iFb6frvahDwFulXmqUbhftr69O0/ey9yp/pk+Xuv7ICQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a7a093-89f7-4ee5-19be-08d7c0e344e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 08:57:44.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqvsZWcb5AGBVyRnwQhpFb3sUCzg3i6HBMzegvMUvJZUxMHkKtgukipnNhCQN8WlMuyrVV7iTVJYR3UU8o63PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2870
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

VGhlIG1tY19oczQwMF90b19oczIwMCBmdW5jdGlvbiBpcyBjYWxsZWQgb25seSBpbiBIUzQwMCBt
b2RlLg0KSSBzYXcgdGhlIGNsb2NrIGNoYW5nZSBmcm9tIDIwME1IeiB0byA1Mk1IeiB2aWEgb3Nj
aWxsb3Njb3BlIG9uIHJlYWwgcGxhdGZvcm0uDQoNCkkgdGhpbmsgQ01ENiBpcyBzZW50IGluIEhT
NDAwIG1vZGUgd2l0aCAyMDBNSHogY2xvY2ssIGJ1dCBpdCdzIG5vdC4NCkZpcnN0IENNRDYgaW4g
bW1jX2hzNDAwX3RvX2hzMjAwIGZ1bmN0aW9uIGlzIHNlbnQgd2l0aCA1Mk1IeiBjbG9jay4NCg0K
VGhhbmtzDQpLTQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVWxmIEhhbnNz
b24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCA0LCAy
MDIwIDg6MDkgUE0NClRvOiBTZW8sIEt5dW5nbWluIDxreXVuZ21pbi5zZW9AaW50ZWwuY29tPg0K
Q2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3Qg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6
IG1tYzogRml4IHRoZSB0aW1pbmcgZm9yIGNsb2NrIGNoYW5naW5nIGluIG1tYw0KDQpPbiBXZWQs
IDEyIEZlYiAyMDIwIGF0IDAzOjQwLCBLeXVuZ21pbiBTZW8gPGt5dW5nbWluLnNlb0BpbnRlbC5j
b20+IHdyb3RlOg0KPg0KPiBUaGUgY2xvY2sgaGFzIHRvIGJlIGNoYW5nZWQgYWZ0ZXIgc2VuZGlu
ZyBDTUQ2IGZvciBIUyBtb2RlIHNlbGVjdGlvbiANCj4gaW4NCj4gbW1jX2hzNDAwX3RvX2hzMjAw
KCkgZnVuY3Rpb24uDQo+DQo+IFRoZSBKRURFQyA1LjAgYW5kIDUuMSBzYWlkIHRoYXQgIkhpZ2gt
c3BlZWQiIG1vZGUgc2VsZWN0aW9uIGhhcyB0byANCj4gZW5hYmxlIHRoZSB0aGUgaGlnaCBzcGVl
ZCBtb2RlIHRpbWluZyBpbiB0aGUgRGV2aWNlLCBiZWZvcmUgY2hhbmluZyANCj4gdGhlIGNsb2Nr
IGZyZXF1ZW5jeSB0byBhIGZyZXF1ZW5jeSBiZXR3ZWVuIDI2TUh6IGFuZCA1Mk1Iei4NCg0KSSB0
aGluayB0aGF0IGlzIGJhc2VkIHVwb24gdGhlIGFzc3VtcHRpb24gdGhhdCB5b3UgYXJlIHVzaW5n
IGEgbG93ZXIgZnJlcXVlbmN5IHRvIHN0YXJ0IHdpdGguDQoNCkZvciBleGFtcGxlLCBhc3N1bWUg
dGhhdCB5b3UgYXJlIHJ1bm5pbmcgd2l0aCA0MDBLSHogZHVyaW5nIGNhcmQgaW5pdGlhbGl6YXRp
b24sIHRoZW4geW91IHdhbnQgdG8gc2VuZCB0aGUgQ01ENiB0byBzd2l0Y2ggdG8gSFMgbW9kZSBh
bmQgdGhhdCBzaG91bGQgYmUgZG9uZSwgYmVmb3JlIHVwZGF0aW5nIHRoZSBjbG9jayByYXRlLg0K
DQptbWNfaHM0MDBfdG9faHMyMDAoKSBnb2VzIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24sIHNvIEkg
dGhpbmsgdGhlIGN1cnJlbnQgY29kZSBsb29rcyBjb3JyZWN0IHRvIG1lLg0KDQpLaW5kIHJlZ2Fy
ZHMNClVmZmUNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLeXVuZ21pbiBTZW8gPGt5dW5nbWluLnNl
b0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvY29yZS9tbWMuYyB8IDggKysrKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29y
ZS9tbWMuYyBpbmRleCANCj4gMzQ4NmJjN2ZiYjY0Li45ODY0MGI1MWM3M2UgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWMu
Yw0KPiBAQCAtMTE5NiwxMCArMTE5Niw2IEBAIGludCBtbWNfaHM0MDBfdG9faHMyMDAoc3RydWN0
IG1tY19jYXJkICpjYXJkKQ0KPiAgICAgICAgIGludCBlcnI7DQo+ICAgICAgICAgdTggdmFsOw0K
Pg0KPiAtICAgICAgIC8qIFJlZHVjZSBmcmVxdWVuY3kgdG8gSFMgKi8NCj4gLSAgICAgICBtYXhf
ZHRyID0gY2FyZC0+ZXh0X2NzZC5oc19tYXhfZHRyOw0KPiAtICAgICAgIG1tY19zZXRfY2xvY2so
aG9zdCwgbWF4X2R0cik7DQo+IC0NCj4gICAgICAgICAvKiBTd2l0Y2ggSFM0MDAgdG8gSFMgRERS
ICovDQo+ICAgICAgICAgdmFsID0gRVhUX0NTRF9USU1JTkdfSFM7DQo+ICAgICAgICAgZXJyID0g
X19tbWNfc3dpdGNoKGNhcmQsIEVYVF9DU0RfQ01EX1NFVF9OT1JNQUwsIA0KPiBFWFRfQ1NEX0hT
X1RJTUlORywgQEAgLTEyMTAsNiArMTIwNiwxMCBAQCBpbnQgDQo+IG1tY19oczQwMF90b19oczIw
MChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQo+DQo+ICAgICAgICAgbW1jX3NldF90aW1pbmcoaG9z
dCwgTU1DX1RJTUlOR19NTUNfRERSNTIpOw0KPg0KPiArICAgICAgIC8qIFJlZHVjZSBmcmVxdWVu
Y3kgdG8gSFMgKi8NCj4gKyAgICAgICBtYXhfZHRyID0gY2FyZC0+ZXh0X2NzZC5oc19tYXhfZHRy
Ow0KPiArICAgICAgIG1tY19zZXRfY2xvY2soaG9zdCwgbWF4X2R0cik7DQo+ICsNCj4gICAgICAg
ICBlcnIgPSBtbWNfc3dpdGNoX3N0YXR1cyhjYXJkKTsNCj4gICAgICAgICBpZiAoZXJyKQ0KPiAg
ICAgICAgICAgICAgICAgZ290byBvdXRfZXJyOw0KPiAtLQ0KPiAyLjE3LjENCj4NCg==
