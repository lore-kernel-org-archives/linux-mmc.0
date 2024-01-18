Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668D1173D
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jan 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567962; cv=fail; b=VNZRa70/tBuXd+/iXgc++m3T1h6WWoGpbwAkSPXgBdxxdMmvoYgBOH5vDmfwPbjhqmoNuqxHkcSkiTmgfC46jg+OUTsH9HYTaLLqislmQCajfXxq/TCjczxgbbSHjU9t++1A3VpLhtRhDCrZVnUnbSOwGXXPbFIcJTe7UfpVT0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567962; c=relaxed/simple;
	bh=WNO4FsbBwRKnSS6UAeq0C5PZBrQyJP2zK+IA5Zg/46Y=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NtgO1yCK8v6ictZgKehGnkZAFHUdmQN49OzHlJH9nvCq3Apq3VvwAPQmM2K58R4nW88noyz/Zyd94TFWRHrEMzvNowm2nxIuf/lFS2sIstcdwz78YuiqGw2FnI5xzIxcLZVRnIh5KmqAP4Wlt33KzS3CBPm4mkbRi7f6/Xdf0Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com; spf=pass smtp.mailfrom=bayhubtech.com; dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b=v69mPV4r; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="v69mPV4r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8QDvxdo7sOviOQQC5wREI1yPXBq3nMfNc2MNbW8VehrDAsIIAUeh18ardzmza2L0nM8lto483v/qwG95xPYx53SRC4xdhcXTiAGZeoI9N6P7ofL1RSnTLUz4wDkah3bgkgkg6EoirwaoV4Mt+ADzKRSWVEHyDC08TVuvbpyKQyH/Uq1Sqr0/OFfSIlpEMk7Kjrd2qAQxL/tDpTIUqqKXzE7jCqoDbJYTBad6d04SXxcYtC/AVBsoSIOVTPBbvdW5wjm7hK6PxNc5/nyjkAC+O55bxzUYO4bsrcsaQ92OHtLCU4rR9u7t2bTl6h27+yD5f/AE/CSSyDjfXo6YdPaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNO4FsbBwRKnSS6UAeq0C5PZBrQyJP2zK+IA5Zg/46Y=;
 b=MzgewQUVj/gRL1TMbaGXcs9ci27VqTaqVNtKe463XgX0ZUG1apQF46MSJVPs5JS9RFHhC1xJFcoJwLHYhPYn0OsGLY8spuEhh1rbdlJ/fbvTz4hXPESxGJKn0M6c8rn8eybGlkEPLMTYW0Ozbee4AGZ7tl5j8DE+gqb84eiPRVrhWuW6i2QKNvi2Wy1Z/pDn/768iEk/lZuN5aoKFCKC+rqdV2gz9IWx6u88pdis83Io3KOExPDgy4nZKwA0pEzRTdtvnN+t4crZkf3JXx/sdKdQTLEBWorKH3AZaH6EwscIHBiEpShvE435poMJaYhb9NYtNyOljqqooFejcrsmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNO4FsbBwRKnSS6UAeq0C5PZBrQyJP2zK+IA5Zg/46Y=;
 b=v69mPV4r8nK8KihfvjZ1PiWfezIRMEnFIUy9eC7gElsAoufYIdbuoLmMhvyGXAk83Cg1D/ojpFbDBIr1vbbcce1eD2nsWUlKUvRmW+YMM/5a8DGj3/qNXKo6eT6yCAlPxSbrWpEyfKmpbbyaMpm4F2B56BKObqdh5Lx9cQzFbJ4=
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 PH7PR16MB6274.namprd16.prod.outlook.com (2603:10b6:510:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 08:52:36 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::17e9:205d:e39b:6666]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::17e9:205d:e39b:6666%5]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 08:52:35 +0000
From: "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Brent Roman <brent@mbari.org>, "Fred
 Ai(WH)" <fred.ai@bayhubtech.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
Subject: RE: Regression in sdhci-pci-o2micro.c
Thread-Topic: Regression in sdhci-pci-o2micro.c
Thread-Index: AQHaST9IjbpbGMqfpketvTJRtpDhGbDe6wLggABW2CA=
Date: Thu, 18 Jan 2024 08:52:35 +0000
Message-ID:
 <DM4PR16MB50041AB09DA48C7FB8C41C57EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
