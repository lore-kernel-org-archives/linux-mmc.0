Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922BC4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E8061A59
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 06:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhHPGrS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 02:47:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35787 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhHPGrM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096401; x=1660632401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZdrY4VDmPLCuZ8nRDI3bGC1FVxq6aJFgBjS1+2JX+5M=;
  b=fR8k75MpAxpI7cMyF7Bc8qWbsNpGN3fkTA1l5+JB3pT49TLyQ7OIi2+5
   56iQIn97uFFoc/K7nreaSnZlRcwtsC76TonEQ5kon05qq9TOMhReZUCwh
   IJaeLkpE/uPQfjtcRj4P/WIIFBAwxhT78KxszRJVRzV0SzUdluuZTXvl/
   Fk/ItSwDVUItb5V7PjxXp7MLgC+eUkfyFpYQx1AClNZGVq477ZYq85I6b
   4x5GPSvRR2IrK5AHgfJrbjHT2gcfd3RmeK9+EiAm7mU2gA4SOuulcL+yz
   npKgYryMmWH4fs+Olm7uLv1kB1PLWyC6u0LqZWliFUV14AeFbA8BQipRC
   A==;
IronPort-SDR: nZIKmk+m4yzXb3/jndTMNqTr5ETKYDIfw15SC02Sl5E2R3Vwt1IXDmjEkCYBenJjqrgVH6BJJs
 KRiB7c2Zw4GGSVtPgJSPLOBFq3sUhU4zKwh50nqXNE7Y/DX3V/oTwcdCBEybpDjNdZXde9ArLv
 s0NzRANYaYCHw0kN2+utaDlJUYGhVlklHHqD5fpX3Hftgd3BsawggSurfpryAF4+APotE+4Aw6
 +AMBkjWhbP7zKgDLr5n5QUf1Y64dHlg70Mn+Kn16bBSoscJNoEOmkQd1B9u8Bc5qTzQpVcn9Wg
 ZKU+Nqm1E1cF8aYqWk+9ONUv
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125900513"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Sun, 15 Aug 2021 23:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4FvI9UryOJ5e0axpK9gB2ll2nXzcBh/0zf0OBT1SK/SstgyFBkHGmKR406r4O7wMWjtEGXkAMoNBO9lUOV/+KlA1NAU8zIB3vmbJBgX+JXHTiDETO0Cusm9K/YxjN4Bx+ntVIUq5GL9/ZkAIsLuBJJgf8eTeKJZluBZKmUHWTbY/DVmWndqxuvkZHtczdJhThjt/bxgxWOA3vj4A/ONhL0wSwtTld9pBHCty2o7Vp+Ru5yb7EPV4FKWCRWtEzT9qNbBC7KnMlh9pv+Qo7mIqEC3w7VX9H80MKfa8pQhtF3U5IGafMpCCRvuZ1eMge9oCpeJwaUJT4CFfF5ZFhXYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdrY4VDmPLCuZ8nRDI3bGC1FVxq6aJFgBjS1+2JX+5M=;
 b=LjK4GVzZwLzfMLlEtO5x/k4vqwEutAkra0ws2JkQk1mbE1f9IMEgxfS89zqDDtnG6LxL4M/7mQEy1FtoWssX256wgPIctMKpvTHSAmNqKUzeVywxGmAI9FBi26OKcEsaVTDJ8U6OpfVe8OqtvP44QvUURVOXlrlg1ujoBnsQ7IANhyY4Bg77B6wzRb5D+ue2kT/m8h6G3H5MQiDfkCAfHCExNZ4CE+SUr6c/9NS7Tp2OUaCnD4HY0P0WUqGRI3Rv6h2vsPhZXX2lOxNoiTPHkrmAHyF6ACQE1GK5SDD6LB9UPPiMUdLBcteWJ3KrXZ6yV6L3jp6TiwFRQoHm3Gxu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdrY4VDmPLCuZ8nRDI3bGC1FVxq6aJFgBjS1+2JX+5M=;
 b=B6ZUPOBNHUzvBqnAnN4nPV+87whnuAI5C/8CxjxR+YQoCAUOlwnP/jc048nhe1dLocUyId6f52HGJz16qd8y1Lvc/ITFdmWsvTcxrg4l1q64MuIhHrqyoWHAJleNnhmFyxrhXezxgcjN+tJox58/R2fWguKHI0dwop3ulT8Tbuc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4329.namprd11.prod.outlook.com (2603:10b6:5:201::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15; Mon, 16 Aug 2021 06:46:39 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e155:7e54:f51f:ff5c%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 06:46:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] mmc: pwrseq: sd8787: add support for selectable
