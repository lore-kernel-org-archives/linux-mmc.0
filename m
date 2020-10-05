Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F2C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D1D20781
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gYbwtTb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJEIhb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:37:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:20550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgJEIha (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 04:37:30 -0400
IronPort-SDR: 8GjfSt5oYcxo14Gzf7G40zI2ly9SFi8wyMAHwUpnl//vsHN39aGP5VntmtswDnQmGKW23V+1LV
 9Ob55qs5Lwlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="160662910"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="160662910"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 01:37:24 -0700
IronPort-SDR: 4+C8dNjn/uLepRw+6z7FKcSopulfNW66wTAfhr8DWkOMVQAnIwpVSoktZgHeJpF5WDfOvINPdK
 i8tk63MP2ynw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="386487085"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 05 Oct 2020 01:37:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:37:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 01:37:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 01:37:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 01:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1QeYnXPSatpsutQsEMJdluVAxziGmuBjQ3VPo5BPKMqsRuzC09mUQCUPqjSPZeEbRpepfzEtGNQ4tb7GfNun4LDDSz/U7ng6XOzt3/MH5X7AR/oUpIJn50Q62Y3Q+BqluE5gBvx2EmWIP5hDZixdkwq/TWmWjNOv7+e/zUVSqZAw3L60WSGg+qUm/mLQQXG02dQzM0y+69mvDjPC/XJDMABs9PVFgQbYEstnr61s00MVo3+u6DYyHH+uXc9LiPSLnqNnUhVV3eU0WYmP1deDtHg8b7LjJa+FOpqE50rN5NoJXGZWhmVyyqitP34y2BkwzWn37pwSqLq6446zELlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTO/VMpMFelWJ65nsAwRu2dqGWHiBMmEGbCPEDJN2ZM=;
 b=mhQOSn4sSfPmoGO3JgCuYSaSyg2sOkjhepmxbumxS14ntnWCCkJmtyEClYMtcFrVSzO+fKOjJ8p+fVW8xR/Zu8UmFjodeQ5yCbPXi0RKy+vyc4+6BMR3Q352XlsRSQeb/HEGxmCz1P6+VzmepaD67tCizM/RE2jsVcwPwgRuycihZiPjSUXlJyhtPvH5ilbdACGWe+5LBJjIhy/Q9UXGt38y8CXWL18Wk279ALWAMlXnTbOLkmdAh2VuLsLuV+5I3Vbj+hugLaRPKwu/SHgpKnMa8G36wgQXI8lzO11WpS+kuOzsGWei6uqfCjho/w2jyly6Qd2U2ZGxUybn8KXM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTO/VMpMFelWJ65nsAwRu2dqGWHiBMmEGbCPEDJN2ZM=;
 b=gYbwtTb5rH+1cvnmEiqXumQSOXk0ddtkIPwcGynC/vS59uzkzpt/FGEWypx2ZsUmrhG8gBirpc26fNfDsy3COIA/MNljf5SwZu4ZasZ79ZVNcGaRKZyaTlLWOTA6bsJnYm5HWwbGMsXz+HPhTfxzoUCJvwOtlEU/YQsAc4lZ0w4=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by BYAPR11MB2966.namprd11.prod.outlook.com (2603:10b6:a03:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.40; Mon, 5 Oct
 2020 08:37:13 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 08:37:13 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: RE: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAACt8AIAAMNyAgAAQH4CABEzPQA==
Date:   Mon, 5 Oct 2020 08:37:13 +0000
Message-ID: <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
In-Reply-To: <20201002145115.GA6520@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8082e701-12cc-4c80-caa6-08d86909dbfe
x-ms-traffictypediagnostic: BYAPR11MB2966:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2966299AAF5AB865DBE20116B80C0@BYAPR11MB2966.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NnEhyU7sxTyRaKO/oE5DVr3Ag9su5aN3sviu0sSENVkpIk3r4YgS9+FwhxEQVheycfbmxBPIsNRTI0wOLswDyXydQ2d1ag2IYt/qvMcGkaO+bTVxgI2T7jtlWuXFKuEIaKm41VS5eVcXOk4WpEyoPxBa3q4VuTmZkqFCm+vl/PsMVFHPt7nse9hzIdU5CqmvHzR6lvVxEukW79qSAHLJjyhmZdmNj03Muzl/NpynNP/8PX8W/2KJiW0iWOa3mCKQFZWNDwTOKJNAdsNg7zEPLBu6vwas/ffFXK+SwRUB9MmyUEm2dJQf1mz3geT/7DRhgOxTdlbM87ctczb4kAHcz0O8juASvwkc0staOHXeJds3AEUwztwF/sjjBbMw9C020kJopyaTpfE43g1xHzadng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(66446008)(64756008)(66556008)(478600001)(66946007)(83080400001)(7696005)(83380400001)(5660300002)(8936002)(55016002)(71200400001)(33656002)(52536014)(66476007)(76116006)(186003)(966005)(4326008)(26005)(6506007)(86362001)(9686003)(110136005)(8676002)(2906002)(316002)(107886003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Fx1u++3kgLmjj7+4lMGauBeBY0qyYKEhVqfcwQO+u5P/lQNMKn7D73+6vCBbK5qGyy3uyphOJsX5vsJSb5gWGk22DtoisU4uSVv4buw2lXtgipIT5cItV5XPxEt8DtdbOiJG6eocQlYRap+TvZ7niZUUCQyk3UTJCmp8PsODvgCeyfG5L7SYuf7eNvEL/Jj0LQC9BEC/uAAmoYNqs4QADEUJrzCHZLG/HRx4wpTYxSgRo1niH0bZsTKpG+S9KPG02524vKmcuA6/4eTvMUEekZKChviQ9Ok8+Eg1+J3MoWyZrSqx2N+uEVL86tax9+/p7gODgJJf9viPOPtvehs7UxFU7iYeY84tuf7zDpPeVusbyZiTWQshYpvSDQUZlT2L9+BGzpWdgdV4VH/ev5pKbsMgkwrkksUK6scYPAWXaXPE8XKRU6uocUQbCmdXE9WewKaBM1MqorN2srO5Tix2ywA0i7hYnl0LOFcPlsiRDegnHCDcZZnrnsPD/mx8kOvRC/4dIU9AIoXmNV0aNifumsE342pywYErjigxQFHH9fD8JTjAnjL5Nz4I71J4jT+TPuRnvdFo3hrHZKgZ/pgiEL+WUZ5wMFc9ixskIVXT1HTO2DrPB2Af10BpEDzKMDgi1BFGBxdB9EXSNhMp7XtRxg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8082e701-12cc-4c80-caa6-08d86909dbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 08:37:13.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckthfwV6dAbQBWofdDhQEsTA9wwlBHsAs95aRVYLY7uAFAd7M/KL99O2CAp7+z3fdzQAAID4EF6duci75Rju8z2kMQk9j/MzSFl0omjU9tj7OQ7JcJmIsLQsn8eX+skB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2966
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgU3VkZWVwLA0KDQpJIGFtIGZhY2luZyBhbiBlcnJvciBkdXJpbmcgc2VuZGluZyB5ZXN0ZXJk
YXkuDQpJIHJlc3BvbnNlIGFnYWluIHRvIHlvdXIgZmVlZGJhY2sgYXMgYmVsb3cNCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFA
YXJtLmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMiwgMjAyMCAxMDo1MSBQTQ0KPlRvOiBN
aWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPkNjOiBadWxraWZsaSwgTXVo
YW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+Ow0KPkh1
bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IHVsZi5oYW5zc29uQGxpbmFy
by5vcmc7IGxpbnV4LQ0KPm1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmFqYSBT
dWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj48bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBp
bnRlbC5jb20+OyBhcm5kQGFybmRiLmRlOyBTdWRlZXAgSG9sbGENCj48c3VkZWVwLmhvbGxhQGFy
bS5jb20+OyBXYW4gTW9oYW1hZCwgV2FuIEFobWFkIFphaW5pZQ0KPjx3YW4uYWhtYWQuemFpbmll
Lndhbi5tb2hhbWFkQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gZmly
bXdhcmU6IEtlZW0gQmF5OiBBZGQgc3VwcG9ydCBmb3IgQXJtIFRydXN0ZWQNCj5GaXJtd2FyZSBT
ZXJ2aWNlIGNhbGwNCj4NCj5IaSBNaWNoYWwsDQo+DQo+T24gRnJpLCBPY3QgMDIsIDIwMjAgYXQg
MDM6NTM6MzNQTSArMDIwMCwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPj4gSGkgU3VkZWVwLA0KPj4N
Cj4+IE9uIDAyLiAxMC4gMjAgMTI6NTgsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+ID4gSGkgTWlj
aGFsLA0KPj4gPg0KPj4gPiBPbiBGcmksIE9jdCAwMiwgMjAyMCBhdCAxMDoyMzowMkFNICswMjAw
LCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+PiA+PiBIaSBTdWRlZXAsDQo+PiA+Pg0KPj4gPj4gT24g
MDEuIDEwLiAyMCAxNzozNSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4gPg0KPj4gPiBbLi4uXQ0K
Pj4gPg0KPj4gPj4+DQo+PiA+Pj4gV2hhdCBhcmUgdGhlIG90aGVyIHVzZXMgb2YgdGhpcyBLRUVN
QkFZX1NJUF8qID8NCj4+ID4+PiBGb3Igbm93IEkgdGVuZCB0byBtb3ZlIHRoaXMgdG8gdGhlIGRy
aXZlciBtYWtpbmcgdXNlIG9mIGl0IHVzaW5nDQo+PiA+Pj4gYXJtX3NtY2NjXzFfMV9pbnZva2Ug
ZGlyZWN0bHkgaWYgcG9zc2libGUuIEkgZG9uJ3Qgc2VlIHRoZSBuZWVkDQo+PiA+Pj4gZm9yIHRo
aXMgdG8gYmUgc2VwYXJhdGUgZHJpdmVyLiBCdXQgZG8gbGV0IHVzIGtub3cgdGhlIGZlYXR1cmVz
DQo+PiA+Pj4gaW1wbGVtZW50ZWQgaW4gdGhlIGZpcm13YXJlLiBJZiBpdCBpcyBub3QgdjEuMSss
IHJlYXNvbnMgZm9yIG5vdA0KPj4gPj4+IHVwZ3JhZGluZyBhcyB5b3UgbmVlZCB2MS4xIGZvciBz
b21lIENQVSBlcnJhdGEgaW1wbGVtZW50YXRpb24uDQo+PiA+Pg0KPj4gPj4gVGhpcyBkcml2ZXIg
aGFzIGJlZW4gY3JlYXRlZCBiYXNlZCBvbiBteSByZXF1ZXN0IHRvIG1vdmUgaXQgb3V0IHRoZQ0K
Pj4gPj4gbW1jIGRyaXZlci4gSXQgbG9va3MgcXVpdGUgaGFja3kgdG8gaGF2ZSBhcm1fc21jY2Nf
cmVzIGFuZCBjYWxsDQo+PiA+PiBhcm1fc21jY2Nfc21jKCkgYWxzbyB3aXRoIHNvbWUgSURzIHdo
ZXJlIGl0IGlzIHZpc2libGUgdGhhdCB0aGUNCj4+ID4+IHBhcnQgb2YgSUQgaXMganVzdCBiYXNl
ZCBvbiBhbnkgc3BlYy4NCj4+ID4NCj4+ID4gT0ssIGRyaXZlciBpcyBmaW5lIGJ1dCBubyBkdC1i
aW5kaW5ncyBhcyBpdCBpcyBkaXNjb3ZlcmFibGUuIEl0IGNhbg0KPj4gPiBhbHNvIGJlIGp1c3Qg
YSB3cmFwcGVyIGxpYnJhcnkgaW5zdGVhZCBhcyBpdCBuZWVkcyBubyBleHBsaWNpdA0KPj4gPiBp
bml0aWFsaXNhdGlvbiBsaWtlIGRyaXZlcnMgdG8gc2V0dXAuDQo+Pg0KPj4gSSBhbSBmaW5lIHdp
dGggaXQuIERvIHdlIGhhdmUgYW55IGV4YW1wbGUgd2hpY2ggd2UgY2FuIHBvaW50IGhpbSB0bz8N
Cj4+DQo+DQo+WW91IHNlZW0gdG8gaGF2ZSBmaWd1cmVkIHRoYXQgb3V0IGFscmVhZHkgd2l0aCBT
T0NfSUQgZXhhbXBsZS4NCj5UaGF0IHdhcyBxdWljayBJIG11c3Qgc2F5IPCfmIQuDQo+DQo+Pg0K
Pj4gPg0KPj4gPj4gQWxzbyBpbiB2MSBoZSBpcyBqdXN0IGNhbGxpbmcgU01DLiBCdXQgbWF5YmUg
dGhlcmUgaXMgZ29pbmcgYSBuZWVkDQo+PiA+PiB0byBjYWxsIEhWQyBpbnN0ZWFkIHdoaWNoIGlz
IHNvbWV0aGluZyB3aGF0IGRldmljZSBkcml2ZXIgc2hvdWxkbid0DQo+PiA+PiBkZWNpZGUgdGhh
dCdzIHdoeSBJTUhPIGRvaW5nIHN0ZXAgdmlhIGZpcm13YXJlIGRyaXZlciBpcyBtdWNoIGJldHRl
cg0KPmFwcHJvYWNoLg0KPj4gPg0KPj4gPiBBZ3JlZWQgYW5kIG9uZSBtdXN0IHVzZSBhcm1fc21j
Y2NfZ2V0X2NvbmR1aXQgb3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+PiA+IE5vIGFkZGl0aW9uYWwg
YmluZGluZ3MgZm9yIGVhY2ggYW5kIGV2ZXIgcGxhdGZvcm0gYW5kIGRyaXZlciB0aGF0DQo+PiA+
IHVzZXMgU01DQ0MgcGxlYXNlLg0KPj4gPg0KPj4gPj4gT2YgY291cnNlIGlmIHRoZXJlIGlzIGEg
YmV0dGVyL2NsZWFuZXIgd2F5IGhvdyB0aGlzIHNob3VsZCBiZSBkb25lDQo+PiA+PiBJIGFtIGhh
cHB5IHRvIGdldCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGl0Lg0KPj4gPj4NCj4+ID4NCj4+ID4g
TGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsgYWJvdXQgbXkgdGhvdWdodHMgc3RhdGVkIGFib3Zl
Lg0KPj4NCj4+DQo+PiBJIGFtIGZpbmUgd2l0aCBpdC4gVGhlIGtleSBwb2ludCBpcyB0byBoYXZl
IHRoZXNlIHNvcnQgaXQgb3V0IGJlY2F1c2UNCj4+IEkgc2VlIHRoYXQgYSBsb3Qgb2YgZHJpdmVy
cyBqdXN0IHNpbXBseSBjYWxsIHRoYXQgU01DcyBmcm9tIGRyaXZlcnMNCj4+IHdoaWNoIGlzIElN
SE8gd3JvbmcuDQo+Pg0KPg0KPlN1cmUsIHNvcnJ5IEkgZGlkbid0IGV4cHJlc3MgbXkgY29uY2Vy
biBwcm9wZXJseS4gSSB3YW50IHRvIGF2b2lkIGR0IGJpbmRpbmdzIGZvcg0KPnRoZXNlIGFuZCB1
c2UgdGhlIFNNQ0NDIGRpc2NvdmVyeSB3ZSBoYXZlIGluIHBsYWNlIGFscmVhZHkgaWYgcG9zc2li
bGUuDQo+DQo+SWYgdGhpcyBkcml2ZXIgaGFkIGNvbnN1bWVycyBpbiB0aGUgRFQgYW5kIGl0IG5l
ZWRzIHRvIGJlIHJlcHJlc2VudGVkIGluIERULCBpdCBpcw0KPmEgZGlmZmVyZW50IHN0b3J5IGFu
ZCBJIGFncmVlIGZvciBuZWVkIGZvciBhIGRyaXZlciB0aGVyZS4NCj5CdXQgSSBkb24ndCBzZWUg
b25lIGluIHRoaXMgdXNlY2FzZS4NCg0KDQpEb2VzIGl0IG9rIGlmIEkgZG8gc29tZSBjaGVja2lu
ZyBpbiBhcmFzYW4gY29udHJvbGxlciBkcml2ZXIgYXMgYmVsb3cgYW5kIHJlcHJlc2VudGVkIGl0
IGluIHRoZSBEVCBvZiBhcmFzYW4sc2RoY2kueWFtbDoNClRoaXMgaXMgdG8gZW5zdXJlIHRoYXQg
Zm9yIEtlZW0gQmF5IFNPQyBzcGVjaWZpYywgdGhlIGZpcm13YXJlIGRyaXZlciBtdXN0IGJlIGNv
bnN1bWUuDQoNCglpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJpbnRlbCxrZWVtYmF5
LXNkaGNpLTUuMS1zZCIpKSB7DQoJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqZG47DQoJCXN0cnVjdCBn
cGlvX2Rlc2MgKnVoczsNCg0KCQlkbiA9IG9mX2ZpbmRfbm9kZV9ieV9uYW1lKE5VTEwsICJrZWVt
YmF5X2Zpcm13YXJlIik7DQoJCWlmICghZG4pDQoJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IFBUUl9FUlIoZG4pLA0KCQkJCQkJImNhbid0IGZpbmQga2VlbWJheV9maXJtd2FyZSBub2RlXG4i
KTsNCgkJb2Zfbm9kZV9wdXQoZG4pOw0KLi4uLi4uLi4uLg0KfQ0KPg0KPj4NCj4+IEJUVzogSSBz
ZWUgeW91IGhhdmUgYWRkZWQgc29jIGlkIHJlYWRpbmcgd2hpY2ggeW91IGFyZSBzYXlpbmcgaXMg
dGhlDQo+PiBwYXJ0IG9mIHNtY2MgdjEuMiBidXQgSSBjYW4ndCBzZWUgYW55IGltcGxlbWVudGF0
aW9uIGluIFRGLUEuIElzIHRoaXMNCj4+IHNwZWMgcHVibGljbHkgYXZhaWxhYmxlPw0KPj4NCj4N
Cj5TcGVjIGlzIG91dFsxXSwgaW5jbHVkZS9saW51eC9hcm0tc21jY2MuaCBwb2ludHMgdG8gdGhl
IGxhdGVzdCBzcGVjLg0KPlRGLUEgZG9lcyBoYXZlIGltcGxlbWVudGF0aW9uIGFzIEkgdGVzdGVk
IHdpdGggaXQgYW5kIGV2ZW4gcmVwb3J0ZWQgYnVnIHRoYXQgSQ0KPmRpc2NvdmVyZWQgd2hlbiBJ
IHRlc3RlZCB3aXRoIG15IHBhdGNoZXMgdGhhdCBhcmUgbm93IG1lcmdlZCB1cHN0cmVhbS4gQXJl
DQo+eW91IHJlZmVycmluZyB0byBtYXN0ZXIgb2YgVEYtQSBvciBsYXN0IHJlbGVhc2UgdmVyc2lv
biA/DQo+SWYgbGF0dGVyLCBpdCBoYWQgYnVnIGFuZCBtYXkgbm90IGJlIHdvcmtpbmcuIEkgbWF5
IGJlIHdyb25nIHRob3VnaCwgYXMgSSBhbSBqdXN0DQo+dGVsbGluZyB3aGF0IHdhcyB0b2xkIHRv
IG1lIGNvdXBsZSBvZiBtb250aHMgYmFjayBhbmQgdGhpbmdzIG1pZ2h0IGhhdmUNCj5jaGFuZ2Vk
IGluIFRGLUEgbGFuZC4NCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+U3VkZWVwDQo+DQo+WzFdIGh0dHBz
Oi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMDI4L2xhdGVzdA0K
