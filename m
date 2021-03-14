Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC545C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FEA64E7C
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 22:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCNW1N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:27:13 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:60193
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhCNW1C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 14 Mar 2021 18:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6pNExTxMjPxrDy706pCI6EBMdhyGC1YnjlvSQFozuJSRuB2T0nmtCXSfXI0BBECi0UndhKWPm63TquurWSIDbHBcptuMzm5iJ4vDazXUs3/abYEeeibo1YOTKHuUsEp6A3qGueSOFD2koIjyZ76nlJY3NH9YdBE9zm2/xlNERj+Li6lt88bjvV5TkvblzSJ5CYIxZRyB+N8TPCL6hopBfrODTFj557GSfYblUjOyjAVF45Sdjzl/Og2CQ8o+OAzbcJragWSRX3uBTzWGHDJE7NQw1NVm05NFgKdThlweirp5GcDqu1O56uDQflZqPFon/k34JNWlodlBZRMCkjVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdMMEjbkNU51+dxbGPA90jLAp00MUDsWsWvTXbej79I=;
 b=PNLgT2JwztB1q4l8A0BjF9jz/uMjItZP1TGmp/oflD/HmWH2SuKunFLLAZX6EFSn7LNri6AB/YMnYovtkxMZVV2f1VZjV5Qf8C5WG08tNyIgmJ43wxMO/fmiC19cF9xloLHYApEqDtQWL3udlEW+tnj0RyrK7LKEjR8uz3IL5M27VTLdqTOPHqLFmrNp41f2W0kHqhHvmlRUsDQE5NftIUorbgxNwDjJ4DWfqUElVCVcRe5rmA+r7GPyumsUZ51m7ruhop5XwmCmec958x29Br3hWzCeqWxARlcbJgBWA3D2oXL5mIOilDUi1HCFrW76ndhkjOH9SyYLqbmY2S079g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdMMEjbkNU51+dxbGPA90jLAp00MUDsWsWvTXbej79I=;
 b=PbUCWfvPc3Fx5t53Vdjk2Ey8QfeqnaQ64RhRbNHxp8G3MqnUqBhOyV2cJN48zA6osJnTi150MfZtr40KgEet3KoqsD8ks18u+z+GdhEbTdLxErm3LPnYp7ZghbuK8bbQsEQqZpiqiHrN3/w5O9BR1hjzk1EkBKekRnJXehLFgP4=
