Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DBC4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 04:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084E623A7B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 04:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgLREDJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 23:03:09 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32550 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgLREDI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 23:03:08 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BI3oB4T010196;
        Thu, 17 Dec 2020 20:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=wUvwqkutUjOJ4O1i8ZMfZX2MyxPfrZwFQeRRbWdoV58=;
 b=L+Qc+gLOYhdegtML9p3YxZruT/66aQsTydScQRg1NlFc1NwhaFN4Xjs7ytl7fS6SMjob
 I0H7vuy18CdZXtP++zXmgF2uzpT/nAaSya1UQNGk38vgJWs0IvofoL+roxLkTc2LDtA7
 gZYQst6/I488AAjnkpkNlTv5URANRyOZZ2WPCxLMFKp36dtbHmUJETBqSIikRb+I4y09
 rWmda59xJojvEM/gfSP7W4O/RhLJqws10YX3gp7lQd9U31YulcjB+eXBBzXbugpQh29s
 TEdZHtFZEg3sS6lIGLAFg9ot5UAcYh8iMVrhFaxNK8zHYKzgdDcy2l4DtcABZhhpGVui YA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8thxbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 20:02:18 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 20:02:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 17 Dec 2020 20:02:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5lBJgiNBJjqgGzkLevBD6BfodkIHt/tO2ktcYrs526h42gy5HsI8qei8mcdE40WWFw6+lDKLUmd1WM6PwfF/Qonw/zEB+MXc/a8RNCX0asEvf0jVMaAO5OWyK+Dj4vhw5flQldMSXRYs/IU00hqkrrMoveS1CP0lS4KtidLh1x2Zepm66KyDydP8o0gv6GcIJyetLPjK5+BfxyCL3sOT8SuN5IBBjf0e/LZcrNdzamwnl8L6crwkczc2UQ7hFTO35k5z4n3qKvpHBrUnzJpzIrTsI4mWPp5yFndXgysBv2WegS3H0isjzCd6hahHmYdWA0Hxz/r1X6xV8cLNrIaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUvwqkutUjOJ4O1i8ZMfZX2MyxPfrZwFQeRRbWdoV58=;
 b=FbxdX0W81mX1073B7uCJ9+xmaVDOPbMpwkWnWV9SlN5BvLiggAnUT2SDYyIuce6vkia2RaC5jj2Yqjo4Uhx//j/UU93LeXwJnSGcQ2PznoNcH9UC4PKxvwBLxYbsVZG+D8u4rbMg95vvi0oh/MpgT7ONDmfDjrLgPzIJwgoTTtBRNESOXMvxnPbq9T6/d8TE/js9o8Ip44b/EHnBwL/Y0yBBT8AKN8R+QUdmu/Pz0KRkW4vboSfInIC996zRvbraVAjVipE64cYP/0DsIByKt13NdRAcfT2IHk3BbpwEDHUiwylc2IZ6sWu0tVtG3WegsyjUaJImFuMjFy7biD0P2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUvwqkutUjOJ4O1i8ZMfZX2MyxPfrZwFQeRRbWdoV58=;
 b=q0caUe0gm28svi4HCiznNv9DtVfZzjE30lQ5owxmo2Spnbs2A2LZg7mGVPact35gWYQIP/0/lpOVfeFhOm9vUyQrpk4gxGjzcLr5xus1jdoFMKri+E63WK9hfG1x5JYK4vv5k7NMHO9Rh5q8J2CkTyFntyiYSb75gE+iVySuo/w=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1672.namprd18.prod.outlook.com
 (2603:10b6:903:144::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 04:02:15 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::bcae:7eef:6788:7770]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::bcae:7eef:6788:7770%5]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 04:02:14 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Topic: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Thread-Index: AQHWzJBGAAft6IQ2BkOkVnoLREcZc6nxyUkAgAXb/lCAAHB2AIAACZ6ggAFrHgCAAALOcIAADKCAgAGYuECAAGOvAIAAs0ew
Date:   Fri, 18 Dec 2020 04:02:14 +0000
Message-ID: <CY4PR1801MB2070C05E828C5D12544183ADDEC30@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
 <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com>
 <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
 <CAPDyKFoSr72bKd3qzYi9QZT5L3DewjEYjRExE+V4XmdiqHLkXw@mail.gmail.com>
