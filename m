Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42DC10DCE
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E3A24655
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 04:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YvBufQgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgCJE2F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:28:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:21078 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgCJE2F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Mar 2020 00:28:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 21:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="441157191"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2020 21:28:01 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 21:28:00 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 21:28:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 9 Mar 2020 21:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRjil6lIgAL/XJ5wrFlKtbsHmtTkT3kURBG++HboHLC0gky1AMsn+UTy+X7AyNCPF+FULbk2797QaWHWK9IYbsob7w3ScDrCz+lw2smC6KTXSn6266eI4A6cDEtzdn8oqLwHO4wFeMkiKSdXwVnK4y1S6m8EkGkzXn4RGPhg8jhP3/prN0E3Vb80OEyy4Wc9KMY16cEaWNy9tdvSJNZukuBwTBmOPLQblu2buqAoEKvDtTWPbSemaZfhpAwlZAZ6zINHwRjAfe54zVQ7u92aTDndimYVe76F45PqoYtqfJNH1FU12DaaThe5kX//eXUCkMC9MdyE1v9MtIY9bUAkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfF1FQ7BeenL4k5Xro52R3hfqRti/NTIA4N1uyOG+dc=;
 b=YY0dPj6SSogvpVjekJqjcIvGSx69JQb0x9b96TfFdhAtR6PH8d1CCWR953WBqLrXaN35NCcGxOOYAJNhdV1HyaGrGVWLu/ZWHnn1JrqmjHJOFd6Vrah1hQ8ce18XEiOqnhmaL3HXZ+QwBXVl9oRdCxgM5Pj02a+UOJYDZ9jfXFlKv87rNfVQ+nWPSZZpvaR3q4EuVT1LSqxg8mhCNMBWZFc3rSvKZfrQl3RyY6iwOSLDTxKfp4BhRBPj4wUxMR3kwthtn91W23WSvI5lmyqGF4Kk9HecrNOl4wEejvNd8QNSWd+WuC+1h/qDfQedaIFXWpO59rE0QUE1GwUC4fJGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfF1FQ7BeenL4k5Xro52R3hfqRti/NTIA4N1uyOG+dc=;
 b=YvBufQgTU5gRb1KP/x3N7ahw4b8bC0LmdqWFZqnjk7Og4Jl3VFvuUlWUpvwi5ymoUuMRLsfUkBnChNkJCNb39tEmiypafYmLXT0aIUdIuu6OK+FJvW43DZGhHuC+ckQ6tJnWEpYnyORTYN/orX/g4CX6Fj5a6ierwDNuIYnlSu4=
