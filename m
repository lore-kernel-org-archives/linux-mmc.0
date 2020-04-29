Return-Path: <SRS0=oXoI=6N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28291C83003
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23102087E
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LV6yTAD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD2IVW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:21:22 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22278 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbgD2IVW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Apr 2020 04:21:22 -0400
X-UUID: 0fca8db431cc45a6b64e23d1b1db0205-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lTlqFTrPf5IrpTbBnQKpE5jaipjUNN+C3YGiRSNSEWc=;
        b=LV6yTAD3UDfkQnSDnLIBnej7cdePvbLY4vLSinZMKhcmAzpjIBp2XQlnaOucWe+eN3ayWnLezCcrUVEYI7Wy2tOqxLCV6VJzk/eB8Q5CjOQfP4DJMxZgn75px+NQJikDpYI9xWBO8FFqJnmoPn3tfGitm2uLjq45xbWlqeWQ8bg=;
X-UUID: 0fca8db431cc45a6b64e23d1b1db0205-20200429
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1525058838; Wed, 29 Apr 2020 16:21:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 29 Apr
 2020 16:21:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 16:21:05 +0800
Message-ID: <1588148417.10768.18.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in
 mmc_sdio_resend_if_cond
From:   "yong.mao@mediatek.com" <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 29 Apr 2020 16:20:17 +0800
In-Reply-To: <CAPDyKFrBd0E2Qy89JgTE3YH0iiXB7due0JmnSVAhYL5aubSczA@mail.gmail.com>
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
         <1586835611-13857-2-git-send-email-yong.mao@mediatek.com>
         <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
         <1588066038.30914.28.camel@mhfsdcap03>
         <CAPDyKFrBd0E2Qy89JgTE3YH0iiXB7due0JmnSVAhYL5aubSczA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A51CEC974ABE8E0E27E20E1F54AE553FB2971B2713AD31F285230F0E28E9CB742000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTI4IGF0IDE0OjEzICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gVHVlLCAyOCBBcHIgMjAyMCBhdCAxMToyOCwgeW9uZy5tYW9AbWVkaWF0ZWsuY29tDQo+IDx5
