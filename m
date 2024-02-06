Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2122.outbound.protection.outlook.com [40.107.237.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0D128365
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201802; cv=fail; b=jV3GyfGDIBh4/YeqbyRbyPyfvpusAMYAUw0B1C/Occow/FvLgtAEn/txexxwSJPw1gvOGPd4KyQ6U23YnX5RXmjAs44LssIsAKmZ/raI7e/vw30WFjPwivLn3lMpmFdhBEopMdpV3WdWw/At3GMhzp7fZwX7gRWRMalNRoLrmAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201802; c=relaxed/simple;
	bh=QnO42bFADYIbj9SFitg7CZPDQOmqRU50DLI6EG60wcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBr3h+CAoFlWsKuFQ3sDnwveVHevLP2WpSsM+qIXWXh3cDpzffJ7pUfYQGUV/koRfx0lsVI9v17APUdOXsoItNWqg4hzXvRIHlxS3lIwuUYoumrcWQ+WC3sVQ+uZm2NSbs14h5Bqq9w5oQIDHdbDC2PxiZ2Kz0gPlR2qvvcjXK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com; spf=pass smtp.mailfrom=bayhubtech.com; dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b=a69cdqdU; arc=fail smtp.client-ip=40.107.237.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="a69cdqdU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbzBo0CERzJxm/p8q0QlW5zgQqDAUubQjNp9GSR4oM9ZAfC0MwOhD6bnDaNCNbNSRsgfarE27HvckuoKM0WN70P8R6zMGYtZmBj3e3BDy6BRhSOcHTmZVDajqtzrklbQBT6hG8HUU5s/QVVVYPbYg5qPHtzxd0Usjm3BnufRVCmd+SsETWBpi1IB4znmD5QRRRaWMcND/75hb3aCMk1NYGeFA1L1jrBGrgr0pm1G5Lr9kh+gsRkZBNS+08YCFLdg4/EH6q6dO4qdpjiIg49Jy+oPPIp03b5NZUGmQDwxFLO09J0fpmwZcsJy9MaT/d0sxzsh7H+UVRrrknZN3QSTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnO42bFADYIbj9SFitg7CZPDQOmqRU50DLI6EG60wcQ=;
 b=mFxYA0XGWtqs42NMyyFkdUIo6BJcVcmKPwtdAbcw9EWqreIVjPmEK/CrmrP9b61o/xBpUJl47Upz3yjKKqgKOpQBJveleHptkujysopnHVk15mFVkYOfHJXFCO885NdaQXjciv20v481DcOwk2HKWsB8MJB7Rt8bXo7xu5wHO+DlGBJnlFQ0MG6RUfWk4Zr4cFMasGuH0IUnGRURV31VsNobrpX4A8byu18RpBXv8DrwM9sU/gEcSNmcRMaVdarbwOvbPOequ6qUFxrOWJvpY/LM9szKkVt7s8Pa+xQAllRCL3kt3+K3WNwfgAYwAdXVlKmg44RjxONhWF/gyuh8yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnO42bFADYIbj9SFitg7CZPDQOmqRU50DLI6EG60wcQ=;
 b=a69cdqdU4qe9phjGzLeDPbjdxbRFAPdk2jfPt0RfVKjhg3e19vdPksO+05wgL3rJ8M23sX87MqL5O7y0248MT5/HRKv+aT2VC4LGoqzqke/iSHF7D+wx+Z9rzsOCe0OMth6SDjuPKs6XjupZFg7IIkgD8BMGabvdWtObBRmTBCM=
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by MN0PR16MB6363.namprd16.prod.outlook.com (2603:10b6:208:4c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 06:43:16 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::4cbb:1322:5c9d:1d30]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::4cbb:1322:5c9d:1d30%4]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 06:43:16 +0000
From: "Fred Ai(WH)" <fred.ai@bayhubtech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "fredaibayhubtech@126.com"
	<fredaibayhubtech@126.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux.kernel@vger.kernel.org" <linux.kernel@vger.kernel.org>, "Shaper Liu
 (WH)" <shaper.liu@bayhubtech.com>, "Chevron Li (WH)"
	<chevron.li@bayhubtech.com>, "XiaoGuang Yu (WH)"
	<xiaoguang.yu@bayhubtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggVjEgMS8xXSBtbWM6IHNkaGNpLXBjaS1vMm1pY3Jv?=
 =?utf-8?B?OiBGaXggYSB3YXJtIHJlYm9vdCBpc3N1ZSB0aGF0IGRpc2sgY2FuJ3QgYmUg?=
 =?utf-8?Q?detected_by_BIOS?=
