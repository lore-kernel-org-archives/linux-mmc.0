Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A4C48BE5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFCF613D5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 10:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFQKUU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:20:20 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:39265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231654AbhFQKUT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Jun 2021 06:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0nF835jbJoay1oJ8ZT1TsTolouJyVsi1OK2yxilnhFmOJT1zZM+7paAcz99GI2RIwKwH632u7cqLVCCQLamB9y6Pt2Iv3H3UmjPpAKhJprnb3TTcQBs77ETX5almIfuxqhtUa8SN00P9NiwxImkiJNCEXQc9mhCk9sNfB6VVmbTdFMS1pM1bS90iFK0UuyVhA5VjAJ88iJMwZd/Zpq5t+Z0RAnjnUrivooOGGVF9TKBW5KgVW7xK6WWFsYkamGPsaKBZdrkYlec+RPEoLGnAXotLIJD3ibewDVk/0wue9cllzbjQIZYV6lOdOdIyZ4vbSx1EoFCkdW4Cnt91sh1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZHgkZIqjcUuIBpJoPKgNsyTBKyX3owKbFZk70oDUS0=;
 b=CtTu9Fb9SppwrXemH9ZGQlS44WoveF7LYud9CRQ7g1WtCkEzwgHjzkBVM2fP7PM9loCeX6LMAPueckH/lDaIgoqKR871z3pwIgwH90en3xj/FcAnD7X5RJea+SsaCv/Tixd78YSCVzHUAtVMBe6+YC6qWWbhES1cmWzFDiAyYg5b+IcBNXkKLA8K7tobEe/DjwEsUMcZJeWw+nZlu0X6iLwuuf0ktW88u7pIMaN5PmB/SHeXOnCgWl/GNHnrZs5sNmnF02o/o8uJgW/oMo06McfyIyHACkYrq1HXmsRz5Uh/wBZAdToexUKIDaj2yNUeqMLp8q03qx0IViKerOxxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZHgkZIqjcUuIBpJoPKgNsyTBKyX3owKbFZk70oDUS0=;
 b=egPrgoq16P27Q2se6nmbCHxXxV59X2Fgrdg5V5lFV6VN4Z/o0cNhnd2A2hmedWVYwfrjWTKF7SsexaexivR8kCId7FviEXjvdoVaqgm2IOxuqroztVqrcZPnb/nk3I7UxbLSg8ngevasja8IhxdOYZLy+ZnoUaurp37MfyCdvTo=
