From: Alex Lemberg <Alex.Lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 27 Jun 2016 11:30:48 +0000
Message-ID: <BCC7912B-462E-445B-B8BE-E333AD894E22@sandisk.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
 <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
 <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD@sandisk.com>
 <29966a6f-eb14-0307-08cc-f91a97f50382@rock-chips.com>
 <B7133967-23A7-46AF-9013-417BD282E005@sandisk.com>
 <23729258-7a6b-80ac-6c90-b48eed64e0ea@rock-chips.com>
 <576B7211.2030208@intel.com>
 <CAPDyKFoxTH_-U_Aj0jHWPKbwd+4OoOYBTdOeD-6SpG4XyM=3AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFoxTH_-U_Aj0jHWPKbwd+4OoOYBTdOeD-6SpG4XyM=3AA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <08D0622F6E2B24408B603A210CD59AE2-GsdMcTDXqN6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SGkgVWxmIGFuZCBBZHJpYW4sDQoNCg0KT24gNi8yNy8xNiwgMTI6MDggUE0sICJVbGYgSGFuc3Nv
biIgPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IHdyb3RlOg0KDQo+Wy4uLl0NCj4NCj4+Pj4gSWYg
SSBhbSBub3Qgd3JvbmcsIGluIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgcnVudGltZSBzdXNw
ZW5kLA0KPj4+PiB0aGUgZHJpdmVyIHN0b3BzIEJLT1BTIChzZW5kIEhQSSkganVzdCBiZWZvcmUg
c2VuZGluZyBzbGVlcCBjb21tYW5kLA0KPj4+PiBzZWUgX21tY19zdXNwZW5kKCksIGRlcGVuZHMg
b24g4oCcTU1DX0NBUF9BR0dSRVNTSVZFX1BN4oCdIGZsYWcuDQo+Pj4+IEluIHRoaXMgY2FzZSwg
dGhlIGVNTUMgZGV2aWNlIHdpbGwgbm90IGhhdmUgZW5vdWdoIHRpbWUgdG8gcGVyZm9ybSBpbnRl
cm5hbA0KPj4+PiBCS09QUyBpbiBib3RoIOKAkyBNYW51YWwgYW5kIEF1dG8gQktPUFMgY29uZmln
dXJhdGlvbnMuDQo+Pj4+DQo+Pj4NCj4+PiB5ZSwgc28gaXQgc2VlbXMgYSBwcmUtZXhpdGluZyBp
c3N1ZSBiZWZvcmUgaW50cm9kdWNpbmcgYXV0byBia29wcz8NCj4+PiBJIHRoaW5rIHdlIGNhbiBw
dXNoIGFub3RoZXIgcGF0Y2ggdG8gaW1wcm92ZSBpdCBidXQgbm90IGhhbmRsaW5nDQo+Pj4gaXQg
Zm9yIHRoaXMgJFNVQkpFQ1QsIGRvZXMgaXQgc291bmQgb2sgdG8geW91Pw0KPj4NCj4+IFJ1bnRp
bWUgc3VzcGVuZCBmb3IgZU1NQyBoYXMgYSBkZWZhdWx0IGF1dG8tc3VzcGVuZCBkZWxheSBvZiAz
IHNlY29uZHMNCj4+IChyZWZlciBtbWNfYmxrX3Byb2JlKCkpLiAgSXNuJ3QgdGhhdCB3aGVuIGF1
dG8gYmtvcHMgd291bGQgaGFwcGVuPw0KPg0KPlRoYXQncyBjb3JyZWN0Lg0KPg0KPlNvIHBlcmhh
cHMgd2Ugc2hvdWxkIGV4dGVuZCB0aGUgZGVmYXVsdCBhdXRvLXN1c3BlbmQgZGVsYXk/DQoNCkR1
ZSB0byB0aGUgZGlmZmVyZW5jZXMgaW4gZmxhc2ggbWFuYWdlbWVudCBhbmQgdGVjaG5vbG9naWVz
LA0KSSBzdWdnZXN0IHRvIG1ha2UgdGhpcyB2YWx1ZSBjb25maWd1cmFibGUsIGFuZCBub3QgaGFy
ZCBjb2RlZC4NCkkgYmVsaWV2ZSBpdCBzaG91bGQgYmUgY29uZmlndXJlZCBwZXIgdmVuZG9yIEJL
T1BTIG5lZWRzLg0KVGhlIGRlZmF1bHQgdmFsdWUgc3RpbGwgY2FuIGJlIHNldCB0byAzIHNlY29u
ZHMsIGFzIGRvbmUgdG9kYXnigKYNCg0KPg0KPlRoZSBTRCBjYXNlIGFjdHVhbGx5IGhhdmUgdGhl
IHNhbWUgaXNzdWUsIGFzIEkgc29tZSBiYWNrZ3JvdW5kDQo+b3BlcmF0aW9ucyBleGlzdHMgdGhl
cmUgYXMgd2VsbC4NCj4NCj5bLi4uXQ0KPg0KPktpbmQgcmVnYXJkcw0KPlVmZmUNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAg
bWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
