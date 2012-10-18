From: Yong Ding <yongd@marvell.com>
Subject: RE: [PATCH 1/3] mmc: esdhc: enable polling to detect card by itself
Date: Thu, 18 Oct 2012 00:19:22 -0700
Message-ID: <89813612683626448B837EE5A0B6A7CB3038856013@SC-VEXCH4.marvell.com>
References: <1348828113-19668-1-git-send-email-yongd@marvell.com>
 <1348828113-19668-2-git-send-email-yongd@marvell.com>
 <20121007140648.GA10148@S2101-09.ap.freescale.net>
 <89813612683626448B837EE5A0B6A7CB30388601C9@SC-VEXCH4.marvell.com>
 <20121018054053.GA4513@S2101-09.ap.freescale.net>
 <89813612683626448B837EE5A0B6A7CB3038855FF9@SC-VEXCH4.marvell.com>
 <20121018063825.GC4513@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:40373 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785Ab2JRHVs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 03:21:48 -0400
In-Reply-To: <20121018063825.GC4513@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>, Zhangfei Gao <zgao6@marvell.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

U2hhd24sDQpUaGFua3MsIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIGZvciBzZGhjaS1lc2RoYy1p
bXguYyBhbmQgYWxzbyBmaXggbXkgbWFpbCBBU0FQOi0pDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBTaGF3biBHdW8gW21haWx0bzpzaGF3bi5ndW9AbGluYXJvLm9yZ10gDQpT
ZW50OiAyMDEyxOoxMNTCMTjI1SAxNDozOA0KVG86IFlvbmcgRGluZw0KQ2M6IENocmlzIEJhbGw7
IEFudG9uIFZvcm9udHNvdjsgTWFyZWsgU3p5cHJvd3NraTsgV29sZnJhbSBTYW5nOyBEYW5pZWwg
RHJha2U7IFNhc2NoYSBIYXVlcjsgV2lsc29uIENhbGxhbjsgQmVuIERvb2tzOyBaaGFuZ2ZlaSBH
YW87IEtldmluIExpdTsgSmlhbGluZyBGdTsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIG1tYzog
ZXNkaGM6IGVuYWJsZSBwb2xsaW5nIHRvIGRldGVjdCBjYXJkIGJ5IGl0c2VsZg0KDQpDYW4geW91
IGZpeCB5b3VyIG1haWxlciB0byB1c2UgYm90dG9tIHBvc3RpbmcgcmF0aGVyIHRoYW4gdG9wIHBv
c3RpbmcsDQphbmQgaGF2ZSB0ZXh0cyB3cmFwIGFyb3VuZCBjb2x1bW4gNzA/ICBPdGhlcndpc2Us
IHlvdSBtZXNzYWdlIHN0YW5kcw0KYSBnb29kIGNoYW5jZSB0byBiZSBpZ25vcmVkIGJ5IHBlb3Bs
ZS4NCg0KT24gV2VkLCBPY3QgMTcsIDIwMTIgYXQgMTE6Mjc6MTdQTSAtMDcwMCwgWW9uZyBEaW5n
IHdyb3RlOg0KPiBTaGF3biwNCj4gVGhhbmtzLiBPaCwgc29ycnkgSSByZWFsbHkgaGF2ZSBtaXNz
ZWQgdGhlIGZhY3QgdSBtZW50aW9uZWQuIFUgYXJlIHJpZ2h0IGluIHRoZSBjdXJyZW50IGNvZGUs
IHRoZSBiaXQgd2lsbCBhbHNvIGJlIGNsZWFyZWQgZm9yIEVTREhDX0NEX0dQSU8uIA0KPiBCdXQg
SSB0aGluayB0aGlzIGlzIGltcHJvcGVyIHNpbmNlIGZvciBHUElPIGRldGVjdGlvbiB0eXBlLCB3
ZSBkb24ndCB1c2UgdGhlIGhvc3QgY29udHJvbGxlciBpbnRlcm5hbCBjYXJkIGRldGVjdGlvbihF
U0RIQ19DRF9DT05UUk9MTEVSKSwgYnV0IHdpdGggU0RIQ0lfUVVJUktfQlJPS0VOX0NBUkRfREVU
RUNUSU9OIGNsZWFyZWQsIHdlJ2xsIHN0aWxsIGVuYWJsZS9kaXNhYmxlIHJlbGV2YW50IElOVCBi
aXRzIChpbiBzZGhjaV9zZXRfY2FyZF9kZXRlY3Rpb24gaW4gc2RoY2kuYykuIFRoaXMgaXMgbXkg
YmlnZ2VzdCBjb25jZXJuLiBBbmQgSSB0aGluayB0aGUgU0RIQ0lfUVVJUktfQlJPS0VOX0NBUkRf
REVURUNUSU9OIHNoYWxsIGJlIHB1cmVseSB1c2VkIHRvIG5vdGlmeSB3aGV0aGVyIHRoZSBob3N0
IGNvbnRyb2xsZXIgZGV0ZWN0aW9uIG1ldGhvZCBpcyB1c2VkIG9yIG5vdC4gU28gZXZlbiBmb3Ig
dGhlIEVTREhDX0NEX0dQSU8gdHlwZSwgd2Ugc2hvdWxkIHN0aWxsIHNldCB0aGlzIGZsYWcuIEhv
dyBkbyB1IHRoaW5rPw0KPiANCkknbSBmaW5lIHdpdGggdGhhdC4gIEp1c3QgcmVtaW5kIHlvdSBh
IGZhY3QgeW91IHNlZW0gbWlzc2VkIGluIGNhc2UNCnlvdSBuZWVkIHRvIGNoYW5nZSBzZGhjaS1l
c2RoYy1pbXguYyB0byBhZGFwdCB0aGUgY2hhbmdlcyB5b3UgYXJlIGdvaW5nDQp0byBtYWtlIG9u
IHNkaGNpLmMuDQoNClNoYXduIA0K
