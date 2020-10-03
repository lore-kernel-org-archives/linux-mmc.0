Return-Path: <SRS0=8Wh9=DK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AFAC4363D
	for <linux-mmc@archiver.kernel.org>; Sat,  3 Oct 2020 19:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F01A206DD
	for <linux-mmc@archiver.kernel.org>; Sat,  3 Oct 2020 19:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="T83d8nnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgJCTD1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:03:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:10430 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgJCTD1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 3 Oct 2020 15:03:27 -0400
IronPort-SDR: diKQwBpvBf1A88ATEQ5BsAXoGTf7pTuAeMsy/BIwaa5kRGxm3sETik8HtWhRHzuau1JyVJ12eC
 Yx6JIhROGXyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="227377687"
X-IronPort-AV: E=Sophos;i="5.77,332,1596524400"; 
   d="scan'208";a="227377687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 12:03:18 -0700
IronPort-SDR: smabDqlwBvIDTcu8WExXGRjkpYHfdCXLGBh+G8rVAga7KMrs6KX/BnSDavtsmTg11Dpkp1zIup
 tnUTV1i/gF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,332,1596524400"; 
   d="scan'208";a="346810335"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2020 12:03:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 3 Oct 2020 12:03:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 3 Oct 2020 12:03:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 3 Oct 2020 12:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwTefQ+2ky42EQRFW0j0FQtJAiRgFpeV8X7oFl9Ap0bMOl/2UmmPVhawAvOYgIedLQNcD8hXzJY3nHxT8MtHh5Sfesc4o7Pw3Dx6p5l2tRXAf5ueX5tahllXch5uFzAYXvvQJrFv2hUrQKSJqcYTpThVaeUjXCPu2nnWZKQV6hP7yRTTri4JhNHW9k4NN/5ecB9xlHsJ5Rr6b2EQMCp/WI6txtpjvv91whDZCZ+YkVlPT+xt4CMSUABSJWYyOXVJe9EkxDQ/azDgHYIgoCst4487vc4YRZGbwUVhpNxgwMjFPf30/9tt+P/gni9tANCPd/RyZ28Zu8hlS+1ywncPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlLlIvM7csm/edJkamulYzkhhsWD0D3dn0/3Gz+dEE=;
 b=hJ9b0tQyilFO9f07gv4X2Xro4p1ofn1CvQvTvr1EVA8jNUMKweQr+SQyr2zHnVAYEBJYtWG5XA7ucB6Sr/7QQKBCJcARPnGqNxIvpIyW5w8fSy8isSKIDqAPm0yTq1LnCD6UGBbtripG5d6nnKNoPBxH+UgV14qTkTChcgDUB99+n0Se6GCKFGADHKyGxmh5A98KadgqDwi+AiP0zT1KEneX1wb3jnkSty+gUuTma7cIFngzhVQQLPZ5kISoSGl5gA1/WXtZv2TzB5CxiYMdOl6Vs7UY0QdRVQqDIPsXcX7vFTrocMlh8B3sqpxP2a/FZIYa8LHXqpyodUnNSASnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlLlIvM7csm/edJkamulYzkhhsWD0D3dn0/3Gz+dEE=;
 b=T83d8nnjSSGk6drDgLQXBQUjuYx/Tc6XBU9j6M84ZgDrJ5KiZzq3GsiHZbsvxF05uShg85nRb2k+0SotM7LT4XvSX24xeDlbxyTUked1KAhIslID6aJ3F6Gy2SFfxE1HX84ODooNkWZq3nJI+1PeZdHuloKL7+O2p22uz6+AedY=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 19:03:14 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.032; Sat, 3 Oct 2020
 19:03:14 +0000
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
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAACt8AIAAMNyAgAAQH4CAAdbRwA==
Date:   Sat, 3 Oct 2020 19:03:13 +0000
Message-ID: <BYAPR11MB30151D697F4D3E21224CEE39B80E0@BYAPR11MB3015.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: e26a8172-af70-4d49-3722-08d867cefab9
x-ms-traffictypediagnostic: BYAPR11MB3015:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB301534F9DBD50D092E3447FAB80E0@BYAPR11MB3015.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UnlCIyknuqTJpKSy6QZK0semo0etkkwuUb3z50LLN1z3Kp7r+SGiJAmdoHk21sDaMQt4er4iwh21INCltuHIGWsSJRVwOTehBANgUCIVC+MZSUar2lYyCsl3X30zXYNUN4k4o6MLGN7n6Vgkec4Np+RObrIejInR2Bh+Z58GOo/sFxsz4H2v3TsL69Gw5hL76dyiNatH0jAmSFCZE/++GsICB6QYUdHJ3+RzWu305hQtSHMVVij27IOqz0tylP9/sSDJR9NI08q5TKCn2YgHzKjcxYYKwS3WErjeChngwLhLDNXTfdt215SX3snlzwtjc0SHH+tHztuoccpAACBEzG2iBI+OzK6QeGilId9guD3BaOiho45u13Ss78Rcwoxiw8po2FMxphpfVdwxs36vgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(86362001)(52536014)(26005)(54906003)(66556008)(66476007)(66946007)(9686003)(64756008)(76116006)(186003)(5660300002)(7696005)(316002)(6506007)(66446008)(2906002)(83080400001)(55016002)(4326008)(33656002)(83380400001)(107886003)(478600001)(8676002)(8936002)(110136005)(71200400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ESJRAoMC5C8nMrY62RfjDcfqBtpzqWFeDqrh7D3By/nZrLTcV2ZwOF4BbD3ER+LjjGbPvytscLiAAjoD0XW+ZEY1dV2anTDsWlnjNqBMVroXTALmTExmuzJeL3DN4O9QyTm4vXoKC4DQnB7UeHrBUvdSFvToFgP0LYukUIrNFAgUNH9Xxj3uwA49IUSh0SxMK525Db8H/jIduQ506XWX84XNIOUc+2ZheqDp5z3M0WVXcEM51HH7KPoEiRvlezoqnwNDq1R1+zQvPIp9wsSt1vwrGQs3SPjbGzC7JBXAanfDlUtaGxOHQly6GTN4M2n6gPKP+iOjsmfsUzgdFvRbm257MjUd79YWsgkFMr6OkW1bubLFfExkhVnfR9b8FnOPo3Eu/uycRMtAVuS02tYUlKePZ8jDjI74LFFDVXWvjt2X5/tJ7eEX02qwbaqFjhfyg59SKgKJVjTaj3ncgCHNi/bQa4m8z7zxBBiN7AM1+hAeDtyzhS6jRyglaW25ZjkY7PVOMHMD/TmpqnjRRjegay0aiHGATtzJPQp3gkyn2ahgaSp/JM92asIMZSOrtn3vmhJEceaXDydu0CmdtPrT8BRleznF6WiMHpowN5ne5q8h+WVkAEw5LJnWkIINV39IgGHm/2B5exOTEPOPx2VcCA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26a8172-af70-4d49-3722-08d867cefab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 19:03:13.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 277q8eDwg11A9cTiWoOSzPAEi2pWpqJVgY6YBjouHHA17YPJSIreTAw8I5F0XoY/U+8RkiSnBwbtPkLoZo8CGef5OpO/lj/bKpS9oWngKY7BfkHWFcWATnuafyuGQ9fW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBTdWRlZXAg
SG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyLCAy
MDIwIDEwOjUxIFBNDQo+VG86IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+
DQo+Q2M6IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtp
ZmxpQGludGVsLmNvbT47DQo+SHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgbGludXgtDQo+bW1jQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPjxsYWtzaG1pLmJh
aS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47IGFybmRAYXJuZGIuZGU7IFN1ZGVlcCBIb2xs
YQ0KPjxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFdhbiBNb2hhbWFkLCBXYW4gQWhtYWQgWmFpbmll
DQo+PHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMi8zXSBmaXJtd2FyZTogS2VlbSBCYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0g
VHJ1c3RlZA0KPkZpcm13YXJlIFNlcnZpY2UgY2FsbA0KPg0KPkhpIE1pY2hhbCwNCj4NCj5PbiBG
cmksIE9jdCAwMiwgMjAyMCBhdCAwMzo1MzozM1BNICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6
DQo+PiBIaSBTdWRlZXAsDQo+Pg0KPj4gT24gMDIuIDEwLiAyMCAxMjo1OCwgU3VkZWVwIEhvbGxh
IHdyb3RlOg0KPj4gPiBIaSBNaWNoYWwsDQo+PiA+DQo+PiA+IE9uIEZyaSwgT2N0IDAyLCAyMDIw
IGF0IDEwOjIzOjAyQU0gKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToNCj4+ID4+IEhpIFN1ZGVl
cCwNCj4+ID4+DQo+PiA+PiBPbiAwMS4gMTAuIDIwIDE3OjM1LCBTdWRlZXAgSG9sbGEgd3JvdGU6
DQo+PiA+DQo+PiA+IFsuLi5dDQo+PiA+DQo+PiA+Pj4NCj4+ID4+PiBXaGF0IGFyZSB0aGUgb3Ro
ZXIgdXNlcyBvZiB0aGlzIEtFRU1CQVlfU0lQXyogPw0KPj4gPj4+IEZvciBub3cgSSB0ZW5kIHRv
IG1vdmUgdGhpcyB0byB0aGUgZHJpdmVyIG1ha2luZyB1c2Ugb2YgaXQgdXNpbmcNCj4+ID4+PiBh
cm1fc21jY2NfMV8xX2ludm9rZSBkaXJlY3RseSBpZiBwb3NzaWJsZS4gSSBkb24ndCBzZWUgdGhl
IG5lZWQNCj4+ID4+PiBmb3IgdGhpcyB0byBiZSBzZXBhcmF0ZSBkcml2ZXIuIEJ1dCBkbyBsZXQg
dXMga25vdyB0aGUgZmVhdHVyZXMNCj4+ID4+PiBpbXBsZW1lbnRlZCBpbiB0aGUgZmlybXdhcmUu
IElmIGl0IGlzIG5vdCB2MS4xKywgcmVhc29ucyBmb3Igbm90DQo+PiA+Pj4gdXBncmFkaW5nIGFz
IHlvdSBuZWVkIHYxLjEgZm9yIHNvbWUgQ1BVIGVycmF0YSBpbXBsZW1lbnRhdGlvbi4NCj4+ID4+
DQo+PiA+PiBUaGlzIGRyaXZlciBoYXMgYmVlbiBjcmVhdGVkIGJhc2VkIG9uIG15IHJlcXVlc3Qg
dG8gbW92ZSBpdCBvdXQgdGhlDQo+PiA+PiBtbWMgZHJpdmVyLiBJdCBsb29rcyBxdWl0ZSBoYWNr
eSB0byBoYXZlIGFybV9zbWNjY19yZXMgYW5kIGNhbGwNCj4+ID4+IGFybV9zbWNjY19zbWMoKSBh
bHNvIHdpdGggc29tZSBJRHMgd2hlcmUgaXQgaXMgdmlzaWJsZSB0aGF0IHRoZQ0KPj4gPj4gcGFy
dCBvZiBJRCBpcyBqdXN0IGJhc2VkIG9uIGFueSBzcGVjLg0KPj4gPg0KPj4gPiBPSywgZHJpdmVy
IGlzIGZpbmUgYnV0IG5vIGR0LWJpbmRpbmdzIGFzIGl0IGlzIGRpc2NvdmVyYWJsZS4gSXQgY2Fu
DQo+PiA+IGFsc28gYmUganVzdCBhIHdyYXBwZXIgbGlicmFyeSBpbnN0ZWFkIGFzIGl0IG5lZWRz
IG5vIGV4cGxpY2l0DQo+PiA+IGluaXRpYWxpc2F0aW9uIGxpa2UgZHJpdmVycyB0byBzZXR1cC4N
Cj4+DQo+PiBJIGFtIGZpbmUgd2l0aCBpdC4gRG8gd2UgaGF2ZSBhbnkgZXhhbXBsZSB3aGljaCB3
ZSBjYW4gcG9pbnQgaGltIHRvPw0KPj4NCj4NCj5Zb3Ugc2VlbSB0byBoYXZlIGZpZ3VyZWQgdGhh
dCBvdXQgYWxyZWFkeSB3aXRoIFNPQ19JRCBleGFtcGxlLg0KPlRoYXQgd2FzIHF1aWNrIEkgbXVz
dCBzYXkg8J+YhC4NCj4NCj4+DQo+PiA+DQo+PiA+PiBBbHNvIGluIHYxIGhlIGlzIGp1c3QgY2Fs
bGluZyBTTUMuIEJ1dCBtYXliZSB0aGVyZSBpcyBnb2luZyBhIG5lZWQNCj4+ID4+IHRvIGNhbGwg
SFZDIGluc3RlYWQgd2hpY2ggaXMgc29tZXRoaW5nIHdoYXQgZGV2aWNlIGRyaXZlciBzaG91bGRu
J3QNCj4+ID4+IGRlY2lkZSB0aGF0J3Mgd2h5IElNSE8gZG9pbmcgc3RlcCB2aWEgZmlybXdhcmUg
ZHJpdmVyIGlzIG11Y2ggYmV0dGVyDQo+YXBwcm9hY2guDQpJIHdpbGwgYWRkIGZ1bmMgZm9yIEhW
QyBhbHNvIGluIGNhc2UgaW4gdGhlIGZ1dHVyZSBpZiBzb21lb25lIHdhbnQgdG8gdXNlIGl0Lg0K
Pj4gPg0KPj4gPiBBZ3JlZWQgYW5kIG9uZSBtdXN0IHVzZSBhcm1fc21jY2NfZ2V0X2NvbmR1aXQg
b3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+PiA+IE5vIGFkZGl0aW9uYWwgYmluZGluZ3MgZm9yIGVh
Y2ggYW5kIGV2ZXIgcGxhdGZvcm0gYW5kIGRyaXZlciB0aGF0DQo+PiA+IHVzZXMgU01DQ0MgcGxl
YXNlLg0KPj4gPg0KPj4gPj4gT2YgY291cnNlIGlmIHRoZXJlIGlzIGEgYmV0dGVyL2NsZWFuZXIg
d2F5IGhvdyB0aGlzIHNob3VsZCBiZSBkb25lDQo+PiA+PiBJIGFtIGhhcHB5IHRvIGdldCBtb3Jl
IGluZm9ybWF0aW9uIGFib3V0IGl0Lg0KPj4gPj4NCj4+ID4NCj4+ID4gTGV0IG1lIGtub3cgd2hh
dCB5b3UgdGhpbmsgYWJvdXQgbXkgdGhvdWdodHMgc3RhdGVkIGFib3ZlLg0KPj4NCj4+DQo+PiBJ
IGFtIGZpbmUgd2l0aCBpdC4gVGhlIGtleSBwb2ludCBpcyB0byBoYXZlIHRoZXNlIHNvcnQgaXQg
b3V0IGJlY2F1c2UNCj4+IEkgc2VlIHRoYXQgYSBsb3Qgb2YgZHJpdmVycyBqdXN0IHNpbXBseSBj
YWxsIHRoYXQgU01DcyBmcm9tIGRyaXZlcnMNCj4+IHdoaWNoIGlzIElNSE8gd3JvbmcuDQo+Pg0K
Pg0KPlN1cmUsIHNvcnJ5IEkgZGlkbid0IGV4cHJlc3MgbXkgY29uY2VybiBwcm9wZXJseS4gSSB3
YW50IHRvIGF2b2lkIGR0IGJpbmRpbmdzIGZvcg0KPnRoZXNlIGFuZCB1c2UgdGhlIFNNQ0NDIGRp
c2NvdmVyeSB3ZSBoYXZlIGluIHBsYWNlIGFscmVhZHkgaWYgcG9zc2libGUuDQo+DQo+SWYgdGhp
cyBkcml2ZXIgaGFkIGNvbnN1bWVycyBpbiB0aGUgRFQgYW5kIGl0IG5lZWRzIHRvIGJlIHJlcHJl
c2VudGVkIGluIERULCBpdCBpcw0KPmEgZGlmZmVyZW50IHN0b3J5IGFuZCBJIGFncmVlIGZvciBu
ZWVkIGZvciBhIGRyaXZlciB0aGVyZS4NCj5CdXQgSSBkb24ndCBzZWUgb25lIGluIHRoaXMgdXNl
Y2FzZS4NCg0KRG9lcyBpdCBvayBpZiBJIGRvIHNvbWUgY2hlY2tpbmcgaW4gYXJhc2FuIGNvbnRy
b2xsZXIgZHJpdmVyIGFzIGJlbG93IGFuZCANCnJlcHJlc2VudGVkIGl0IGluIHRoZSBEVCBvZiBh
cmFzYW4sc2RoY2kueWFtbDoNClRoaXMgaXMgdG8gZW5zdXJlIHRoYXQgZm9yIEtlZW0gQmF5IFNP
QyBzcGVjaWZpYywgS2VlbWJheV9maXJtd2FyZSBub2RlIG11c3QgYmUgY29uc3VtZS4NCg0KCWlm
IChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImludGVsLGtlZW1iYXktc2RoY2ktNS4xLXNk
IikpIHsNCgkJc3RydWN0IGRldmljZV9ub2RlICpkbjsNCgkJc3RydWN0IGdwaW9fZGVzYyAqdWhz
Ow0KDQoJCWRuID0gb2ZfZmluZF9ub2RlX2J5X25hbWUoTlVMTCwgImtlZW1iYXlfZmlybXdhcmUi
KTsNCgkJaWYgKCFkbikNCgkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkbiks
DQoJCQkJCQkiY2FuJ3QgZmluZCBrZWVtYmF5X2Zpcm13YXJlIG5vZGVcbiIpOw0KCQlvZl9ub2Rl
X3B1dChkbik7DQouLi4uLi4uLi4uDQp9DQoNClRoYW5rcw0KPg0KPj4NCj4+IEJUVzogSSBzZWUg
eW91IGhhdmUgYWRkZWQgc29jIGlkIHJlYWRpbmcgd2hpY2ggeW91IGFyZSBzYXlpbmcgaXMgdGhl
DQo+PiBwYXJ0IG9mIHNtY2MgdjEuMiBidXQgSSBjYW4ndCBzZWUgYW55IGltcGxlbWVudGF0aW9u
IGluIFRGLUEuIElzIHRoaXMNCj4+IHNwZWMgcHVibGljbHkgYXZhaWxhYmxlPw0KPj4NCj4NCj5T
cGVjIGlzIG91dFsxXSwgaW5jbHVkZS9saW51eC9hcm0tc21jY2MuaCBwb2ludHMgdG8gdGhlIGxh
dGVzdCBzcGVjLg0KPlRGLUEgZG9lcyBoYXZlIGltcGxlbWVudGF0aW9uIGFzIEkgdGVzdGVkIHdp
dGggaXQgYW5kIGV2ZW4gcmVwb3J0ZWQgYnVnIHRoYXQgSQ0KPmRpc2NvdmVyZWQgd2hlbiBJIHRl
c3RlZCB3aXRoIG15IHBhdGNoZXMgdGhhdCBhcmUgbm93IG1lcmdlZCB1cHN0cmVhbS4gQXJlDQo+
eW91IHJlZmVycmluZyB0byBtYXN0ZXIgb2YgVEYtQSBvciBsYXN0IHJlbGVhc2UgdmVyc2lvbiA/
DQo+SWYgbGF0dGVyLCBpdCBoYWQgYnVnIGFuZCBtYXkgbm90IGJlIHdvcmtpbmcuIEkgbWF5IGJl
IHdyb25nIHRob3VnaCwgYXMgSSBhbSBqdXN0DQo+dGVsbGluZyB3aGF0IHdhcyB0b2xkIHRvIG1l
IGNvdXBsZSBvZiBtb250aHMgYmFjayBhbmQgdGhpbmdzIG1pZ2h0IGhhdmUNCj5jaGFuZ2VkIGlu
IFRGLUEgbGFuZC4NCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+U3VkZWVwDQo+DQo+WzFdIGh0dHBzOi8v
ZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMDI4L2xhdGVzdA0K
