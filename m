Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18991C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C852206DC
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GW/Or7tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgINNaG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 09:30:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:54134 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgINN1r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Sep 2020 09:27:47 -0400
IronPort-SDR: l2+IC1XfVAzz320HxqxY8hxxMF1kJI73AxGsWkOTH7OeCfUkust5BCV76v6c9yGQV9oD0j+mKC
 fivsNvm9qc8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146815434"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="146815434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 06:26:59 -0700
IronPort-SDR: Coufpi7BKil6teQ3eUgwl2BdeMHwb0hbcvboIuIb6ZoX/kZzLg8MnxlSzvwR+yFcKGM0vJ7Qmg
 Or+8tLCb4qbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="330740311"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2020 06:26:58 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 06:26:58 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Sep 2020 06:26:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 14 Sep 2020 06:26:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Sep 2020 06:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgoeZW/HDCjgr/zQz/8JCQlq66P+cYbIWV+GG7IQQXSGgTURdtamnypOnPkXv5W8JhHzWrcgMkVUeKbZmQ5Ttyi+TRlhKaN01ZPLpS05byJ/HxfZYqFpZJ7JPAqY25TIM9i4J4CokJR2yuYlyRKBAq9wsmVvdydV2mdVDya/jFe0uQYO7vfoLsdBBP/+Ld1fwfkgVfHYC2kUqhCHVVfE0lw9/09x1HhoXQY/WPR0bcn+mGMUEEO6Feo0jpUcRSdckUFqieTjb5W9oZdNfCVgqorMggFLBDeS/GkL2J37lqAFJ8cNQsspM3EilsycLrJ0qg9aKmyfYxR9l74v//9T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDoN6W5GJTr/pplnS+tsiUeAoFOMvtnJCXxcFvp+dGs=;
 b=VoWOOJg+myhkSFEvZ3ZIgRyw8y/Nufw1fTj/Q5EMdRhfG03lThCEMktF3xglmVlcP0DgvgD0sJpyJQoZKdtKmhbAK1ewlfdPnrvYrT9VmCmnMMX0Kin3YHztQAy6X+IdOMR5LJtMW94J/v2afZCc8V7k0YqyaFtyPoxjOZ1D6IiAhxXg5lsvdAXor2NljESA9de7CSfHZbVOL1Rv8bdo/GiNAEs6ktQBxwjhVbY9Od4z4si/OZdGFavjCGomg+o4us6nTy8bseGjsVnC4w0BN6b30Dh8l8ERT25F1s2N/vaMso2EAu/w4gyDre17IgVBi2Vaz83KAaR1eNS2lffoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDoN6W5GJTr/pplnS+tsiUeAoFOMvtnJCXxcFvp+dGs=;
 b=GW/Or7tC8NVaWeP/o6RRBwtKz7fSDyj9VKLUogi4L+NQBYdKlMZmQZwet6wyQOkvYUcRoIhgZpq6o043XPuddJ0Wzmbkba5FXpSEczCQ2ARPxpuxvd+/GTF/ecGH69XGLWoQWBU4mA3+3TCZuvZ9inc/wDy3WtPlvG8qkhaitxA=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by BYAPR11MB3285.namprd11.prod.outlook.com (2603:10b6:a03:7b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 13:26:56 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::c409:25f2:a182:5105]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::c409:25f2:a182:5105%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 13:26:56 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWimLCf5qN36I7DEm2Cbc0P5ffRKloHlGg
Date:   Mon, 14 Sep 2020 13:26:56 +0000
Message-ID: <BYAPR11MB3015FF6503F4FBB4A184FA57B8230@BYAPR11MB3015.namprd11.prod.outlook.com>
References: <20200914051214.13918-1-muhammad.husaini.zulkifli@intel.com>
 <20200914051214.13918-2-muhammad.husaini.zulkifli@intel.com>
 <21d34b75-5947-e115-7c9a-6d068375bbdd@xilinx.com>
