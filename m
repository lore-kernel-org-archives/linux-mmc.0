Return-Path: <SRS0=muGE=BC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29999C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB4320888
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 08:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGWIQg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:16:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43096 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgGWIQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jul 2020 04:16:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06N8GA0A0015679, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06N8GA0A0015679
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 16:16:10 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jul 2020 16:16:10 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jul 2020 16:16:10 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Thu, 23 Jul 2020 16:16:10 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 0/5] minor rtsx cleanups
Thread-Topic: [PATCH 0/5] minor rtsx cleanups
Thread-Index: AQHWX6U7/EnDl+omQUONkIrG0NSvaKkSBlyAgALLY3A=
Date:   Thu, 23 Jul 2020 08:16:10 +0000
Message-ID: <9f42cc48087a447a8ff295a86d439039@realtek.com>
References: <20200721212336.1159079-1-helgaas@kernel.org>
 <CAK8P3a0aqus-7Z-qSc9J+gOsSCX5Ad570F-3a_HB1MHfJor7Bg@mail.gmail.com>
In-Reply-To: <CAK8P3a0aqus-7Z-qSc9J+gOsSCX5Ad570F-3a_HB1MHfJor7Bg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQXJuZCwgQmpvcm4sDQoNClNvIEhvdyBjYW4gSSBkbyBmb3Igbm93Pw0KSSBuZWVkIHRvIHdh
aXQgQmpvcm4ncyBwYXRjaCBhcHBsaWVkIGFuZCByZXN1Ym1pdCBwYXRjaCBmb3Igb3VyIG5ldyBj
aGlwIFJUUzUyMjggYmFzZSBvbiBCam9ybidzIHBhdGNoIG9yID8NCg0KUmlja3kNCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQgQmVyZ21hbm4gW21haWx0bzph
cm5kQGFybmRiLmRlXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjIsIDIwMjAgNToyOSBBTQ0K
PiBUbzogQmpvcm4gSGVsZ2Fhcw0KPiBDYzog5ZCz5piK5r6EIFJpY2t5OyBHcmVnIEtyb2FoLUhh
cnRtYW47IFVsZiBIYW5zc29uOyBSdWkgRmVuZzsgS2xhdXMgRG90aDsNCj4gTGludXMgV2FsbGVp
ajsgUnVpIE1pZ3VlbCBTaWx2YTsgUHVyYW5qYXkgTW9oYW47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LW1tYzsgQmpvcm4gSGVsZ2Fhcw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDAvNV0gbWlub3IgcnRzeCBjbGVhbnVwcw0KPiANCj4gT24gVHVlLCBKdWwgMjEsIDIwMjAg
YXQgMTE6MjMgUE0gQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4g
Pg0KPiA+IEZyb206IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+ID4NCj4g
PiBDbGVhbiB1cCBzb21lIG5lZWRsZXNzbHkgZGV2aWNlLXNwZWNpZmljIHN0dWZmIGluIHRoZSBS
ZWFsdGVrIGNhcmQgcmVhZGVyDQo+ID4gZHJpdmVycy4NCj4gPg0KPiA+IFRoaXMgaW1wbGVtZW50
cyBzb21lIG9mIG15IHN1Z2dlc3Rpb25zIGZyb20NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjAwNzIwMjIwNjUxLkdBMTAzNTg1N0Biam9ybi1QcmVjaXNpb24tNTUyMA0KPiA+DQo+
ID4gVGhpcyB3aWxsIGNvbmZsaWN0IHdpdGggUmlja3kncyBwb3N0IGhlcmU6DQo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMDcwNjA3MDI1OS4zMjU2NS0xLXJpY2t5X3d1QHJlYWx0
ZWsuY29tDQo+ID4NCj4gPiBJJ2xsIGJlIGhhcHB5IHRvIHVwZGF0ZSB0aGlzIG9uIHRvcCBvZiBS
aWNreSdzIHBhdGNoIGFmdGVyIGl0J3MgYXBwbGllZCwgb3INCj4gPiBSaWNreSBjb3VsZCBwaWNr
IHVwIHRoZXNlIHBhdGNoZXMgYW5kIGJhc2UgaGlzIG9uIHRvcC4NCj4gDQo+IA0KPiBMb29rcyBh
bGwgZ29vZCB0byBtZSwNCj4gDQo+IEFja2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPg0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUg
cHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
