Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDAC4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C61F22AAE
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgLOSqd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:46:33 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2310 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730517AbgLOSqb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 13:46:31 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFIjPq0008576;
        Tue, 15 Dec 2020 10:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=LJSdtItXi/uc02jLBtg/TKDBit4n9WPZk9sqLYrFpXg=;
 b=DEofAqJgGMYqjYiJ6jahvc8lZ4NEd7NbsTFvzfttGdU2kSNWUi1eB33UpAHhGfy3aDIR
 KH5H0d+Ou8XiJ0tQQwbu+KEsL+hvDMGr3n19aL5kMAJwGWkqEeB5kaYaUzjOSIOc+2ho
 FJ7yC/DKr6/FiVy2kprrL1VdNuK6Ml/CHYYaSIY8AZ+yewiIhxV0Tts8rUHvq1OFfoV5
 Y2ql4Ym9kbkmltIzXYMw0v5xIH/Flq2oRIjto3rfSPXR05Il5FMkhvXxqZQ4A6A2YkGb
 650x4pgEhQI+ZD1ubNC1Pgu1nxNfReOdOczGZm3SzCq7wT7Up6U9VsJZ66jcUFiFB48P cw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35cv3t16ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 10:45:29 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 10:45:28 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 10:45:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 10:45:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3AuACL740rrj+0SMwqfg7JKV4GxtUvb5wXvLLIT1yi7m2QjZ3zzWUmOWaODYIUxhjA0TZdfqXX1kf/RLvYTWWZ+SZz1N35/gqjaL0Ep16EP1LHjz4/TClSS6PlALRXf9qxwPB+4BS5oi4XLfHdOkMh5Ab7chMbH5aTuS250nCelqgM2yXV+C1WDM7GX0TrV4Q0DE4RAdQUkKrYhP2/hWljKAGrUrM7yKo/2hVIqN8bOH34nUIlSoUsCP47USBMC0DodPX5d57Ra2rsPNx5oqolu37WqDtdL0ihns9auw5J9OisL/mLkfFvXBrYpt3N+sZ0fTOFlo1W/a9zMc8uEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJSdtItXi/uc02jLBtg/TKDBit4n9WPZk9sqLYrFpXg=;
 b=jfyfZdc34oAK7yRt4KwLwI/KiBQdHBcee3E+oKZZ6bdN7EAJaSHqcFeyLvCy6VYdqf8gyuW8jSxWJJEAHuxHUGD6IOeEXwn0P+GtO9wJV4prakc5MxOMl0zKJcFy6mLAo/0JjsjJLpwRFGuh9Hlo8oOG9IzQIQFzJWX8k186yXBDKoyjJW51p71fOW0E1W9aYqgXL1PGymAJXbdQfPKU1LvHSd1HGYPtrI1iPkSNR112+g3+OT0Qo1bZP7I3n/ZLV+TE+J7ezIysHjMNS+e8uB46PJLo99XBFKgJ5DQe7zWdQcpIlZ7gffsJ/qfryJRvovxqRYW6Sih6p4PbvA1Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJSdtItXi/uc02jLBtg/TKDBit4n9WPZk9sqLYrFpXg=;
 b=T0vgiEvoEiDLO6Wu5gcIEpCbnWXj16WjJmxJ+Dr0s2v4YPwePZ9NpirH4E01OUSzLVLaBB/5nIINy4LP7TYMvJCvcyiQVqqqf8lqRMCeBT8DtIqNQGwncgyLrSOB/sjS8B7C+ExFMIVwgK45icL1thxxna59zWVri7K99OCJMr0=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM6PR18MB2490.namprd18.prod.outlook.com (2603:10b6:5:188::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.18; Tue, 15 Dec 2020 18:45:26 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6%9]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 18:45:26 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>
Subject: RE: [EXT] Re: [PATCH 2/3] mmc: xenon: add AP807 compatible string
Thread-Topic: [EXT] Re: [PATCH 2/3] mmc: xenon: add AP807 compatible string
Thread-Index: AQHW0wYCHTTj40f+2k2yZQKnrhDuG6n4fgnw
Date:   Tue, 15 Dec 2020 18:45:26 +0000
Message-ID: <DM5PR18MB14521CD0BE8BFEAC34921D74CAC60@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20201215155636.28474-1-kostap@marvell.com>
 <20201215155636.28474-3-kostap@marvell.com>
 <30d17db8-5735-8e3c-b026-3a7f4794d1c7@intel.com>