Received: from DM5PR02MB3877.namprd02.prod.outlook.com (2603:10b6:4:b9::34) by
 DM6PR02MB5354.namprd02.prod.outlook.com (2603:10b6:5:4c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Thu, 17 Jun 2021 10:18:11 +0000
Received: from DM5PR02MB3877.namprd02.prod.outlook.com
 ([fe80::53:31a3:2e23:75e1]) by DM5PR02MB3877.namprd02.prod.outlook.com
 ([fe80::53:31a3:2e23:75e1%5]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 10:18:10 +0000
From:   Sai Krishna Potthuri <lakshmis@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>
CC:     "rashmi.a@intel.com" <rashmi.a@intel.com>,
        "linux-drivers-review-request@eclists.intel.com" 
        <linux-drivers-review-request@eclists.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "furong.zhou@intel.com" <furong.zhou@intel.com>,
        "mallikarjunappa.sangannavar@intel.com" 
        <mallikarjunappa.sangannavar@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "mahesh.r.vaidya@intel.com" <mahesh.r.vaidya@intel.com>,
        "nandhini.srikandan@intel.com" <nandhini.srikandan@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: =?utf-8?B?UkU6IFvigJxQQVRDSOKAnSAxLzJdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBV?=
 =?utf-8?Q?se_clock-frequency_property_to_update_clk=5Fxin?=
Thread-Topic: =?utf-8?B?W+KAnFBBVENI4oCdIDEvMl0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IFVzZSBj?=
 =?utf-8?Q?lock-frequency_property_to_update_clk=5Fxin?=
Thread-Index: AQHXWQjG8dfTI+uYIUesoYUB049ZoasYDjKAgAACAAA=
Date:   Thu, 17 Jun 2021 10:18:10 +0000
Message-ID: <DM5PR02MB3877417CC8D3AE42226AE2DBBD0E9@DM5PR02MB3877.namprd02.prod.outlook.com>
References: <20210603182242.25733-1-rashmi.a@intel.com>
 <20210603182242.25733-2-rashmi.a@intel.com>
 <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
 <CAPDyKFpTf8DvauD17JR+jMH1TypgPiNs86k3YtaD4g10fRp65Q@mail.gmail.com>
In-Reply-To: <CAPDyKFpTf8DvauD17JR+jMH1TypgPiNs86k3YtaD4g10fRp65Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e45a186-f9d9-4902-3d03-08d931793596
x-ms-traffictypediagnostic: DM6PR02MB5354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB5354D6FEE80D652775904681BD0E9@DM6PR02MB5354.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAm+BX8UUb6GeOIa/fceJUDkEewBsrscwSdTXswuVBF5IHYTnS6e3dCwQQGqC7OO+FZ6gkNncOnlQCGSRhZtS9JbWzYai9gVmzjtXEzOuqsTgasKrjAjW1BlDpyxbpoUHnv+W4rRsqR5KqqIpMFDd84DL08WcuMKz92zKRw0g1hDlJnsOJgf8eG7uaevVJPSkzAHnhvvaM7tSsz8Fuy6W6dWc8y6aEDaQIKSkaFiSsGD0qu7XlchTR6zXzDH8wtDXhCzBbmjzIS4HBf1sc9SYLsdsOFEN73FWwoBEOSvgvZDKLmYLrdtRZOGhsFaxWGp3X6paCergGiqzciPeOLaGR6KP82nz13DvTstPFHQjZr6aLgwWBlqAPUiWOPf3FTf1fi7nAQU6GI0jK9Pr4BwAuwRJUsnE9/G8v7i0Z8PM1e/tNFWG6ihhlReHPKrM/p7tZEnDBuauEp++/qroMh+gRVMPuhiSDVVR0RCpEoGz+iY+K+PT5hLMqr+cwMs5+wApmSN9C10X54syyLXYlZZhSl+lwgUByi5OaRApQgM9nPfcmrabcXE9ltTeVG3/FVIqsucxOKv8kyC+3o1qAFpdW/kXkCyhfAAnFOFTRqL9nc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3877.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(478600001)(110136005)(54906003)(71200400001)(66946007)(316002)(186003)(66446008)(38100700002)(64756008)(66476007)(8936002)(66556008)(9686003)(33656002)(55016002)(122000001)(53546011)(6636002)(2906002)(5660300002)(6506007)(4326008)(83380400001)(7416002)(7696005)(26005)(86362001)(52536014)(76116006)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkd4aFZaeEg1b3NtUG92WjJwa0tqM0FWd2g2VHNIUmtFMGFwbmRVbUY0czM2?=
 =?utf-8?B?ODA4REkyQ2tERXdzZkJuaTN5U0NCeDU4Tnlwc3M3dmIwdHU1enNIejZnWEdX?=
 =?utf-8?B?bCttNjRTalFGcUZNUzhMMmNUYkprcEJXT2lSQTFYbE1jQmY1RUxLYUZhTzBY?=
 =?utf-8?B?R2xVdTdOU0JDeGZWS1c5MEc2ejlmY3cyOTNlNnNMaVhGMy9FOS9hN3FYaWxS?=
 =?utf-8?B?Nk12WnQ5YnE2dXVnWVVrMXNaRFhFN2ZlZythMmhoajYzUjlqSHZkTjFMZWV3?=
 =?utf-8?B?R3pBY2IrbnRxOHdGY3lBZEhpbHY0R0hXd0I1RlErVmxYaWRSZ0RuQmU0Tm9Y?=
 =?utf-8?B?YllKS2k2Ym1RdnVmSlNFaHJkMlFZbTF1R3NGSUI2ejNhRGFUS1hucXpjdHRs?=
 =?utf-8?B?VzcrdTg2UDJtUmduZGxQL0Q0VkxiTXNEZk90by9qZmw5WTRCby94TStCWEM5?=
 =?utf-8?B?SUkyMFo4L1hWTENtWmxXbDZGVnI1bFgxenduUDdxcFRaWUoxLzRlaVJreHJx?=
 =?utf-8?B?TEF4aHkyRDVWRFFibTB2U2Y0LzV3Uk1ZNlI5enpwa1RUUXhBQlcvS2pZWDR0?=
 =?utf-8?B?czhnOUZLdGgySm5zT0pndmgxQlZwdm1yQWhVNEEvUzZEenlncFpqNUJxQzl6?=
 =?utf-8?B?Z0Nzbmk1Y1BOSEdnU3lVRjFucDBKdEQ4d3hRR0VrS2h6aU1XWitFQUJxelV0?=
 =?utf-8?B?eHJnRUZHTVNmMFJpUk1Jd05EYm10VzlUY3MxK2NSQnlHSS85QUZuN3hodzFW?=
 =?utf-8?B?eVlHOGp1NHRGS3Q2dStOTFdxeStGbExxblgvWk8zMjJKenlEVXAwNzkrQ0Rk?=
 =?utf-8?B?NUVVSDVhYlVvaU8xdzJ6dUM2ekhGWU9xcE5EQ2RUNjk2eXBlQmdSemoxVkdJ?=
 =?utf-8?B?ZFlxcjI0VUMrcVlIaTVlY3hvNnoxUW1JbWNqb01kcURwblVyMTEwbERhaHJv?=
 =?utf-8?B?OHRmV0VjWUM0M01LejdBSlBmNXhkM2owN0h4bHZFU2NiUC9zMXluT1psOEYx?=
 =?utf-8?B?L2ljQTgwejduZFI5WTlKSno4UkVFYjZubllxYVA2Z0Fid21NcjlSNHE0b0cy?=
 =?utf-8?B?bG1paEhJM09vMjQ1SDR4Y2ExTktNdEQ2akcwMkJxSVNmSWhUS3NScldxTTRl?=
 =?utf-8?B?QTJGVTJTa3Bxdk1HejRKMVJRaHREY3d3b2FwVVZtbHBNOCtJYTF0NTFNaUJr?=
 =?utf-8?B?ejhEQ1lkWFRtWTVrbWQ3ZC9DalVFNE5VT2p3RnI5QzNGUWtZMzlrSEJFdEVV?=
 =?utf-8?B?dVNmeXhOeXBRYUhxOVU1d2ZBaE9kdk1PNWhLV2FZOHFqZTZWV3paZGw5Rzh1?=
 =?utf-8?B?NTY3ZjlOYjQ2SHh1OTEyUy9HUjVHS04yTGg2RlpiNzI4UDJ1Sjdua1hQK05S?=
 =?utf-8?B?d090eVFJSmYxK3RNVXdXTkxnL0c0d05FS0NZN2FoZU1FZ2xYb04zYmN1WHJU?=
 =?utf-8?B?dFBNNXQzK09ja09LaklHUmNpR2I3c3h1b1NoRjQ1Y1VpN1J5TC9zVitQK084?=
 =?utf-8?B?ajF6TlVWM2E5RjZwcjRvUkcwa1ZSd2lWMnlkWU1OZ2JHTkVFOEwwQnRYbWVS?=
 =?utf-8?B?ZG1hcDVKRCtBSThCdGFRUU52T256bjJPMUMrTU1ycVJjeVB4TzIvcG9YN2JP?=
 =?utf-8?B?azV4ZmE0VGJaM0J4SDJlY1crYldJbjlZbE9PSlZWcCtncmRjN1hTY3ZMQm80?=
 =?utf-8?B?TWs1bDJJVG0rVW1EaU9kemJ4eHgrSHFWQlJQc0NmMk1iTkh2RmJlamNsK1NO?=
 =?utf-8?Q?Ih1nzf2Qo8BL78kHH7bB/iIHxolToikvBHYo8DW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3877.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e45a186-f9d9-4902-3d03-08d931793596
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 10:18:10.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIuAyUh2QF0nH0kALS9A9kd1PKwdr+9z0HkwgJWHyAz5E28ljTGrdkIiT5/mmAB4bhoPXH7KNDc8lJicCjRUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5354
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDE3LCAyMDIx
IDM6MzQgUE0NCj4gVG86IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgTWFuaXNo
IE5hcmFuaQ0KPiA8TU5BUkFOSUB4aWxpbnguY29tPjsgU2FpIEtyaXNobmEgUG90dGh1cmkgPGxh
a3NobWlzQHhpbGlueC5jb20+DQo+IENjOiByYXNobWkuYUBpbnRlbC5jb207IGxpbnV4LWRyaXZl
cnMtcmV2aWV3LXJlcXVlc3RAZWNsaXN0cy5pbnRlbC5jb207DQo+IGxpbnV4LW1tYyA8bGludXgt
bW1jQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgS2lzaG9uIDxraXNob25AdGkuY29tPjsgVmlub2QgS291
bA0KPiA8dmtvdWxAa2VybmVsLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPjsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IE1h
cmsNCj4gR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+OyBrcmlzLnBhbkBsaW51eC5pbnRl
bC5jb207DQo+IGZ1cm9uZy56aG91QGludGVsLmNvbTsgbWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5h
dmFyQGludGVsLmNvbTsgQWRyaWFuDQo+IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBtYWhlc2guci52YWlkeWFAaW50ZWwuY29tOw0KPiBuYW5kaGluaS5zcmlrYW5kYW5AaW50ZWwu
Y29tOyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPiA8bGFrc2htaS5iYWkucmFqYS5z
dWJyYW1hbmlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb4oCcUEFUQ0jigJ0gMS8yXSBt
bWM6IHNkaGNpLW9mLWFyYXNhbjogVXNlIGNsb2NrLWZyZXF1ZW5jeQ0KPiBwcm9wZXJ0eSB0byB1
cGRhdGUgY2xrX3hpbg0KPiANCj4gT24gRnJpLCA0IEp1biAyMDIxIGF0IDA4OjEzLCBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4g
PiBPbiA2LzMvMjEgODoyMiBQTSwgcmFzaG1pLmFAaW50ZWwuY29tIHdyb3RlOg0KPiA+ID4gRnJv
bTogUmFzaG1pIEEgPHJhc2htaS5hQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBJZiBjbG9jay1m
cmVxdWVuY3kgcHJvcGVydHkgaXMgc2V0IGFuZCBpdCBpcyBub3QgdGhlIHNhbWUgYXMgdGhlDQo+
ID4gPiBjdXJyZW50IGNsb2NrIHJhdGUgb2YgY2xrX3hpbihiYXNlIGNsb2NrIGZyZXF1ZW5jeSks
IHNldCBjbGtfeGluIHRvDQo+ID4gPiB1c2UgdGhlIHByb3ZpZGVkIGNsb2NrIHJhdGUuDQo+ID4g
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFzaG1pIEEgPHJhc2htaS5hQGludGVsLmNvbT4NCj4g
PiA+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCAx
NCArKysrKysrKysrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
YXJhc2FuLmMNCj4gPiA+IGluZGV4IDgzOTk2NWY3YzcxNy4uMGU3YzA3ZWQ5NjkwIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+ID4gQEAgLTE1NDIsNiAr
MTU0Miw4IEBAIHN0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgICAgICAgICAgICAgIH0NCj4gPiA+ICAgICAgIH0NCj4g
PiA+DQo+ID4gPiArICAgICBzZGhjaV9nZXRfb2ZfcHJvcGVydHkocGRldik7DQo+ID4gPiArDQo+
ID4gPiAgICAgICBzZGhjaV9hcmFzYW4tPmNsa19haGIgPSBkZXZtX2Nsa19nZXQoZGV2LCAiY2xr
X2FoYiIpOw0KPiA+ID4gICAgICAgaWYgKElTX0VSUihzZGhjaV9hcmFzYW4tPmNsa19haGIpKSB7
DQo+ID4gPiAgICAgICAgICAgICAgIHJldCA9IGRldl9lcnJfcHJvYmUoZGV2LA0KPiA+ID4gUFRS
X0VSUihzZGhjaV9hcmFzYW4tPmNsa19haGIpLCBAQCAtMTU2MSwxNCArMTU2MywyMiBAQCBzdGF0
aWMgaW50DQo+IHNkaGNpX2FyYXNhbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ID4gICAgICAgICAgICAgICBnb3RvIGVycl9wbHRmbV9mcmVlOw0KPiA+ID4gICAgICAg
fQ0KPiA+ID4NCj4gPiA+ICsgICAgIC8qIElmIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSBpcyBz
ZXQsIHVzZSB0aGUgcHJvdmlkZWQgdmFsdWUgKi8NCj4gPiA+ICsgICAgIGlmIChwbHRmbV9ob3N0
LT5jbG9jayAmJg0KPiA+ID4gKyAgICAgICAgIHBsdGZtX2hvc3QtPmNsb2NrICE9IGNsa19nZXRf
cmF0ZShjbGtfeGluKSkgew0KPiA+ID4gKyAgICAgICAgICAgICByZXQgPSBjbGtfc2V0X3JhdGUo
Y2xrX3hpbiwgcGx0Zm1faG9zdC0+Y2xvY2spOw0KPiA+ID4gKyAgICAgICAgICAgICBpZiAocmV0
KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiRmFp
bGVkIHRvIHNldCBTRCBjbG9jayByYXRlXG4iKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGNsa19kaXNfYWhiOw0KPiA+ID4gKyAgICAgICAgICAgICB9DQo+ID4gPiArICAgICB9
DQo+ID4gPiArDQo+ID4gPiAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoY2xrX3hpbik7
DQo+ID4gPiAgICAgICBpZiAocmV0KSB7DQo+ID4gPiAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiVW5hYmxlIHRvIGVuYWJsZSBTRCBjbG9jay5cbiIpOw0KPiA+ID4gICAgICAgICAgICAgICBn
b3RvIGNsa19kaXNfYWhiOw0KPiA+ID4gICAgICAgfQ0KPiA+ID4NCj4gPiA+IC0gICAgIHNkaGNp
X2dldF9vZl9wcm9wZXJ0eShwZGV2KTsNCj4gPiA+IC0NCj4gPiA+ICAgICAgIGlmIChvZl9wcm9w
ZXJ0eV9yZWFkX2Jvb2wobnAsICJ4bG54LGZhaWxzLXdpdGhvdXQtdGVzdC1jZCIpKQ0KPiA+ID4g
ICAgICAgICAgICAgICBzZGhjaV9hcmFzYW4tPnF1aXJrcyB8PQ0KPiA+ID4gU0RIQ0lfQVJBU0FO
X1FVSVJLX0ZPUkNFX0NEVEVTVDsNCj4gPiA+DQo+ID4gPg0KPiA+DQo+ID4gTWFuaXNoL1NhaTog
UGxlYXNlIHJldGVzdCB0aGlzIG9uIFhpbGlueCBTT0MuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
TWljaGFsDQo+IA0KPiBJIGFtIGFib3V0IHRvIHF1ZXVlIHRoaXMgcGF0Y2gsIGJ1dCBpdCB3b3Vs
ZCBiZSBuaWNlIHRvIGdldCB5b3VyIGNvbmZpcm1hdGlvbg0KPiBhbmQgdGVzdGVkLWJ5IHRhZ3Mg
YmVmb3JlIGRvaW5nIHNvLiBXb3VsZCB0aGF0IGJlIHBvc3NpYmxlIHdpdGhpbiB0aGUgbmV4dA0K
PiBjb3VwbGUgb2YgZGF5cz8NClRlc3RlZCB0aGlzIHBhdGNoIG9uIFhpbGlueCBwbGF0Zm9ybXMu
DQpUZXN0ZWQtYnk6IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxsYWtzaG1pLnNhaS5rcmlzaG5hLnBv
dHRodXJpQHhpbGlueC5jb20+DQoNClJlZ2FyZHMNClNhaSBLcmlzaG5hDQo=
