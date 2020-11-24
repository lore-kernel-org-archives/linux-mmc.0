Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE724C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 04:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590EF20857
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 04:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NDYG752Q";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="KAHhdAHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKXEKC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 23:10:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728339AbgKXEKB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 23:10:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AO411QT011253;
        Mon, 23 Nov 2020 20:09:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=beS94GU3fEKSa28g95I9sDkcpXm8KzC1Da2/SvBdNyo=;
 b=NDYG752QuSavnSOmZnCaub8F66WHHZfj1KoYsfTwYAurNL4KyaQUBGJdN86f0o2glPLj
 In9PfpvtK04q/M+i8pz5FurfCfUEnCXrZp8SHyRwWr0/2H8Xpy9/3uF7Gdpqh2TqrrpJ
 x0AJkVa41TwoUkJL7Q7PXtSa/gfhWAof/dvpkyrpFw9Sx7WGdGMWO0oSjwhM1NrhYRn5
 J/4YIUNSMgKkE7o82XLUrTCYIQAmX76UrxRJu0Btb2Cr163bBumeFE2M8AqibjVKtpUF
 DRI980BMdudxivGKOQ+TQXzl5lpKW6lkB6PwA6DT/Z3mwMhXlmKLz7G4duZGWqZSSmUl fQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 34y39r8842-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 20:09:52 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Nov
 2020 20:09:51 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Nov
 2020 20:09:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 20:09:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQEw/Ljp7A3egi8qQMNcv9d1YKQkeDlXKVtA7dw0/AWBnPJacn/SaoJGtAU6mm+MY/RkqmcsUd4UQbLZdWWAKsVBaI7fVX9fSzxX5En1iyUmCcrw0uO2v49gQlp/Urkvweo9oSfQrOmCvFKDjZAdRjpFPE3NyOaVamVb0Egbxr//h11heXQemumrpuQnJrtaYD8Yo7EHoDS51QAHKpJ6wVM0Qr2aQEWNzuf4+32tt3xGjMLEWgUQK5IAzrqap9ywEPxntGFyxnWJw/BAhluZl8K8f7OZtc29lsOrwBBfohrPybja9l/RvHFIZJSnu3Xu9jfL2LhvrWc9In5TsBvDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beS94GU3fEKSa28g95I9sDkcpXm8KzC1Da2/SvBdNyo=;
 b=C8y828zw/Jo1APqJpopr8CQDWcm4zMKoBFO2YbeNidhLcTXvlJHW+3vc5bnU3xRTe3lumjFkIZEg2OM/uYWuxdz6sf2pOodoaISsXzVhIK5huazWb38WP++SBcbJU3M4Wsb4U9uxr51c0kuxm4Q3sbss+lev7ct553yd1rF/ZlrUUd8qoYBJnN9FnYvBq/pp9kvXhAIDgU4ZTtQ+vyhYj1hblTX/LmrpZ4D/oQWluG8mMv1sJJcgTOk83V+sjsHWaSWBgyKB4B2+jac7oZw7GWYKDInvSRxnuNMFCZ88yDMqW9qnWzhsnpo51lmTCkgMnSCfju1eg3+C1sUW+FANOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beS94GU3fEKSa28g95I9sDkcpXm8KzC1Da2/SvBdNyo=;
 b=KAHhdAHMfi8s4ezE2aI2YOmtoqM1TJDKRgSepoIPSB/IhFC3Es15ioWVE/xZXgKEhp2f3FG3CpXTlNkzfFryryZvPgVDWJT6EZj8YtYh8jF1Luk9pfhqbih32lRn4KQ8//f7otOGg5Zb0t2Z5ghkihhiRx7pghcsztaa06X+PpY=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1287.namprd18.prod.outlook.com
 (2603:10b6:903:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 04:09:49 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::c9c8:b925:516f:9090%7]) with mapi id 15.20.3564.028; Tue, 24 Nov 2020
 04:09:49 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH v1 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWuLx9yi13PVc6VE27a/W5N/Q7T6nRDl8AgAQxowCAAHQQAIAAHabQ
Date:   Tue, 24 Nov 2020 04:09:49 +0000
Message-ID: <CY4PR1801MB2070549B13D3ADD324F4E8EBDEFB0@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201112062422.32212-1-bbudiredla@marvell.com>
 <20201112062422.32212-2-bbudiredla@marvell.com>
 <CAPDyKFqZij1_aZZs3EeEuNob37WsGYN+6N52H2N0nTzM427j3g@mail.gmail.com>
 <CY4PR1801MB20705DF5A12318AB80EDBD45DEFC0@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com>