References: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
 <CAPDyKFqsRounzo1Ns0dDdCS9Qu0doq82ivYwEUNWgOiMtDS0Xg@mail.gmail.com>
 <DM4PR16MB50049CE307E3B479D80EFD95EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
In-Reply-To:
 <DM4PR16MB50049CE307E3B479D80EFD95EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR16MB5004:EE_|PH7PR16MB6274:EE_
x-ms-office365-filtering-correlation-id: 6959909e-7a01-4383-016a-08dc1802d12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TaeVe39k60ncuIDvf5RKtptSK080mVjOM0bXdZLkgt2EEEw5yYVIxG/dcesndhVUWUsdROau/d6ga9ppZj1jwAtDvshLJlqkfKboLsjxe8YjJYDJyzEc/euLH3EGrGhwvOtYW66NhYUvkc7u3qXWmWbfJaFwREo7bFpuZBDXvVTfdSdUGGp2RN9lF/PNDiyrK3NYZ0VzdJ1TDXJYV2SbGePGOFL6RonLLHythEkkgZ0Vb/ECtYO9O5xzabipU1dwIhtycWj+KFYV0m9dy12RcNhMUen+xs7Plid8YUn2PTAqHJGT/arLuuLfsbXA+BxSkiw/3czzpE8ntOQSC/gzsrHqoCqEEVYP5lSt4TkID/k5o6ncOoNmzRg2r4NAD+kZxmC2a7wdmfXWj0vlJPS7yBGbPL+OO1JtwzCmlhB42eYij5FAtujhAWYxjYFRurTwlmvgPKYHIde3/bMGiA63YXEMYURWHLRCiItd57HCChYJ58NHQTJSnx5hV+6Uvo7NELUkr1VOU/IBE1SlfJKmJkksctGlbNmSld5YTzegmL1DEnPydHIE25zYPwTmTkGGo/stkCsQZk0Gpc/VeHIqDQ8TX5SXgou2tYHx8i1ztwbve9edRsSxBVfOy36BCUNT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(52536014)(5660300002)(2906002)(478600001)(71200400001)(9686003)(6506007)(53546011)(66446008)(66476007)(66946007)(64756008)(6636002)(66556008)(76116006)(110136005)(54906003)(316002)(8676002)(8936002)(41300700001)(66899024)(7696005)(2940100002)(38100700002)(122000001)(86362001)(33656002)(26005)(38070700009)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFRYbTA5aXc1Vk9CZ2JmNnRySzBWK2hDNUpPWGp3RGhMei92UnlDbWp5aTBB?=
 =?utf-8?B?MnNKK2VZZzdqYVZLeGRwaGRHeUZtRWF1VkUzS000VUUweFFJYXpaUXFmVTdN?=
 =?utf-8?B?SnY0KzQyTHk1ZFZFY1NQaUFXOWJiOVRqNGI2MUJoWDFLc24wVzhTSzlPdnJr?=
 =?utf-8?B?L3IrdEg4WGpRSEZFYWJlZkhRWUV2b2ZDcHgyY3hOblFYYVl3YWVGRVNpVjl2?=
 =?utf-8?B?ZEJ1RFhDWXZsNkY0Nzk3Ni9RY0crcmxiYkxzZEJmOVg1MjFPSTIyNXZEVURP?=
 =?utf-8?B?NjlvNUk1bHJVdTF1SWR5TnVnODNHTVBhbVliYndPUFJEbkxPQnhnc0ZmMEZB?=
 =?utf-8?B?a2R0VkdSL3dPaGZKcHFKd2NiL3dpKzJEWkt1V1NHSTRjcS9JRmM3Vy9lMjRU?=
 =?utf-8?B?Z204OUQ4ODZvWEV4ZnRIcm5RdDVuRG1paEM5bjBIZ0FTT3JTZlhkdEFibFVl?=
 =?utf-8?B?VFFGd2I5d0ErRXNzR3RaMk9VUnJHMlFxRHBNeFpwZzc3N2RQM1doY1laL2JN?=
 =?utf-8?B?cmE3NmZ0UUp1UERuaXNYRy9qNm5yd0pmeXdkNTMzMTJSOW9RU2VkZTdPQ2JG?=
 =?utf-8?B?VnJKaFJKYnNQeU11NVNRbEtXMWE1REF5c1Flekw1ZFNIc09hbWs2SjNaTVZQ?=
 =?utf-8?B?UWFMdk5sRm5McmlibGc2RnMwR2lxVzZ1UzNqRG81M3RNMm5vazJ5TjFsSlU5?=
 =?utf-8?B?cTBxSEkrZzNwWitxdVkvRWV6MzZ2QVRRTkZPY2ptMWpYdE9RazM4NzkwbVp3?=
 =?utf-8?B?cXlQRlRxNTBrV2JGamJCclFLdG1VdzBsSmV3ZEFhZTFnUkpwL3ZzSTUyUm9F?=
 =?utf-8?B?bzdrYS9NN1VISkJIVnkzR3hMdk9sR096NmRoTmNJcUFBcWJmdTFaUEFRb2pM?=
 =?utf-8?B?OXBrMlo0a1BMb3YwUWowVlB5ZkwvODNqeHlqdkZzRGN5aUlWM3BMakpuc3BD?=
 =?utf-8?B?aWNwTU9MVS93TGoxT2hIZUo3dDhiT3dManVIME1mbkppU0dqODR6dzVta0JO?=
 =?utf-8?B?WWhRRXJqYUR2NGYxem1QVzI1eHVKNXVleVQ5eHhwSWVDcnlCcnhNQ21wM2tI?=
 =?utf-8?B?WmFjVkI3VEZVd1NaN1VHL2VCZzFuOVEvZ0o0alQwVkI2U3JaUG1xZXg4TUFw?=
 =?utf-8?B?RVlKSDVxSjlFUk1VNGFZWHRVdzRGcG5yUk4vemZIWU9sZk9yV0lHY3JrbFRV?=
 =?utf-8?B?UkRKbkRZQjFkVTFwMmdmTHpzcFQ3RWJNQ0FLeXo1WjZFZTNsQjJISW9yM3BJ?=
 =?utf-8?B?MmJjQ1B1NlB0eUFoOUZ2S28xZ2Z5S00xS2drMXRYaVJSVnJveU11c0JPcjR4?=
 =?utf-8?B?ZXhkd213aVF4Wkx5QmF6czFPN002RHo4bGtTZWFJdjF4WDJPWjIzZ2hFV29Q?=
 =?utf-8?B?M2RiV2daMGxjaUtvQXhycHprb0pyNEdBRTBleVZhZ2lzUE93VEIwQXRmbUlQ?=
 =?utf-8?B?NEQ2ek1JbzNNSnh1V2xiSWw0MG5EeTB0NEZTTjlzWU9LK1N0eUFUaXlRWCtC?=
 =?utf-8?B?YUtGMmlMSGhhak9kc1N2K290bWpRcnBJZXNTUUFPc21HYStscTR4RVhneUYz?=
 =?utf-8?B?M1BZUnhYdnF6QWw3YlZvYTdRZnhia1JwUnY5RVVmcHk1bFlIcnBlVTQ4UTY5?=
 =?utf-8?B?bXByR0tjcGQ3dGJSZ3grbmE4ckRNVGFmMFBYdXRmQUQrMWEvOVdBY0NJWmk3?=
 =?utf-8?B?Q1NhT2tXcHFSUit5WHhTNU1ETS9uc0FwTnVwR0prQ0pUbzRNTER0ZTdCOTd0?=
 =?utf-8?B?VFB1Qk1EY2RxV2ZTQWpMZStIdXFWRlIwQis4dHFEQzIrNjN0dUFjRnhDZnRj?=
 =?utf-8?B?ZmVaK1BwSEwwVVM1ZXovZGZlRkdFeEZWVW1DWFdxa1hxa1lxbHNCa2d4M1RN?=
 =?utf-8?B?SEpnOXFLRWZCbXBSdjVBU0c5Q21nNXZPNkdFSHFPRXZYZVBOZ2lFN1M2RnEz?=
 =?utf-8?B?UUF5K1A0OUptbGRZeG9jNDZNVDlWYmdHc1VMS29VUzVhWjdxR0JLS2M2UVpO?=
 =?utf-8?B?dFpyQVBDc1piZ0NoLy9hWjd0Qlc4ZVJsR3lrYkRPcjErQmpWVzV0MDhFMUtJ?=
 =?utf-8?B?NUtVakJXV2J5NzhtTXZnTHF5UXpVNU1JTjZRelZvT1NXT3NQQ3VsbmNYSWt3?=
 =?utf-8?Q?bL2VN9CDkXpYQe6SaqlKZkW/A?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6959909e-7a01-4383-016a-08dc1802d12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:52:35.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8+CaNSRP+Lw9XyU8dECziNlWzx3m7E/OGl+d+wSnuZy2ytdJouhOxcVfnfd//IXNj/UE1xhb2UxRt1yaAbh323loeIu3OoVNfXliNIuNCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6274