Thread-Topic: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix a warm reboot issue
 that disk can't be detected by BIOS
Thread-Index: AQHaVovbjchhZJMnc0K9LXaT1zM5ubD74tiAgAD6pwA=
Date: Tue, 6 Feb 2024 06:43:15 +0000
Message-ID:
 <BL3PR16MB45709A1A9FC4BA160398E2E399462@BL3PR16MB4570.namprd16.prod.outlook.com>
References: <20240203102908.4683-1-fredaibayhubtech@126.com>
 <CAPDyKFrt80WPeCGJZsQaCsN5a+95ru6rKnQb3kPODMkU1G6Ocw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFrt80WPeCGJZsQaCsN5a+95ru6rKnQb3kPODMkU1G6Ocw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR16MB4570:EE_|MN0PR16MB6363:EE_
x-ms-office365-filtering-correlation-id: c8f4bf11-46a1-421b-7a07-08dc26dee5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wuCyiuCvIG0VJQJuu82hu6QiMq+u4880kZWSWXBiA9svHB2rF/F40hHJQ51ASzUYU5OjQ0rnzjPvJ0dOknnYGxHtclYZPLqggS/fKvPahG6EOqKvc+o2kg9VkrLCs8cdGnp8PQ5YqPvTSkKnqwnsoxph2f6azuBpfW0E7WSX9TfOKA5LWoEQjWYuN8esLvs1vlfd04kdlTJnkFYU0vdyK6lSCmlQ4ZiRgRp3BvNfMpecZ2klWEcCahTh9Q/QiKCsL579FpPpgF3n09w04MLOMUZ6SgCPkAAnwZdSFKq7r4AKhehiAxDF+GF8/DrYve7vm4vlivWCSaA7WlLVSCZF5dnfJ4hQDD5rb+dVmswRUwOo9hvmNkCH3zu7aHy2ApOGkWfmAA9+G7CIR5ghzoxJX01a1RonsNFQnDlbO/SvF9BSpJf1QJTDIattu/VYb7umRsMfq5tIi2dqyo6SwUUazBwSyuTsM/SDWtfGf+ORurx7b4ZOd12gsfl1bvfvpxMd/W9mViwBqFefTLSgR2O7r6JD9iDa3efRVHU2lPgY+fuigRR73I/ulNgT+wi3cYiOXwbBm2eEnpewEe4ruxetaqEdRWozKVnF0ScjBvZ0DKo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(26005)(55016003)(107886003)(38070700009)(224303003)(38100700002)(9686003)(71200400001)(966005)(122000001)(478600001)(83380400001)(6506007)(7696005)(66556008)(86362001)(33656002)(66946007)(66476007)(4326008)(66446008)(5660300002)(54906003)(64756008)(76116006)(110136005)(2906002)(316002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2FxMUg2Z3YyOWtOVlh0c3lTRmVySTRMRWYyNzVUQUpka0tOTUNKYUExQWdT?=
 =?utf-8?B?RHVQQVBxWEhremp1UW9KY2gwcFM5ZHpkeDg5RGlDRzc0cW5DK3BjZmlESHgx?=
 =?utf-8?B?NVNRTjRUU0FYTTg0dW1vaytuZlNHSTBYSGo0UWhFN2ZlUVZKYlZqOXFNSktz?=
 =?utf-8?B?TnVMOTVVRkltRW9aV0U2M0JDZ0h2dUdPRi85WmlXZ2gzSFRjQksrSWpTUXRm?=
 =?utf-8?B?ZG1XQVM5Z1FaLzRDcXZHeE0yRWVoVVF6L0lmblhGYUZzV095eUlzZEIxaTBK?=
 =?utf-8?B?RFVhMW9ib2d3YzNVOGw1cE5HSHBxMm40TWtCMGQvdFY1RGpFbFNIZktMZ01o?=
 =?utf-8?B?cVRBMTQ1Rmw5NU5ydG9GOFBuekNsYzlWeldnWDI3dlpBaFJJTVh6M25Pbys1?=
 =?utf-8?B?V1I3Rk9rMi91dlBHODZwU1ZrUDNoZkpTZEJnSUFEaFZ4cUdqckc3b2haZEhu?=
 =?utf-8?B?ZTJyWE9hdXpmR0VKZ2h0bDFZelN1OVFYTWM0N2RWeHBtQXRqUVE0UWdueHVY?=
 =?utf-8?B?REFuTFB5V1Z3emhid2YzUytvZ2lQZTFERUo0VnppWml5V09KQUd4MkhjNnB5?=
 =?utf-8?B?NEdobmY5MGlSTldsVFFGU08xTlZSaitXYUpneElaeEZjRkU4U2V1YUd5dGt3?=
 =?utf-8?B?L1dXLzlna1IxR2RqcHlpazB2RHRLM05NSUtLeTd6TjlwNnpYTHlBWW1nSUg5?=
 =?utf-8?B?Skk5QXlKQmFIb2NJOUZLcXk3cWpDYzlSTjJVb1F4RGVEbUFZUkY5U3hzaXJ5?=
 =?utf-8?B?UmxDeUxhRGdCZ3V5ejN5R0tsaVRCQS9pSHJIMXNQK2l2dzVrczhJMERYMVJu?=
 =?utf-8?B?TnN1SGppWjBidmE5MFJNSks1clRZbmhob3lkZTZwT2J4bWFodXFjOUZ3TEVR?=
 =?utf-8?B?azQxQ0srUzdOSHNnVmUxakdmazFZbWtFcjRQWjdNOUY0WE5oUVZRVkg5OVlG?=
 =?utf-8?B?dEhiY2ZOdGRHSENQUG1jRmo2Q2V5NnBQMW9QeWVRRHMxcG42TTkzeklZSVJp?=
 =?utf-8?B?OXc2MHdNSm9hYVZxSzBDMmtLdW9ZWlpnZC9HRnBlT2xIOWtuVlZaNUpOaDAw?=
 =?utf-8?B?ME16c1craXRyV2hwaHFRZXBqZEowSy9QYW5NbVNLVlNrSkp0aDNaSEFFckdt?=
 =?utf-8?B?aDl6aHJtOHhWRzk2UmJTR0VYWTFoT0tzWlg0eC9OY2NTZnQ1U3JBRDNKc0p3?=
 =?utf-8?B?V2hsZHJkdEgzNEl1RDc5ZWRPRGtwMnh6bnhNMVlQeEtmRW1XU1NHeDl4SXJp?=
 =?utf-8?B?aW9IdG1ja3htL20wYy9CTEFhc0tBVytVK1lnVzhnMy80ZGNuSnNtbWdacDlW?=
 =?utf-8?B?NDZKWnlvUmk5MFg1aGxYSDB6VGJ5M2plRTlLdHZPWlhYREwrdlE1SFpqYXJY?=
 =?utf-8?B?ME4wRUxiRU5IUzVaRWluSE5jNDJkdUZaK25oYmVLeTdpcjhRQWJLT3FjeVUw?=
 =?utf-8?B?dEcvL0kyQjBMV2w5UzBYRWFKTXVZYnp3V2tOdFluUWMrSkNDTzAxc296KzVm?=
 =?utf-8?B?elpDUzFlMXRNL1FiSWFEWGpMNEFaYUUvRkZSZExnanVJZDJpK0o0MzJjdDF5?=
 =?utf-8?B?QnlSYkFhUWpncVFNc1VuMnd1Njh0cW9iWVlZZDJxb25vdGIrc29oVEtLcnBt?=
 =?utf-8?B?OElZUGdHU21GUEl2UW9NaUwyRlVEYXJzMzFkQktXSWFPa1Bvck5qc2dBaUNo?=
 =?utf-8?B?MVB4bE81ME5sQ1ljUlRWdE9MRHRDVi9LWnZjQTJEYUcwUGNXa1FsT2Z5M1kx?=
 =?utf-8?B?RHVaRG05bWNZdnFhNUEzMURGSURBenhQNEN4YWpGaWRMMXIzeGxQVmpIS2Vz?=
 =?utf-8?B?YWFWMlF2cUg2Q3cyNDZJMmtxRGRXR0tEc2NqYzlFMENUaFhaUi8wcGkrMGhI?=
 =?utf-8?B?SzFTaFh4U3Y4Y2k1cG8yUHBmSTZtQXNycVp3cjR6TGkzcGJJN1NaRlNiUi8r?=
 =?utf-8?B?RUE0Y1RWY0UzVDN1OGhzTU5oYWkzbGFEcUdPMkY5TmZ1OXpOQ3JRdTlWNGVz?=
 =?utf-8?B?VkhySlJNVzBSMFNyZEN2SXJGWnl6NHp1dHhUaEdwbWZ3T2k2VERzd0s5Z21y?=
 =?utf-8?B?TlNabFB4czRrNzRFN0ozQjZsUkVoaEQ4SGhidHJLTFh0Qi9oamVkZGp3bHl3?=
 =?utf-8?Q?gZtEE/sCFnKeqqR3WwRdPIRGq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f4bf11-46a1-421b-7a07-08dc26dee5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 06:43:15.9939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gbkz0t5vOedE/wt+qlCHQLl3xNtye+pX9sM3h33s55IdW9Fg0cmaJ0+b5YXPgmkak1uTyZ+LJWOQ2lI7dpA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR16MB6363

SGkgVWZmZQ0KSSBmaXhlZCB0aGlzIGlzc3VlIHdhcyBiYXNlZCBvbiBiZWxvdyBjb21taXQgaGlz
dG9yeS4NCg0KY29tbWl0IDRiZTMzY2YxODcwMzY3NDRiNGVkODQ4MjRlNzE1N2NmYzA5YzZmNGMg
KEhFQUQpDQpBdXRob3I6IEZyZWQgQWkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQpEYXRlOiAg
IE1vbiBEZWMgMjAgMjA6MDk6NDAgMjAyMSAtMDgwMA0KDQogICAgbW1jOiBzZGhjaS1wY2ktbzJt
aWNybzogSW1wcm92ZSBjYXJkIGlucHV0IHRpbWluZyBhdCBTRFIxMDQvSFMyMDAgbW9kZQ0KICAg
IA0KICAgIENhcmQgaW5wdXQgdGltaW5nIGlzIG1hcmdpbiwgbmVlZCB0byBhZGp1c3QgdGhlIGhv
bGQgdGltaW5nIG9mIGNhcmQgaW5wdXQuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogRnJlZCBB
aSA8ZnJlZC5haUBiYXlodWJ0ZWNoLmNvbT4NCiAgICBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjExMjIxMDQwOTQwLjQ4NC0xLWZyZWQuYWlAYmF5aHVidGVjaC5jb20NCiAgICBT
aWduZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCg0KQmVz
dCByZWdhcmRzDQpGcmVkDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogVWxm
IEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0
MuaciDXml6UgMjM6MjgNCuaUtuS7tuS6ujogZnJlZGFpYmF5aHVidGVjaEAxMjYuY29tDQrmioTp
gIE6IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaGFwZXIgTGl1IChXSCkgPHNoYXBlci5saXVA
YmF5aHVidGVjaC5jb20+OyBDaGV2cm9uIExpIChXSCkgPGNoZXZyb24ubGlAYmF5aHVidGVjaC5j
b20+OyBYaWFvR3VhbmcgWXUgKFdIKSA8eGlhb2d1YW5nLnl1QGJheWh1YnRlY2guY29tPjsgRnJl
ZCBBaShXSCkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0ggVjEg
MS8xXSBtbWM6IHNkaGNpLXBjaS1vMm1pY3JvOiBGaXggYSB3YXJtIHJlYm9vdCBpc3N1ZSB0aGF0
IGRpc2sgY2FuJ3QgYmUgZGV0ZWN0ZWQgYnkgQklPUw0KDQpPbiBTYXQsIDMgRmViIDIwMjQgYXQg
MTE6MjksIDxmcmVkYWliYXlodWJ0ZWNoQDEyNi5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBGcmVk
IEFpIDxmcmVkLmFpQGJheWh1YnRlY2guY29tPg0KPg0KPiBEcml2ZXIgc2hhbGwgc3dpdGNoIGNs
b2NrIHNvdXJjZSBmcm9tIERMTCBjbG9jayB0byBPUEUgY2xvY2sgd2hlbiANCj4gcG93ZXIgb2Zm
IGNhcmQgdG8gZW5zdXJlIHRoYXQgY2FyZCBjYW4gYmUgaWRlbnRpZmllZCB3aXRoIE9QRSBjbG9j
ayBieSANCj4gQklPUy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRnJlZCBBaSA8ZnJlZC5haUBiYXlo
dWJ0ZWNoLmNvbT4NCg0KSSBhc3N1bWUgd2Ugd2FudCBhIHN0YWJsZSB0YWcgdG8gYmUgYWRkZWQg
dG8gdGhpcywgYnV0IHBlcmhhcHMgd2UgY2FuIGFsc28gYWRkIGEgZml4ZXMgdGFnPyBJbiB0aGF0
IGNhc2UsIHdoYXQgaXMgdGhlIGNvbW1pdCB0aGlzIGlzIGZpeGluZz8NCg0KS2luZCByZWdhcmRz
DQpVZmZlDQoNCj4gLS0tDQo+IENoYW5nZSBpbiBWMToNCj4gSW1wbGVtZW50IHRoZSAic2V0X3Bv
d2VyIiBjYWxsYmFjayBpbiBzZGhjaV9vcHMsIHRoZW4gc3dpdGNoIFBDUiANCj4gcmVnaXN0ZXIg
MHgzNTQgY2xvY2sgc291cmNlIGJhY2sgdG8gT1BFIGNsb2NrIHdoZW4gcG93ZXIgb2ZmIGNhcmQu
DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIHwgMzAgDQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXBjaS1v
Mm1pY3JvLmMgDQo+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+IGlu
ZGV4IDdiZmVlMjgxMTZhZi4uZDRhMDIxODQ3ODRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1wY2ktbzJtaWNyby5jDQo+IEBAIC02OTMsNiArNjkzLDM1IEBAIHN0YXRpYyBpbnQgc2RoY2lf
cGNpX28yX2luaXRfc2RfZXhwcmVzcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19p
b3MgKmlvDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+ICtzdGF0aWMgdm9pZCBzZGhj
aV9wY2lfbzJfc2V0X3Bvd2VyKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCANCj4g
K2NoYXIgbW9kZSwgIHVuc2lnbmVkIHNob3J0IHZkZCkgew0KPiArICAgICAgIHN0cnVjdCBzZGhj
aV9wY2lfY2hpcCAqY2hpcDsNCj4gKyAgICAgICBzdHJ1Y3Qgc2RoY2lfcGNpX3Nsb3QgKnNsb3Qg
PSBzZGhjaV9wcml2KGhvc3QpOw0KPiArICAgICAgIHUzMiBzY3JhdGNoXzMyID0gMDsNCj4gKyAg
ICAgICB1OCBzY3JhdGNoXzggPSAwOw0KPiArDQo+ICsgICAgICAgY2hpcCA9IHNsb3QtPmNoaXA7
DQo+ICsNCj4gKyAgICAgICBpZiAobW9kZSA9PSBNTUNfUE9XRVJfT0ZGKSB7DQo+ICsgICAgICAg
ICAgICAgICAvKiBVbkxvY2sgV1AgKi8NCj4gKyAgICAgICAgICAgICAgIHBjaV9yZWFkX2NvbmZp
Z19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tfV1AsICZzY3JhdGNoXzgpOw0KPiArICAgICAg
ICAgICAgICAgc2NyYXRjaF84ICY9IDB4N2Y7DQo+ICsgICAgICAgICAgICAgICBwY2lfd3JpdGVf
Y29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJfU0RfTE9DS19XUCwgDQo+ICsgc2NyYXRjaF84KTsN
Cj4gKw0KPiArICAgICAgICAgICAgICAgLyogU2V0IFBDUiAweDM1NFsxNl0gdG8gc3dpdGNoIENs
b2NrIFNvdXJjZSBiYWNrIHRvIE9QRSBDbG9jayAqLw0KPiArICAgICAgICAgICAgICAgcGNpX3Jl
YWRfY29uZmlnX2R3b3JkKGNoaXAtPnBkZXYsIE8yX1NEX09VVFBVVF9DTEtfU09VUkNFX1NXSVRD
SCwgJnNjcmF0Y2hfMzIpOw0KPiArICAgICAgICAgICAgICAgc2NyYXRjaF8zMiAmPSB+KE8yX1NE
X1NFTF9ETEwpOw0KPiArICAgICAgICAgICAgICAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlw
LT5wZGV2LCANCj4gKyBPMl9TRF9PVVRQVVRfQ0xLX1NPVVJDRV9TV0lUQ0gsIHNjcmF0Y2hfMzIp
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBMb2NrIFdQICovDQo+ICsgICAgICAgICAgICAg
ICBwY2lfcmVhZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRF9MT0NLX1dQLCAmc2NyYXRj
aF84KTsNCj4gKyAgICAgICAgICAgICAgIHNjcmF0Y2hfOCB8PSAweDgwOw0KPiArICAgICAgICAg
ICAgICAgcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tfV1AsIHNj
cmF0Y2hfOCk7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgc2RoY2lfc2V0X3Bvd2VyKGhv
c3QsIG1vZGUsIHZkZCk7IH0NCj4gKw0KPiAgc3RhdGljIGludCBzZGhjaV9wY2lfbzJfcHJvYmVf
c2xvdChzdHJ1Y3Qgc2RoY2lfcGNpX3Nsb3QgKnNsb3QpICB7DQo+ICAgICAgICAgc3RydWN0IHNk
aGNpX3BjaV9jaGlwICpjaGlwOw0KPiBAQCAtMTA1MSw2ICsxMDgwLDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBzZGhjaV9vcHMgc2RoY2lfcGNpX28yX29wcyA9IHsNCj4gICAgICAgICAuc2V0X2J1
c193aWR0aCA9IHNkaGNpX3NldF9idXNfd2lkdGgsDQo+ICAgICAgICAgLnJlc2V0ID0gc2RoY2lf
cmVzZXQsDQo+ICAgICAgICAgLnNldF91aHNfc2lnbmFsaW5nID0gc2RoY2lfc2V0X3Voc19zaWdu
YWxpbmcsDQo+ICsgICAgICAgLnNldF9wb3dlciA9IHNkaGNpX3BjaV9vMl9zZXRfcG93ZXIsDQo+
ICB9Ow0KPg0KPiAgY29uc3Qgc3RydWN0IHNkaGNpX3BjaV9maXhlcyBzZGhjaV9vMiA9IHsNCj4N
Cj4gYmFzZS1jb21taXQ6IDU2ODk3ZDUxODg2ZmE3ZTlmMDM0ZmYyNjEyOGViMDlmMWI4MTE1OTQN
Cj4gLS0NCj4gMi4yNS4xDQo+DQo=
