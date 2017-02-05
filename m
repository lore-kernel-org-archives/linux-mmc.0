From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Sun, 5 Feb 2017 15:13:41 +0000
Message-ID: <695B0367-2BA5-4B95-AF75-6BD43FE17528@sandisk.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:24998
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751442AbdBEPNt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 5 Feb 2017 10:13:49 -0500
In-Reply-To: <935e77c5-7e6a-00e0-9064-ea9dbcb4fef5@rock-chips.com>
Content-Language: en-US
Content-ID: <99CC85637AF0D046B74AADC374DD043C@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Uri Yanai <Uri.Yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Harjani Ritesh <riteshh@codeaurora.org>

SGkgU2hhd24sDQoNCk9uIDIvNS8xNywgMzo0MyBBTSwgIlNoYXduIExpbiIgPHNoYXduLmxpbkBy
b2NrLWNoaXBzLmNvbT4gd3JvdGU6DQoNCg0KICAgID4NCiAgICA+IEhtbS4NCiAgICA+DQogICAg
PiBTaG91bGRuJ3Qgd2UgYWJvcnQgKHJldHVybiAtRUJVU1kpIGFsc28gaW4gdGhlIHN5c3RlbSBQ
TSBzdXNwZW5kIGNhc2UNCiAgICA+IGFuZCBub3Qgb25seSBmb3IgcnVudGltZSBQTSBzdXNwZW5k
Pw0KICAgIA0KICAgIEkgd291bGQgcmF0aGVyIHdlIGRvbid0IGFib3J0IHJ1bnRpbWUgUE0sIGJ1
dCBkbyBpdCBmb3Igc3lzdGVtIFBNDQogICAgaW5zdGVhZC4gV2hhdCB3ZSBkbyBmb3IgcnVudGlt
ZSBQTSBpcyBqdXN0IGZvciBzYXZpbmcgcG93ZXIgZm9yDQogICAgb3VyIGhvc3RzIGluY2x1ZGlu
ZyBtYW5pcHVsYXRpbmcgY2xvY2sgYW5kIGdlbnBkIGV0Yy4uIFRodXMgd2UgZG9uJ3QNCiAgICB0
b3VjaCBhbnkgcG93ZXItc3VwcGx5IGZvciBlTU1DLiBJZiBzbywgaXQgY291bGQgc3RpbGwgYmUg
cG9zc2libGUNCiAgICBmb3IgZU1NQyBmaXJtd2FyZSB0byB3b3JrIG9uIGRvaW5nIGJrb3BzIGlu
IHJwbSBjb250ZXh0Lg0KDQpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB5b3UgYXJlIHN1Z2dl
c3RpbmcgZG8gbm90IHNlbmQgU0xFRVAgY29tbWFuZA0Kb24gUnVudGltZSBTdXNwZW5kPw0KSWYg
c28sIGFuZCBpZiBtbWMgaG9zdCBkb2VzIG5vdCB0b3VjaCBhbnkgcG93ZXIgc3VwcGx5IGZvciBl
TU1DLCANCnRoZSBkZXZpY2UgY2FuIGNvbnRpbnVlIGRvaW5nIEF1dG8gQktPUFMgZHVyaW5nIFJ1
bnRpbWUgU3VzcGVuZC4NClRoZSBxdWVzdGlvbiBpcyB3aHkgdGhlIFNsZWVwIGNvbW1hbmQgaXMg
c2VudCBub3csDQppbiB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24/DQpJIGFzc3VtZSBpdCBp
cyBzZW50IGZvciBzYXZpbmcgYSBwb3dlciBmcm9tIHRoZSBkZXZpY2Ugc2lkZSBhcyB3ZWxsPyAN
Cg0K
