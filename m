Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B3C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A114C6100A
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhDSMrx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:47:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49172 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhDSMrw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Apr 2021 08:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618836444; x=1650372444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
  b=HPe0gqmWQsEEXjXX6sqZlFObTeHaOlg2dyEsyTAbj0YmxchJg52RNUsF
   hUALcpStIryNkszjiCBhHdTo7UqDX9L70+lE+WqRkdvyjBp18nLWh2CSH
   kRz1MvFauXxELbfpsXZFoGyTtJ/vP/laKN9T5PzP+sEvxBTRU91xD7Oah
   Tqz54QZUkkk3S1YjEWJoLl7zYYNtdk1fQrUkNaLGTnpbQw99kNoLbcn+E
   eqgBJDOm0QpUPAJ+tM0mOifEVGTQx2+MMoyIJzLrgWg4yik3mHuGOWtGN
   K0DJnDb/O9T06s+KoGKTrXHngOfxd8oPJSq+6tg96TkoWcGkEydpOkf1W
   w==;
IronPort-SDR: O4cPImjH3g6CrcRK9nJsna2X/yXF9FkokKFb27EYlUhJLS/WemuV8pSqCGZgcBEbF1/6WGHVC+
 xW8L/s8Pan6zimMPy+AZ1t8RUbZbfg8o2zYNKbMxM/ObVm+dio9KRLbrU1Tvef45PkCivqCW7E
 sv14LhXhvFO26pVLJ7DMIaDlbszfvgBFnyTr3jfcWUam+mvMAIzeKpZFM0PXawYes0uCcVJV1R
 vpq+L3i+ZOmAnt0ynXTZIpVPciYyzZ1Z4Vbsi+Sm7zGaToz6cAGzf6FERq4RWE48ooG5t2pME3
 t1c=