In-Reply-To: <21d34b75-5947-e115-7c9a-6d068375bbdd@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.182.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d6ba796-5df9-4133-5ebd-08d858b1da30
x-ms-traffictypediagnostic: BYAPR11MB3285:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB328519008AC3C71BCC0DB0A4B8230@BYAPR11MB3285.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JtbHfgDkOre/8EcSKibOPZQhehh1jVPgkpd7VkdXBr9vt3Ps21SX0Kb0oCfWjhB/hnVYOA5wIVNKbN4bQ8RlvjBg3bKMlXZ1Dkm86Re8KYg/PP1XNWEZfB2YKU3PBcWF7ibV20JnzK3cJIRn2ZhK8jRr5IRYBUUnygaPS4PArDuk61QsP1MAOSiqhVPyXalgJRA+XWNM9hXlA/7xF57kgaXQ6fP/skD5gZogU95rhZpWXbgDUI2qvxtydsaPDtSkeCz0QBPyFdBjcqcNEL5BRDP2DFejR1HQQzLj3xFXBQgsYT1BEI6o/F6ntKnjZ46C+B2vAHf9h/MjrynrUkhdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(52536014)(71200400001)(55016002)(76116006)(2906002)(110136005)(9686003)(33656002)(186003)(26005)(86362001)(478600001)(6506007)(83380400001)(53546011)(66476007)(4326008)(316002)(54906003)(7696005)(66446008)(64756008)(8676002)(107886003)(66556008)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FbojBKv6ytG3pRWmXRRd1e+cjBgxVIGgwPXLxsW5O0aIn/E92MOsFmoTd2qP4F6sTB2kAaNPiwNg1Mccz+aBvDP+anQbvI8hDU7OsWDjMJzCzs9XrjblofDOpYD0+6ixeeiKGaFx8j6vG4hwbMv7C61LTO/Nf2L0XGsEyQlUuHcJp86CgTPSs1BfHHpoi5ak0HUme5Pa+qQM7bTaEcLwgTheDc0M32L9+OJVUBCk9hCgPSUDr6AIN2fBJffcaK5auJifyR0+syH2vSrF0Rp0ccuRAVVrEYS90mPyjLFeUz3MMfdhRP5mJf3FCweq75hqM5HdUI7wBf5dY3puM+oUkmlaAVy5L/mwr0+VxJhBc2XtzZxbse5+5SJhBJWh+gDPky4sNNDTE4a9m5vhLI82E4GrKBSnmtqAaKZefK9kEufjExZfJJwZSdEirK6nE8DbrGHFG4qkU5YlUgjSXQ8v0Jrpp+TeTat11d2Z/ukUtuuYB9gV/f0bU7j0D6VFMzhcATnn6nLZOTonbt8Gf32Cue+K7EamCSZX3wQNXucPBjXK7hhnSdJ7BK6gd90nPI/vc12+FEJmmqbuiWfP64JThbE7YmSdh7x10o0lSLNAvoZBpZne0I8Lb/CIXuZk36LciHhcakOhD81AxnqlON/oWA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ba796-5df9-4133-5ebd-08d858b1da30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 13:26:56.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbAfXcUih1Zn2xCBHr/hAd3RON7moD6DduTI7c8Fu1KmBYzCn3ziTVY0avUz00+hOA/anByrM+L/pqKT2S66T77SaBZ7GoqlDJuPFvL8QKdGYRi+9liFOwyEYG61Jq98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3285
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SEkgTWljaGFsLA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cy4NCkkgcmVwbGllZCBpbmxpbmUN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQHhpbGlueC5jb20+IA0KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjAgMjo0
NiBQTQ0KVG86IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1
bGtpZmxpQGludGVsLmNvbT47IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBsaW51
eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+DQpDYzogUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJh
amEuc3VicmFtYW5pYW5AaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1t
Yzogc2RoY2ktb2YtYXJhc2FuOiBFbmFibGUgVUhTLTEgc3VwcG9ydCBmb3IgS2VlbSBCYXkgU09D
DQoNCkhpLCArQXJuZCwNCg0KT24gMTQuIDA5LiAyMCA3OjEyLCBtdWhhbW1hZC5odXNhaW5pLnp1
bGtpZmxpQGludGVsLmNvbSB3cm90ZToNCj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZs
aSA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+IA0KPiBWb2x0YWdlIHN3
aXRjaGluZyBzZXF1ZW5jZSBpcyBuZWVkZWQgdG8gc3VwcG9ydCBVSFMtMSBpbnRlcmZhY2UgYXMg
DQo+IEtlZW0gQmF5IEVWTSBpcyB1c2luZyBleHRlcm5hbCB2b2x0YWdlIHJlZ3VsYXRvciB0byBz
d2l0Y2ggYmV0d2VlbiANCj4gMS44ViBhbmQgMy4zVi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE11
aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkgDQo+IDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGlu
dGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRl
ckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4u
YyB8IDE0MCANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtYXJhc2FuLmMgDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFz
YW4uYw0KPiBpbmRleCBmMTg2ZmJkMDE2YjEuLmMxMzM0MDhkMGM3NCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+IEBAIC0xNiw3ICsxNiw5IEBADQo+ICAgKi8NCj4gIA0K
PiAgI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2dw
aW8vY29uc3VtZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvYXJtLXNtY2NjLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGh5L3Bo
eS5oPg0KPiBAQCAtNDEsNiArNDMsMTEgQEANCj4gICNkZWZpbmUgU0RIQ0lfSVRBUERMWV9FTkFC
TEUJCTB4MTAwDQo+ICAjZGVmaW5lIFNESENJX09UQVBETFlfRU5BQkxFCQkweDQwDQo+ICANCj4g
Ky8qIFNldHRpbmcgZm9yIEtlZW0gQmF5IElPIFBhZCAxLjggVm9sdGFnZSBTZWxlY3Rpb24gKi8N
Cj4gKyNkZWZpbmUgS0VFTUJBWV9BT05fU0lQX0ZVTkNfSUQJCTB4ODIwMGZmMjYNCj4gKyNkZWZp
bmUgS0VFTUJBWV9BT05fU0VUXzFWOF9WT0xUCTB4MDENCj4gKyNkZWZpbmUgS0VFTUJBWV9BT05f
U0VUXzNWM19WT0xUCTB4MDANCj4gKw0KPiAgLyogRGVmYXVsdCBzZXR0aW5ncyBmb3IgWnlucU1Q
IENsb2NrIFBoYXNlcyAqLw0KPiAgI2RlZmluZSBaWU5RTVBfSUNMS19QSEFTRSB7MCwgNjMsIDYz
LCAwLCA2MywgIDAsICAgMCwgMTgzLCA1NCwgIDAsIDB9DQo+ICAjZGVmaW5lIFpZTlFNUF9PQ0xL
X1BIQVNFIHswLCA3MiwgNjAsIDAsIDYwLCA3MiwgMTM1LCA0OCwgNzIsIDEzNSwgMH0gDQo+IEBA
IC0xNTAsNiArMTU3LDcgQEAgc3RydWN0IHNkaGNpX2FyYXNhbl9kYXRhIHsNCj4gIAlzdHJ1Y3Qg
cmVnbWFwCSpzb2NfY3RsX2Jhc2U7DQo+ICAJY29uc3Qgc3RydWN0IHNkaGNpX2FyYXNhbl9zb2Nf
Y3RsX21hcCAqc29jX2N0bF9tYXA7DQo+ICAJdW5zaWduZWQgaW50CXF1aXJrczsNCj4gKwlzdHJ1
Y3QgZ3Bpb19kZXNjICp1aHNfZ3BpbzsNCj4gIA0KPiAgLyogQ29udHJvbGxlciBkb2VzIG5vdCBo
YXZlIENEIHdpcmVkIGFuZCB3aWxsIG5vdCBmdW5jdGlvbiBub3JtYWxseSB3aXRob3V0ICovDQo+
ICAjZGVmaW5lIFNESENJX0FSQVNBTl9RVUlSS19GT1JDRV9DRFRFU1QJQklUKDApDQo+IEBAIC0z
NjEsNiArMzY5LDEyMSBAQCBzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl92b2x0YWdlX3N3aXRjaChz
dHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4gIAlyZXR1cm4gLUVJTlZBTDsNCj4gIH0NCj4gIA0KPiAr
c3RhdGljIGludCBzZGhjaV9hcmFzYW5fa2VlbWJheV9zZXRfdm9sdGFnZShpbnQgdm9sdCkgeyAj
aWYgDQo+ICtJU19FTkFCTEVEKENPTkZJR19IQVZFX0FSTV9TTUNDQykNCj4gKwlzdHJ1Y3QgYXJt
X3NtY2NjX3JlcyByZXM7DQo+ICsNCj4gKwlhcm1fc21jY2Nfc21jKEtFRU1CQVlfQU9OX1NJUF9G
VU5DX0lELCB2b2x0LCAwLCAwLCAwLCAwLCAwLCAwLCAmcmVzKTsNCj4gKwlpZiAocmVzLmEwKQ0K
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlyZXR1cm4gMDsNCg0KSSBhbSBqdXN0IGN1cmlvdXMg
YWJvdXQgY2FsbGluZyB0aGlzIHNtYyBkaXJlY3RseSBmcm9tIGRldmljZSBkcml2ZXIuIEkgc2Vl
IHRoYXQgc2V2ZXJhbCBkcml2ZXJzIGFyZSBkb2luZyB0aGlzIGJ1dCBpc24ndCBpdCBiZXR0ZXIg
dG8gaGlkZSB0aGVzZSBpbiBmaXJtd2FyZSBkcml2ZXI/DQpbSHVzYWluaV0gSW4gb3JkZXIgdG8g
Y2hhbmdlIHRoZSB2b2x0YWdlIHNlbGVjdGlvbiBmb3IgSU8gUGFkcyB2b2x0YWdlIHN3aXRjaGlu
ZyBsZXZlbCBjb250cm9sLCBJIG5lZWQgdG8gYWNjZXNzL3dyaXRlIHRvIEFPTiByZWdpc3Rlci4g
DQpEdWUgdG8gc2VjdXJpdHkgY29uY2VybiwgVS1Cb290IFRlYW0gcHJvdmlkZWQgYW4gaW50ZXJm
YWNlIHVzaW5nIHRoaXMgU0lQIFNlcnZpY2UgZm9yIG1lIHRvIGNhbGwgZHVyaW5nIGtlcm5lbCBk
cml2ZXIgdm9sdGFnZSBzd2l0Y2hpbmcgb3BlcmF0aW9uLiANCg0KQWxzbyB0aGUgcGFydCBvZiBG
VU5DX0lEIGlzIHNtYzMyLCBzaXAgc2VydmljZSBjYWxsICgweDgyMDAwMDAwKSBmdW5jdGlvbiBp
ZGVudGlmaWVyIHdoaWNoIGlzIGxpa2VseSBzb21ldGhpbmcgd2hhdCBzaG91bGQgYmUgdXNlZCBh
cyBtYWNybyBpbiBzaGFyZWQgbG9jYXRpb24gdGhhdCBvdGhlcnMgY2FuIHVzZSBpdCB0b28uDQpb
SHVzYWluaV0gVGhlIG9ubHkgdGhpbmcgcHJvdmlkZWQgd2FzIHRoZSBGVU5DX0lEIHZhbHVlIGFu
ZCBhcmd1bWVudC4NCg0KQW5vdGhlciBwYXJ0IGlzIHRoYXQgYmFzZWQgb24gZGVzY3JpcHRpb24g
eW91IGFyZSB0YWxraW5nIHRvIGV4dGVybmFsIHZvbHRhZ2UgcmVndWxhdG9yIHdpdGhvdXQgdXNp
bmcgcmVndWxhdG9yIGZyYW1ld29yayBhdCBhbGwuIElzbid0IGl0IGJldHRlciBqdXN0IHRvIGNy
ZWF0ZSBmaXJtd2FyZSBiYXNlZCByZWd1bGF0b3IgZm9yIHRoaXMgcHVycG9zZT8NCltIdXNhaW5p
XSBUaGlzIGlzIGZvciBLZWVtYmF5IHNwZWNpZmljIGFuZCB3ZSBkaWQgbm90IHVzZSByZWd1bGF0
b3IgZnJhbWV3b3JrLiANCkR1cmluZyB0aGUgdm9sdGFnZSBzd2l0Y2hpbmcsIHRoaXMgU0lQIGZ1
bmN0aW9uIG5lZWQgdG8gYmUgZXhlY3V0ZWQgdG8gY2hhbmdlIHRoZSBLZWVtIEJheSBJTyBQYWQg
U3dpdGNoaW5nIExldmVsIENvbnRyb2wgdG8gMS44ViBmb3IgVUhTIG9yIDMuM3YgZm9yIGRlZmF1
bHQgbW9kZS4NClRvIGJlIHNwZWNpZmljLCBiZWxvdyBsaW5lIG9mIGNvZGUgbXVzdCBjb21lIHRv
Z2V0aGVyIGR1cmluZyB0aGUgdm9sdGFnZSBzd2l0Y2hpbmcgb3BlcmF0aW9uLg0KDQpGb3IgMS44
Vg0KKwkJLyogU2V0IFZERElPX0Igdm9sdGFnZSB0byBMb3cgZm9yIDEuOFYgKi8NCisJCWdwaW9k
X3NldF92YWx1ZV9jYW5zbGVlcChzZGhjaV9hcmFzYW4tPnVoc19ncGlvLCAwKTsNCisNCisJCXJl
dCA9IHNkaGNpX2FyYXNhbl9rZWVtYmF5X3NldF92b2x0YWdlKEtFRU1CQVlfQU9OX1NFVF8xVjhf
Vk9MVCk7DQorCQlpZiAocmV0KQ0KKwkJCXJldHVybiByZXQ7DQoNCkZvciAzLjNWDQoJCS8qIFNl
dCBWRERJT19CIHZvbHRhZ2UgdG8gSGlnaCBmb3IgMy4zViAqLw0KKwkJZ3Bpb2Rfc2V0X3ZhbHVl
X2NhbnNsZWVwKHNkaGNpX2FyYXNhbi0+dWhzX2dwaW8sIDEpOw0KKw0KKwkJcmV0ID0gc2RoY2lf
YXJhc2FuX2tlZW1iYXlfc2V0X3ZvbHRhZ2UoS0VFTUJBWV9BT05fU0VUXzNWM19WT0xUKTsNCisJ
CWlmIChyZXQpDQorCQkJcmV0dXJuIHJldDsNCg0KT3Igd2FzIHRoZXJlIGFueSBhZ3JlZW1lbnQg
dG8gcHV0IHRoZXNlIHN0dWZmIGRpcmVjdGx5IHRvIHRoZSBkcml2ZXI/DQpbSHVzYWluaV0gVGhl
cmUgaXMgYW4gYWdyZWVtZW50IGJldHdlZW4gSU8gVGVhbSBhbmQgVS1ib290IHRlYW0gdG8gdXNl
IHRoaXMga2luZCBvZiBpbXBsZW1lbnRhdGlvbiB0byBzdXBwb3J0IHRoaXMgVUhTLTEgTW9kZSBm
ZWF0dXJlcyBmb3Iga2VlbSBiYXkgDQpmb3Igdm9sdGFnZSBzd2l0Y2hpbmcgc2VxdWVuY2UuDQoN
ClRoYW5rcywNCk1pY2hhbA0KDQo=