In-Reply-To: <30d17db8-5735-8e3c-b026-3a7f4794d1c7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [37.142.9.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87bbb66f-d724-4c80-bfe0-08d8a1299684
x-ms-traffictypediagnostic: DM6PR18MB2490:
x-microsoft-antispam-prvs: <DM6PR18MB249047D5B8551E9A4B2257A7CAC60@DM6PR18MB2490.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MREgbwu2kIvJ+SA0nVAHAmwt0dTNJD+zUxvtR6WHf1g01K9gqZ8Zu4R3kBVoiCmfT7qUvP0CtmYSQDohjfdWoI9/b1t+PnznE54XdxPlSat4YD/QRK4Mf1Jn3T+Q8WxA8InvihzFG4JY13NbGu227GpIkAChLJK/mUDAbcsKf7BQ7AT1AcxLrYkWW4ZWP0m7gEnCFWjOooGmOAFeoKv0xUg4kUq+zqAgdxwtDUSo7F3cFpAXZ+H4YxQgHJkW7bTMbQh6nFuX10mKUwfKIgyWtF+/jyh6xSFNYo6zZK9ZxXhlX3w5Y04fD3rHuB8IDjanuCxOHf3k+0+rxobiOj91eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(66446008)(64756008)(8936002)(66556008)(76116006)(66946007)(110136005)(54906003)(4326008)(478600001)(316002)(66476007)(53546011)(52536014)(2906002)(5660300002)(9686003)(71200400001)(7696005)(86362001)(33656002)(6506007)(55016002)(186003)(26005)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MjdZWEp6V2p5TDdrcXpZbWZHMDMzQ2RqK3BXNXZad3QyVUZqQU5UTjBjMXVs?=
 =?utf-8?B?bTVrWmpjL3NDbzRXZnZrSTV6dGViSmR6ZG1jckhjZEtNVmsvaEJzZi9NN2dz?=
 =?utf-8?B?ZnR4L0Q0QndLTjBCN2pkUTIwUURWR29FWkduRHJ1SytXM3hZcFd6UGt0Nld0?=
 =?utf-8?B?dDJLcHM3OVZWZm9VK2lNUmszbURrbHdnK0tzamVLNTRyUkdEKzlEUEczWTgv?=
 =?utf-8?B?ZEpmT2JHRCs5K0ZxM2NLaFQyQm9FSU42QlUwSXpzWlFQYzRNNWQzZHFJTFJC?=
 =?utf-8?B?aHp3WWUzVFZ6Y21pLzBSUEVFdU55SnloZVZ6dEZmU1VVNExrWXVvZVl0NmNY?=
 =?utf-8?B?L2hUUFNPRjBQbDZxR1JkajBTYUlETjRsNFRrc3REZGo3ZnJ0YkdMR3pKZVFV?=
 =?utf-8?B?WW5jb3M0VFZYQnNvaDZBUWVyZVRHbDZ1enlUeVJlZzNzWHYxbitWZDFTNkNm?=
 =?utf-8?B?ZHZKRHdRcDNqMVF2Rm51emI2Rm8zN0ZSRytCQUR4WXc0RncydncrdFA4ZG5i?=
 =?utf-8?B?L3gyZ3RFYUFUYzREejNKekoxdC9DbFlraDZZZ0lPZytnMldtdnhPY1NyY01U?=
 =?utf-8?B?SUlOSVpHVTQwbk54bFRJVWVoTE5JUytzUkRuWlpDNVlnV1VzUVhVUHZHbmpE?=
 =?utf-8?B?eTNKU0R5SnRRWGZwTUFwY05kS0RhYjZUTURVaVpDeVRUM3luV1lPRk1qTlJN?=
 =?utf-8?B?ZS90TXZISm04SzlIVGFLY1daMVgwWWo2dENRUkpzTVJrMDExY2pNUm05VU9D?=
 =?utf-8?B?MXF3NklGVHpTNG4wNVdpZVcreEgzM2FRQU11VWhzaFhDOHFueHBBQ0M4NXgv?=
 =?utf-8?B?Y2xJSjQrdk1oR3kycGN4MHdQNWt2REZtdCtTTEVGWEVxSStocE1vRmFjUGg2?=
 =?utf-8?B?cWdDWmtISVgyL2w4Q082ZE5PVWdWMlJSZ1lnZ2VVSWtGRSt6dzZ0UDdCdWQ2?=
 =?utf-8?B?N1owQ3pSOUhDcGVUU3QxT3hHV2FaaFFsT0hTVGUrdVJCSmFYTEVMUDloeGpJ?=
 =?utf-8?B?QkpPY0tyYUhvYTNlWi9OSWNsMC9MNFFtSVgyaDhmUXlSaXN1aDZmL1dGOWl2?=
 =?utf-8?B?Y3pycE9kWlI2elhCRGdvSUdIOWFYUmtEYWdNUWhib3BqQ1h1VWU5eTlWaUxB?=
 =?utf-8?B?bE5IWTBNdktJZUIrOEV3aEhjb2g2RTYvMnJuMy9FM0dTQ1IxMnVhcVp6dTZZ?=
 =?utf-8?B?bk9GeFQ0MW5BLzN5cldFbVowWjJ4ZFA4UjFjZmtlbUxnVzJNUDMzU0hvQzNY?=
 =?utf-8?B?bmI4blV0RjJmcXZzc1BMVXVoKzdhbFFWbHUxOTFkclpRbWZDRlJoVEUreXhP?=
 =?utf-8?Q?TayT6XWpVqjqw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bbb66f-d724-4c80-bfe0-08d8a1299684
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 18:45:26.3028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwAHFOTO+cm90j9qQCQbUuPMOq1mwz8iykW2ZWLqJdBedxxqqSbg/QQbFXP3y3fpf6EAC0rtUdPR2QHu73h0vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2490
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE1LCAy
MDIwIDE5OjE2DQo+IFRvOiBLb3N0eWEgUG9yb3RjaGtpbiA8a29zdGFwQG1hcnZlbGwuY29tPjsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogaHV6aWppQG1hcnZlbGwuY29tOyB1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnOyBhbmRyZXdAbHVubi5jaDsNCj4gZ3JlZ29yeS5jbGVtZW50QGJv
b3RsaW4uY29tOyBzZWJhc3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tOw0KPiBtd0BzZW1paGFs
Zi5jb207IGphekBzZW1paGFsZi5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAyLzNd
IG1tYzogeGVub246IGFkZCBBUDgwNyBjb21wYXRpYmxlIHN0cmluZw0KPiANCj4gRXh0ZXJuYWwg
RW1haWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gT24gMTUvMTIvMjAgNTo1NiBwbSwga29zdGFw
QG1hcnZlbGwuY29tIHdyb3RlOg0KPiA+IEZyb206IE1hcmNpbiBXb2p0YXMgPG13QHNlbWloYWxm
LmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBuZXcgY29tcGF0aWJsZSBzdHJpbmcgdG8g
ZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZQ0KPiA+IGNvbnRyb2xsZXJzIHZlcnNpb25zIGluY2x1
ZGVkIGluIHRoZSBBUDgwNyBub3J0aCBicmlkZ2UuIFRoYW5rcyB0bw0KPiA+IHRoaXMgY2hhbmdl
LCB0aGUgU29DcyB3aGljaCB1c2UNCj4gPiBBUDgwNyB3aWxsIG5vdCBydW4gdW5pbnRlbnRpb25h
bGx5IGluIHRoZSAnc2xvdyBtb2RlJw0KPiA+IHdpdGggZGlzYWJsZWQgVUhTIG1vZGVzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2luIFdvanRhcyA8bXdAc2VtaWhhbGYuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA3LmR0c2kg
fCA0ICsrKysNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS14ZW5vbi5jICAgICAgICAgICAg
ICAgIHwgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS1hcDgwNy5k
dHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA3LmR0c2kN
Cj4gPiBpbmRleCA2MjMwMTBmM2NhODkuLmU5YTc0MGVjMjJjYiAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA3LmR0c2kNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODA3LmR0c2kNCj4gPiBAQCAtMjcs
MyArMjcsNyBAQA0KPiA+ICAJCSNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiAgCX07DQo+ID4gIH07
DQo+ID4gKw0KPiA+ICsmYXBfc2RoY2kwIHsNCj4gPiArCWNvbXBhdGlibGUgPSAibWFydmVsbCxh
cm1hZGEtYXA4MDctc2RoY2kiOyB9Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLXhlbm9uLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kteGVub24uYyBpbmRl
eCAyNGM5NzhkZTJhM2YuLjI5ZjZiZWRlOWI5Ng0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kteGVub24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kteGVub24uYw0KPiA+IEBAIC02NjgsNiArNjY4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
ZXZfcG1fb3BzDQo+ID4gc2RoY2lfeGVub25fZGV2X3BtX29wcyA9IHsNCj4gPg0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZGhjaV94ZW5vbl9kdF9pZHNbXSA9IHsNCj4g
PiAgCXsgLmNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGEtYXA4MDYtc2RoY2kiLH0sDQo+ID4g
Kwl7IC5jb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLWFwODA3LXNkaGNpIix9LA0KPiANCj4g
RGlkbid0IHlvdSBhZGQgbWF0Y2ggZGF0YSBoZXJlPyAgVGhlbiBpdCBuZWVkcyBhIHJlLWJhc2Ug
b24gVWxmJ3MgJ25leHQnDQo+IGJyYW5jaC4NCltLUF0gVGhhbmsgeW91LCBJIHdpbGwgcmViYXNl
IG9uIHRvcCBvZiBrZXJuZWwvZ2l0L3VsZmgvbW1jLmdpdCB0aGVuLCAgYW5kIHJlLXN1Ym1pdCBh
cyB2Mg0KDQo+IA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS1jcDExMC1z
ZGhjaSIsfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWFydmVsbCxhcm1hZGEtMzcwMC1zZGhj
aSIsfSwNCj4gPiAgCXt9DQo+ID4NCg0K