Received: from BN7PR08MB4753.namprd08.prod.outlook.com (2603:10b6:408:29::20)
 by BN7PR08MB5234.namprd08.prod.outlook.com (2603:10b6:408:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sun, 14 Mar
 2021 22:26:59 +0000
Received: from BN7PR08MB4753.namprd08.prod.outlook.com
 ([fe80::452c:a304:d1fa:d8b]) by BN7PR08MB4753.namprd08.prod.outlook.com
 ([fe80::452c:a304:d1fa:d8b%6]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 22:26:59 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Luca Porzio <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Zhan Liu (zliua)" <zliua@micron.com>
Subject: RE: [EXT] Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
Thread-Topic: [EXT] Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
Thread-Index: AQHXFD1kxo7HSz9GdEi2zkgSoP/e9ap7pNsAgAAp0QCACEkS4A==
Date:   Sun, 14 Mar 2021 22:26:58 +0000
Message-ID: <BN7PR08MB47536B73AD16A2B7EA040631DC6D9@BN7PR08MB4753.namprd08.prod.outlook.com>
References: <20210215003249.GA12303@lupo-laptop>
 <CAPDyKFqy5z3a5sCXM8BCrhWQgNCUuOGc4VoOBqVwXnHZSdQaxQ@mail.gmail.com>
 <CABhGgDPpUXPHJ49E_ku5N-fO=GWZKTdQQUGugAruG6y2=J1YgA@mail.gmail.com>
 <CAPDyKFri_6G2M7iP-p9Z2b-DmGgWtvndjosxpLRk0fNsuDhCtA@mail.gmail.com>
In-Reply-To: <CAPDyKFri_6G2M7iP-p9Z2b-DmGgWtvndjosxpLRk0fNsuDhCtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-03-14T22:26:56Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=f66c43b7-7576-4d89-8b5c-3c038c105621;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=micron.com;
x-originating-ip: [165.225.203.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f92455a-0834-41aa-1748-08d8e738489c
x-ms-traffictypediagnostic: BN7PR08MB5234:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB52347730F14BCD89C46E021ADC6D9@BN7PR08MB5234.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFXYCvZUp/2mmsNfRyJ3cfTABddik784X6VrQX2kf6KJoWB4dx/52L0G6STBdTXy12nXCeWQxfwRilrcM42vQOspcr0bWY+U/GAAVAtobQYnuJmvSNVnHtWmkXPMHEN/H/PZvktlh0D7fSNJPfnc7o+8A9FAt1VcqJIbFKP12f/fYGJGIkTgoaLeufZde1TDIPU04WJdY485FvMXuJTnILP/86plrSERFalECrhlSq2BWcbMLQuxSiAP7Sraj7pfZbIg5rKpdeIenWo75HAV+E5UC2iDi6EV/eJkUOnjJzcLopHK26NqFjpGOL1n1LL+JeOz/0Y67mRreVpO8qZPCEdO8JRVcasLJ83lo6iuf+5MHty4G4ahCVyNix6Lsi8blKx6XPEFZdAUBWHxnbrBZuz3NMhemvH4JbAwLKEXfi/gW0tA8JXLTGiFCklDQKzxKVKBYQunr3IMHXpprYZlYdgmk7fkVjMoI2ClvBWe6o1NtlBXNOkDUpn2htTUeJ3DfdNQ46xPPo02u4xBgbNC4x6S+QMrJ8DQDbUY5LAjAcs543r4F19CQ6EeOM2ogw+3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB4753.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(186003)(55236004)(4326008)(26005)(66446008)(107886003)(9686003)(55016002)(76116006)(66556008)(6506007)(66476007)(66946007)(5660300002)(52536014)(316002)(54906003)(110136005)(478600001)(2906002)(7696005)(8676002)(8936002)(64756008)(86362001)(83380400001)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R2p0ODNkZE0yR3QwaU5teFJwQkZJQUhpZFk3OVJHbXlKYWRZWGg2NGo0dTBr?=
 =?utf-8?B?NUVIYW1JMVdVVCtKK0FNRFUxOHJpQ0ltYUs0Y0sxSFNmU1ExSXcvNWw0M1ZB?=
 =?utf-8?B?clJLbktYYXRXSzl0Z2JOanBla0t5WWtqa0k1YndJQXlyVGlWUVY5eldXMm45?=
 =?utf-8?B?WE56TnpZWmpaeGQyeUtUM3ZlelNkTFlWQVpZZGpReklTUHNsQVBBem53RG1l?=
 =?utf-8?B?STlrMTFBUWNmL2d1M3pTWHNrM3pMYmpSRmRtTUhuaHRrT3F6TlM4ZkNySjlj?=
 =?utf-8?B?V0t0a3BJL1FPRHhlYmx0VFltQjM3SElrTUtkaHZwRXpVanozRWpOTjZBRjlJ?=
 =?utf-8?B?dmtWSUhZeDhjZG9uMk1YaHIwK2pYaEhlMm02cnd6L0hLYjZjZ0VRUHl2TnlV?=
 =?utf-8?B?MERqaExHVUQ2K0ZnWHFERU5QbHBaZmVycStiUlZmU3Bralk0U3RnOFNTbloz?=
 =?utf-8?B?TU9KR1VrcDY4cU5DcFE0WGpaTE42MnduelZDazcvTjNIWXlHcFNDVW5HRnpi?=
 =?utf-8?B?RTIzaTFPUkhyYnIxcmpPQXUvcjRZRVRVWWtMRXAzWU81MEJ1TGViZUpadnls?=
 =?utf-8?B?bkdNa1BOZE0zYjFzQ1VtVkt3NVVDMWJ2amtORWVGWC81RnkrVytJUWlab3Fh?=
 =?utf-8?B?bFBYRndVQzRuTXRMS1d0VG4zSnJlcWFCaVNVWmpvOVZ0ZVJhNStZTnJ6RmFi?=
 =?utf-8?B?eHlsZXY4d2tsVDBMaTRWZVZzWGRhbllhSVc1U0p4NEtBbG9YWDJlRC92QWNq?=
 =?utf-8?B?RXFHT2N5ZFNyQXdPbXNsNFJycGUzQXFXVFFSUGcyeWVYTWpOaTFLSk9ZMHk4?=
 =?utf-8?B?THBPMlYrcHcxKzAyaU0rQkRPRmo2UXd2UHMyb0t2VkNnT2NsMk11TTMxcnRC?=
 =?utf-8?B?MXRLWGpBbUxUYTZUa3ZlLzlHWGdrYXBwSU1mRk85WG9adzNUWU1QYTdlSFhH?=
 =?utf-8?B?MmZ4eC9GRGRnWXpBUEFMbWxVRzNRVUphOURWNGFZVXJDd0g5QXNTYk9XNkpt?=
 =?utf-8?B?R3NKdDJJZXBUYXp4S2lTckVZR2JseUpUN2toSEJRSUdWS2dRL0l0VFZpcWE4?=
 =?utf-8?B?QW1Bck9lSWFKYm5CUGVEK3pSYnhTbmEvYVgrdjl6ZnJwd2t4NjBveEhoZW9j?=
 =?utf-8?B?dGIwZFhMeEZhRittaHZvL3pHeWdhUlc2Uk1qeEUzR2RWclZ4Mld6V09iNXFN?=
 =?utf-8?B?ZC90ZUQ2ZEl5azBFZDY1WWRaenF5NEt0Q0pTWHRWL3Q2MGtWMXlBb0dxWmxS?=
 =?utf-8?B?YTEzMEpHL3l5WjgyNE5yczFFNFdVcmNKN1lzc3dqV3N0NzhJM1JucGs0ZW55?=
 =?utf-8?B?MjFNRTVON3VIK0g1a0xMTUZZek9VZ1JEeTdJdWx2UXNLSkJNWnZsdVEwNGc3?=
 =?utf-8?B?dXZzK3NGM2o5R3JXQnlUQVloS2pHZlpyTTlZMGlteTQzZWY4S2FwNlVqbk5J?=
 =?utf-8?B?eS9VY0lYVlFDZ2wrcDB6U0R1OUJ1RTYvZ3d3R3FVZVUyMkRVZWsrcDQwMTB0?=
 =?utf-8?B?Q3pRcEY1aDd4dkVWdDR5VVk0bG1XL3o4V2VHa01haG1pRi9pcHZ2NkJIRWVS?=
 =?utf-8?B?YlQ4MFFZdVgrUEdrS29HcFN6R3RFWWF5KzZtQmw1eklMVERSSW9wN1lLd3o3?=
 =?utf-8?B?WlpTOWgzZjkvV0pWcnpsTFRlRU9ObWJ6MWtKMkc5aC9TdU14VVJQUnJPOHBp?=
 =?utf-8?B?YnRHaG0zZVRWdk5uT1RBZmp1bEFLMVZCS0h5Q2FmeFMyNkpnMnY2OXl4RUN4?=
 =?utf-8?Q?NlmIHbP00pwAb6rRgK45+y6XpWA+ViKRs3Sjg8x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR08MB4753.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f92455a-0834-41aa-1748-08d8e738489c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2021 22:26:58.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VOs1LBbFv/YqsQIAjGX2kdWLsVSbD6T6B+hefuqtkrbzHheU1MEAjIVXSyUvirxFbiu7n3FjDSEgxOlikKF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5234
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TWljcm9uIENvbmZpZGVudGlhbA0KDQo+IA0KPiBBcmUgeW91IHNheWluZyB0aGF0IHdlIG1heSB3
YW50IENRRSB0byBzdGF5IGRpc2FibGVkIGJleW9uZCB0aGUgRkZVDQo+IHByb2Nlc3MsIHRvIGFs
bG93IHRoZSByZWJvb3QgdG8gYmUgY29tcGxldGVkIHNhZmVseT8NCj4gDQoNClllcywgaXQgaXMu
IEFsc28gdGhlcmUgYXJlIHVzZSBjYXNlcyB3aGVyZSByZWJvb3QgaXMgcGFydCBvZiB0aGUgc2Vx
dWVuY2UgDQplLmcuIHRoZSBmb3JjZV9kaXNhYmxlX2NtZHEgZmxhZyBmb3IgdGhlIHRlc3RzIGlz
IGEgZ29vZCBleGFtcGxlLg0KDQo+ID4gQWxzbyB3ZSBuZWVkIHRvIGNsYWltIHRoZSBob3N0IHRv
IG1ha2Ugc3VyZSBhbGwgdGhlIHBlbmRpbmcgY29tbWFuZHMNCj4gPiBpbiB0aGUgcXVldWUgYXJl
IGNvbXBsZXRlZCBzdWNjZXNzZnVsbHkgYmVmb3JlIGRpc2FibGluZy4NCj4gDQo+IFllcywgb2Yg
Y291cnNlLiBJdCBzb3VuZHMgbGlrZSB5b3UgbWF5IGhhdmUgbWlzaW50ZXJwcmV0ZWQgbXkgcHJv
cG9zYWxzLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgbm90IHRoYXQgd2UgbmVlZCB0byBjbGFpbSB0
aGUgaG9zdCwgYnV0IHRoYXQgeW91IGFkZCBhbg0KPiBlbnRpcmVseSBuZXcgcGF0aCB0byBkbyBp
dC4NCj4gDQo+ICpJZiogd2UgY29uY2x1ZGUgdGhhdCB3ZSBzaG91bGQgYWRkIGEgc3lzZnMgbm9k
ZSB0byBjb250cm9sIENRRSwgd2Ugc2hvdWxkDQo+IGNyZWF0ZSBhIG1tYyBibGsgcmVxdWVzdCBm
b3IgaXQgKHdoaWNoIHdpbGwgbWFuYWdlIHRoZSBjbGFpbSBmb3IgdXMgYXMgd2VsbCkuIEkNCj4g
c3VnZ2VzdCB5b3UgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHBvd2VyX3JvX2xvY2tfc3RvcmUoKSwg
d2hpY2ggc2hvdWxkIGJlDQo+IHRoZSBlcXVpdmFsZW50IHRvIHdoYXQgd2UgbmVlZCB0byBpbXBs
ZW1lbnQgaGVyZS4NCj4gDQoNCkkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGFuZCB0cnkgdG8g
cmV0aGluayB0aGUgcGF0Y2ggdGFraW5nIGluc3BpcmF0aW9uIA0KZnJvbSB0aGF0Lg0KDQo+ID4N
Cj4gPiBJIGNhbiByZXRoaW5rIHRoZSBwYXRjaCB0byBpbXBsZW1lbnQgYSBzcGVjaWZpYyBpb3Rj
bCgpIHJlcXVlc3Qgd2hpY2gNCj4gPiBkaXNhYmxlcyBDTURRIGlmIHlvdSB0aGluayB0aGF0IGlz
IGEgYmV0dGVyIGltcGxlbWVudGF0aW9uIGJ1dCBpbiB0aGUNCj4gPiBlbmQgaXQgd2lsbCBzdGls
bCByZXF1aXJlIHRoZSBob3N0IGNsYWltLg0KPiA+DQo+ID4gQW55IGZlZWRiYWNrIG9yIHN1Z2dl
c3Rpb24gaXMgYXBwcmVjaWF0ZWQuDQo+IA0KPiBUbyBiZSBjbGVhciwgSSBhbSBub3QgcHJvcG9z
aW5nIHRvIGFkZCBhIG5ldyBpb2N0bCBmb3IgbW1jLiBUaG9zZSB3ZSBoYXZlDQo+IHRvZGF5LCBz
aG91bGQgYmUgc3VmZmljaWVudCBJIHRoaW5rLg0KPiANCj4gSG93ZXZlciwgcmF0aGVyIHRoYW4g
YWRkaW5nIGEgbmV3IHN5c2ZzIG5vZGUgdG8gY29udHJvbCBDUUUsIHBlcmhhcHMgd2UNCj4gY2Fu
IHBhcnNlIHRoZSByZWNlaXZlZCBpb2N0bCBkYXRhIHN0cnVjdHVyZSwgdG8gZmluZCBvdXQgaWYg
dGhlDQo+IGNvbW1hbmQvcmVxdWVzdCBpcyBmb3IgRkZVIGFuZCB0aGVuIHRha2Ugc3BlY2lmaWMg
YWN0aW9ucy4gQWxvbmcgdGhlIGxpbmVzIG9mDQo+IHdoYXQgd2UgZG8gZm9yIG1tY19zYW5pdGl6
ZSgpLCBmb3IgZXhhbXBsZS4NCj4gDQo+IEFub3RoZXIgb3B0aW9uLCByYXRoZXIgdGhhbiBwYXJz
aW5nIGlvY3RsIGRhdGEgZm9yIHRoZSBGRlUgY29tbWFuZC9yZXF1ZXN0LA0KPiBpcyB0byBhbHdh
eXMgdGVtcG9yYXJpbHkgZGlzYWJsZSBDUUUgd2hpbGUgcHJvY2Vzc2luZyBhbiBtbWMgaW9jdGwg
cmVxdWVzdC4NCj4gDQo+IFdvdWxkIHRoaXMgd29yaz8NCj4NCg0KSSB0aGluayB5b3UgYXJlIHJp
Z2h0OiB3ZSBzaG91bGQgYWx3YXlzIGRpc2FibGUgQ01EUSBmb3IgYWxsIGlvY3RsIHJlcXVlc3Rz
IA0KYXMgb2YgdG9kYXkgSSBkbyBub3Qga25vdyBhIGNhc2Ugd2hlcmUgQ01EUSBvbiBpcyB1c2Vm
dWwgZm9yIG11bHRpIGNtZCBsaXN0cy4NCg0KV2hhdCBkbyB5b3Ugc3VnZ2VzdDoNCjEgLSBtaW1p
YyB0aGUgcG93ZXJfcm9fbG9ja19zdG9yZSBhbmQgbGV0IENNRFEgYmUgb2ZmIGFjcm9zcyByZWJv
b3RzDQoyIC0gZGlzYWJsZSBjbWRxIGZvciBtdWx0aSBjbWQgbGlzdHMNCg0KSSB3b3VsZCBwcmVm
ZXIgMSBiZWNhdXNlIGl0IGNvdmVycyBtb3N0IGNhc2VzIGJ1dCAyIGNvdWxkIGJlIGFuIG9wdGlv
biBJIA0KY2FuIGludmVzdGlnYXRlLg0KIA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQpDaGVl
cnMhDQogICBMdWNhDQoNCk1pY3JvbiBDb25maWRlbnRpYWwNCg==
