Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86441C4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B53F20731
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Yqx22wcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgKPOWj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:22:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:21954 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbgKPOWj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 09:22:39 -0500
IronPort-SDR: ult6hYxGeHf6U1oxibCMypd+4Rs60NW+aMyjWEdOZ/SU2Rmsy94i/MR50uMRCbJQ+DuFDWoPaZ
 6rlfBtJrVyBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158527895"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="158527895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:22:37 -0800
IronPort-SDR: CzcwJjpJqBHKmzczGPzB4Bo3dGbXTs0RH5m9Gt66Rwk4Y2tVUzNq/zw9+jOK1suF2o6V6aIUbA
 5VML3Y32kD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="340547328"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 16 Nov 2020 06:22:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 06:22:36 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 06:22:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Nov 2020 06:22:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 16 Nov 2020 06:22:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klwb6d1TMtuljxPJMtOjtEZP6KJgq+gdqtyEynElR3RCfOG3x5WJGzYw558lsw2BKgCuLWajQ+XH5NT6Pxlpp0BPmso3J2F++ozeUPeXCJucV3objj7caLENQ6R5WXKEDas5O2zZJB5muNIxmoLmASJq5oCO+9cZM0DFHl4g76x87ieN9PlzBsDFxb1Ml6q+9wKoMlbUDZEBXt1Lti3ollfrqygqpp1Om7puoF70bKICNrLrsEQkhhbSeYM28Mq4crY5QS8N0Bet5AlXkOKhRGZLXTGyl9oQNEDCYnHCq5vEbBuzl8VHxGa27ziCs/jsI8JSu/FBWipL1sFTxSq6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQraJR8RT5R+CGrYYSxbZuAh2IGbX3g2Ylcu2g4bEs=;
 b=MWeDR5/fhZIcE5cKVAak5ohvXLza//UYh93gOpEx5JOC/udgJLlQsZBzg4u28IbT5p/PRj//vAKS1ia6ib9ZynUQYZ5tyolok+Yk3hRPNWkKBAg6cA3feXujRkE8T4bvG+3G5RnVMU3pSB9bLzgRyHl2D58J4doZgVtBfa6AoT+MPJFcWcgig9s3TLOp1GDkP72azG5qB2J/AmG+JmVjTrjxtz03b9+9KhXCTZ10ijHm3CjLhVX9OdxawM57UwcvQOBjp9uDCuHbRYagQ5cMzKxeHa5DtM+vJx3wHehhJHHnLXtStvAmEQg+ElSHedBQoMeqzb9ljvhZ2dEQGYX/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQraJR8RT5R+CGrYYSxbZuAh2IGbX3g2Ylcu2g4bEs=;
 b=Yqx22wcjOvT3kRVm2oEtwN/8kETEarC+mPEtsipar6TPGpIcCWCahIHIsDu3+JjHzed2weCRiaHu5CozlW4EYEAM+EbritKMIhHNvqJ6nr9VNmYWV8ombnheBDk965XKd4X1b08JKgdRkTnr0CHB5y9OofHPkqt++QQPpAQA9UY=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB4025.namprd11.prod.outlook.com (2603:10b6:5:197::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 14:22:33 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 14:22:33 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Index: AQHWs/Kyv+f0bf2SO0CVLGdSxsJGq6nKstkAgAApWoA=
Date:   Mon, 16 Nov 2020 14:22:32 +0000
Message-ID: <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
In-Reply-To: <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.188.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc85f554-778d-4781-b03d-08d88a3b0f5d
x-ms-traffictypediagnostic: DM6PR11MB4025:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4025A48ED37384BC74C8D755B8E30@DM6PR11MB4025.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKHsCmDpKUxYcj1YZsECH9HZIoN5KaqZfncR404Rqao19AtOFaD0DozRJfux+D6LYk1IR9flERmCv66Fr/aBjL3Jn20MEhhvV6DHt199QZ4jcmyPYkFkSu/e8AvHAb0Gkvt/a7JNsp84ky0Ybkfh88TSa/7ryknH8Yj50IVEU9P41HR0F6yYipgRnu6Va9Zp0Y+pPuZG4XB6XxD56KVle9W2PQAYTloPCo/jbF0fqy0j17PncCHZMGTGZPxMyCPNFLC0/2M7H9j9FIyEiaDMtsfqiq213J4h537Kt0APlXnhkGAgA/RQmaq9xfkaM2T6k2+o7N8UjTuAsecI6BR8gHcwC4HIPmxZga0AvxIOcz5zs4emCiZ3Es6mFyez+Zrh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(478600001)(2906002)(83380400001)(6916009)(55016002)(9686003)(186003)(76116006)(5660300002)(26005)(7696005)(316002)(6506007)(54906003)(71200400001)(66446008)(33656002)(8676002)(4326008)(66946007)(66476007)(86362001)(66556008)(64756008)(8936002)(52536014)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Shiw/CD1aJ1a7uJ32TwXDD9S2d5CbD6HGIgpq6AETbv8J7BCG/VWNx6Czt/t7hYkbL+a5E89AxfTuDMn6W4loaVjnOYmUEL98vS/xlg3QDcVHzfn5q5TFGSsT+7Ffn4iwkZmpNRFKUo00PP2iGdHHn/q01WDq3dZybJN77pIPqI0BD+UN6anK2JjNN99AmVgBRZ940/8v9+HVtZNqWtur8WvR2Oucv2RROg5WG2oE9GmFqk7NBXW7CofqsVPyTEFi080yGtuzDYLeX2sGbxtH4vJ97OH6FofBnyScsEDPGeYvDG9mnSyEoGSBlelW1ht19q/8/ggyoFd01QSwJtlkJfVh4nXBEskWs5y9EJov39Q/NGajnfd+ABGebJlxp837QjprsXvb/Znsdjo4gryubUgT77TweUT37X/BaGnte35QpeyNLHr9MjpYhSbpYyoFtHMnnPiedb6lPlZmiXuDF5aHIMROe3Z5zy34ZE/WU8atHpQUA4RSMyzKDhxTnUTS0eSJIcwZeBLuLwFrLG0aLoathImPxiJnouQ6xiuXTgBjQAI1Sh6k4e4OYZpSDMF5smW/3Yh5x3ENqL+5ulyM5J0EIn0Jk/zLTCTkVPWKsnOB0ebzdhtErCVWT6FutIu72We+OCaJEjS8FmFbpqQ+9ZjaVuTfkTcFQugsY0g7iK62bQkKVG3l+/4sMGlgN73yNX/lF+FFhaU9BPwkIgec8sB33ksoZCpU6Qkckil85TtcO5bIXgHVBHuhlXE8/dNS/W1dRQ77Pas2snXdfByUg7B7HDdRpXx8B+tN5JZjgsQHdI914ITgbsczfaBl0UYtHM3Mr84mZrdnUyFbWye6ohxCPMWnN0xGx+siDt6qk3cjZNgnCKbfYRw0UO36PqFKD/SASm3NO4YZyF2/Rd3Qw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc85f554-778d-4781-b03d-08d88a3b0f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 14:22:33.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZrw1MchpGazhY2Ys0z8IkPURN0Jff7iHjCJTLUtohDjzEhtTFeUOV9FygWXbY+ZDiX1GjS8y9bSuzIZfFRiGhedUKp8ThFRuuK/Yt6+4Azxi2AbGR7IcPUo+b6K5V/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLiBJIHJlcGxpZWQgaW5s
aW5lDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTYsIDIwMjAg
Nzo0MSBQTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVzYWlu
aS56dWxraWZsaUBpbnRlbC5jb20+DQo+Q2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExp
bnV4IEFSTSA8bGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXgg
S2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZz47IEh1
bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IFJhamENCj5TdWJyYW1hbmlh
biwgTGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsg
V2FuDQo+TW9oYW1hZCwgV2FuIEFobWFkIFphaW5pZQ0KPjx3YW4uYWhtYWQuemFpbmllLndhbi5t
b2hhbWFkQGludGVsLmNvbT47IERhdmlkIEUuIEJveA0KPjxkYXZpZC5lLmJveEBsaW51eC5pbnRl
bC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1tYzogc2RoY2ktb2YtYXJhc2Fu
OiBTcGVjaWZ5IC5jbGtfb3BzIGZvciBLZWVtDQo+QmF5IFNPQw0KPg0KPk9uIEZyaSwgNiBOb3Yg
MjAyMCBhdCAwNToxMCwgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPiB3cm90
ZToNCj4+DQo+PiBGcm9tOiBNdWhhbW1hZCBIdXNhaW5pIFp1bGtpZmxpIDxtdWhhbW1hZC5odXNh
aW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+DQo+PiBDb21taXQgMTZhZGE3MzBhNzU5ICgibW1j
OiBzZGhjaS1vZi1hcmFzYW46IE1vZGlmeSBjbG9jayBvcGVyYXRpb25zDQo+PiBoYW5kbGluZyIp
IGludHJvZHVjZXMgcGxhdGZvcm0gc3BlY2lmaWMgU0RIQ0kgY2xvY2sgb3BlcmF0aW9uLg0KPj4N
Cj4+IFRoaXMgcGF0Y2ggZGVjbGFyZXMgdGhlIGNsb2NrIG9wZXJhdGlvbiBmb3IgS2VlbSBCYXku
DQo+PiBBZGQgY2xrX29wcyBmb3IgU0QsIEVNTUMgYW5kIFNESU8gb3BlcmF0aW9ucy4NCj4NCj5U
aGUgYWJvdmUgY29tbWl0IG1lc3NhZ2UgZG9lc24ndCByZWFsbHkgdGVsbCB3aHkgb3Igd2hhdCBn
b2VzIG9uIGhlcmUuDQo+Q2FuIHBsZWFzZSB0cnkgdG8gY2xhcmlmeSB0aGF0Lg0KDQpXZSBtaXNz
ZWQgb3V0IHRoZSBjbG9jayBvcGVyYXRpb24gaGFuZGxpbmcgcGF0Y2ggKENvbW1pdCAxNmFkYTcz
MGE3NTkpDQphbmQgZGlkIG5vdCBoYW5kbGUgdGhlIGNsa19vcHMgIGZvciBLZWVtIEJheSBTT0Mg
ZGV2aWNlcy4gDQpUaGVzZSAyIHBhdGNoZXMgKENvbW1pdCAxNmFkYTczMGE3NTkpIGFuZCAoQ29t
bWl0IDM2YzZhYWRhYWU4NikgIGFyZSBtZXJnZWQgYXQgYXJvdW5kIHRoZSBzYW1lIHRpbWUuDQpX
ZSBjYXRjaCB0aGUgaXNzdWUgbGF0ZXIgd2hlbiB0cnlpbmcgdG8gYm9vdCBpbnRvIHY1LjEwLXJj
MSB3aXRoIEtlZW0gQmF5IEVWTS4NClRoYXQgaXMgd2h5IEkgY3JlYXRlZCB0aGlzIHBhdGNoIHRv
IGhhbmRsZSB0aGUgY2xrX29wcyBmb3IgS2VlbSBCYXkgZGV2aWNlcy4NCg0KPg0KPj4NCj4+IEZp
eGVzOiAzNmM2YWFkYWFlODYgKCJtbWM6IHNkaGNpLW9mLWFyYXNhbjogQWRkIHN1cHBvcnQgZm9y
IEludGVsIEtlZW0NCj4+IEJheSIpDQo+DQo+SXMgJHN1YmplY3QgcGF0Y2ggZml4aW5nIGEgYnVn
L3JlZ3Jlc3Npb24/DQoNClRoaXMgaXMgdG8gZml4IGlzc3VlIG9uIHByZXZpb3VzIGNvbW1pdC4g
SXQgaXMgYSBidWcgZml4Lg0KDQo+DQo+S2luZCByZWdhcmRzDQo+VWZmZQ0KPg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+IDxtdWhhbW1hZC5odXNh
aW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktb2YtYXJhc2FuLmMgfCAzICsrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4u
Yw0KPj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+PiBpbmRleCA4Mjlj
Y2VmODc0MjYuLjAxMmQ1MmUxYWJlZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktb2YtYXJhc2FuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJh
c2FuLmMNCj4+IEBAIC0xMTk5LDE2ICsxMTk5LDE5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJh
c2FuX29mX2RhdGENCj4+IHNkaGNpX2FyYXNhbl92ZXJzYWxfZGF0YSA9IHsgIHN0YXRpYyBzdHJ1
Y3Qgc2RoY2lfYXJhc2FuX29mX2RhdGENCj5pbnRlbF9rZWVtYmF5X2VtbWNfZGF0YSA9IHsNCj4+
ICAgICAgICAgLnNvY19jdGxfbWFwID0gJmludGVsX2tlZW1iYXlfc29jX2N0bF9tYXAsDQo+PiAg
ICAgICAgIC5wZGF0YSA9ICZzZGhjaV9rZWVtYmF5X2VtbWNfcGRhdGEsDQo+PiArICAgICAgIC5j
bGtfb3BzID0gJmFyYXNhbl9jbGtfb3BzLA0KPj4gIH07DQo+Pg0KPj4gIHN0YXRpYyBzdHJ1Y3Qg
c2RoY2lfYXJhc2FuX29mX2RhdGEgaW50ZWxfa2VlbWJheV9zZF9kYXRhID0gew0KPj4gICAgICAg
ICAuc29jX2N0bF9tYXAgPSAmaW50ZWxfa2VlbWJheV9zb2NfY3RsX21hcCwNCj4+ICAgICAgICAg
LnBkYXRhID0gJnNkaGNpX2tlZW1iYXlfc2RfcGRhdGEsDQo+PiArICAgICAgIC5jbGtfb3BzID0g
JmFyYXNhbl9jbGtfb3BzLA0KPj4gIH07DQo+Pg0KPj4gIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJh
c2FuX29mX2RhdGEgaW50ZWxfa2VlbWJheV9zZGlvX2RhdGEgPSB7DQo+PiAgICAgICAgIC5zb2Nf
Y3RsX21hcCA9ICZpbnRlbF9rZWVtYmF5X3NvY19jdGxfbWFwLA0KPj4gICAgICAgICAucGRhdGEg
PSAmc2RoY2lfa2VlbWJheV9zZGlvX3BkYXRhLA0KPj4gKyAgICAgICAuY2xrX29wcyA9ICZhcmFz
YW5fY2xrX29wcywNCj4+ICB9Ow0KPj4NCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBzZGhjaV9hcmFzYW5fb2ZfbWF0Y2hbXSA9IHsNCj4+IC0tDQo+PiAyLjE3LjENCj4+DQo=