Received: from BYAPR11MB2696.namprd11.prod.outlook.com (2603:10b6:a02:c5::29)
 by BYAPR11MB3239.namprd11.prod.outlook.com (2603:10b6:a03:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 04:27:58 +0000
Received: from BYAPR11MB2696.namprd11.prod.outlook.com
 ([fe80::cd7c:9f3a:d3c5:9996]) by BYAPR11MB2696.namprd11.prod.outlook.com
 ([fe80::cd7c:9f3a:d3c5:9996%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 04:27:58 +0000
From:   "Seo, Kyungmin" <kyungmin.seo@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
Thread-Topic: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
Thread-Index: AQHV4U3UZQRzu+4KjkaXjUHxMczLpag4Z/+AgAFr9LCAAGvxgIAHIe9A
Date:   Tue, 10 Mar 2020 04:27:57 +0000
Message-ID: <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
References: <20200212024220.GA32111@seokyung-mobl1>
 <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
In-Reply-To: <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kyungmin.seo@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b7c3c2d-1061-42d0-8e98-08d7c4ab6958
x-ms-traffictypediagnostic: BYAPR11MB3239:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB32399F95091B018A4A80DA019CFF0@BYAPR11MB3239.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(52536014)(71200400001)(8936002)(66476007)(5660300002)(7696005)(26005)(76116006)(66446008)(66556008)(66946007)(2906002)(64756008)(4326008)(966005)(86362001)(316002)(81166006)(81156014)(186003)(478600001)(33656002)(55016002)(53546011)(6506007)(54906003)(9686003)(8676002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3239;H:BYAPR11MB2696.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wESPKwIWPUG3so3ol6iT2G3IEUls3xYo7/ssWVKKpZU98hN5eaEtlM/K+0i8LA6gu0ufOQQ/XGcfp8xpNYSbu1aVdU6qPF40q2+qbnItcEUVTSqjkmE2yBMth2smWgGLGoqli3ZpSel7MU+f4NxDLcb+yxU+jI8p1eoLYkaYGBAGStiHS2emNfHEQhRLXey2WHlFLz4ho4lf1/qo2fPkiR2vezGvLbqmvuEeGRWNF2KcjeybjpZvFnS8djsPlsUxFiyIWqSApRS2eXvuxJU8ISbovtOQUxx8aoeak4MALq9rXJVqYsp4NaURs1KWXeb/USMz71UsKjVTgfWg5ZirkdbeJw9BYNv+EI4dGaUUo39jEOmC+pbA1480tyfcvdkWYc9xz6hQKkvhdtARNZtjA2dzvhu+PwXUINJ62jwRphoQ5DorKgj0TMtvOz17tnFITfxZ+E05m/MpUnFaKa4CeAyIcb/iMM18BC0skFskcwCkA7rvs+1WNZkzaLDhv50YHIdoh7G1mLEgDWDi1XhjQ==
x-ms-exchange-antispam-messagedata: ck9o9hngNXAxLxXLb+aFwvNSi7HEVsAWwOvnT8g0Gwe1V6dCv+QpWeWDjqP2oHfd1dAdALJiiEykOkFp23eXga+j/U/K4bkzihU/AtJf4+/bDgaqzujxDJkdGiQ7XjE43rMATKBkbIrPpNibR36ZKQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7c3c2d-1061-42d0-8e98-08d7c4ab6958
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 04:27:57.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ryt5nkE1KrJ3mXSVJtp+CiahGDwR45+IayqnwC/EesFcjmFryRzA0kmwpoBGTbbMmVF8eNmPkE82J3zjf7KF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3239
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SSByZWFkIHRoZSBsaW5rIGFuZCBwYXRjaCBvZiBDaGFvdGlhbiBKaW5nLg0KSSBhbHNvIHBvaW50
IG91dCB3aGF0IENoYW90aWFuIHNhaWQuDQpNb3N0IGhvc3QgY29udHJvbGxlcnMgaGF2ZSBETEwg
dHVuaW5nIHZhbHVlcyBmb3IgZWFjaCBtb2RlLiBXaGVuIGhvc3QgY29udHJvbGxlciBpcyBzZXQg
YXMgSFM0MDAgbW9kZSB3aXRoIDUwTUh6IGNsb2NrLCBob3N0IGNvbnRyb2xsZXIgdXNlcyBETEwg
dmFsdWUgd2hpY2ggaXMgdHVuZWQgd2l0aCAyMDBNSHogY2xvY2suDQoNCklmIERMTCB2YWx1ZSBp
biBIUzQwMCBtb2RlIGRvZXNuJ3QgaGF2ZSB0aGUgcGFzcyByYW5nZSBpbiBIUyBtb2RlLCBjb21t
YW5kIHRyYW5zZmVyIGZhaWxpbmcgbWF5IGZhaWwuDQpJbiBvcmRlciB0byBtYWtlIHJvYnVzdCBz
ZGhjaSBkcml2ZXIsIEkgdGhpbmsgdGhlIHBhdGNoIG5lZWRzIHRvIGJlIGNvbnNpZGVyZWQuDQpP
ZiBjb3Vyc2UsIENNRDYgd2l0aCBIUzQwMCBtb2RlIGFuZCAyMDBNSHogY2xvY2sgc2hvdWxkIG5v
dCBjYXVzZSBhbnkgcHJvYmxlbSBiZWNhdXNlIGl0J3MgY29ycmVjdCBjb25maWd1cmF0aW9uLg0K
DQpUaGFua3MNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPiANClNlbnQ6IEZyaWRheSwgTWFyY2ggNiwgMjAyMCAx
MjoxOCBBTQ0KVG86IFNlbywgS3l1bmdtaW4gPGt5dW5nbWluLnNlb0BpbnRlbC5jb20+OyBIdW50
ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBDaGFvdGlhbiBKaW5nIDxjaGFv
dGlhbi5qaW5nQG1lZGlhdGVrLmNvbT4NCkNjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBM
aW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K
U3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBtbWM6IEZpeCB0aGUgdGltaW5nIGZvciBjbG9jayBj
aGFuZ2luZyBpbiBtbWMNCg0KKyBBZHJpYW4sIENoYW90aWFuDQoNCk9uIFRodSwgNSBNYXIgMjAy
MCBhdCAwOTo1NywgU2VvLCBLeXVuZ21pbiA8a3l1bmdtaW4uc2VvQGludGVsLmNvbT4gd3JvdGU6
DQo+DQo+IFRoZSBtbWNfaHM0MDBfdG9faHMyMDAgZnVuY3Rpb24gaXMgY2FsbGVkIG9ubHkgaW4g
SFM0MDAgbW9kZS4NCj4gSSBzYXcgdGhlIGNsb2NrIGNoYW5nZSBmcm9tIDIwME1IeiB0byA1Mk1I
eiB2aWEgb3NjaWxsb3Njb3BlIG9uIHJlYWwgcGxhdGZvcm0uDQo+DQo+IEkgdGhpbmsgQ01ENiBp
cyBzZW50IGluIEhTNDAwIG1vZGUgd2l0aCAyMDBNSHogY2xvY2ssIGJ1dCBpdCdzIG5vdC4NCj4g
Rmlyc3QgQ01ENiBpbiBtbWNfaHM0MDBfdG9faHMyMDAgZnVuY3Rpb24gaXMgc2VudCB3aXRoIDUy
TUh6IGNsb2NrLg0KDQpJIGhhZCBhIHZhZ3VlIG1lbW9yeSB0aGF0IHdlIGhhdmUgZGlzY3Vzc2Vk
IGEgc2ltaWxhciBwcm9ibGVtIGFzIHlvdXIgYXJlIHBvaW50aW5nIG91dCBvbiB0aGUgbWFpbGlu
ZyBsaXN0IGFscmVhZHkuIEFuZCBJIHdhcyByaWdodC4NCg0KUGxlYXNlIHJlYWQgdXAgb24gdGhl
IGJlbG93IHJlZmVyZW5jZXMsIFsxXSwgWzJdIGZvciB0aGUgZWFybGllciBkaXNjdXNzaW9ucy4g
SSBzdWdnZXN0ZWQgYSBzb2x1dGlvbiBmb3IgQ2hhb3RpYW4gdG8gdHJ5LCBidXQgaXQgc2VlbXMg
bGlrZSBoZSBuZXZlciBtYW5hZ2VkIHRvIGdpdmUgaXQgYSBnbywgYXMgSSBkb24ndCByZWNhbGwg
bmV3IHBhdGNoIGJlaW5nIHBvc3RlZC4NCg0KUGVyaGFwcyB5b3UgY2FuIHBpY2sgdXAgd2VyZSBD
aGFvdGlhbiBsZWZ0IGFuZCBzZWUgaWYgeW91IGNhbiBpbXBsZW1lbnQgdGhlIHN1Z2dlc3RlZCBz
b2x1dGlvbihzKS4gTXkgbWFpbiBjb25jZXJuIGlzIGJyZWFraW5nIG90aGVyIGhvc3QgZHJpdmVy
cywgYXMgdGhhdCBzZWVtcyBxdWl0ZSBsaWtlbHkgdG8gaGFwcGVuLCBpZiB3ZSBhcmVuJ3QgY2Fy
ZWZ1bCBhYm91dCB0aGlzLg0KDQpLaW5kIHJlZ2FyZHMNClVmZmUNCg0KWzFdDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1tbWMvMTU0ODkyMTIxMi01MjE5LTEtZ2l0LXNlbmQtZW1haWwt
Y2hhb3RpYW4uamluZ0BtZWRpYXRlay5jb20vDQpbMl0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tYy9DQVBEeUtGcXV5eVh4MU1xTkxWWHVGeGNFREI5bkt6TjhMR0dOVVAyeXhvVk1R
cldpVWdAbWFpbC5nbWFpbC5jb20vDQoNCg0KDQo+DQo+IFRoYW5rcw0KPiBLTQ0KPg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25A
bGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA0LCAyMDIwIDg6MDkgUE0NCj4g
VG86IFNlbywgS3l1bmdtaW4gPGt5dW5nbWluLnNlb0BpbnRlbC5jb20+DQo+IENjOiBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IA0KPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBtbWM6
IEZpeCB0aGUgdGltaW5nIGZvciBjbG9jayBjaGFuZ2luZyBpbiANCj4gbW1jDQo+DQo+IE9uIFdl
ZCwgMTIgRmViIDIwMjAgYXQgMDM6NDAsIEt5dW5nbWluIFNlbyA8a3l1bmdtaW4uc2VvQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY2xvY2sgaGFzIHRvIGJlIGNoYW5nZWQgYWZ0ZXIg
c2VuZGluZyBDTUQ2IGZvciBIUyBtb2RlIHNlbGVjdGlvbiANCj4gPiBpbg0KPiA+IG1tY19oczQw
MF90b19oczIwMCgpIGZ1bmN0aW9uLg0KPiA+DQo+ID4gVGhlIEpFREVDIDUuMCBhbmQgNS4xIHNh
aWQgdGhhdCAiSGlnaC1zcGVlZCIgbW9kZSBzZWxlY3Rpb24gaGFzIHRvIA0KPiA+IGVuYWJsZSB0
aGUgdGhlIGhpZ2ggc3BlZWQgbW9kZSB0aW1pbmcgaW4gdGhlIERldmljZSwgYmVmb3JlIGNoYW5p
bmcgDQo+ID4gdGhlIGNsb2NrIGZyZXF1ZW5jeSB0byBhIGZyZXF1ZW5jeSBiZXR3ZWVuIDI2TUh6
IGFuZCA1Mk1Iei4NCj4NCj4gSSB0aGluayB0aGF0IGlzIGJhc2VkIHVwb24gdGhlIGFzc3VtcHRp
b24gdGhhdCB5b3UgYXJlIHVzaW5nIGEgbG93ZXIgZnJlcXVlbmN5IHRvIHN0YXJ0IHdpdGguDQo+
DQo+IEZvciBleGFtcGxlLCBhc3N1bWUgdGhhdCB5b3UgYXJlIHJ1bm5pbmcgd2l0aCA0MDBLSHog
ZHVyaW5nIGNhcmQgaW5pdGlhbGl6YXRpb24sIHRoZW4geW91IHdhbnQgdG8gc2VuZCB0aGUgQ01E
NiB0byBzd2l0Y2ggdG8gSFMgbW9kZSBhbmQgdGhhdCBzaG91bGQgYmUgZG9uZSwgYmVmb3JlIHVw
ZGF0aW5nIHRoZSBjbG9jayByYXRlLg0KPg0KPiBtbWNfaHM0MDBfdG9faHMyMDAoKSBnb2VzIHRo
ZSBvcHBvc2l0ZSBkaXJlY3Rpb24sIHNvIEkgdGhpbmsgdGhlIGN1cnJlbnQgY29kZSBsb29rcyBj
b3JyZWN0IHRvIG1lLg0KPg0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS3l1bmdtaW4gU2VvIDxreXVuZ21pbi5zZW9AaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL21tYy5jIHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGlu
ZGV4IA0KPiA+IDM0ODZiYzdmYmI2NC4uOTg2NDBiNTFjNzNlIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+
ID4gQEAgLTExOTYsMTAgKzExOTYsNiBAQCBpbnQgbW1jX2hzNDAwX3RvX2hzMjAwKHN0cnVjdCBt
bWNfY2FyZCAqY2FyZCkNCj4gPiAgICAgICAgIGludCBlcnI7DQo+ID4gICAgICAgICB1OCB2YWw7
DQo+ID4NCj4gPiAtICAgICAgIC8qIFJlZHVjZSBmcmVxdWVuY3kgdG8gSFMgKi8NCj4gPiAtICAg
ICAgIG1heF9kdHIgPSBjYXJkLT5leHRfY3NkLmhzX21heF9kdHI7DQo+ID4gLSAgICAgICBtbWNf
c2V0X2Nsb2NrKGhvc3QsIG1heF9kdHIpOw0KPiA+IC0NCj4gPiAgICAgICAgIC8qIFN3aXRjaCBI
UzQwMCB0byBIUyBERFIgKi8NCj4gPiAgICAgICAgIHZhbCA9IEVYVF9DU0RfVElNSU5HX0hTOw0K
PiA+ICAgICAgICAgZXJyID0gX19tbWNfc3dpdGNoKGNhcmQsIEVYVF9DU0RfQ01EX1NFVF9OT1JN
QUwsIA0KPiA+IEVYVF9DU0RfSFNfVElNSU5HLCBAQCAtMTIxMCw2ICsxMjA2LDEwIEBAIGludCAN
Cj4gPiBtbWNfaHM0MDBfdG9faHMyMDAoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+DQo+ID4g
ICAgICAgICBtbWNfc2V0X3RpbWluZyhob3N0LCBNTUNfVElNSU5HX01NQ19ERFI1Mik7DQo+ID4N
Cj4gPiArICAgICAgIC8qIFJlZHVjZSBmcmVxdWVuY3kgdG8gSFMgKi8NCj4gPiArICAgICAgIG1h
eF9kdHIgPSBjYXJkLT5leHRfY3NkLmhzX21heF9kdHI7DQo+ID4gKyAgICAgICBtbWNfc2V0X2Ns
b2NrKGhvc3QsIG1heF9kdHIpOw0KPiA+ICsNCj4gPiAgICAgICAgIGVyciA9IG1tY19zd2l0Y2hf
c3RhdHVzKGNhcmQpOw0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAg
Z290byBvdXRfZXJyOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
