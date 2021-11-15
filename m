Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C834DC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 08:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6F061BFD
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhKOIli (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:41:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44594 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhKOIlb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 03:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636965518; x=1668501518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+IqWx3oHBvvIRqDaJHogWBvMPsVNCjBBvp9em9krzC4=;
  b=NmFFd1xSe3hgAhE3kuS4ti0mjGxlS7XqK+gWtwObaNcHMNJzQ2Drq3dK
   a0e7OVOnzDCadFEmbdexbwsgfdNYdlaWtRMOKosNKTEcr4KRWpcs58XrO
   7PEZiJOO7fv7rIPNNpS50nn1z1Ws4QYEOEFL2r7aNvkc5ULQBdDetKgoY
   mb/sig/aAXAGPCyuNlPtJKyKOZYmPHzEME7N70ngS65HR22XjI+voMkdF
   HmQ6te1LMnchtQDiYoZ482x4QuXdusyZNxhkS8kWDUqvoO2zTo8bhdhY/
   n0epJAtj+zAgzcmrkO54JOExSG0AqKltZXYephMs5ieM97Uw1zhGxR3FA
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="186611839"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 16:38:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6VXyyCvFjBgpQEoc7TS4KTIIeZ/mO0PLj+0Whic4jYyh3WglAXcyD7u2P8bvSfLZvLtTL7Ykg5bMCporzA5aqVheEdDCvHPRT3Z0Ewh7a3Ah4goftocBuCRLNlRuJC620AL28DjoalUO0c7fhD+Z9bWOyaHGulMmLjAOpwyiEG2OpI6/ZjvMYZQyJ4l4WZFpG4OamcwnYYRbqgAcPb4NCiKwKNjSHB8k9TSjl5sV43zd2VI+0+zC+pTj2ZhiPs6NQmo2zCfpvXItOv9NRs95aTg+TNR8kSiYIvt9klcDe0ViIrnXelifgHddYU72qfWk+XMvrjS8o7J7TXLbf/NYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IqWx3oHBvvIRqDaJHogWBvMPsVNCjBBvp9em9krzC4=;
 b=YtbFB+DEppJ38QgA18Ms9cvEfyCb3qJMsKtf+DdTYe8XonL6CmdCXaJc7v9fiTlxUwDBB7hfsjoD712qn/n/bPjUIVTI2k0Mf4xBPwUkQtTD2mjG+ce3nVn0BZJEqumOGKM+m2r2dhSReCUhCsirhT9Yiz9SRfJoTZLdTj6WjOZmbkj2AsVDHWnj901ucJUNF38bLzdQ2xjR5kdghN+D7NctRBH5kJ/edonO8w//Sk+0lLAUZVlF1P+JN38DRs6/yqpZM0m2NYNwAJoTjTovTXmjsx06BUTj0MzBSdmGDAabEAOvJVgj8l55lUWzKC6EEIbiZKq0IMuQe7V9+BF0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IqWx3oHBvvIRqDaJHogWBvMPsVNCjBBvp9em9krzC4=;
 b=xXKA/voxdzSTROte4ovhTY8qbOqBBN3T2Ky/Qu5wcWoQ9D3VAxAnKbLRAzvGRlSpTfvJTTOLcoCkBf+pHnZkMf1v1itMpqeDKTYJVfDIQaiE2odmZ7QOVGR55SFYmkfE215CDfJdLYicriuHPDaRXlzuL5l0IayokNIpv85bF34=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6574.namprd04.prod.outlook.com (2603:10b6:5:208::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.19; Mon, 15 Nov 2021 08:38:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::edbe:4c5:6ee8:fc59%4]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 08:38:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>
Subject: RE: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
Thread-Topic: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
Thread-Index: AQHX2Zhgc4q1kM9RKEyjWb6PnCX2TawERAbA
Date:   Mon, 15 Nov 2021 08:38:33 +0000
Message-ID: <DM6PR04MB65753B3AB67AB262FC3383EFFC989@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20211114204331.39555-1-huobean@gmail.com>
 <20211114204331.39555-2-huobean@gmail.com>
In-Reply-To: <20211114204331.39555-2-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 137d05c3-f7ac-43cf-79ff-08d9a8134ee4
x-ms-traffictypediagnostic: DM6PR04MB6574:
x-microsoft-antispam-prvs: <DM6PR04MB6574B3ACD140DB4A2E1BD04EFC989@DM6PR04MB6574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1QdI55tTcgQyXlrZwyz+MJvTTJhDYmVW6in5wBGZXwu7AY3557S5Xx4yB6FilWMBTs7sIpbmOHWuQWeH6IL34nkYHtYYiotZX+ne/poCjWCUh5rIMARJs8ALqlP9XIQKkTIV7TRVvgDNd9NTIebd6h0daWp2su3RN7/kTylrWsNmS6kpZu8+DOSjDqTs8vmO9SD0KVmOdIovzzXkgdkCMNBTeNJdq1o5v9Eh/ADo/3rSB6jN0gytLIkxMRCZqVX3HV1B/uR2sNanwWUESQCjuWa5mpkwgH6FMOmFN+F5TDefQWEvGLkkU5FkqwUgAKMWJdT6Dj1PiT83HfLlZGwZODv23XeiJEiCXHaLxkKAj1LYUjV4j92ZT5pkhfGxXNc+geEPq9I1ec86qufJCoOBA6jzd8UtbcF/ghCyQBS+PEaG0zxoYbWj1fDHzriL18wnG/xOf06ZK9r0shLvvK9jABqZ8rU6iswHqft0K93u43E5caDI9BsgCRaEatOVPCL6353Hz7R8Z4PKvvZfgm7ghshuLfv37Iiz/ilPzHN4YgE6bbIemTG09HyAqWx0ElONvp4Om9zw5INaBf+f1iMF+oQcIk+GV5VQL/+gfutWsEhIMU3fkIeK4gL29CR9QnvQ+X5J0mHTw/vdVrhMkENhQluA9aN/aHI48ZcdiF/B5+g2EBz7Zm9k9mny8gT5HUWa7JsdBGPMSakGmvbybNwJJUIHj96iDnYxQT3OgSYtf4kehrLqA16eLNebpW+IKfYhTDnm3GvlMuHxsoNB5LzTK3nKxe5WiLuI/qQR/DsAo2IpM88iIiwDweEsd3pklLhG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(122000001)(52536014)(6506007)(26005)(2906002)(9686003)(5660300002)(8936002)(508600001)(7696005)(38070700005)(110136005)(55016002)(86362001)(38100700002)(71200400001)(66556008)(186003)(66476007)(64756008)(66446008)(76116006)(82960400001)(83380400001)(316002)(66946007)(966005)(8676002)(4326008)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEpuM3BzQURVeExXYXM2Y25HOVhVQzNCQ0pUbGM2U09mdzFxYm1ta1kxRXor?=
 =?utf-8?B?ZThheWRRRTllY2t3UzJNZ2lmUU9lQ0xUMFZuVGR6SE03aGJ4MmdGU0VsWG1w?=
 =?utf-8?B?dmJYV1l2cVNyd0RkMjRYd25mQUVITk0rcVlrVjRWTXFKTVR0N3psMklnVng3?=
 =?utf-8?B?MzByKzFETTZDN0thVk9qQTlxRHBraWhrNVYxelY2T01PVFBMYm1aVlpWeTBB?=
 =?utf-8?B?WStSZldmdzkvRGNqTUMxTm1JM2ptZndxdzcyWjNlRUVvV20yY2c1T2xucGFB?=
 =?utf-8?B?QTArSWgwRHV1WDN2dVFncXhReFpHd2NBZTJ1UWovQU1oa1c2YkowVnFtSVFX?=
 =?utf-8?B?SkpZZVVMakt3M1hZQURhNURldWo2ejRPTDFtb1FOc2JvNkpBdkxkeFBkZjha?=
 =?utf-8?B?dm5WRzRMZGNWOVprNlQvWXgxNldGTlBGUjJxdzRQdFV4dHE3dmxkSVlZdFND?=
 =?utf-8?B?RWdMUW5RVlJmaEVrcTVJeDZOcnRLV2RxY1h0YzNvdnZVcVpwcHpGclN6bTVp?=
 =?utf-8?B?ak1qWG1waTYyNTdXejZ3NnFpblhNaTBRd2d3alZNSHk0bE96SUtRWmFtdWc3?=
 =?utf-8?B?dXlwdlJUWkdjaVdJazZZWDJBdW9VLzFLZHl0U2N3RFVWbFFqc0o3MHV1a09Q?=
 =?utf-8?B?UThQZmNpNjBST1daOFkzZ2xxeFZzelpoVWtZYkQyYmlnUEQxT0o5bjdUOStB?=
 =?utf-8?B?blJCYUVxem9vWHlWaWQ5R0R2a29mcU9aMmNFMXFtTUdhOWoyZUpaZDlOUTBv?=
 =?utf-8?B?aTZYR1lsUys5MmRWTy9yRDIzM0ZLTGcyb3FDOW83cjJ6YmVxTlAwNmFIMzNa?=
 =?utf-8?B?ZDNpKytsSnNFMVI5V1FVN0lKWHB5U0xTZTh5SFhpSTUzSGhqTjNRZE5mckJQ?=
 =?utf-8?B?OXE2OTNmZ3hxdENQay9zdEZ2WW5oUE5hMXZNRUJuY1BUOGNsM2ZuWHE5Rzhl?=
 =?utf-8?B?aHBJMjRDT0hLYkhsclBKdENBcGl3VmhEdVhIYlpKaGZOY1JEZkc3d3RhbEo0?=
 =?utf-8?B?ckhpVU5mRklLY2lkeTFINE95a2xkY3RzQzhqZldNUTQ5dWhXMjR6YlZIRXJV?=
 =?utf-8?B?L3lnN0ZXYTR1cHlDK3hQOW9mbkRycjRRVlBLTzhRRHpNUDNuR0JJTHhkVHZD?=
 =?utf-8?B?ZTB2b1Y0LytUSkp1RmlUVndzTEMyd2tSMVl2OWhpSlR0bzBvRE1wekdyeXVh?=
 =?utf-8?B?TmZ1Z3QrSEx0aUlGK1NOUG9ha3BWb0w1bHc2N3JyakZvV1FHaERJdmplcW5h?=
 =?utf-8?B?OVV0Y1Nxckxqdzk0Sk5ZUjNSYkh0eXNndHJwYlBRNzNjVFpSanhmWkQwMXhm?=
 =?utf-8?B?N3VYaFloQUtxYk10UVdyYWs5R05qYkVjMnZ3Y2V6Q3Q3dFNPTmxsM0p5YVJQ?=
 =?utf-8?B?dlZpTGNyaDBqWDN2ckpOVE04TVFDR21ES040VlA5UFlsd0w4d2x2NkJXK2lx?=
 =?utf-8?B?b2lQREYrVlhkemxrZVd3VjNyaTcyZC9HcnczSkdTL2pYTDZxd3BPeXlxVHRI?=
 =?utf-8?B?cFIxaG1hbkRDN2lzVzhqNUN3RjVLQS82VUJwNHpVUXZvWlJvOWxCZldYODFG?=
 =?utf-8?B?UDlhbVRmcEhUQ3pDYlEwVEhBUlk1cCs3VlAxOGZtM08vTmhDbTRXZjgxWXI5?=
 =?utf-8?B?dmJHWHQ2SVlTd0FQaHFZdy9QeHlpNW1QY2pESjNwb2hWb1JOSG1DOWxoRFZ0?=
 =?utf-8?B?Z0luTUN4MXdKazFlWnp2ditvOVlyQXJ1SURqelBLcC9hNUNySytvaDRqQm8y?=
 =?utf-8?B?ZnRUWXRMVHN4aTYzcENkK2hWYWZTc3ZHYTdOdE5QSW5RZ1RxNTVaSmdrQU9y?=
 =?utf-8?B?MzJxaEdrT2I2dDlQUDZTTXZJMVNpZmFEQTFLWUlyeHBxZzBoZXJZMTJvcmxI?=
 =?utf-8?B?RFJFYU8zSUYyMlZvdkVrRjIyUklFVm5peXZKVkd3YW1xNm9abllBOHRxT1FF?=
 =?utf-8?B?SWMvSDNPYllUNGh4VHVBcTEvZ3pnbXlvZm5sUklId0RHVUdTcHh5ZFh2QmNM?=
 =?utf-8?B?WFBCOWhGUVBwb2hWVERwMVpxb3drT2pldnk0ZTFBTGhCYjZFaEUzZjNpQjhC?=
 =?utf-8?B?REU3cWdPOE9vZXVHT2J6aHNMTE9KSkpIM1pmY1V3cWd5RktrQmZRb1ZkUXEz?=
 =?utf-8?B?WTVVSS9sWlZVMWRJS2dKeHQ1M2JsVlJlZG1pNHN5UFNMcnZTR21ERnFNS0c3?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137d05c3-f7ac-43cf-79ff-08d9a8134ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 08:38:33.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYz6S3yobxKPT7/dusiQLK3TnZrRt49npB5gK3NbeEFfo5dYIycnBp5xDtWnXI54ctVCHi0A7xLgLTW0BSUQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6574
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQmVhbiwNCj4gDQo+IFRoZSAtV3N0cmluZ29wLXRydW5jYXRpb24gd2FybmluZyBhZGRlZCBp
biBHQ0MgOC4wOg0KPiAgICAgaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5j
Z2k/aWQ9ODI5NDQNCj4gDQo+IElmIHlvdSB1c2UgdGhlIEdDQyA+IHY4LjAsIHlvdSBwcm9iYWJs
eSB3aWxsIGdldCB0aGlzIGNvbXBpbGF0aW9uIGVycm9yOg0KPiANCj4gZXJyb3I6IOKAmF9fYnVp
bHRpbl9zdHJuY3B54oCZIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIGNvcHlpbmcgOCBieXRlcyBm
cm9tIGENCj4gc3RyaW5nIG9mIGxlbmd0aCA1MTEgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlv
bl0NCj4gDQo+IFVzZSBtZW1jcHkgaW5zdGVhZCBvZiBzdHJuY3B5IHRvIGF2b2lkIHRoaXMgY29t
cGlsYXRpb24gZXJyb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0Bt
aWNyb24uY29tPg0KTG9va2luZyBpbnRvIHRoZSBsaW5rIGFib3ZlLCBpdCBzYXkgdGhhdCB0aGlz
IHdhcm5pbmc6DQoiLi4uIGlzIHNwZWNpZmljYWxseSBpbnRlbmRlZCB0byBoaWdobGlnaHQgbGlr
ZWx5IHVuaW50ZW5kZWQgdXNlcyBvZiB0aGUgc3RybmNweSBmdW5jdGlvbiB0aGF0IHRydW5jYXRl
IHRoZSB0ZXJtaW5hdGluZyBOVUwgY2hhcmN0ZXIgZnJvbSB0aGUgc291cmNlIHN0cmluZy4iDQoN
CkFzIHRoaXMgaXMgbm90IHRoZSBjYXNlIGhlcmUsIEkgd291bGRuJ3Qgd29ycnkgYWJvdXQgdGhp
cyB3YXJuaW5nLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gLS0tDQo+ICBtbWNfY21kcy5jIHwgMyAr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9tbWNfY21kcy5jIGIvbW1jX2NtZHMuYw0KPiBpbmRleCAyMDVlNmU1
Yjg5ZjkuLmVjYmRlMzkzN2M4MSAxMDA2NDQNCj4gLS0tIGEvbW1jX2NtZHMuYw0KPiArKysgYi9t
bWNfY21kcy5jDQo+IEBAIC0xODM1LDcgKzE4MzUsOCBAQCBpbnQgZG9fcmVhZF9leHRjc2QoaW50
IG5hcmdzLCBjaGFyICoqYXJndikNCj4gDQo+ICAgICAgICAgaWYgKGV4dF9jc2RfcmV2ID49IDcp
IHsNCj4gICAgICAgICAgICAgICAgICBtZW1zZXQobGJ1ZiwgMCwgc2l6ZW9mKGxidWYpKTsNCj4g
LSAgICAgICAgICAgICAgIHN0cm5jcHkobGJ1ZiwgKGNoYXIqKSZleHRfY3NkW0VYVF9DU0RfRklS
TVdBUkVfVkVSU0lPTl0sIDgpOw0KPiArICAgICAgICAgICAgICAgbWVtY3B5KGxidWYsIChjaGFy
KikmZXh0X2NzZFtFWFRfQ1NEX0ZJUk1XQVJFX1ZFUlNJT05dLCA4KTsNCj4gKyAgICAgICAgICAg
ICAgIGxidWZbOF0gPSAnXDAnOw0KPiAgICAgICAgICAgICAgICAgcHJpbnRmKCJlTU1DIEZpcm13
YXJlIFZlcnNpb246ICVzXG4iLCBsYnVmKTsNCj4gICAgICAgICAgICAgICAgIHByaW50ZigiZU1N
QyBMaWZlIFRpbWUgRXN0aW1hdGlvbiBBDQo+IFtFWFRfQ1NEX0RFVklDRV9MSUZFX1RJTUVfRVNU
X1RZUF9BXTogMHglMDJ4XG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBleHRfY3NkW0VY
VF9DU0RfREVWSUNFX0xJRkVfVElNRV9FU1RfVFlQX0FdKTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
