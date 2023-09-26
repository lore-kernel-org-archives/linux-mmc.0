Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3D0E7D271
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 09:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIZJya (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIZJy3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 05:54:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB197
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722063; x=1727258063;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5W1xGoeFzUHz5+BC4UmZYSpjEO6s0k1PzfYUIB+lVdM=;
  b=PQth/uz8p24Oy3A06t+hrd8uq/4DN/jfpjJ8q7ak9HxTdEUe4QZ+5i32
   TJE7l8gey8NUmCXwc+J68z9NcaLp+DQ7l3M2ztYHTUGwAtuAnoLy6Ay3w
   hx5WtoVYljkjPJIEBbL2Gwi0T4z9zf9Zri3HRqfjsm7aXAHBxSj0lwp1J
   1/zAN3DRKH8W/93dNgRuU/mTWkhJBGVeNSigfO3vDUA4e7Flrqgqo21Wa
   8reDXevwR7PbrjjDj6UhhLd+y9ef2RdRq2RFJlDSHS+I3+j/+9EFFWX1k
   j+Q5rP3WEHDl5NNQ2Lhf+BheY57WaFyDzANXdZb/K/oZ+Jff5EHULWvoe
   A==;
X-CSE-ConnectionGUID: 8tSPM32oT/KaY89RoTRyaA==
X-CSE-MsgGUID: 6N/NMIiKQi+9ByXVWp2eqQ==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="244969090"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 17:54:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYem5/GWQYvvDE5kDe/bLbcyv52mrCCGSFNc+Y5ony4fJP2j4PKL8GoU2fJr1hWrMAgiN3dfpF0Af0CAGyK0XtHFzHbySfIzeJOpEGjPzMMfEeOfOnaHyRPghfzoGU8cWLrOdAwMRQmR2d4VvjA7mIapdUZY1Xcputv7QYIByMYFoSW6CLApQW+qbjLgtDTcf+D86j2uLsMtg2M6ZU8TB+G68tcrtAvVtovOtlQDlQCKi/S1n6oszFVPcXURHMOH3WgdLLbba8zFr3NGbDfIRhpGq6FlOlLWYwOhfwXttJvSQffOZbhmPUFy2qYazT9my4ECdag8Eq3PXor4sBOJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W1xGoeFzUHz5+BC4UmZYSpjEO6s0k1PzfYUIB+lVdM=;
 b=gc1tcm8eENUiOtytXqzENU0z4+pmB4u4c8QeUENsEdZ3+FOQoHa0i5zdnWUBXZJi9u0o+Lh1Yy6pQXIiF/f9A0dNoXd+Q5wRFphKpmnVQ+5xh67CPu/0t9veN9p1UxCDnCK34Oodb/XETdqcKpOESOvR2XT3je1ZMZ3JXlVmDIil0ZvWIJ35TO8mRTwbNsl9K1w+SKuBGZMK0jDYZNiLPZOKKP9C7e1gLglSW2a0ccAKF4RD/s6kJTmmRorfWHez+vmvIREfGdLul39IT6bDnIYoYaxCCLfjascwZtaGsC9QmImGJRhqYFjG1nsyUYEQGKQGI67cHX4LAqAt5ehESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W1xGoeFzUHz5+BC4UmZYSpjEO6s0k1PzfYUIB+lVdM=;
 b=wE4dV7OnaBX+A3FLy1f14TxAjga2Mo41OKlKrD7pRi5kcmr3oUjBFO4QIm17jsSTGzMoLTaWT0X7co+VNwTwGH1QXcV182t+4Kk4RRYbfk3QBJGUzEDwblb9PxQcsW0t3OewL8gu1rMMCERFxxlvBYxMOXG+bwyEw1lMWMEq/lA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7912.namprd04.prod.outlook.com (2603:10b6:5:315::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.18; Tue, 26 Sep 2023 09:54:16 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 09:54:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: fix potential overflow
Thread-Topic: [PATCH] mmc-utils: fix potential overflow
Thread-Index: AQHZ8EllWHw/2mbtRki6/9suqJpfNrAs3JJw
Date:   Tue, 26 Sep 2023 09:54:15 +0000
Message-ID: <DM6PR04MB65758D3887318C2F53D033CBFCC3A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230926071524.3638706-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20230926071524.3638706-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7912:EE_
x-ms-office365-filtering-correlation-id: 7f4e9383-cb06-4100-f54b-08dbbe768b60
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lU72E/1dx3feKxpFn53opIkWmEdvSngQT6Mz/8/dzGfwFn5XB4HE46YnvAssxDcrM/AcETAGEVnYI3E/h0yteZ4zcjy2b4lvBFHqSZmUfcXgPtdaxDNYf+jy5Do1a+EiYEQuRMSOjlMVcQNDnIcuP80B5mBuKL/2hpHUBfonkhA8hO4kJpotFhtZQhJDq0sujan9B52wuGQg900eW+K8OM7knCuAQx7CN6qKQupw5/a2u3Z9tN0z5swblOJU3lcVLToi7s1Xdre8V226S28MFD0YGipnsV3K0L53xFibMXwrGDe1L1HVJBn+DkDUlb/tqB6My90BiU7KJtmS/CPoFYe7ETwYzJSLzKwKBLPSfKunsN3tE3Mhe9uS1s6CugN9VGlVTukHy1CGvYswc6tOyNrct/rbnedhC5ZbWo0/IlJ3ctYq6PoLGGYl4vqkUwSw/1/x76lH66eWONV+6+2+HazMfCo+o26QzGYraRnyUMXmvtjlOg1xlKTlKT4q2JX6/etJTPa85ZtWwqjNHcQH428VuY6haTMluQomdpirgYPMb/JLkPHs+OE2D7WQ7GDnrJlu33LceEzKBm4Cj66yMl//zNLydwNO4jDmSlw2o+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(451199024)(316002)(5660300002)(8936002)(8676002)(41300700001)(110136005)(66446008)(66476007)(64756008)(66556008)(52536014)(76116006)(66946007)(2906002)(55016003)(33656002)(6506007)(7696005)(9686003)(71200400001)(478600001)(966005)(83380400001)(38070700005)(86362001)(82960400001)(38100700002)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1I1SUVibDA0c0Eyd1RuajYyMDJobEcwNjRqcm5hSTJ6R2l3N0hIQUxaYW1V?=
 =?utf-8?B?d2tqUWk3Z0JIaXY2R250N25ndmVrbkZRVCtOYXR3Sjh3V3htZzVMNzZ6QUIy?=
 =?utf-8?B?SnRsbXBIVnBSYzJDay9SL3ZTQm1JRUZhVVZEYVVXck5lYlVTMTZhdDN6bzJl?=
 =?utf-8?B?MjFzY3RaS1VOOHI4WktNL3hJMndodmFlUXNndkZOK21ld210TTJKei82NnZS?=
 =?utf-8?B?ZnZtU3JZdWhVQmJnSkNhUDJ1NFZlVStHNVF0eWs1MkhRV3RVMzZpR1gvU29D?=
 =?utf-8?B?RGk1bXZjQ2Z3VUUvNG40NDFTK1BCQm5SWFF0cXN4d2dFb2R4aGJDL0RvaGNk?=
 =?utf-8?B?YjBHR2FZa2Vub2NCSkNKODBLM3NwcHBSU3BBeUxySjRzRUJycFVKTC9MeGo0?=
 =?utf-8?B?K1ZSa0xab0tCOUp2aThlR1A4RVBYa1RXQ25wTm4yVWZxays5anMrMG13RUxl?=
 =?utf-8?B?cTl2VDVQSE9ZM3ZsWk1mWTZvZ3lNaytKRTB3V1JDZStmR3FYc093TWlLK2cv?=
 =?utf-8?B?VC9FemNWRXZpZHFtMnk4TG1vc2pxSnNJUUViTGpMakw5R3JsZ2M5cGVqa0py?=
 =?utf-8?B?T0pHQWZsRlVUMUVidk9PazhNSk4wZUdqKy9jcVU5MGhNL1NIM3YwOEVWdmlk?=
 =?utf-8?B?SXNTMEtGdXNJZFYydmNjZmZYVVFFQU5kczZQNmdRQ3FYWXZkTForTTRiRVlI?=
 =?utf-8?B?dmJuMkZReXl6S2sxbE1rOHJQR05pMFo3NmlyYmxXeGVLRGpFRTkyMWJLcm0w?=
 =?utf-8?B?U3JyallHN0hDQ0FreDh3eWxtRENxNTRpSFpKV0M4bGliWDF2RWFNVm9McUVG?=
 =?utf-8?B?MVdCTFFnN1RkbjhKSWlEcE9NbzBnbFJOemwxRXlSNGdxRU9qY0VmNVhCN3BD?=
 =?utf-8?B?QkRyYmgxOEdvQ2pLN1NtMUVObTI1dFA2MkJ2U3VuajNNVXM0N2Y0Um55WFlP?=
 =?utf-8?B?SDlsWTNvRmdxbEp2bU0vdHNkTXlEVmdEbkpuYnFBSlRSdExVdWJDVTNlZzlD?=
 =?utf-8?B?MzU5Ujdpek8zQUJzLzhtSUlzRS95SDlBc1RKQnNWQXhBWHE5UzFXaDhOQ0t3?=
 =?utf-8?B?THExMHM2T0I4ZTh5SHM0YnBMcVg5RHpYU3JXNzJ6bTJBMnFZVkViVytJN0k1?=
 =?utf-8?B?RGVQZkFjMDkrUnV3Ty9iNFJ2T3VuTWF4enlnRXlyd2ZIc0JTcndScmowc2dj?=
 =?utf-8?B?WnYwNXVyYXhzelVINHhqa3IwYXRiMTg5bVozRFJPS1V0bG0wWEE5V0dzQUR6?=
 =?utf-8?B?M3BKS1JjSytMZWR6KzlvdFdPcFNrNm5CZmQvRG5QSGNGQW51c1RiVjNTeWdQ?=
 =?utf-8?B?ZW5NZW5HOHI2bkRHdm9CN0MvZlZGOEtxMHBFa25Xem5GUm9SYzFFR2IwZ3hV?=
 =?utf-8?B?bE5DMEVwYnF5ekRCdGJmS05nWlE4bDc2Nm9kL3FwQVlHQXU5ZjJNT0pON3g3?=
 =?utf-8?B?VFJKM2Y5aHgzcTd6TjJwTUFJTmthQVVEY25lUWRXdVNzajViRGUvN0F3YUpv?=
 =?utf-8?B?dlhKUU1id29DQmo2UmZqbklENFRmSTJhUU1jR2JVWXZmdHN6amplS3k3Q3lX?=
 =?utf-8?B?V0V0N0tGVHc2RWZzNHh1UUtnWnJuQ1Y4UnFCd0FIbXIrVy8wbmVDNE9XaERY?=
 =?utf-8?B?R0lJNkUzdE5xQTBOdFhOMXBXT0V1Ri9ZZk1GUGJLbUhEdkFHL2U4YjU2aGpF?=
 =?utf-8?B?ZGlvWEtiZU8zelZ0ZldsRk15V0JTM2pTMU81TEYvS0dXcFhSbjVMaTY5Uzk1?=
 =?utf-8?B?NFlRUGUrVkxRK0hJdzNqQVcwNWFIR2xFY1AyMXk4SXF2ME5Nc05wakRpTzFE?=
 =?utf-8?B?UkZaSTRIM0h1aGxwN3A0YUJOdVZlajlGemJJUnhLaVZtRjFvT3huZkMyRkxi?=
 =?utf-8?B?alN4Um0xWmFkU3pvekZGMVVTT3JBUklEM0NaSTAwY2p2Vm03MW1TbDZzMldY?=
 =?utf-8?B?RG5HRTV2bXhyNDl6R2dzK0JCZ05ZdklrNUJIdkhzNkVPa2Y3NEFNNlRWVGt5?=
 =?utf-8?B?eDNKTEgwdDZ3ZkJPalRVZHVGS0FtbnE1dHhDNzA0TFlIaGV3UzJNRUlDQTJN?=
 =?utf-8?B?NWtjYTFZcUQwanE5bnJQdXhzUVdnSnFvbkVoTllJM2diUkp5anJWQWVWdDRs?=
 =?utf-8?Q?DbEjIkOOyXhiiZs1gQRNSAaMM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hx9oY1Q/p5loNXItT94C3LTE4hgalXtNLYrTWXP2+/PW1lx2v39aN8BE32TI3I0aUaByl2LHk/Z3B+Uj7++2oS7MT44MwOaXaDakxYmZbmZSksB39cOLCi46FC4CKPyDXzq1YWfIiuF1gKHP1jmfrcayfo+3xd/1J21ISl+zO/3UCRohuDx09QFfch7qqLT4X2Lpji21/Fb1i0IRe8SBsXxZrMIukU75d7XPu5fLmobO/KuTIXcyM0TpXSkwG4lTr7uzayG9FlQWG8r/JgIkIgi8zay82C71bk1tPBKzJ8HmMv60J27te0+ljftrlD4L1rixfV6pJjgJYBpmjTPCJwQKsHjAPJcJvG4Ytm9rY1/7wwyjkwjPhqr0eze+lk2pPm/z7qduaZkx29ZUz9li2r8YJ0/hoVqA6fMbjRScCZFIwjx4IyqbyOgP21i0+JcX1cii0evl3ZeX9Iez2p9/DA6RIOC0uytNxRiTBTgBcLYg9Pkvld5q+cXKh9Tq+DxNq/X/8u5hiYZOWzB5Wsf58GHCxz/Q19OwinCOMHarh/0NL5xFmXl8oAbnnlFRtu5/Hfr10plqyJMIRI+Tqxv7h3URyEVjh0eKNBaVAkWrSAUWLDlTbuMPpkoIEhJrh2b/kIJtCb1Sq9GrLYNQ4yLo3ftfKnXwdTPoKhrZurK/pGetZJCxnBqyDJQxGRmh3hyz/urfJu/nfYKXW0nGoocEqZaZSrHFW0NZT0o1YJNYHPfGzAqK9lq0EDONTsLNo1XSuO0mob+TsOuSy/Z56MaGz7YBVbsyIJSPihbpfZJwr1o8LUXQBEOiq13ttiUJPLGY/fUtXTdd/RS11Y0BcLZKaw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4e9383-cb06-4100-f54b-08dbbe768b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 09:54:15.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYo46FDFUi/ntNH6TAu0pi+kdn27Mwx+vifx4u768kBE5gycxrQ9VZMqc3m0iotyTYtbu/7q9Fy54uy4ZBccSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7912
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBXaXRoIGZvcnRpZnkgZW5hYmxlZCBnY2MgdGhyb3dzIGZvbGxvd2luZyBlcnJvcjoNCj4gICAg
ICAgICAgICAgICAgICBmcm9tIG1tY19jbWRzLmM6MjA6DQo+IEluIGZ1bmN0aW9uIOKAmHJlYWTi
gJksDQo+ICAgICBpbmxpbmVkIGZyb20g4oCYZG9fcnBtYl93cml0ZV9rZXnigJkgYXQgbW1jX2Nt
ZHMuYzoyMjMzOjg6DQo+IC9ob21lL2dpdWxpb2JlbmV0dGkvYnJfcmVwcm9kdWNlL2E1MzkyMmM1
ZGIzZTYwNWE1ZTgxZTUzYzAzNGY0NTAxN2UNCj4gYmI3ZGI3L291dHB1dC9ob3N0L21pcHNlbC1i
dWlsZHJvb3QtbGludXgtDQo+IGdudS9zeXNyb290L3Vzci9pbmNsdWRlL2JpdHMvdW5pc3RkLmg6
Mzg6MTA6IGVycm9yOiDigJhfX3JlYWRfYWxpYXPigJkgd3JpdGluZw0KPiAyMjggb3IgbW9yZSBi
eXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNpemUgMzIgb3ZlcmZsb3dzIHRoZSBkZXN0aW5hdGlvbiBb
LQ0KPiBXZXJyb3I9c3RyaW5nb3Atb3ZlcmZsb3c9XQ0KPiAgICAzOCB8ICAgcmV0dXJuIF9fZ2xp
YmNfZm9ydGlmeSAocmVhZCwgX19uYnl0ZXMsIHNpemVvZiAoY2hhciksDQo+ICAgICAgIHwgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+DQo+IG1tY19jbWRzLmM6IEluIGZ1bmN0aW9uIOKAmGRvX3Jw
bWJfd3JpdGVfa2V54oCZOg0KPiBtbWNfY21kcy5jOjIwODc6MTk6IG5vdGU6IGRlc3RpbmF0aW9u
IG9iamVjdCDigJhrZXlfbWFj4oCZIG9mIHNpemUgMzINCj4gIDIwODcgfCAgICAgICAgIHVfaW50
OF90ICBrZXlfbWFjWzMyXTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+
IC9ob21lL2dpdWxpb2JlbmV0dGkvYnJfcmVwcm9kdWNlL2E1MzkyMmM1ZGIzZTYwNWE1ZTgxZTUz
YzAzNGY0NTAxN2UNCj4gYmI3ZGI3L291dHB1dC9ob3N0L21pcHNlbC1idWlsZHJvb3QtbGludXgt
DQo+IGdudS9zeXNyb290L3Vzci9pbmNsdWRlL2JpdHMvdW5pc3RkLmg6MjY6MTY6IG5vdGU6IGlu
IGEgY2FsbCB0byBmdW5jdGlvbg0KPiDigJhfX3JlYWRfYWxpYXPigJkgZGVjbGFyZWQgd2l0aCBh
dHRyaWJ1dGUg4oCYYWNjZXNzICh3cml0ZV9vbmx5LCAyLCAzKeKAmQ0KPiAgICAyNiB8IGV4dGVy
biBzc2l6ZV90IF9fUkVESVJFQ1QgKF9fcmVhZF9hbGlhcywgKGludCBfX2ZkLCB2b2lkICpfX2J1
ZiwNCj4gICAgICAgfCAgICAgICAgICAgICAgICBefn5+fn5+fn5+DQo+IA0KPiByZWFkKCkgY291
bGQgcG90ZW50aWFsbHkgcmV0dXJuIG1vcmUgdGhhbiBuYnl0ZSBzbyBsZXQncyBjaGVjayBmb3Ig
cmV0IDwgbmJ5dGUuDQpObyBpdCBjYW4ndCBiZWNhdXNlIHRoYXQgd291bGQgbWVhbiBidWZmZXIg
b3ZlcmZsb3cuDQpTZWUgaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85Njk5
OTE5Nzk5L2Z1bmN0aW9ucy9yZWFkLmh0bWwgOiANCiIgdGhpcyBudW1iZXIgc2hhbGwgbmV2ZXIg
YmUgZ3JlYXRlciB0aGFuIG5ieXRlLiINCg0KU28gdGhpcyBzZWVtcyBsaWtlIGEgYm9ndXMgd2Fy
bmluZyB0byBtZS4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogR2l1bGlv
IEJlbmV0dGkgPGdpdWxpby5iZW5ldHRpQGJlbmV0dGllbmdpbmVlcmluZy5jb20+DQo+IC0tLQ0K
PiAgbW1jX2NtZHMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tY19jbWRzLmMgYi9tbWNfY21kcy5j
DQo+IGluZGV4IDEwZDA2M2QuLmFlN2I4NzYgMTAwNjQ0DQo+IC0tLSBhL21tY19jbWRzLmMNCj4g
KysrIGIvbW1jX2NtZHMuYw0KPiBAQCAtMjA2NSw3ICsyMDY1LDcgQEAgaW50IGRvX3Nhbml0aXpl
KGludCBuYXJncywgY2hhciAqKmFyZ3YpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChy
ID4gMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCArPSByOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+IC0gICAgICAgICAg
ICAgICB9IHdoaWxlIChyICE9IDAgJiYgKHNpemVfdClyZXQgIT0gbmJ5dGUpOyAgICAgICBcDQo+
ICsgICAgICAgICAgICAgICB9IHdoaWxlIChyICE9IDAgJiYgKHNpemVfdClyZXQgPCBuYnl0ZSk7
ICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXA0KPiAgICAgICAgICAgICAgICAgcmV0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAg
ICAgfSkNCj4gLS0NCj4gMi4zNC4xDQoNCg==