X-IronPort-AV: E=Sophos;i="5.82,234,1613404800"; 
   d="scan'208";a="165984945"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 20:47:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7RxFRHH5hYaZkV9XiSvuVQHmewcb0islnpeN6epJSH2HD8EdxEd5JVo1O8YRvkLveUy20nIH/76mXW1IiigW4I9iTHtBpVOgQPVcCAqLFjDrc62D3ozAcT3QF7jZwVNj765WbVGvsJF7RUVBZZwnZjgpRj3e21swKalkRzbfyO1aAg5E9RD6zq5EIrEzV18zpeN5kp+NeFLn6HJ04KI64BMKzJYarnhPj9VFpZhuZQlOJX7F95FmpDBR8oyUFuobNgL8cxtHnsDDNk92JNQ7rQVZbAQ5NP7YN4JbgOtfwvPEN7WPaoZ3E1v8nHQtLZrgUswhHzcCKe/l0JKTFxosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
 b=KCvlRlQ3EC4H1KhOp47Y7m3JuzqV+XwzUMhPoM9m4Q/VB21HIRmW1HZWAU8aTiLxmbpvHzk5WFbj+fHX4hAoaujZhKkdzv5j/8YoCSn9xmMarUPrnch3lgQsf9Gd0mMJcUx5dDh3Uqbqc4U96cePObVoL9q0RPGu4YYrH/S9da7Fiz09y5ZFuheCIBkkTu2c54bqaqJh/VFZ4OHojOAWF4/EiQuTgH5Eb4rB7PIJOBbcjuOhwXHHfui/o6mC8KJCk9z9NsXw12J+Jrn4iYWVjsn6gVmdSI0xuZO28J5MOY7eXlIYJitsDYeQVvsx+adZRrZ/Hym655jLkA2fB2xgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HQsS3Bruuj6QKYVV3SU9tGJ6t1EXfvOhHXxrOarkqw=;
 b=zykK7okq/QedHMHCA0SCAR4uVULnqqM2xYcscBhzFa1tntFp7RmhAgrTelNpy3sNAFgGHRKrqlmDr/9/1iMr/yhm/JceDOaW/8u0MRAscYbYs2VGEz23azMToow/zFGogM2oYhMaBVDziUP17WZhhZEpSNt9kBS1+osXIPrXcqY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5081.namprd04.prod.outlook.com (2603:10b6:5:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21; Mon, 19 Apr 2021 12:47:20 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:47:20 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Peter <bpeter@lytx.com>
Subject: RE: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
Thread-Topic: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
Thread-Index: AQHXNBgiJh9AhyzBkUSbB86oYQKMUKq7ycoAgAACEtA=
Date:   Mon, 19 Apr 2021 12:47:20 +0000
Message-ID: <DM6PR04MB6575351DBFF56CF453D7BB8AFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210418055953.26959-1-avri.altman@wdc.com>
 <20210418055953.26959-2-avri.altman@wdc.com>
 <CAPDyKFqAdXcVO9=26pTbQyzYprax9-_i0T1XMeXTWAYOMAaovw@mail.gmail.com>
In-Reply-To: <CAPDyKFqAdXcVO9=26pTbQyzYprax9-_i0T1XMeXTWAYOMAaovw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fe44560-babb-4751-5d6c-08d90331457c
x-ms-traffictypediagnostic: DM6PR04MB5081:
x-microsoft-antispam-prvs: <DM6PR04MB50813AD72BA86039E5032554FC499@DM6PR04MB5081.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwaXKf/0Z+Tgq8DAho0635upSgomaOkt+nDURDDJ/2B9Za8owGUOKI0K+4WkSk5y9kaaxMhgC2K8zbfyhQ3OD0cicSTrV5CQ4/TGqE0qfP8o9VRVbsNO7SZI647ewqkHyG1+1FZAkQOYvOWsC96B9fmKg35sI6UEfwfPwcp7a2cLHIXAbtaprDbdNivRLCdFon4CjDCJ8do3jOj9sa/04YC4vRK/B0rdE8QejxYQHOGiixcBxRJLpGnI1H9iD2Kx5UfiZJcJg8ECNaHOTygEd+wwBWMUBnsrXiVFTPQMbSiXZBzUd9oTcumqqW7vpm5A801BifNi9inA9yHLohiI5euNEglB/uTSEWeSElS16n/Q/aq/z3NjCumHX5P4f4YDUi78I9ZMEjWRyrT2Dj04uzafX4NbsVLp3A7trmQLo9TECbEbDblvDrrbEVhUrnuR75VVW1RKEh9NURtybUGJ+yJvsQLnMP+qlbz+AJIzlEocw85/QVhfbLCxum8hKCaQVw6rau1lOv0/UaH9ATZo7891zw08QBkXz6vAGKktYCOweo0c1s/HHnScZC7W0GweG66xegBUzK/g7Bef+ah8cyCsy+pgvEx4Vjc8q4t9BAkaanf1ZC5shHEXLiWA+fTByASdD+akFLbLnZxImWAdXs35VvR0ixf13hocNcS3YSBHyI+JQwz83PNO/7GS3gvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(33656002)(6916009)(5660300002)(71200400001)(26005)(9686003)(55016002)(7696005)(66476007)(186003)(66556008)(66446008)(64756008)(4744005)(2906002)(8936002)(966005)(54906003)(86362001)(122000001)(316002)(38100700002)(52536014)(8676002)(66946007)(478600001)(76116006)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Q0dkRHY4LzZTYmdFODZrNFRBMm5GcHVMTDBQL3dCcGdPWVRsRm8zbmZsMHd3?=
 =?utf-8?B?YUI2R3AwZXhuV1I4dExBeDNSNm5HQ0hlZXFNS3A3cC9tYnZBdVlQU3FQK1VL?=
 =?utf-8?B?KzBqNXQ1K05zeGRocUJUbEVHbFZaT1BXVGs0MXNPZ05qN2NrTWh1bWJCWVdt?=
 =?utf-8?B?N2dwNVY4QWdMeDl5WkVmVVlrcFZ1U2VIREtxTk1KV2p5VFJYcU5iLyszdDYv?=
 =?utf-8?B?ZENWUU0zbDhwZlRUYWFHSmQxamZTM1JZWnc4eHNmRDZDM1Bnd0VLN3dXLzcw?=
 =?utf-8?B?MERGbEt1TnBOZGZUODZzNEpaN2UxbXdVbC9CZHFwQWlDQ2NIUzMrL3NIUXMr?=
 =?utf-8?B?RG0rTWxUdWZMY3dxTFFYMVM1T0syaGdsVmY4R3J4SW1FVmZ3elBjejlMWFdu?=
 =?utf-8?B?amdZRWVublhzeVVoU2Y0RitkWjBuWkM1VEplckFUUGtxZyt1RDZyb1ZSTENn?=
 =?utf-8?B?NjhSRFdpZXBBWlJSWFBKeUo5TStVSloyU3czSnN2cU9jZ3JBS21DOWFIN2Fl?=
 =?utf-8?B?QS9ac1M4RDl2Wm1hRVNJQXhlckRTOUtDbEM5Y1VZbHFicHRiQzNZQ3pUbE1K?=
 =?utf-8?B?N2ZVUWdUcU9jSTQ3bldnVWtTVGVUYkt6a2lSWUhBdXVFQ3VmSDNXNXc3U09J?=
 =?utf-8?B?c1ZEZlRLQ29sWENJdUtzMk5YeDA1ZmE2NkRBNnJVb21VZ2xLQTVhaGhJUlZR?=
 =?utf-8?B?TFh4U0pHZU5GSG9uMUp5eUNyQ2h5aWtRbWVRMmNSVzkzb3VmUjVkREZER3Rk?=
 =?utf-8?B?YW9Ba2MxUTQvYldMdVg4VVdzTXhFcTBpU2RYSkZpKytVVVhraHpNYWFJakJh?=
 =?utf-8?B?b05FY1N6UDdoRHNTYThuNTBvTkNpWUhnczlNSHJUY09FWWx5K2pha1ZrZ0NH?=
 =?utf-8?B?RkMwZjM5Q1p4NzBELzUzRlBUVzlTOTRkT3EzYjUzcEpZQ0ZoSU1ReVpCVHJP?=
 =?utf-8?B?SzlZbjl2ZWRQR2p0RnhiMk5wenY0MW9EZy95RC9FSGl4Q2pNV20wS3A3R1RE?=
 =?utf-8?B?ZzdmREx0eVdyaGNDbVkrdm1XRDJyZ2VCVkwybXNTaXExZlFIb3lDVm1CSmUr?=
 =?utf-8?B?cExyTnJRendoYkhRQzhZdUZBMDFjMVp0dVhmZ0JWMlVvMEFkdHAxQjV2Mjh0?=
 =?utf-8?B?eW16V0VQWGQybFpSdmlBemozTURLb3FMYWJ4R3lvaU5mQkJUMlBiQ2dzaU9T?=
 =?utf-8?B?VTQ2TEhpUDdwTnpiVHVBNG5OUDJKUjlyU1luYTRBbHUyU2VuM1RhZWNJaW13?=
 =?utf-8?B?VTNOK0xYenVDaFQwSllqa29MaUNaN2lKbWdSM2VlUklWR0lJU3RkSEE2eXlt?=
 =?utf-8?B?VFVEM0l6ZGkwdE8xRkhQVGNrUXp5S1lPU1k5THBkL3ZtL2ZnMlFFMWVYc0VU?=
 =?utf-8?B?eUZ5WnlEdTdjeENmQkhmY1FxMmRvSWNBSWl5NkhyZW8wWjFxT0VoNkx3SmFS?=
 =?utf-8?B?RUROZWo0RzNva05mVGhoaHVWY2p2andpL3k0NkxoVDJncWU0M3AyTzdxS0xt?=
 =?utf-8?B?bXBNRGdzb00rYVhiSXZYNS92WmFpQ1l4UDNWb1hiK01IU3JnLzQ3b0tET1Zh?=
 =?utf-8?B?bkZVSmQ2NWgrYUx6cGJJSTFkVTU2empDNWc0NGZIbFZrdFFSS1pBTXE0MGt4?=
 =?utf-8?B?bWhKSFpwbU52QnQ1aVBjZXJIYTJXTkpZYWE5UllDTmNoUXRoZGY3RFRrMXV3?=
 =?utf-8?B?ejA5M1RJdXpqY2ZSK3VTK0hrdExFL3lPVmFuUktvcE1iR1c4Ri9LeGsxMmV4?=
 =?utf-8?Q?IYDhlfw7puodVp7CLM1TJDbhaHq8XcIbaReTmKp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe44560-babb-4751-5d6c-08d90331457c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 12:47:20.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qorAym0+kFGX++wNWhzVVJfVRPwq9rt8ytUEVZysKtff8CJkiN9wPq/yh0yUWg6j3+QbYey5Jy2heqa7H/xmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5081
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiANCj4gT24gU3VuLCAxOCBBcHIgMjAyMSBhdCAwODowMCwgQXZyaSBBbHRtYW4gPGF2cmkuYWx0
bWFuQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGNhY2hlIG1heSBiZSBmbHVzaGVkIHRv
IHRoZSBub252b2xhdGlsZSBzdG9yYWdlIGJ5IHdyaXRpbmcgdG8NCj4gPiBGTFVTSF9DQUNIRSBi
eXRlIChFWFRfQ1NEIGJ5dGUgWzMyXSkuIFdoZW4gaW4gY29tbWFuZCBxdWV1ZWluZyBtb2RlLA0K
PiB0aGUNCj4gPiBjYWNoZSBtYXkgYmUgZmx1c2hlZCBieSBpc3N1aW5nIGEgQ01EUV9UQVNLXyBE
RVZfTUdNVCAoQ01ENDgpIHdpdGggYQ0KPiA+IEZMVVNIX0NBQ0hFIG9wLWNvZGUuICBFaXRoZXIg
d2F5LCB2ZXJpZnkgdGhhdCBUaGUgY2FjaGUgZnVuY3Rpb24gaXMNCj4gPiB0dXJuZWQgT04gYmVm
b3JlIGRvaW5nIHNvLg0KPiANCj4gQXZyaSwgdGhhbmtzIGZvciB5b3VyIHBhdGNoLiBPdmVyYWxs
IHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEhvd2V2ZXIgdGhpbmdzIGFyZSBiZWNvbWlu
ZyBtb3JlIGFuZCBtb3JlIG1lc3N5IGluIHRoZXNlIGxheWVycyBvZiB0aGUNCj4gbW1jIGNvcmUu
IEluIHBhcnRpY3VsYXIsIEkgd291bGQgbGlrZSB1cyB0byB0YWtlIGFkdmFudGFnZSBvZiB0aGUN
Cj4gYnVzX29wcyBjYWxsYmFja3MsIHdoZW4gZU1NQyBhbmQvb3IgU0Qgc3BlY2lmaWMgZmVhdHVy
ZXMgbmVlZA0KPiBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb25zLg0KPiANCj4gSSBoYXZlIHBvc3Rl
ZCBhIHBhdGNoIFsxXSwgdGhhdCBtb3ZlcyB0aGUgZU1NQyBjYWNoZSBmbHVzaGluZyBpbnRvIGEN
Cj4gYnVzX29wcyBjYWxsYmFjay4gV291bGQgeW91IG1pbmQgcmViYXNpbmcgdGhpcyBzZXJpZXMg
b24gdG9wIG9mIHRoYXQ/DQpTdXJlLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEtpbmQgcmVn
YXJkcw0KPiBVZmZlDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LQ0KPiBtbWMvcGF0Y2gvMjAyMTA0MTkxMjI5NDMuNjgyMzQtMS11bGYuaGFu
c3NvbkBsaW5hcm8ub3JnLw0KDQo=