Thread-Topic: [PATCH 0/4] mmc: pwrseq: sd8787: add support for selectable
Thread-Index: AQHXkmp2VST0lBo81EO95UDHiWUykg==
Date:   Mon, 16 Aug 2021 06:46:39 +0000
Message-ID: <ce9e6c0c-6ed8-b039-f5b4-67766ecb595a@microchip.com>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
 <YRbU3NtbYamh7UGH@robh.at.kernel.org>
In-Reply-To: <YRbU3NtbYamh7UGH@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa1b503e-5f4c-4df6-ca0b-08d960819977
x-ms-traffictypediagnostic: DM6PR11MB4329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4329D58E4A95D4F5B946332787FD9@DM6PR11MB4329.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNwRtK42cURL9ZoNe/Ve2/awbQs8jEky3lrOijd+1Z+C+xR74hFAhup/EeXD3E5eNr0M6Thn8KbWwm52ZUTfKd1s8vRZVyqGbepX4rFZ9v+nIZW2GDnNQKGnFOrRh7G4ekVzwKA7V7wx0WS4zK0mWBZ38QkymINevYRCTYS5Z3PJc4om8olLlt+hPBbvq/dYJWJHAuXrfl1EvI7UvY+0wz4v8qOzsnY+TVn86yR+zVvvXJF1XybRjyhAal4+UZozaDsYeiCM59RMGlzhfO7h0z3ZFIys384hVOTKcB3/50gTRpfw11CpoDhHEw9hkZqh9FeND9UYZK4TCVr97Fz1+DuOFwFPRa2FQzORGXh3POwmcVv7hYX/yc1vhQbMlj3D8JWyWWTJP0ZBE+RglpkoT6RVhhISnlPbOLWrOtE8QRq5ewyZkEIiWDGwbMTfk0FKrcKrSP6SGdS5sXOT+H4q96X8RQbqPFVbgpCGgGBnwEwp1+hwyFtN8+prN0zH0j9qwTGdbjYrtoWDsSX5LOl5Ssb1T3hYh5DfzJ000w5vtqzDRzkOycGXXaSWjHYcRMihdFcEpHnWMDRjZWc1iF0WiIe9ulxiJtu8FmGRw6PAnCR/T5TqlJQsOcNf+R+KXnkCkX5WYVbguRLmnnEjQKqKPxmu/T1MxzoSCPDgSEUS6SX0ptAPO+/8heKWuxD2mZEnzeoF1BBa4kdQ1jltLCHenkOliC5XQZrSvaEO7tL1GZ3UiVKArmwF+LosfOttyGNZwM2Bee22S1mDAU6xmRP6SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(376002)(136003)(186003)(2906002)(4744005)(86362001)(122000001)(38100700002)(31686004)(31696002)(4326008)(66446008)(6486002)(8676002)(478600001)(66556008)(64756008)(66476007)(38070700005)(76116006)(66946007)(91956017)(6506007)(71200400001)(5660300002)(2616005)(54906003)(6512007)(36756003)(6916009)(316002)(26005)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlVqSmd2SEoyU2dORTVkL0U4aXBDajdFelBPanYrNU85c3l3MERqc0tJaklD?=
 =?utf-8?B?UE5iNG9kZHRjWkQ5YVZFclpWSU9KZXFYek9wZitOZzJOTUFlem8xOWltdmdJ?=
 =?utf-8?B?akJkbXJsbEhpMkp2U0RtL2dyanNDbGpHVXdIRzVMcXB6NVhWNVR0U0Fhb0RP?=
 =?utf-8?B?Sk95SmlXMFpFNHg0OGtXNnk2ZVhMbG1OYUlGZlhIR1lLSlFZN1RQWGVxeG9v?=
 =?utf-8?B?ZHJnTHJrNmpTU1pxRXpSTEZqenRRM0V5RG5vKytvVWVKK3BlNWRuMjBkU1dv?=
 =?utf-8?B?Yi9VTlFMOU9TL1UyQVVpWUplYzhOZUk3VTZYZEt6Q3pvN1RaSkRjUjZicXFa?=
 =?utf-8?B?elB6Q2I3NEN5THpDWHhCUllKeTR3TTR6RWh0SUpHQTl6SDUrVGlSdENYdnJv?=
 =?utf-8?B?R3k3NERMVDlyeEEzb0xueEZQOEROOFJFaXRsb0RzWGJsRmdZSEh6NGREZkpS?=
 =?utf-8?B?RHlZM2c3Tkc2eUtmRVJtckdXNlQxdDVONVBUay9rdDE4LzZnSkg0cXQwY2NM?=
 =?utf-8?B?VUptbzgwQkc3NHBMTGxjQzBZcENybm1yUVNsQmJGMllIOWo5WDdrSnBoR0lj?=
 =?utf-8?B?dG9SRENDdlMxeFFVQnhKRTE0bGJtaFV5dDErSG85cVYvVmVsTkxOWGZXcVY2?=
 =?utf-8?B?U0hBbXlqbmVNZWlRNVI3a1Riem50ZDIvMnRaVVAvYTlsbFZ5QWlLejdLN1FY?=
 =?utf-8?B?MGZDUTBYYWJlVEMzRWd1SVIxeVNCK0FLZUdWOUpuZW00REdIMDJSYk03WXZ1?=
 =?utf-8?B?VFFPcnR6Zm5HRGlDUktCY2RxUy9rRHZZRWl0RU9oYk9hT0dEUXVyNEQzRllt?=
 =?utf-8?B?UU9PclE1OVgxS0xkNWRZTlNhYWVZUHVFN2RFamE5R2FTb2dxYk1BSGVEaEIz?=
 =?utf-8?B?OWpWaDVxTGY3RU43aGk3VitReC9lMWxCWmVTZm9na3NMM3g0Q3lRWk02SDk4?=
 =?utf-8?B?N2s5Skd0U0JMUU92OVd2TXphMExWbjVLa0ZKZ2g2VFdQYlE1bVRLZ0VCK0hH?=
 =?utf-8?B?Q3k4TlNQeWU1UitMNm9ISitQLyswZFRkTHBKcjRXMDhIcUlBUWs0SjNPREpY?=
 =?utf-8?B?VnRhZkNYUUNBZm11cUdMRVIzVFpTUDk1TS9LcTh5T3RUemQ0NFlaWDdRODRP?=
 =?utf-8?B?RDZXUmJNcHFUaHZpMFVCbE1vSEQ5a25NM1BLS3pRMWxTa0NlSEFnQjBRRHhZ?=
 =?utf-8?B?dDcvdHV2MllxSTVQUkY2UWRXU0lxK1kzZlJaUnA2OSt6VjVqblBaU3ZvaGNP?=
 =?utf-8?B?aUdCcTIwSjhrbUMyNXEzVkRKTW1xd2FoaktBVi9RaFZFRlRnVllrR2pFMEVP?=
 =?utf-8?B?ZkV3b0I2cVQweld4eEcvM2o3UGxnclVzRGUyeXJTUGVGeEJCZUJnak1NTXoy?=
 =?utf-8?B?Zjk4TnYwM0QvNFhVVi9nbkZqS3c5TW1ZUmE4cElQWmMyaWY0d0VBTzZtOGNK?=
 =?utf-8?B?M1lBYkcwT3MvTmNXUWZGWEM5eUNzdnRFQnR1dDBRejBuWW1Qbk9mRDk1SkVR?=
 =?utf-8?B?clJLOWluQlkraG5jU3N1YUdDOCtrMXVUNDd2OEg3Zkc0bEFaR05aZFV6eWM0?=
 =?utf-8?B?T3E3bjZYWW9LNUEwV0lpblVlcGZzMFBtZW96UjI2bytnUnBrak42Zm5VNE1i?=
 =?utf-8?B?YlN4NHlPc0RsU05rdFFSWE5qTmFtRHI4emIzS0RwUjFEUzJGb1dIU3lIUEZh?=
 =?utf-8?B?WmZMazVVMUFCek9WaFNzZjU4cTNNUXZvelFsQndzdUVwUmdGZE5TTlpDMUhr?=
 =?utf-8?Q?eyFc2FQQ8A36ZLxUGE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DF4F5040F8C18429A34DD0A26E93CFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1b503e-5f4c-4df6-ca0b-08d960819977
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 06:46:39.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7k/0loRZorv7TKUpnrctUpiWkGMswO1wERZMPbktb7pKVC3U5i95SThMBpBx+QIhaw2S3zBopW/Mi9jw79zKKueCkhG8LZjqNthFpaNduQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4329
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gMTMuMDguMjAyMSAyMzoyMywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBBdWcgMDYsIDIwMjEgYXQgMDI6Mjk6
NTdQTSArMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBUaGlzIHNl
cmllcyBhZGRzIHN1cHBvcnQgZm9yIHNlbGVjdGluZyB0aGUgZGVsYXkgYi93IHJlc2V0IGFuZCBw
b3dlcg0KPj4gbGluZXMgb24gcHdyc2VxLXNkODc4Ny4gV2l0aCB0aGlzIHRoZSBkcml2ZXIgY291
bGQgYWxzbyBiZSB1c2VkIGJ5DQo+PiBvdGhlciBkZXZpY2VzIChlLmcuIFdJTEMxMDAwL1dJTEMz
MDAwIHdoaWNoIG5lZWRzIGEgZGVsYXkgb2YgNW1zKS4gQWxvbmcNCj4+IHdpdGggdGhpcyBhZGRl
ZCB0aGUgRFQgYmluZGluZ3MgZm9yIFdJTEMzMDAwIGRldmljZSBwcmVzZW50IG9uDQo+PiBTQU1B
NUQyNyBXTFNPTTEgYm9hcmQuDQo+IA0KPiBBIDMwMG1zIGRlbGF5IGRvZXNuJ3Qgd29yaz8NCg0K
SXQgc2hvdWxkIHdvcmsgYXMgdGhlIGRhdGFzaGVldCBzcGVjaWZpZXMgYSBtaW5pbXVtIG9mIDVt
cyBpcyBuZWNlc3NhcnkuDQoNCj4gSXMgcG93ZXJpbmcgb24gdGhlIGRldmljZSBzbyB0aW1pbmcN
Cj4gY3JpdGljYWw/DQo+IA0KPiBBZGQgYSBuZXcgY29tcGF0aWJsZSBmb3IgeW91ciBkZXZpY2Ug
YW5kIGltcGx5IHRoZSB0aW1pbmcgZnJvbSB0aGF0Lg0KPiBUaGF0IHdheSB3ZSdyZSBub3QgZXh0
ZW5kaW5nIHRoZSBiaW5kaW5nIGEgcHJvcGVydHkgYXQgYSB0aW1lIGluIGENCj4gcG9vcmx5IGRl
c2lnbmVkIHdheSBmb3IgZWFjaCBuZXcgdGltaW5nIHF1aXJrLg0KDQpPSywgd2lsbCBkbyBpdCBp
biB2Mi4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldywNCkNsYXVkaXUgQmV6bmVhDQoNCj4g
DQo+IFJvYg0KPiANCg0K
