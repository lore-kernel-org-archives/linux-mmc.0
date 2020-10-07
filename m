Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE54C4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0FD21548
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DsJRNAoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJGN0I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:26:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:32691 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgJGN0H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:26:07 -0400
IronPort-SDR: d51DlWzLwdHwff4l4jbIUEdTpMUmXpGIUcxFecNoD0j9UNdhbL2ayWH2ExadsabAzOwiq+0PWi
 bwjc9DZ92rcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="165070901"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="165070901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:26:06 -0700
IronPort-SDR: m3JBm4Oj06IH9RAUHIMWyxieRr09/l5Uwf6QnXDgF22ns82tMKWS7MufSxjP8wWBIlBJVJGw3O
 okR1YKOeHRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="518833417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 07 Oct 2020 06:26:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:26:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:26:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 06:26:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 06:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3oHzVBRn3Dv2EggXqjR7dPrD2vLWdlUT+PNTRMq/P3cteotrA2RwsM9fJT6mcyH8XhyaLfAveQdPNsuTbUSEYlTYfe+4k/tYAUHugsYMOu2Y8qJFHYVzfQlVTmbhCSefXTn0fy2qurBHIAurLIiJeyYbG+kUgRNq5rnKgqNN0cgGZeYy198ayULR2Rww3W595dXH3sRaPBowLGXT903ZRfDlPhxyTJV92Alj0MYZy7Sd1/kj+EFx2qRRr9qKq5FzIVrBZeexwUnZetf3+gyZGHfUr6rrVgYayT/eWPdg8b2TEMKOKjcAN2DigVTeKVGW98wkNGgM8koPpLwRK/HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcbY9iSfy/cgLUqHrL4L7nbBVraf5kbc+RyAqnNMEk8=;
 b=YYyj9h8xZrfTZLZYJ7dw8fQ1EJMUx1EaHUKeECX2sttzqJcEqeumwfiww3YdrgdVlYqF31ucWs95vsyaZeJ1kiGYo3inr3TpIwwIC2pGthkSrpOSIkEIlvz9ejjmStR89smPSvqu5gcPXS8QbY8BpKdbbTCc72cb83jHYZs7zMkz98Vy4FFH7t0GvbJYG8TE06fIh9knjW0pmvn6eOIFL0Hyp58KnBFJrTSia8MtuLPTBBZfz36EyozrgoKF8J+5OCkBJIA1H/FzQ9n/ZPxns24VMxDiZ2/yAM9WpxxRI5f2LjJRje5iEfkEKAGqcdVchcXZOHezKLn/Zif8Hlji1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcbY9iSfy/cgLUqHrL4L7nbBVraf5kbc+RyAqnNMEk8=;
 b=DsJRNAoAvLtgzZeMSuayBgKEvnRsKPxVpbj+zW8X+ahuyjqyn/06jiey7WThQNb+gfJkrPA65sHfLziJA+RAifHmmDCFHpKUSZh6M1mIQ9HWUFSmjDpZSnvZvU7WWU7oOkXmPf3LEyeEX0t+l5+NCdzqGvPsdtgU9YiVtmQZuaQ=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2620.namprd11.prod.outlook.com (2603:10b6:5:c8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Wed, 7 Oct 2020 13:25:54 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:25:54 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWm/miHZrYTgP7dkS6mFSOGlc+ZqmL0SmAgABQnzA=
Date:   Wed, 7 Oct 2020 13:25:54 +0000
Message-ID: <DM6PR11MB28769EDDD494D8647A82527CB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
 <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
In-Reply-To: <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d32d0a-e5dd-4201-fd82-08d86ac484d5
x-ms-traffictypediagnostic: DM6PR11MB2620:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2620A5C521A889E939FB27B5B80A0@DM6PR11MB2620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2hwW4YM/COLNsQMMOxiDx7i72k5TAPN/KbslkWgZj4EGtq8C/y+1mk/ySvyWgkRVsRRP/uddJGPUvUs6JR+JrpjzP+hElmOs7wqwmTQ2wiURAdFMYkvG8DUspYLpwyXIT3dshIHm15ROQgh28WdsOG5I4PRL0skug3BAiKmqt/gH5D+l7skH9MqxZ8InSASrLxd8v04Q84Y6W2ScDtbkwrhv4ytOyxvixEBJox0QiZFr6geqRKLcec/p2V4L1ftb8+Jc06wdWVWEtObJqKG1HvRiOkMg0nQEwStmg/JjEdlpsVznSYzF5vjwbAdFxGbEL0vdjR7u4SUo2X73S4Www==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(83380400001)(76116006)(64756008)(66476007)(2906002)(478600001)(66946007)(66556008)(9686003)(66446008)(4326008)(52536014)(71200400001)(5660300002)(33656002)(110136005)(54906003)(26005)(186003)(86362001)(8676002)(6506007)(8936002)(316002)(7696005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X5lRTgBdHNceIu6anA2vXbTinc+y7+QlE5k1XQvVrk97Im829yCyhIwwnhSI81ZFyrwAC9FM1LSjSRJejjwU7Z6BzqQHU5pAJQWjErKqp+URMn1KnkcFe236etZG9lJtg1dzQS5sYfy1PkzSGlg7fvRcn5BDM+AzQzePKNqSg8uYUGC0rJX1H0CrqT8KDYtzQBU+E90BhMShLhHkZUaY/Dc3awyFiiiwJGb5nPEl9ZmaI3fkNR7jHK91i8BRGBI8LFhDRhbf1acZdoFSrX6+nZ/3/bJYwgYjE3/5THkpLYRD/p7ZI4Mrsx0PNbPNMk03NpoEuJZszbd3jI2nwjOQpK/GeYwfTg718za5EehTa1POxm7u5yJVe/TM7OGKDx8zRDoNHgCacFmU8EAfdcEkLlIJRBxodDDCBczIlAHwfesIEXDLDpUoNAWT5Dc6B3BqRpJblzsoxf0EuYz2K/utcpkQzSbkMCZDiDFCulT20FTnScQJSz55C/BIKzAiII/NBtP6SklrLtuJsaQxzlVdwvoj21LNYLVCaJFBSTZQt54k12yt1FZlC5bkMLvxuKEuQuqUDGhiekxIkfOxO8SukqUaEYvJBocsj0JZoqlA0d7QlT0SIUQsI6Ww3IJ/8DqMCZ93QtnTmIjCpZsc5diotg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d32d0a-e5dd-4201-fd82-08d86ac484d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 13:25:54.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: de0saUJk9SmJSzexUdSVJQbeafxzDuvDYiY0tORSf+nftygvh3ruL2xmnZGBT6UdG5SwQd1zrMZx+ul4PnlGJBnTiuOTNTlOWiHYlH9ey6ZjeEk8RJ5qJUhDwHtY3aVU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2620
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWljaGFsLA0KDQpUaGFua3MgYWdhaW4gZm9yIHRoZSBmZWVkYmFjay4gSSByZXBsaWVkIGlu
bGluZQ0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNaWNoYWwgU2ltZWsg
PG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA3LCAy
MDIwIDQ6MzQgUE0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1
c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPjsNCj5IdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRl
ckBpbnRlbC5jb20+OyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsNCj5zdWRlZXAuaG9sbGFAYXJt
LmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsN
Cj5saW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj5DYzogUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkgPGxha3NobWku
YmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsNCj5XYW4gTW9oYW1hZCwgV2FuIEFobWFk
IFphaW5pZQ0KPjx3YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IGFybmRA
YXJuZGIuZGUNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gbW1jOiBzZGhjaS1vZi1hcmFz
YW46IEVuYWJsZSBVSFMtMSBzdXBwb3J0IGZvcg0KPktlZW0gQmF5IFNPQw0KPg0KPg0KPg0KPk9u
IDA2LiAxMC4gMjAgMTc6NTUsIG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tIHdy
b3RlOg0KPj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaSA8bXVoYW1tYWQuaHVzYWlu
aS56dWxraWZsaUBpbnRlbC5jb20+DQo+Pg0KPj4gVm9sdGFnZSBzd2l0Y2hpbmcgc2VxdWVuY2Ug
aXMgbmVlZGVkIHRvIHN1cHBvcnQgVUhTLTEgaW50ZXJmYWNlLg0KPj4gVGhlcmUgYXJlIDIgcGxh
Y2VzIHRvIGNvbnRyb2wgdGhlIHZvbHRhZ2UuDQo+PiAxKSBCeSBzZXR0aW5nIHRoZSBBT04gcmVn
aXN0ZXIgdXNpbmcgZmlybXdhcmUgZHJpdmVyIGNhbGxpbmcNCj4+IHN5c3RlbS1sZXZlbCBwbGF0
Zm9ybSBtYW5hZ2VtZW50IGxheWVyIChTTUMpIHRvIHNldCB0aGUgcmVnaXN0ZXIuDQo+PiAyKSBC
eSBjb250cm9sbGluZyB0aGUgR1BJTyBleHBhbmRlciB2YWx1ZSB0byBkcml2ZSBlaXRoZXIgMS44
ViBvciAzLjNWDQo+PiBmb3IgcG93ZXIgbXV4IGlucHV0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+IDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxp
QGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4u
aHVudGVyQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
YXJhc2FuLmMgfCAxMjcNCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1hcmFzYW4uYw0KPj4gaW5kZXggZjE4NmZiZDAxNmIxLi5lNjgxZTZmODYwYmEgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+PiArKysgYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+PiBAQCAtMTYsNiArMTYsNyBAQA0K
Pj4gICAqLw0KPj4NCj4+ICAjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L2dwaW8vY29uc3VtZXIuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5
c2Nvbi5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4+ICAjaW5jbHVkZSA8bGlu
dXgvb2ZfZGV2aWNlLmg+DQo+PiBAQCAtMjMsNiArMjQsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51
eC9yZWdtYXAuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICAjaW5jbHVkZSA8bGlu
dXgvZmlybXdhcmUveGxueC16eW5xbXAuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvZmlybXdhcmUv
aW50ZWwva2VlbWJheV9maXJtd2FyZS5oPg0KPj4NCj4+ICAjaW5jbHVkZSAiY3FoY2kuaCINCj4+
ICAjaW5jbHVkZSAic2RoY2ktcGx0Zm0uaCINCj4+IEBAIC0xNTAsNiArMTUyLDcgQEAgc3RydWN0
IHNkaGNpX2FyYXNhbl9kYXRhIHsNCj4+ICAJc3RydWN0IHJlZ21hcAkqc29jX2N0bF9iYXNlOw0K
Pj4gIAljb25zdCBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX3NvY19jdGxfbWFwICpzb2NfY3RsX21hcDsN
Cj4+ICAJdW5zaWduZWQgaW50CXF1aXJrczsNCj4+ICsJc3RydWN0IGdwaW9fZGVzYyAqdWhzX2dw
aW87DQo+Pg0KPj4gIC8qIENvbnRyb2xsZXIgZG9lcyBub3QgaGF2ZSBDRCB3aXJlZCBhbmQgd2ls
bCBub3QgZnVuY3Rpb24gbm9ybWFsbHkgd2l0aG91dA0KPiovDQo+PiAgI2RlZmluZSBTREhDSV9B
UkFTQU5fUVVJUktfRk9SQ0VfQ0RURVNUCUJJVCgwKQ0KPj4gQEAgLTM2MSw2ICszNjQsMTEzIEBA
IHN0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX3ZvbHRhZ2Vfc3dpdGNoKHN0cnVjdA0KPm1tY19ob3N0
ICptbWMsDQo+PiAgCXJldHVybiAtRUlOVkFMOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGludCBz
ZGhjaV9hcmFzYW5fa2VlbWJheV92b2x0YWdlX3N3aXRjaChzdHJ1Y3QgbW1jX2hvc3QgKm1tYywN
Cj4+ICsJCQkJICAgICAgIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+PiArew0KPj4gKwlzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+PiArCXN0cnVjdCBzZGhjaV9wbHRm
bV9ob3N0ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4+ICsJc3RydWN0IHNkaGNp
X2FyYXNhbl9kYXRhICpzZGhjaV9hcmFzYW4gPQ0KPnNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9z
dCk7DQo+PiArCXUxNiBjdHJsXzI7DQo+PiArCXUxNiBjbGs7DQo+DQo+bml0OiBwdXQgaXQgdG8g
b25lIGxpbmUuDQpOb3RlZC4gRG9uZSB0aGUgY2hhbmdlcy4NCj4NCj4+ICsJaW50IHJldDsNCj4+
ICsNCj4+ICsJc3dpdGNoIChpb3MtPnNpZ25hbF92b2x0YWdlKSB7DQo+PiArCWNhc2UgTU1DX1NJ
R05BTF9WT0xUQUdFXzE4MDoNCj4+ICsJCWNsayAgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9D
TE9DS19DT05UUk9MKTsNCj4NCj5uaXQ6IGRvdWJsZSBzcGFjZQ0KTm90ZWQuIERvbmUgdGhlIGNo
YW5nZXMuDQo+DQo+PiArCQljbGsgJj0gflNESENJX0NMT0NLX0NBUkRfRU47DQo+PiArCQlzZGhj
aV93cml0ZXcoaG9zdCwgY2xrLCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4+ICsNCj4+ICsJCWNs
ayAgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4NCj5uaXQ6IGRv
dWJsZSBzcGFjZSBhZ2Fpbi4NCk5vdGVkLiBEb25lIHRoZSBjaGFuZ2VzLg0KPg0KPj4gKwkJaWYg
KGNsayAmIFNESENJX0NMT0NLX0NBUkRfRU4pDQo+PiArCQkJcmV0dXJuIC1FQUdBSU47DQo+PiAr
DQo+PiArCQlzZGhjaV93cml0ZWIoaG9zdCwgU0RIQ0lfUE9XRVJfT04gfCBTREhDSV9QT1dFUl8x
ODAsDQo+PiArCQkJCSAgIFNESENJX1BPV0VSX0NPTlRST0wpOw0KPj4gKw0KPj4gKwkJLyoNCj4+
ICsJCSAqIFNldCBWRERJT19CIHZvbHRhZ2UgdG8gTG93IGZvciAxLjhWDQo+PiArCQkgKiB3aGlj
aCBpcyBjb250cm9sbGluZyBieSBHUElPIEV4cGFuZGVyLg0KPj4gKwkJICovDQo+PiArCQlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAoc2RoY2lfYXJhc2FuLT51aHNfZ3BpbywgMCk7DQo+PiArDQo+
PiArCQkvKg0KPj4gKwkJICogVGhpcyBpcyBsaWtlIGZpbmFsIGdhdGVrZWVwZXIuIE5lZWQgdG8g
ZW5zdXJlIGNoYW5nZWQgdm9sdGFnZQ0KPj4gKwkJICogaXMgc2V0dGxlZCBiZWZvcmUgYW5kIGFm
dGVyIHR1cm4gb24gdGhpcyBiaXQuDQo+PiArCQkgKi8NCj4+ICsJCXVzbGVlcF9yYW5nZSgxMDAw
LCAxMTAwKTsNCj4+ICsNCj4+ICsJCXJldCA9DQo+a2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlv
bihLRUVNQkFZX1NFVF8xVjhfVk9MVCk7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCXJldHVybiBy
ZXQ7DQo+PiArDQo+PiArCQl1c2xlZXBfcmFuZ2UoMTAwMCwgMTEwMCk7DQo+PiArDQo+PiArCQlj
dHJsXzIgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9IT1NUX0NPTlRST0wyKTsNCj4+ICsJCWN0
cmxfMiB8PSBTREhDSV9DVFJMX1ZERF8xODA7DQo+PiArCQlzZGhjaV93cml0ZXcoaG9zdCwgY3Ry
bF8yLCBTREhDSV9IT1NUX0NPTlRST0wyKTsNCj4+ICsNCj4+ICsJCS8qIFNsZWVwIGZvciA1bXMg
dG8gc3RhYmlsaXplIDEuOFYgcmVndWxhdG9yICovDQo+PiArCQl1c2xlZXBfcmFuZ2UoNTAwMCwg
NTUwMCk7DQo+PiArDQo+PiArCQkvKiAxLjhWIHJlZ3VsYXRvciBvdXRwdXQgc2hvdWxkIGJlIHN0
YWJsZSB3aXRoaW4gNSBtcyAqLw0KPj4gKwkJY3RybF8yID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RI
Q0lfSE9TVF9DT05UUk9MMik7DQo+PiArCQlpZiAoIShjdHJsXzIgJiBTREhDSV9DVFJMX1ZERF8x
ODApKQ0KPj4gKwkJCXJldHVybiAtRUFHQUlOOw0KPj4gKw0KPj4gKwkJY2xrICA9IHNkaGNpX3Jl
YWR3KGhvc3QsIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPj4gKwkJY2xrIHw9IFNESENJX0NMT0NL
X0NBUkRfRU47DQo+PiArCQlzZGhjaV93cml0ZXcoaG9zdCwgY2xrLCBTREhDSV9DTE9DS19DT05U
Uk9MKTsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIE1NQ19TSUdOQUxfVk9MVEFHRV8zMzA6DQo+
PiArCQkvKg0KPj4gKwkJICogU2V0IFZERElPX0Igdm9sdGFnZSB0byBIaWdoIGZvciAzLjNWDQo+
PiArCQkgKiB3aGljaCBpcyBjb250cm9sbGluZyBieSBHUElPIEV4cGFuZGVyLg0KPj4gKwkJICov
DQo+PiArCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoc2RoY2lfYXJhc2FuLT51aHNfZ3Bpbywg
MSk7DQo+PiArDQo+PiArCQkvKg0KPj4gKwkJICogVGhpcyBpcyBsaWtlIGZpbmFsIGdhdGVrZWVw
ZXIuIE5lZWQgdG8gZW5zdXJlIGNoYW5nZWQgdm9sdGFnZQ0KPj4gKwkJICogaXMgc2V0dGxlZCBi
ZWZvcmUgYW5kIGFmdGVyIHR1cm4gb24gdGhpcyBiaXQuDQo+PiArCQkgKi8NCj4+ICsJCXVzbGVl
cF9yYW5nZSgxMDAwLCAxMTAwKTsNCj4+ICsNCj4+ICsJCXJldCA9DQo+a2VlbWJheV9zZF92b2x0
YWdlX3NlbGVjdGlvbihLRUVNQkFZX1NFVF8zVjNfVk9MVCk7DQo+PiArCQlpZiAocmV0KQ0KPj4g
KwkJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCQl1c2xlZXBfcmFuZ2UoMTAwMCwgMTEwMCk7DQo+
PiArDQo+PiArCQkvKiBTZXQgMS44ViBTaWduYWwgRW5hYmxlIGluIHRoZSBIb3N0IENvbnRyb2wy
IHJlZ2lzdGVyIHRvIDAgKi8NCj4+ICsJCWN0cmxfMiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJ
X0hPU1RfQ09OVFJPTDIpOw0KPj4gKwkJY3RybF8yICY9IH5TREhDSV9DVFJMX1ZERF8xODA7DQo+
PiArCQlzZGhjaV93cml0ZXcoaG9zdCwgY3RybF8yLCBTREhDSV9IT1NUX0NPTlRST0wyKTsNCj4+
ICsNCj4+ICsJCS8qIFNsZWVwIGZvciA1bXMgdG8gc3RhYmlsaXplIDMuM1YgcmVndWxhdG9yICov
DQo+PiArCQl1c2xlZXBfcmFuZ2UoNTAwMCwgNTUwMCk7DQo+PiArDQo+PiArCQkvKiAzLjNWIHJl
Z3VsYXRvciBvdXRwdXQgc2hvdWxkIGJlIHN0YWJsZSB3aXRoaW4gNSBtcyAqLw0KPj4gKwkJY3Ry
bF8yID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7DQo+PiArCQlpZiAo
Y3RybF8yICYgU0RIQ0lfQ1RSTF9WRERfMTgwKQ0KPj4gKwkJCXJldHVybiAtRUFHQUlOOw0KPj4g
Kw0KPj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+
ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBz
ZGhjaV9hcmFzYW5fa2VlbWJheV9zZWxlY3RfZHJpdmVfc3RyZW5ndGgoc3RydWN0IG1tY19jYXJk
DQo+KmNhcmQsDQo+PiArCQkJCQl1bnNpZ25lZCBpbnQgbWF4X2R0ciwgaW50IGhvc3RfZHJ2LA0K
Pj4gKwkJCQkJaW50IGNhcmRfZHJ2LCBpbnQgKmRydl90eXBlKQ0KPj4gK3sNCj4+ICsJaWYgKGNh
cmQtPmhvc3QtPmlvcy5zaWduYWxfdm9sdGFnZSA9PSBNTUNfU0lHTkFMX1ZPTFRBR0VfMTgwKQ0K
Pj4gKwkJKmRydl90eXBlID0gTU1DX1NFVF9EUklWRVJfVFlQRV9DOw0KPj4gKw0KPj4gKwlyZXR1
cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9vcHMgc2Ro
Y2lfYXJhc2FuX29wcyA9IHsNCj4+ICAJLnNldF9jbG9jayA9IHNkaGNpX2FyYXNhbl9zZXRfY2xv
Y2ssDQo+PiAgCS5nZXRfbWF4X2Nsb2NrID0gc2RoY2lfcGx0Zm1fY2xrX2dldF9tYXhfY2xvY2ss
IEBAIC0xNTIxLDYgKzE2MzEsNw0KPj4gQEAgc3RhdGljIGludCBzZGhjaV9hcmFzYW5fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAJc3RydWN0IHNkaGNpX3BsdGZtX2hv
c3QgKnBsdGZtX2hvc3Q7DQo+PiAgCXN0cnVjdCBzZGhjaV9hcmFzYW5fZGF0YSAqc2RoY2lfYXJh
c2FuOw0KPj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+
PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+DQo+bml0OiBJIGdvdCB0aGlz
IGJ1dCBhcyBJIHNlZSAzIGxpbmVzIGJlbG93IG1heWJlIHdvdWxkIGJlIGJldHRlciB0byB1c2Ug
aXQNCj5ldmVyeXdoZXJlIGJ1dCBpdCBjYW4gYmUgZG9uZSBpbiBzZXBhcmF0ZSBwYXRjaC4NCj4N
Cj4+ICAJY29uc3Qgc3RydWN0IHNkaGNpX2FyYXNhbl9vZl9kYXRhICpkYXRhOw0KPj4NCj4+ICAJ
bWF0Y2ggPSBvZl9tYXRjaF9ub2RlKHNkaGNpX2FyYXNhbl9vZl9tYXRjaCwgcGRldi0+ZGV2Lm9m
X25vZGUpOw0KPkBADQo+PiAtMTYwMCw2ICsxNzExLDIyIEBAIHN0YXRpYyBpbnQgc2RoY2lfYXJh
c2FuX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4qcGRldikNCj4+ICAJCWhvc3QtPm1t
Yy0+Y2FwcyB8PSBNTUNfQ0FQX1dBSVRfV0hJTEVfQlVTWTsNCj4+ICAJfQ0KPj4NCj4+ICsJaWYg
KG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAiaW50ZWwsa2VlbWJheS1zZGhjaS01LjEtc2Qi
KSkgew0KPj4gKwkJc3RydWN0IGdwaW9fZGVzYyAqdWhzOw0KPj4gKw0KPj4gKwkJdWhzID0gZGV2
bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAidWhzIiwNCj5HUElPRF9PVVRfSElHSCk7DQo+DQo+
SSBjYW4ndCBzZWUgY2hhbmdlIGluIGR0IGJpbmRpbmcgdG8gcmVjb3JkIHVocyBncGlvLg0KTm90
ZWQuIERvbmUgdGhlIGNoYW5nZXMuIFdpbGwgYWRkIGJpbmRpbmcgZm9yIHRoaXMNCj4NCj4NCj5C
ZXR0ZXINCj5zZGhjaV9hcmFzYW4tPnVoc19ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwo
ZGV2LCAidWhzIiwNCj5HUElPRF9PVVRfSElHSCk7DQo+DQo+dGhlbiB5b3UgY2FuIGF2b2lkIHVo
cyB2YXJpYWJsZS4NCldpbGwgcmVtYWluIGFzIGl0IGlzIHRvIG1ha2UgaXQgbW9yZSByZWFkYWJs
ZS4NCj4NCj4+ICsJCWlmIChJU19FUlIodWhzKSkNCj4+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9i
ZShkZXYsIFBUUl9FUlIodWhzKSwgImNhbid0IGdldA0KPnVocyBncGlvXG4iKTsNCj4+ICsNCj4+
ICsJCXNkaGNpX2FyYXNhbi0+dWhzX2dwaW8gPSB1aHM7DQo+PiArDQo+PiArCQlob3N0LT5tbWNf
aG9zdF9vcHMuc3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoID0NCj4+ICsJCQlzZGhjaV9hcmFz
YW5fa2VlbWJheV92b2x0YWdlX3N3aXRjaDsNCj4+ICsNCj4+ICsJCWhvc3QtPm1tY19ob3N0X29w
cy5zZWxlY3RfZHJpdmVfc3RyZW5ndGggPQ0KPj4gKwkJCXNkaGNpX2FyYXNhbl9rZWVtYmF5X3Nl
bGVjdF9kcml2ZV9zdHJlbmd0aDsNCj4+ICsJfQ0KPj4gKw0KPj4gIAlzZGhjaV9hcmFzYW5fdXBk
YXRlX2Jhc2VjbGtmcmVxKGhvc3QpOw0KPj4NCj4+ICAJcmV0ID0gc2RoY2lfYXJhc2FuX3JlZ2lz
dGVyX3NkY2xrKHNkaGNpX2FyYXNhbiwgY2xrX3hpbiwNCj4+ICZwZGV2LT5kZXYpOw0KPj4NCj4N
Cj5UaGFua3MsDQo+TWljaGFsDQo=