In-Reply-To: <CAPDyKFoSr72bKd3qzYi9QZT5L3DewjEYjRExE+V4XmdiqHLkXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [27.59.187.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddba6bea-e9e0-4401-efa3-08d8a309b43e
x-ms-traffictypediagnostic: CY4PR18MB1672:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB167241A575E01CC578077914DEC30@CY4PR18MB1672.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 686y3H8/xWso4ynPnwIEWA79j8ogJFc726K/1sk7yyo+nt6bjfzTArqcElTeiqtjp/bgJUN1NiMyRRefgEgWcftDwKnXga9NOsjs4M4Thi8qPyOgIwHRhC9wzXhTSxNLHA3gGdqpzcHEDO8OTFImMuChZUGTUOXcx0V9V3neHF5+RNh4XjzlY38D8/JtSx8eguBCx7djVxiBZpC+qhcpTe6FLmsFlrC9nPji6Xb9h6nvF2NmH1iwGvJ4M13JASb/HjL92SWvUN4RcZku4Zb4qu/5nDIirDxf5xMqCyVo7rWanszRtDGyKnwfIhb2UQHXbksURwEhLnvax5GTbX6Z0spUSkGyX8tW7rMthKLYpgzQxOJp5XkJP0bxArmOGPJIRSWrV+DALJz+hAb0hO+2FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(76116006)(8936002)(66446008)(66476007)(26005)(66556008)(86362001)(4326008)(186003)(64756008)(52536014)(66946007)(83380400001)(5660300002)(33656002)(7696005)(6506007)(6916009)(316002)(55016002)(478600001)(54906003)(2906002)(9686003)(8676002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UkRUL1ArVmE5WVdRVDJkRTFUUy8vS2IvdGpDeEthMWJtMnNxd1lMSGl2MzBp?=
 =?utf-8?B?bHZ5azJzM0xvQXd1QlZHbi9DTmVsaER6K0RDVHl2OCt6Ry9kN1Jic1F1MTd6?=
 =?utf-8?B?anNZUm5IM0kvSlJZdnFqQXFONkxKQUg3UHlGQ2tGYUdCbTlrR2I4dC81cGdl?=
 =?utf-8?B?ZmxDZTRnWDRaaUgrMDVMUzgzV3g0b1JhcDhQL0F0ZDZzLzBsMTd6cEZ1R0w1?=
 =?utf-8?B?UkhUY1JFVmpONTNoUGpkYTgwQnBLb09sZVZVM3BuNWRWN1JBZzVudXRrVTlw?=
 =?utf-8?B?MEJEV0N1WUM0ZzlraDdZUk85K3RhRnRzSitRM2JuL0VHSkphYThMYXBiNXlz?=
 =?utf-8?B?ZDlxNE5KNFB0eU1uaWs2K29vM2MwRzd3V1dHUDJaelRKdTBwcjVhM2VCWXBm?=
 =?utf-8?B?Y3psbmF2TTZ0RlFQcDZmQ1I3K1RTZ01USmt1Q25jLzl4OFZwdjFBcCtkN2Iv?=
 =?utf-8?B?MlpiamNKU00vR3JQRzJPNGl4VUhGU1d6UG5ZdXBxNUtuT0c4SXFZMWViVkQ4?=
 =?utf-8?B?dk5IUkpQNFJOWWxGK2o5a3g4ZlBCM24rWkM1eFRVdDRNRUpIVUtnQmJJSnJ0?=
 =?utf-8?B?ejdJZUVZR2U3QTFGK2pkUjNGZUNQNWJLK0h5Qkh0VUM5V0w0ZWFqeTYrZ0tE?=
 =?utf-8?B?RWk0ZkJTaTlYWW5IL2YxUHNPYTBZdDRGQWFqbzYwVkwrVXV5WXIvZUZJLzB5?=
 =?utf-8?B?SjhXSEJQZGVuQ2JjZTFYcmVTUm5BKy94Qm1FOGtSMzZ2UFlSczNMZm91eWx2?=
 =?utf-8?B?YVZ4S1o3VjA4WmxmTUpST0FGOU1YSVVHQzRoWHozT0Q1MDNrMnRBOWVnd2hP?=
 =?utf-8?B?WlhmNEFzQTVtOTBlNWF3OGIvRU5jTnhESmNoVU1EWXlrcFNuRTB1cGhXZUMv?=
 =?utf-8?B?RDlWMldrVU1XcGlrOXFLd0tYN1VxYmh1RmgxTHhjdDZCcEZoT1lFWHVvZzZu?=
 =?utf-8?B?T2cxMkFVSy9wTjV1V0ZQRjRzKzlQY01reERCMDlLRWsvRHpxeE1vZkJ6MlhM?=
 =?utf-8?B?Smx5dU5VVEg2UHBIYnQ2UGJYSkJ1d1J1akxLbnZneXJEdzN6OGU5NDVxeEZu?=
 =?utf-8?B?Z2x2VGt1dFVjdHJiNWhUeUdlNDd1ckRXUzc0NVk5clJNMzh3czAzYUlkVUI0?=
 =?utf-8?B?b3BxMElpRldRNGt6WWNMbnZxVkRpYTlzQlpLWlNwWm9wK2k5cnlJOEJYZ3px?=
 =?utf-8?B?MXE0aTlhaFN3WW9qbG5OY2JweCt6bktqc1pkVmp5ZlA5NXdiZVYzYnFNTElr?=
 =?utf-8?B?T0NhOGEwclNwRnJIdElLdE1NSnhzYjByU0RGQXdnY01nc0pQMDBoWWlvdnBk?=
 =?utf-8?Q?6NON7B0xP0nTU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddba6bea-e9e0-4401-efa3-08d8a309b43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 04:02:14.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krpi+K0PceMeNIJ+xWsI4lE6lrbmtzXxDMWcH9Xw64pO/V7b2OTRAeHYyYqr2M9ArE3nVIQZCfvi2P8ExT6YWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1672
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_03:2020-12-17,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxNywgMjAyMCAx
MDo0MiBQTQ0KPlRvOiBCaGFza2FyYSBCdWRpcmVkbGEgPGJidWRpcmVkbGFAbWFydmVsbC5jb20+
DQo+Q2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPjsgQ29saW4gQ3Jvc3MNCj48
Y2Nyb3NzQGFuZHJvaWQuY29tPjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgU3Vu
aWwgS292dnVyaQ0KPkdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgbGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZzsgTGludXgNCj5LZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgQ2hyaXN0b3BoIEhlbGx3aWcNCj48aGNoQGxzdC5kZT4NCj5TdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCAxLzJdIG1tYzogU3VwcG9ydCBrbXNnIGR1bXBlciBi
YXNlZCBvbg0KPnBzdG9yZS9ibGsNCj4NCj5PbiBUaHUsIDE3IERlYyAyMDIwIGF0IDEyOjM2LCBC
aGFza2FyYSBCdWRpcmVkbGEgPGJidWRpcmVkbGFAbWFydmVsbC5jb20+DQo+d3JvdGU6DQo+Pg0K
Pj4NCj4+IFsuLi5dDQo+Pg0KPj4gPj4gPj4gQW4gZXh0cmEgY2hlY2sgY2FuIGJlIGFkZGVkIHRv
IHNlZSBpZiBob3N0IHdhcyBydW50aW1lIHN1c3BlbmRlZA0KPj4gPj4gPj4gYWhlYWQgb2YgcGFu
aWMgd3JpdGUgYXR0ZW1wdC4NCj4+ID4+ID4NCj4+ID4+ID5XaGF0IGlmIHRoYXQgaXMgdGhlIGNh
c2UsIHNob3VsZCB3ZSBqdXN0IHJldHVybiBhbiBlcnJvcj8NCj4+ID4+ID4NCj4+ID4+IFllcy4N
Cj4+ID4+DQo+PiA+PiA+TW9yZW92ZXIsIGV2ZW4gdGhlIGRldmljZSBiZWxvbmdpbmcgdG8gdGhl
IG1tYyBjYXJkIGNhbiBiZSBydW50aW1lDQo+PiA+PiA+c3VzcGVuZGVkIHRvby4gU28gaWYgdGhh
dCBpcyB0aGUgY2FzZSwgd2Ugc2hvdWxkIHJldHVybiBhbiBlcnJvciB0b28/DQo+PiA+PiA+DQo+
PiA+Pg0KPj4gPj4gWWVzLCBzYW1lIGhlcmUuDQo+PiA+Pg0KPj4NCj4+IFBsZWFzZSBjb21tZW50
IGlmIHJldHVybmluZyBlcnJvciBpcyBzdWZmaWNpZW50IGhlcmUgb3IgY2FuIHRoZXJlIGJlDQo+
PiBhbiBhdHRlbXB0IHRvIHdha2UgdGhlIGRldmljZSB0aHJvdWdoIGVpdGhlciBvZiB0aGUgYXRv
bWljIGFjdGl2YXRpb24gY2FsbHM6DQo+PiBwbV9ydW50aW1lX2dldCgpLCAgcG1fcmVxdWVzdF9y
ZXN1bWUoKT8NCj4NCj5IbW0sIEkgd291bGQgc3RhcnQgd2l0aCBwbGF5aW5nIHdpdGggdGhlIGJl
bG93LiBtbWNfY2xhaW1faG9zdCBzdXBwb3J0cw0KPmFsc28gbmVzdGVkIGNsYWltcy4NCj4NCj5t
bWNfY2xhaW1faG9zdChob3N0KSAgLSB0aGlzIHdpbGwgY2FsbCBwbV9ydW50aW1lX2dldF9zeW5j
KGhvc3QpDQo+bW1jX2dldF9jYXJkKGNhcmQsIE5VTEwpIC0gdGhpcyB3aWxsIGNhbGwgY2FuDQo+
cG1fcnVudGltZV9nZXRfc3luYyhjYXJkKSkgYW5kIGFsc28gdHJ5IHRvIGNsYWltIHRoZSBob3N0
DQo+DQoNCkFzIHlvdSBzdWdnZXN0ZWQgSSBhbSBjcmVhdGluZyBhIHBhcmFsbGVsIHBhdGggdGhh
dCBhdm9pZHMgd2FpdCBxdWV1ZSANCnRvIGNsYWltIHRoZSBob3N0LiBUaGUgKl9zeW5jKCkqIHJv
dXRpbmVzIGNvdWxkIHNsZWVwLCBJIGNhbid0IHVzZSB0aGVtDQphcyBwYXJ0IG9mIHBhbmljIHdy
aXRlLiANCg0KDQo+S2luZCByZWdhcmRzDQo+VWZmZQ0KDQpUaGFua3MsDQpCaGFza2FyYQ0K