SGksIFVsZi9BZHJpYW4sDQoNClBsZWFzZSBpZ25vcmUgZm9ybWVyIGVtYWlsLg0KSSBjb25mdXNl
ZCBpdCB3aXRoIGFub3RoZXIgaXNzdWUuDQoNCkkgYWdyZWUgUmVncmVzc2lvbiAibW1jOiBzZGhj
aS1wY2ktbzJtaWNybzogQWRkIG1pc3NpbmcgY2hlY2tzIGluIHNkaGNpX3BjaV9vMl9wcm9iZSIg
aW4gc2RoY2ktcGNpLW8ybWljcm8uYw0KDQpGb3IgdGhlIGlzc3VlIEJyZW50IHJlcG9ydGVkLCB3
ZSB3aWxsIGNoZWNrIGl0IGludGVybmFsIGZpcnN0Lg0KDQpCUiwNCkNoZXZyb24NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZXZyb24gTGkgKFdIKSANClNlbnQ6IFRodXJz
ZGF5LCBKYW51YXJ5IDE4LCAyMDI0IDExOjUzDQpUbzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29u
QGxpbmFyby5vcmc+OyBCcmVudCBSb21hbiA8YnJlbnRAbWJhcmkub3JnPjsgRnJlZCBBaShXSCkg
PGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQpDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsg
QWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQpTdWJqZWN0OiBSRTogUmVn
cmVzc2lvbiBpbiBzZGhjaS1wY2ktbzJtaWNyby5jDQoNCkhpLCBVbGYvQWRyaWFuLA0KDQpXZSB0
cmllZCB0byBpbXBsZW1lbnQgdGhlICJyZW1vdmVfc2xvdCIgYXQgInNkaGNpX3BjaV9maXhlcyIg
YW5kIHJlY292ZXIgc29tZSBjaGFuZ2VkIFBDUiBjb25maWd1cmUgdmFsdWUgZm9yIG5leHQgcmVi
b290IGF0IEJJT1Mgc3RhZ2UuDQpCdXQgSSdtIG5vdCBzdXJlIHRoYXQgdGhlIGFkZGVkIHBhdGNo
IGluICJyZW1vdmVfc2xvdCIgd2lsbCBiZSBjYWxsZWQgd2hlbiBPUyByZWJvb3QuDQpJZiB0aGVy
ZSBhcmUgY2FsbGJhY2sgZm9yIG8ybWljcm8gaG9zdCBkcml2ZXIgd2hlbiBPUyByZWJvb3QuDQoN
CkF0dGFjaG1lbnQgaXMgYSBzYW1wbGUgY29kZSB3aGljaCBpbXBsZW1lbnRlZCB0aGUgInJlbW92
ZV9zbG90IiBhdCAic2RoY2lfcGNpX2ZpeGVzIi4NCg0KQW55IHN1Z2dlc3Rpb25zIHdpbGwgYmUg
YXBwcmVjaWF0ZWQuDQoNCkJSLA0KQ2hldnJvbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQpTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMTcsIDIwMjQgMjA6MTgNClRvOiBCcmVudCBSb21hbiA8YnJlbnRAbWJh
cmkub3JnPjsgQ2hldnJvbiBMaSAoV0gpIDxjaGV2cm9uLmxpQGJheWh1YnRlY2guY29tPjsgRnJl
ZCBBaShXSCkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQpDYzogbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQpTdWJqZWN0
OiBSZTogUmVncmVzc2lvbiBpbiBzZGhjaS1wY2ktbzJtaWNyby5jDQoNCisgRnJlZCwgQ2hldnJv
biBMaSwgQWRyaWFuDQoNCk9uIFR1ZSwgMTYgSmFuIDIwMjQgYXQgMjM6MTgsIEJyZW50IFJvbWFu
IDxicmVudEBtYmFyaS5vcmc+IHdyb3RlOg0KPg0KPiBIaSwNCj4NCj4gSSBoYXZlIGFuIEludGVs
IEhhZGVzIENhbnlvbiBOVUMgKE5VQzhpN0hWSykgd2hvc2UgTzIgTWljcm8gYmFzZWQgDQo+IFNE
LUNhcmQgcmVhZGVyIGlzIG5vIGxvbmdlciBpZGVudGlmaWVkIHdoZW4gaXRzIExpbnV4IGtlcm5l
bCBpcyANCj4gdXBkYXRlZCBwYXN0IDUuMTINCj4NCj4gSSAiZml4ZWQiIHRoaXMgYnkgcmV2ZXJ0
aW5nIGEgY2hhbmdlIGZyb20gNS85LzIxICAoZ2l0DQo+IGVmYzU4YTk2YWRjZDI5Y2MzNzQ4N2E2
MDU4MmQ5ZDA4YjM0ZjY2NDApDQo+IHRoYXQgaW5zZXJ0ZWQgcHJvcGVyIGVycm9yIGNoZWNraW5n
IGFmdGVyIGFsbCB0aGUgUENJIGNvbmZpZyBzcGFjZSANCj4gcmVhZHMgaW4gdGhlIGRldmljZSBw
cm9iZS4NCj4gVGhpcyB3b3VsZCBiZSBjb2RlIHJlbW92ZWQgZW5jbG9zZWQgaW4gI2lmIDAgYmVs
b3c6DQo+DQo+ICAgICAgY2FzZSBQQ0lfREVWSUNFX0lEX08yX1NFQUJJUkQwOg0KPiAgICAgIGNh
c2UgUENJX0RFVklDRV9JRF9PMl9TRUFCSVJEMToNCj4gICAgICAgICAgLyogVW5Mb2NrIFdQICov
DQo+ICAgICAgICAgIHJldCA9IHBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsDQo+ICAg
ICAgICAgICAgICAgICAgTzJfU0RfTE9DS19XUCwgJnNjcmF0Y2gpOw0KPiAgICAgICAgICBpZiAo
cmV0KQ0KPiAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4NCj4gICAgICAgICAgc2NyYXRjaCAm
PSAweDdmOw0KPiAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwgTzJf
U0RfTE9DS19XUCwgc2NyYXRjaCk7DQo+DQo+ICAgICAgICAgIHJldCA9IHBjaV9yZWFkX2NvbmZp
Z19kd29yZChjaGlwLT5wZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgTzJfU0RfUExM
X1NFVFRJTkcsICZzY3JhdGNoXzMyKTsgI2lmIDANCj4gICAgICAgICAgaWYgKHJldCkNCj4gICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ICNlbmRpZg0KPg0KPiAgICAgICAgICBpZiAoKHNjcmF0
Y2hfMzIgJiAweGZmMDAwMDAwKSA9PSAweDAxMDAwMDAwKSB7DQo+ICAgICAgICAgICAgICBzY3Jh
dGNoXzMyICY9IDB4MDAwMEZGRkY7DQo+ICAgICAgICAgICAgICBzY3JhdGNoXzMyIHw9IDB4MUYz
NDAwMDA7DQo+DQo+ICAgICAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2R3b3JkKGNoaXAtPnBk
ZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9TRF9QTExfU0VUVElORywgc2Ny
YXRjaF8zMik7DQo+ICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICBzY3JhdGNoXzMy
ICY9IDB4MDAwMEZGRkY7DQo+ICAgICAgICAgICAgICBzY3JhdGNoXzMyIHw9IDB4MjUxMDAwMDA7
DQo+DQo+ICAgICAgICAgICAgICBwY2lfd3JpdGVfY29uZmlnX2R3b3JkKGNoaXAtPnBkZXYsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9TRF9QTExfU0VUVElORywgc2NyYXRjaF8z
Mik7DQo+DQo+ICAgICAgICAgICAgICByZXQgPSBwY2lfcmVhZF9jb25maWdfZHdvcmQoY2hpcC0+
cGRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPMl9TRF9GVU5DX1JFRzQsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNjcmF0Y2hfMzIpOyAjaWYgMA0KPiAgICAg
ICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAjZW5k
aWYNCj4gICAgICAgICAgICAgIHNjcmF0Y2hfMzIgfD0gKDEgPDwgMjIpOw0KPiAgICAgICAgICAg
ICAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTzJfU0RfRlVOQ19SRUc0LCBzY3JhdGNoXzMyKTsNCj4gICAgICAgICAgfQ0K
Pg0KPiBCb3RoIHRob3NlIHBjaV9yZWFkX2NvbmZpZ19kd29yZCgpIGNhbGxzIHJldHVybiAtRUlO
VkFMIG9uIG15IG1hY2hpbmUuDQo+IFRoZSBkcml2ZXIgaGFkIGJlZW4gd29ya2luZyBlYXJsaWVy
IHByZWNpc2VseSBiZWNhdXNlIGl0IHdhcyBpZ25vcmluZyANCj4gdGhlc2UgZXJyb3IgcmV0dXJu
cyBmcm9tIHBjaV9yZWFkX2NvbmZpZ19kd29yZC4NCj4gSGF2ZSB5b3Ugc2VlbiB0aGlzIGJlaGF2
aW9yIGJlZm9yZSBvbiBhbnkgb3RoZXIgaGFyZHdhcmU/DQo+DQo+IFRoZSBTRGNhcmQgcmVhZGVy
IGlkZW50aWZpZXMgYXM6DQo+IDAzOjAwLjAgU0QgSG9zdCBjb250cm9sbGVyOiBPMiBNaWNybywg
SW5jLiBTRC9NTUMgQ2FyZCBSZWFkZXIgDQo+IENvbnRyb2xsZXIgKHJldiAwMSkNCj4gMDM6MDAu
MCAwODA1OiAxMjE3Ojg2MjEgKHJldiAwMSkNCj4NCj4gSSd2ZSBiZWVuIHVuYWJsZSB0byBmaW5k
IC9hbnkvIGluZm9ybWF0aW9uIG9uIHRoaXMgY2hpcC4NCj4gRG8geW91IGhhdmUgYW55IHlvdSBj
b3VsZCBzaGFyZT8gIEEgZGF0YXNoZWV0IHdvdWxkIGJlIGlkZWFsIDotKQ0KPg0KPiBBbHNvOg0K
PiBJJ3ZlIGFsd2F5cyBoYWQgdG8gb3BlcmF0ZSB0aGlzIGRyaXZlciB3aXRoIGRlYnVnX3F1aXJr
czI9NCB0byBkaXNhYmxlIA0KPiB1bHRyYSBoaWdoLXNwZWVkIHN1cHBvcnQuDQo+IElzIHRoaXMg
YSBrbm93biBpc3N1ZT8NCj4gT3IsIGNvdWxkIGl0IGJlIGEgc3ltcHRvbSBvZiB0aGUgZmFpbGlu
ZyBwY2lfcmVhZF9jb25maWdzIGN1cmluZyBwcm9iZT8NCj4NCj4gVGhhbmtzIGZvciB5b3VyIGF0
dGVudGlvbiwNCg0KTG9va3MgbGlrZSB0aGUgb2ZmZW5kaW5nIGNvbW1pdCBlZmM1OGE5NmFkY2Qg
KCJtbWM6IHNkaGNpLXBjaS1vMm1pY3JvOg0KQWRkIG1pc3NpbmcgY2hlY2tzIGluIHNkaGNpX3Bj
aV9vMl9wcm9iZSIpLCBtYXkgbm90IGhhdmUgYmVlbiB0aG9yb3VnaGx5IHRlc3RlZC4gUGVyaGFw
cyBhIHJldmVydCBpcyBuZWVkZWQuDQoNCkxldCdzIHNlZSBpZiBGcmVkL0NoZXZyb24gTGkgaGFz
IHNvbWUgdGhvdWdodHMgYXJvdW5kIHRoaXMuDQoNCktpbmQgcmVnYXJkcw0KVWZmZQ0K