b25nLm1hb0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiBGcmksIDIwMjAt
MDQtMjQgYXQgMTI6MDkgKzAyMDAsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAx
NCBBcHIgMjAyMCBhdCAwNTo0MCwgWW9uZyBNYW8gPHlvbmcubWFvQG1lZGlhdGVrLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IHlvbmcgbWFvIDx5b25nLm1hb0BtZWRpYXRlay5j
b20+DQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gbW1jX3NkaW9fcmVzbmVkX2lmX2NvbmQgaXMgaW52
b2tlZCwgaXQgaW5kaWNhdGVzIHRoZSBTRElPDQo+ID4gPiA+IGRldmljZSBpcyBub3QgaW4gdGhl
IHJpZ2h0IHN0YXRlLiBJbiB0aGlzIGNvbmRpdGlvbiwgdGhlIHByZXZpb3VzDQo+ID4gPiA+IGlt
cGxlbWVudGF0aW9uIG9mIG1tY19zZGlvX3Jlc2VuZF9pZl9jb25kIGNhbid0IG1ha2Ugc3VyZSBT
RElPDQo+ID4gPiA+IGRldmljZSBiZSBiYWNrIHRvIGlkbGUgc3RhdGUuIG1tY19wb3dlcl9jeWNs
ZSBjYW4gcmVzZXQgdGhlIFNESU8NCj4gPiA+ID4gZGV2aWNlIGJ5IEhXIGFuZCBhbHNvIG1ha2Ug
c3VyZSBTRElPIGRldmljZSBlbnRlciB0byBpZGxlIHN0YXRlDQo+ID4gPiA+IGNvcnJlY3RseS4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBNYW8gPHlvbmcubWFvQG1lZGlh
dGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21tYy9jb3JlL3NkaW8uYyB8
IDEgKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYyBiL2RyaXZlcnMvbW1j
L2NvcmUvc2Rpby5jDQo+ID4gPiA+IGluZGV4IGViYjM4N2EuLmFkYTBhODAgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvc2Rpby5jDQo+ID4gPiA+IEBAIC01NDYsNiArNTQ2LDcgQEAgc3RhdGljIGludCBt
bWNfc2Rpb19pbml0X3Voc19jYXJkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiA+ID4gIHN0
YXRpYyB2b2lkIG1tY19zZGlvX3Jlc2VuZF9pZl9jb25kKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1tY19j
YXJkICpjYXJkKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiArICAgICAgIG1tY19wb3dlcl9jeWNsZSho
b3N0LCBob3N0LT5jYXJkLT5vY3IpOw0KPiA+ID4NCj4gPiA+IFRoaXMgbG9va3Mgd3JvbmcgdG8g
bWUuIG1tY19zZGlvX3Jlc2VuZF9pZl9jb25kKCkgaXMgY2FsbGVkIGZyb20gdHdvIHBsYWNlcy4N
Cj4gPiA+DQo+ID4gPiAxLiBJbiB0aGUgY2FzZSB3aGVuIG1tY19zZXRfdWhzX3ZvbHRhZ2UoKSBm
YWlscyBpbg0KPiA+ID4gbW1jX3NkaW9faW5pdF9jYXJkKCksIHdoaWNoIG1lYW5zIGEgY2FsbCB0
byBtbWNfcG93ZXJfY3ljbGUoKSBoYXMNCj4gPiA+IGFscmVhZHkgYmVlbiBkb25lLg0KPiA+ID4N
Cj4gPiAgIFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KPiA+ICAgWWVzLiBJdCBpcyByaWdodCB0
aGF0IG1tY19wb3dlcl9jeWNsZSgpIGhhcyBhbHJlYWR5IGJlZW4gZG9uZSB3aGVuDQo+ID4gICBt
bWNfc2Rpb19yZXNlbmRfaWZfY29uZCgpIGlzIGNhbGxlZC4gSW4gbm9ybWFsIHJlLWluaXRpYWxp
emF0aW9uIGNhc2UsDQo+ID4gICB0aGlzIG1tY19wb3dlcl9jeWNsZSgpIChjdXJyZW50bHkgaW4g
MS44diB2b2x0YWdlIGFuZCAyMDhNaHogY2xvY2spDQo+ID4gICBjYW4gbWFrZSBTRElPIGRldmlj
ZSByZWFsbHkgYmFjayB0byBpZGxlIHN0YXRlLiBVbmZvcnR1bmF0ZWx5LCBpbiBzb21lDQo+ID4g
ICBzcGVjaWFsIFNESU8gZGV2aWNlLCBpdCB3aWxsIGVudGVyIHRvIHVuc3RhYmxlIHN0YXRlLg0K
PiA+DQo+ID4gICBBdCB0aGlzIHVuc3RhYmxlIHN0YXRlLCBkZXZpY2UgbWF5IGtlZXAgZGF0YTAg
YWx3YXlzIGxvdyBhZnRlciByZWNlaXZpbmcgQ01EMTEuDQo+ID4gICBBbmQgdGhlbiBldmVyeSBv
dGhlciBTRElPIENNRCBjYW4ndCBiZSBzZW50IHRvIGRldmljZSBhbnkgbW9yZSBkdWUgdG8gY2Fy
ZA0KPiA+ICAgaXMgYnVzeShkYXRhMCBpcyBsb3cpLiBUaGVyZWZvcmUsIHByZXZpb3VzIGltcGxl
bWVudGF0aW9uIGNhbid0IHNhdmUgdGhlDQo+ID4gICBkZXZpY2UuIEF0IHRoaXMgdGltZSwgbW1j
X3Bvd2VyX2N5Y2xlKCkgbWF5IGJlIHRoZSBmaW5hbCBzb2x1dGlvbiB0byBtYWtlDQo+ID4gICBz
dXJlIFNESU8gZGV2aWNlIGNhbiBiYWNrIHRvIGlkbGUgc3RhdGUgY29ycmVjdGx5Lg0KPiANCj4g
V2VsbCwgdGhpcyBzdGlsbCBzb3VuZHMgYSBiaXQgdmFndWUgdG8gbWUuIEkgbmVlZCB0byB1bmRl
cnN0YW5kIG1vcmUNCj4gZXhhY3RseSB1bmRlciB3aGF0IGNpcmN1bXN0YW5jZXMgdGhlIHByb2Js
ZW0gb2NjdXJzLg0KPiANCj4gV2hhdCBwbGF0Zm9ybSBhcmUgeW91IHRlc3Rpbmcgd2l0aCBhbmQg
d2hhdCBTRElPIGNhcmQgaXMgYmVpbmcgdXNlZD8NCiBUaGUgcGxhdGZvcm0gaW5mb3JtYXRpb24g
aXMgbXQ4MTczICsgTWFydmVsbCBzZGlvIGRldmljZSArIGtlcm5lbC0zLjE4DQoNCj4gDQo+IElz
IHRoZSBwcm9ibGVtIGhhcHBlbmluZyBkdXJpbmcgdGhlIHN5c3RlbSByZXN1bWUgcGhhc2U/DQog
IFRoZSBwcm9ibGVtIGhhcHBlbiB3aGVuIG1tY19zZGlvX3J1bnRpbWVfcmVzdW1lIGlzIGludm9r
ZWQuDQo+IA0KPiBBcmUgdGhlIFNESU8gZnVuYyBkcml2ZXIgdXNpbmcgcnVudGltZSBQTSBhbmQg
dGhlbiBpcyB0aGUgaG9zdCBjYXBhYmxlDQo+IG9mIE1NQ19DQVBfUE9XRVJfT0ZGX0NBUkQ/DQo+
IA0KICBZZXMuIFNESU8gZnVuYyBkcml2ZXIgdXNlcyBydW50aW1lIFBNIGFuZCBNTUNfQ0FQX1BP
V0VSX09GRl9DQVJEIGlzDQplbmFibGVkLg0KDQo+IElzIGl0IGVhc3kgdG8gcmVwcm9kdWNlIHRo
ZSBwcm9ibGVtIGZvciB5b3U/DQo+IA0KIFRoZXJlIGFyZSBvbmx5IHR3byB1bml0cyBvdXQgb2Yg
bWFueSBwcm9kdWNlZCB1bml0cyB0aGF0IGNhbiBhbHdheXMNCnJlcHJvZHVjZSB0aGlzIGlzc3Vl
Lg0KIA0KPiA+DQo+ID4gPiAyLiBXZW4gc2Rpb19yZWFkX2NjY3IoKSBmYWlscyBhbmQgd2hlbiB3
ZSBkZWNpZGUgdG8gcmV0cnkgdGhlIFVIUy1JDQo+ID4gPiB2b2x0YWdlIHN3aXRjaC4gVGhlbiBw
ZXJoYXBzIGl0IGNvdWxkIG1ha2Ugc2Vuc2UgdG8gcnVuIGEgcG93ZXIgY3ljbGUuDQo+ID4gPiBC
dXQgaWYgc28sIHdlIGJldHRlciBkbyBpdCBvbmx5IGZvciB0aGF0IHBhdGguDQo+ID4gPg0KPiA+
ID4gSSB3aWxsIGNvbnRpbnVlIHRvIGxvb2sgYSBiaXQsIGFzIEkgdGhpbmsgdGhlcmUgYXJlIHJl
YWxseSBtb3JlIGlzc3Vlcw0KPiA+ID4gdGhhdCB3ZSBtYXkgd2FudCB0byBsb29rIGludG8gd2hp
bGUgbG9va2luZyBhdCB0aGlzIHBpZWNlIG9mIGNvZGUuDQo+ID4gPiBIb3dldmVyLCBhbGxvdyBt
ZSBzb21lIG1vcmUgdGltZSBiZWZvcmUgSSBjYW4gcHJvdmlkZSBzb21lIG1vcmUgaWRlYXMNCj4g
PiA+IG9mIGhvdyB0byBtb3ZlIGZvcndhcmQuDQo+ID4gICBJbiB0aGUgYWN0dWFsIHByb2plY3Qs
IHdlIGRvIGVuY291bnRlciBtYW55IHJlbGF0aXZlIGlzc3VlcyBhYm91dCByZS1pbml0aWFsaXpl
ZCBjYXJkLg0KPiA+ICAgVGhlIGZvbGxvd2luZyB0d28gY2F0ZWdvcmllcyBhcmUgdGhlIG1vc3Qg
Y29tbW9uIGlzc3VlIHdlIG1ldCBiZWZvcmUuDQo+ID4gICBBLiB0aGUgU0RJTyBjYXJkIGlzIGlu
aXRpYWxpemVkIGJ5IFVIUy1JIG1vZGUgYXQgdGhlIGZpcnN0IHRpbWUsIGJ1dCB3aWxsIGJlDQo+
ID4gICAgICByZS1pbml0aWFsaXplZCBieSBIaWdoIFNwZWVkIG1vZGUgYXQgdGhlIHNlY29uZCB0
aW1lLg0KPiA+ICAgICAgPT0+IEFsbCB0aGlzIHR5cGUgb2YgaXNzdWVzIGlzIHJlbGF0aXZlIHdp
dGggUzE4QSBpbiByZXNwb25zZSBvZiBDTUQ1Lg0KPiA+ICAgICAgICAgIEFuZCBtb3N0IG9mIHRo
ZSBpc3N1ZXMgYXJlIHJlbGF0ZWQgdG8gdGhlIGludGVydmFsIGJldHdlZW4gcG93ZXJpbmcgb2Zm
IGFuZA0KPiA+ICAgICAgICAgIHBvd2VyaW5nIG9uIGNhcmQuDQo+ID4gICBCLiBJZiB0aGVyZSBp
cyBzb21ldGhpbmcgd3JvbmcgaW4gdGhlIGZsb3cgb2Ygdm9sdGFnZSBzd2l0Y2goYWZ0ZXIgQ01E
MTEpLCBjYXJkIHdpbGwNCj4gPiAgICAgIGFsd2F5cyBrZWVwIGFsbCBkYXRhIHBpbnMgdG8gbG93
LiBBbmQgdGhlbiBpdCBoYW5ncyB1cCBiZWNhdXNlIGRhdGEwIGlzIGFsd2F5cyBsb3cuDQo+ID4g
ICBIb3BlIHRoaXMgaW5mb3JtYXRpb24gd2lsbCBiZSBoZWxwZnVsIGZvciB5b3UuDQo+IA0KPiBU
aGFua3MgZm9yIHNoYXJpbmcgdGhlc2UgZGV0YWlscyEgSSB0aGluayB3ZSBuZWVkIHRvIGNvbnRp
bnVlIHRvIGRlYnVnDQo+IHRoaXMgaXNzdWUsIHRvIGZ1bGx5IHVuZGVyc3RhbmQuDQo+IA0KPiBJ
biBwcmluY2lwbGUsIGl0IHNvdW5kcyB0byBtZSB0aGF0IG1heWJlIG1tY19wb3dlcl9jeWNsZSgp
LCBpc24ndA0KPiByZWFsbHkgc3VjY2Vzc2Z1bGx5IHBvd2VyLWN5Y2xpbmcgdGhlIFNESU8gY2Fy
ZC4gUGVyaGFwcyBpbnNlcnQgYSBmZXcNCj4gZGVsYXlzIG9yIHNvIGluIHRoYXQgY29kZSB0byBz
ZWUgaG93IHRoYXQgd291bGQgYWZmZWN0IHRoaW5ncz8NCj4gDQo+IEFueXdheSwgaG93IGlzIHRo
ZSBwb3dlciB0byB0aGUgU0RJTyBjYXJkIGNvbnRyb2xsZWQgaW4gdGhpcyBjYXNlPyBBcmUNCj4g
eW91IHVzaW5nIGEgbW1jLXB3cnNlcT8NCj4gDQogIHZtbWMgaXMgY29udHJvbGxlZCB0aHJvdWdo
IEdQSU8gdG8gc3VwcGx5IDMuM3YgcG93ZXIuDQogIEFuZCB0aGUgdnFtbWMgaXMgc3VwcGxpZWQg
ZnJvbSBQTUlDIHdoaWNoIGlzIGFsd2F5cyAxLjh2Lg0KICAoVGhlcmUgaXMgbm8gMy4zdiBoZXJl
LiBQZXJoYXBzIHRoaXMgaXMgb25lIG9mIHRoZSByZWFzb25zIHRvIGhhcHBlbg0KdGhpcyBpc3N1
ZXMpDQoNCj4gPg0KPiA+ICAgQW55d2F5LCB3ZSB3aWxsIHdhaXQgZm9yIHlvdXIgYWR2aXNlcy4N
Cj4gPiA+DQo+ID4gPiA+ICAgICAgICAgc2Rpb19yZXNldChob3N0KTsNCj4gPiA+ID4gICAgICAg
ICBtbWNfZ29faWRsZShob3N0KTsNCj4gPiA+ID4gICAgICAgICBtbWNfc2VuZF9pZl9jb25kKGhv
c3QsIGhvc3QtPm9jcl9hdmFpbCk7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDEuOS4xDQo+ID4gPg0K
PiA+ID4gS2luZCByZWdhcmRzDQo+ID4gPiBVZmZlDQo+IA0KPiBJIGhhdmUgYSBmZXcgcGF0Y2hl
cyBpbiB0aGUgcGlwZSwgd2hpY2ggZml4ZXMgc29tZSBvdGhlciBwcm9ibGVtcyBpbg0KPiBtbWNf
c2Rpb19pbml0X2NhcmQoKS4gUG9zc2libHkgdGhvc2UgY2FuIGJlIHJlbGF0ZWQsIGJ1dCBJIG5l
ZWQgYSBkYXkNCj4gb3Igc28gdG8gcG9zdCB0aGVtLCBsZXQncyBzZWUuDQpUaGUgY29kZWJhc2Ug
b2YgdGhpcyBwcm9qZWN0IGlzIGtlcm5lbC0zLjE4LiBNYXliZSBpdCBpcyBoYXJkIHRvIGFwcGx5
IA0KdGhlc2UgbmV3IHBhdGNoZXMuIEFueXdheSwgV2Ugd2lsbCB0cnkgaXQgd2hlbiB3ZSBnZXQg
dGhlIHBhdGNoZXMuDQpUaGFua3MuIA0KDQoNCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQoN
Cg==