In-Reply-To: <CAPDyKFqBWEdAzz0hjk7LhqX1D8qmOomHSS=Be+_vU=upxMr0aA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [2401:4900:16b7:7a82:e41b:25f1:62c3:dda0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e16b4687-8aa6-40b9-2ddb-08d8902ec987
x-ms-traffictypediagnostic: CY4PR18MB1287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB128718442CFB0FD61817B4ABDEFB0@CY4PR18MB1287.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cXwi8MTM3Q26eXoPu037vm67hpFaXbw9KXhb9ADe5bk1kKD8pCxNeNR97N85RBopd4ZhWtuNfsIN1Jj9vXFAVwDEJyXGxO1t4so9lfgQQlWQbwhbrUCFyblzkY/dVQBWmjytM+l801KMatXwFjp/AU/VBSjP3YXXBpXfkAR9S2UF2Ruu/gHJLn/QAfw52u34DUADGgjXqSLOtNU5wEmc5YQ0MnmdbSAyhLHKp5ldn5P4nvTVDE6207c5k7nRn+u2Ca+jtGKKDlj361cLW3+0YgtWFUv+0tjQhWzJ/wW519lvj6dZE6lxG25Vy+IrWEAHC0yfNWU0qt5dJ7DOr1hQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(54906003)(64756008)(4326008)(66476007)(66446008)(33656002)(316002)(66556008)(478600001)(55016002)(8676002)(7696005)(83380400001)(71200400001)(5660300002)(9686003)(8936002)(2906002)(66946007)(52536014)(6916009)(186003)(6506007)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eVQzRHhXSVFOVGFIU3lKY2loMHpibE9jTFBraVlKY1hJa3N5L3g1eU9LNEI4?=
 =?utf-8?B?WmdQdWx1MUxldDJzKzJpcUl5c3pxZjBlZDZaVUdnQjFJcXJkWjVHVXFLVmZs?=
 =?utf-8?B?ci9GUGo2SU1hTGxOdEdyeEN2Nm9ZVjFXMm1seVZCU3VITm9CRzFrVU9MZGZy?=
 =?utf-8?B?ZTBQclF5YXpPVm9HQ3JHU2g0SWxEekNKVXkycXNDQ2JoK3RpQjBEaFhucXBD?=
 =?utf-8?B?YVVZTGFKTkRua3hZcXdISWswUmpvQ3JiQUV1Q2JlUUlCcXZ1bkhaeFF5TVU0?=
 =?utf-8?B?NU1HL1Z2cU1nbW5Tb3I5NFd3YlV4MGJNaXJPOGNCd0h0dytwcHFTNFJ0MWlS?=
 =?utf-8?B?VlNBS0txNG1McnlHOUdGK0g4cFhoanlYMFlFeEdvaTVXN2pQVWp1SWY2L1l3?=
 =?utf-8?B?a3lGV0NYaW1ZQmhDOVZPL0NmWWxqT1Jabm1zQlY4ZUN3VHJCL2g1K1hsenZG?=
 =?utf-8?B?SngxdXhQVTRDM01uRjR1NjlKSXduWkhuazFJYmJhd09CbVoyS0cyRVJXMUox?=
 =?utf-8?B?bm9QYkt6QjlXa2RnR1ZmMVJHd0llMmJpQWhpYmhDRnFveUdNM0JoaXpYVFo5?=
 =?utf-8?B?VzB5K3VpejB3eFo2bXZ3bVpoWkN4NE50MnVxQjBhM0NrUDVxeG5PeGlPZGVU?=
 =?utf-8?B?TFByZm1uNmx0ZDJOeERRZEg4dTg1WFU1Y2tFMlBhd2I0Y3VJK2pCRXpYc2Rj?=
 =?utf-8?B?VHh5S01rdzlTQWtwd2ZqUm5KcHJVOGpVcC8rNnRERjR2aTdtaVkyM0RrRUI2?=
 =?utf-8?B?UU85TklEZ2tjaytNWTJCc20xSVIvbDljeGlNNHM4bE9FQTdBVFh4dk1WS3F5?=
 =?utf-8?B?cUNPaUxqaTNydGNqcUFKZUk4WXF1UnhFbmNtZHV6OTlBNlNiVkFWSm9TSTRH?=
 =?utf-8?B?R0lzUnZvZGI4TmdZaE9yWnYwbUtEQjdua1NHK3hrRXAvSENYRHpiSXNnSVo4?=
 =?utf-8?B?cEhleUhiRTdHZU0zKzdFb2RUcHVvREg0Z0ZhcXV4RUZsYXd5c3pPU3RHdGtB?=
 =?utf-8?B?TERpZzlFa3NQWEtVNjArRXRmbHdtY01iVmhKZS9GYmpWWmFrN0k2UHdJcVk1?=
 =?utf-8?B?aXA5QUhVUzd1Tko1UzVFVWNrTXg0Nnd0T20zckJNY3BCcjRDa1haSDZmZkVF?=
 =?utf-8?B?b0QxZjlaZTBxOVFmYTNjTjZ5bk5UNFhzNTdCMHhZajNsS2YwWTRWYlg5QTdZ?=
 =?utf-8?B?aUpxSzNlaDMyc1FVY0JtQlNENktXUVFIUnpndHpUaVZhVkZDcWlLcDlGQnlU?=
 =?utf-8?B?L3doRFI0blVSN1NCZERYeEdESlB1U2w1ZHZJbWVlclM0bGU4cXBCcExIV1p2?=
 =?utf-8?B?UXljSVNFRklzSmMreG5kRjRNV2sxZDZiamYwbWRWMm00QlNyQTVYSVM0ME5w?=
 =?utf-8?Q?YCo10oBcBq4Z0Bvg/FvhvR6nHzn6B/Jc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b4687-8aa6-40b9-2ddb-08d8902ec987
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 04:09:49.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwQO0UbSPUDVXpR/1WdmD8mBykZpoCW9jZ1JAzlek0ke47BLTWDYfT/W8+lwfXkc9uTXnKMD2mD0eo8kUfLamA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1287
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_19:2020-11-23,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjMsIDIwMjAgNTo0
OSBQTQ0KPlRvOiBCaGFza2FyYSBCdWRpcmVkbGEgPGJidWRpcmVkbGFAbWFydmVsbC5jb20+DQo+
Q2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsgQ29saW4gQ3Jvc3MNCj48Y2Ny
b3NzQGFuZHJvaWQuY29tPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgU3VuaWwg
S292dnVyaQ0KPkdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgbGludXgtbW1jQHZnZXIu
a2VybmVsLm9yZzsgTGludXgNCj5LZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPg0KPlN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxIDEvMl0gbW1j
OiBTdXBwb3J0IGttc2cgZHVtcGVyIGJhc2VkIG9uDQo+cHN0b3JlL2Jsaw0KPg0KPlsuLi5dDQo+
DQo+PiA+DQo+PiA+QXMgSSBzYWlkIGFib3ZlLCBJIHdvdWxkIGxpa2UgdG8gYXZvaWQgaG9zdCBz
cGVjaWZpYyBkZXBsb3ltZW50cyBmcm9tDQo+PiA+YmVpbmcgbmVlZGVkLiBJcyB0aGVyZSBhIHdh
eSB3ZSBjYW4gYXZvaWQgdGhpcz8NCj4+ID4NCj4+DQo+PiBJIGRvbid0IHNlZSBhbiBhbHRlcm5h
dGl2ZS4NCj4NCj5XZWxsLCBpZiBub3QsIGNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gd2h5Pw0KPg0K
DQpUaGUgc29sdXRpb24gaGFzIHRvIGJlIHBvbGxpbmcgYmFzZWQgYXMgcGFuaWMgd3JpdGUgcnVu
cyB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQuDQpJIGFtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGEg
d2F5IHRvIHdyaXRlIGEgcG9sbGluZyBmdW5jdGlvbiB0aGF0IHdvcmtzIG9mIGFsbCBraW5kcw0K
b2YgaG9zdC9kbWEgZHJpdmVycy4gVGhhdOKAmXMgdGhlIHJlYXNvbiBJIGhhdmUgcHJvdmlkZWQg
aG9va3MgdG8gZGVmaW5lIGhvc3QNCnNwZWNpZmljIGRlcGxveW1lbnRzLiBJZiB5b3UgaGF2ZSBi
ZXR0ZXIgaWRlYXMsIHBsZWFzZSBoZWxwLiANCg0KPlsuLi5dDQo+DQo+PiA+PiArDQo+PiA+PiAr
dm9pZCBtbWNwc3RvcmVfY2FyZF9zZXQoc3RydWN0IG1tY19jYXJkICpjYXJkLCBjb25zdCBjaGFy
DQo+PiA+PiArKmRpc2tfbmFtZSkgew0KPj4gPj4gKyAgICAgICBzdHJ1Y3QgbW1jcHN0b3JlX2Nv
bnRleHQgKmN4dCA9ICZvb3BzX2N4dDsNCj4+ID4+ICsgICAgICAgc3RydWN0IHBzdG9yZV9ibGtf
Y29uZmlnICpjb25mID0gJmN4dC0+Y29uZjsNCj4+ID4+ICsgICAgICAgc3RydWN0IHBzdG9yZV9k
ZXZpY2VfaW5mbyAqZGV2ID0gJmN4dC0+ZGV2Ow0KPj4gPj4gKyAgICAgICBzdHJ1Y3QgYmxvY2tf
ZGV2aWNlICpiZGV2Ow0KPj4gPj4gKyAgICAgICBzdHJ1Y3QgbW1jX2NvbW1hbmQgKnN0b3A7DQo+
PiA+PiArICAgICAgIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kOw0KPj4gPj4gKyAgICAgICBzdHJ1
Y3QgbW1jX3JlcXVlc3QgKm1ycTsNCj4+ID4+ICsgICAgICAgc3RydWN0IG1tY19kYXRhICpkYXRh
Ow0KPj4gPj4gKyAgICAgICBpbnQgcmV0Ow0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICBpZiAoIWNv
bmYtPmRldmljZVswXSkNCj4+ID4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiA+PiArDQo+
PiA+PiArICAgICAgIC8qIE11bHRpcGxlIGJhY2tlbmQgZGV2aWNlcyBub3QgYWxsb3dlZCAqLw0K
Pj4gPj4gKyAgICAgICBpZiAoY3h0LT5kZXZfbmFtZVswXSkNCj4+ID4+ICsgICAgICAgICAgICAg
ICByZXR1cm47DQo+PiA+PiArDQo+PiA+PiArICAgICAgIGJkZXYgPSAgbW1jcHN0b3JlX29wZW5f
YmFja2VuZChjb25mLT5kZXZpY2UpOw0KPj4gPj4gKyAgICAgICBpZiAoSVNfRVJSKGJkZXYpKSB7
DQo+PiA+PiArICAgICAgICAgICAgICAgcHJfZXJyKCIlcyBmYWlsZWQgdG8gb3BlbiB3aXRoICVs
ZFxuIiwNCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZi0+ZGV2aWNl
LCBQVFJfRVJSKGJkZXYpKTsNCj4+ID4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiA+PiAr
ICAgICAgIH0NCj4+ID4+ICsNCj4+ID4+ICsgICAgICAgYmRldm5hbWUoYmRldiwgY3h0LT5kZXZf
bmFtZSk7DQo+PiA+PiArICAgICAgIGN4dC0+cGFydG5vID0gYmRldi0+YmRfcGFydC0+cGFydG5v
Ow0KPj4gPj4gKyAgICAgICBtbWNwc3RvcmVfY2xvc2VfYmFja2VuZChiZGV2KTsNCj4+ID4+ICsN
Cj4+ID4+ICsgICAgICAgaWYgKHN0cm5jbXAoY3h0LT5kZXZfbmFtZSwgZGlza19uYW1lLCBzdHJs
ZW4oZGlza19uYW1lKSkpDQo+PiA+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gPj4gKw0K
Pj4gPj4gKyAgICAgICBjeHQtPnN0YXJ0X3NlY3QgPSBtbWNfYmxrX2dldF9wYXJ0KGNhcmQsIGN4
dC0+cGFydG5vLCAmY3h0LT5zaXplKTsNCj4+ID4+ICsgICAgICAgaWYgKCFjeHQtPnN0YXJ0X3Nl
Y3QpIHsNCj4+ID4+ICsgICAgICAgICAgICAgICBwcl9lcnIoIk5vbi1leGlzdGVudCBwYXJ0aXRp
b24gJWQgc2VsZWN0ZWRcbiIsIGN4dC0+cGFydG5vKTsNCj4+ID4+ICsgICAgICAgICAgICAgICBy
ZXR1cm47DQo+PiA+PiArICAgICAgIH0NCj4+ID4+ICsNCj4+ID4+ICsgICAgICAgLyogQ2hlY2sg
Zm9yIGhvc3QgbW1jIHBhbmljIHdyaXRlIHBvbGxpbmcgZnVuY3Rpb24gZGVmaW5pdGlvbnMgKi8N
Cj4+ID4+ICsgICAgICAgaWYgKCFjYXJkLT5ob3N0LT5vcHMtPnJlcV9jbGVhbnVwX3BlbmRpbmcg
fHwNCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICFjYXJkLT5ob3N0LT5vcHMtPnJlcV9j
b21wbGV0aW9uX3BvbGwpDQo+PiA+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gPj4gKw0K
Pj4gPj4gKyAgICAgICBjeHQtPmNhcmQgPSBjYXJkOw0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICBj
eHQtPnN1YiA9IGttYWxsb2MoY29uZi0+a21zZ19zaXplLCBHRlBfS0VSTkVMKTsNCj4+ID4+ICsg
ICAgICAgaWYgKCFjeHQtPnN1YikNCj4+ID4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+
ID4+ICsNCj4+ID4+ICsgICAgICAgbXJxID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG1tY19yZXF1
ZXN0KSwgR0ZQX0tFUk5FTCk7DQo+PiA+PiArICAgICAgIGlmICghbXJxKQ0KPj4gPj4gKyAgICAg
ICAgICAgICAgIGdvdG8gZnJlZV9zdWI7DQo+PiA+PiArDQo+PiA+PiArICAgICAgIGNtZCA9IGt6
YWxsb2Moc2l6ZW9mKHN0cnVjdCBtbWNfY29tbWFuZCksIEdGUF9LRVJORUwpOw0KPj4gPj4gKyAg
ICAgICBpZiAoIWNtZCkNCj4+ID4+ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfbXJxOw0KPj4g
Pj4gKw0KPj4gPj4gKyAgICAgICBzdG9wID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG1tY19jb21t
YW5kKSwgR0ZQX0tFUk5FTCk7DQo+PiA+PiArICAgICAgIGlmICghc3RvcCkNCj4+ID4+ICsgICAg
ICAgICAgICAgICBnb3RvIGZyZWVfY21kOw0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICBkYXRhID0g
a3phbGxvYyhzaXplb2Yoc3RydWN0IG1tY19kYXRhKSwgR0ZQX0tFUk5FTCk7DQo+PiA+PiArICAg
ICAgIGlmICghZGF0YSkNCj4+ID4+ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfc3RvcDsNCj4+
ID4+ICsNCj4+ID4+ICsgICAgICAgbXJxLT5jbWQgPSBjbWQ7DQo+PiA+PiArICAgICAgIG1ycS0+
ZGF0YSA9IGRhdGE7DQo+PiA+PiArICAgICAgIG1ycS0+c3RvcCA9IHN0b3A7DQo+PiA+PiArICAg
ICAgIGN4dC0+bXJxID0gbXJxOw0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICBkZXYtPnRvdGFsX3Np
emUgPSBjeHQtPnNpemU7DQo+PiA+PiArICAgICAgIGRldi0+ZmxhZ3MgPSBQU1RPUkVfRkxBR1Nf
RE1FU0c7DQo+PiA+PiArICAgICAgIGRldi0+cmVhZCA9IG1tY3BzdG9yZV9yZWFkOw0KPj4gPj4g
KyAgICAgICBkZXYtPndyaXRlID0gbW1jcHN0b3JlX3dyaXRlOw0KPj4gPj4gKyAgICAgICBkZXYt
PmVyYXNlID0gTlVMTDsNCj4+ID4+ICsgICAgICAgZGV2LT5wYW5pY193cml0ZSA9IG1tY3BzdG9y
ZV9wYW5pY193cml0ZTsNCj4+ID4+ICsNCj4+ID4+ICsgICAgICAgcmV0ID0gcmVnaXN0ZXJfcHN0
b3JlX2RldmljZSgmY3h0LT5kZXYpOw0KPj4gPg0KPj4gPkJ5IGxvb2tpbmcgYXQgYWxsIG9mIHRo
ZSBjb2RlIGFib3ZlLCBsb3RzIGFyZSBkdXBsaWNhdGVkIGZyb20gdGhlIG1tYw0KPj4gPmJsb2Nr
IGRldmljZSBpbXBsZW1lbnRhdGlvbi4gSXNuJ3QgdGhlcmUgYSB3YXkgdG8gbWFrZSB0aGUgcHN0
b3JlDQo+PiA+YmxvY2sgZGV2aWNlIHRvIHB1c2ggYSByZXF1ZXN0IHRocm91Z2ggdGhlIHJlZ3Vs
YXIgYmxrLW1xIHBhdGggaW5zdGVhZD8NCj4+ID4NCj4+IFRoZSByZWd1bGFyIHBhdGggaGFzIHBy
ZSwgcG9zdCBwcm9jZXNzaW5n4oCZcyBhbmQgbG9ja2luZyBzZW1hbnRpY3MgdGhhdA0KPj4gYXJl
IG5vdCBzdWl0YWJsZSBmb3IgcGFuaWMgd3JpdGUgc2NlbmFyaW8uIEZ1cnRoZXIsIHRoZSBsb2Nr
aW5nDQo+PiBtZWNoYW5pc21zIGFyZSBpbXBsZW1lbnRlZCBpbiBob3N0IGRyaXZlcnMuIFRoaXMg
aXMgcHJlZmVycmVkIHRvDQo+PiBxdWlja2x5IGNvbXBsZXRlIHRoZSB3cml0ZSBiZWZvcmUgdGhl
IGtlcm5lbCBkaWVzLg0KPg0KPkkgYW0gc29ycnksIGJ1dCB0aGlzIGRvZXNuJ3QgbWFrZSBzZW5z
ZSB0byBtZS4NCg0KSXQgc2VlbXMgdGhlcmUgd2FzIHNvbWUgY29uZnVzaW9uLiBNeSBjb21tZW50
cyB3ZXJlIHNwZWNpZmljIHRvIA0KbW1jcHN0b3JlX3BhbmljX3dyaXRlKCkgYXMgaXQgcnVucyB3
aXRoIGludGVycnVwdHMgZGlzYWJsZWQuDQptbWNwc3RvcmVfcmVhZCgpL21tY3BzdG9yZV93cml0
ZSgpIGluZGVlZCBnbyB0aHJvdWdoIHJlZ3VsYXINCmJsay1tcSBwYXRoLiAgDQoNCj4NCj5XaGVu
IGl0IGNvbWVzIHRvIGNvbXBsZXRlIHRoZSBkYXRhIHdyaXRlLCB0aGUgcmVndWxhciBibG9jayBJ
L08gcGF0aCBpcw0KPnN1cHBvc2VkIHRvIGJlIG9wdGltaXplZC4gSWYgdGhlcmUgaXMgYSBwcm9i
bGVtIHdpdGggdGhpcyBwYXRoLCB0aGVuIHdlIHNob3VsZA0KPmZpeCBpdCwgcmF0aGVyIHRoYW4g
YWRkaW5nIGEgbmV3IHBhdGggYWxvbmcgdGhlIHNpZGUgKHVubGVzcyB0aGVyZSBhcmUgdmVyeSBn
b29kDQo+cmVhc29ucyBub3QgdG8pLg0KPg0KPj4NCj4+ID5UaGF0IHNhaWQsIEkgd29uZGVyIHdo
eSB5b3UgZG9uJ3QgY2FsbCByZWdpc3Rlcl9wc3RvcmVfYmxrKCksIGFzIEkNCj4+ID50aG91Z2h0
IHRoYXQgd2FzIHRoZSBpbnRlcmZhY2UgdG8gYmUgdXNlZCBmb3IgcmVndWxhciBibG9jayBkZXZp
Y2VzLCBubz8NCj4+ID4NCj4+IHJlZ2lzdGVyX3BzdG9yZV9ibGsoKSBpcyBmb3IgYXJiaXRyYXJ5
IGJsb2NrIGRldmljZXMgZm9yIHdoaWNoIGJlc3QgZWZmb3J0IGlzIG5vdA0KPmRlZmluZWQuDQo+
DQo+RXhhY3RseSB3aHkgaXNuJ3QgImJlc3QgZWZmb3J0IiBnb29kIGVub3VnaCBmb3IgbW1jPw0K
Pg0KDQpyZWdpc3Rlcl9wc3RvcmVfYmxrKCkgZGVmaW5pdGVseSBkb2VzIHRoZSB3b3JrLiBJZiB5
b3UgcHJlZmVyIHRvIHRha2UgdGhhdCByb3V0ZSwNCml0IHNob3VsZCBiZSBmaW5lLg0KDQoNCj5B
cyB0aGVyZSBhcmUgbm8gb3RoZXIgdXNlcnMgb2YgcmVnaXN0ZXJfcHN0b3JlX2JsaygpLCBpdCBt
YWtlcyBtZSB3b25kZXIsDQo+d2hlbiBpdCBzaG91bGQgYmUgdXNlZCB0aGVuPw0KPg0KDQpQc3Rv
cmUvYmxrIGZvbGtzIG1pZ2h0IGhlbHAgdXMgb24gdGhpcy4NCg0KSGkgS2VlcyAtIGZvciB0aGUg
YmVuZWZpdCBvZiBldmVyeW9uZSBjb3VsZCB5b3UgcGxlYXNlIHRlbGwgdXMgdGhlIHNjZW5hcmlv
cw0KVG8gcHJlZmVyIHJlZ2lzdGVyX3BzdG9yZV9ibGsoKSBhbmQgcmVnaXN0ZXJfcHN0b3JlX2Rl
dmljZSgpPw0KDQoNCj5bLi4uXQ0KPg0KPj4gPj4gKw0KPj4gPj4gK3N0YXRpYyB2b2lkIF9fZXhp
dCBtbWNwc3RvcmVfZXhpdCh2b2lkKSB7DQo+PiA+PiArICAgICAgIHN0cnVjdCBtbWNwc3RvcmVf
Y29udGV4dCAqY3h0ID0gJm9vcHNfY3h0Ow0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICB1bnJlZ2lz
dGVyX3BzdG9yZV9kZXZpY2UoJmN4dC0+ZGV2KTsNCj4+ID4+ICsgICAgICAga2ZyZWUoY3h0LT5t
cnEtPmRhdGEpOw0KPj4gPj4gKyAgICAgICBrZnJlZShjeHQtPm1ycS0+c3RvcCk7DQo+PiA+PiAr
ICAgICAgIGtmcmVlKGN4dC0+bXJxLT5jbWQpOw0KPj4gPj4gKyAgICAgICBrZnJlZShjeHQtPm1y
cSk7DQo+PiA+PiArICAgICAgIGtmcmVlKGN4dC0+c3ViKTsNCj4+ID4+ICsgICAgICAgY3h0LT5j
YXJkID0gTlVMTDsNCj4+ID4NCj4+ID5DYW4gd2UgZG8gdGhpcyB2aWEgbW1jX2Jsa19yZW1vdmUo
KSBpbnN0ZWFkPw0KPj4gPg0KPj4gVGhlIHVucmVnaXN0ZXJzIGhlcmUgYXJlIHJlbGF0ZWQgdG8g
bW1jcHN0b3JlLCBub3RoaW5nIHNwZWNpZmljIHRvIGNhcmQuDQo+DQo+SSBhbSBub3Qgc3VyZSBJ
IHVuZGVyc3RhbmQuIElmIGEgY2FyZCBpcyByZW1vdmVkLCB3aGljaCBoYXMgYmVlbiByZWdpc3Rl
cmVkDQo+Zm9yIHBzdG9yZSAtIHRoZW4gd2hhdCBzaG91bGQgd2UgZG8/DQo+DQo+QXQgbGVhc3Qs
IGl0IGxvb2tzIGxpa2UgYSBjYXJkIHJlbW92YWwgd2lsbCB0cmlnZ2VyIGEgbGlmZSBjeWNsZSBp
c3N1ZSBmb3IgdGhlDQo+YWxsb2NhdGVkIGRhdGEgc3RydWN0dXJlcy4gTm8/DQo+DQoNCkkgaGF2
ZSBwb3N0ZWQgcGF0Y2ggdjIuIEkgdGhpbmsgaXQgaGFzIGFkZHJlc3NlZCB5b3VyIGNvbmNlcm4u
DQoNCj5bLi4uXQ0KPg0KPktpbmQgcmVnYXJkcw0KPlVmZmUNCg==
