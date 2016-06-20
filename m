From: Alex Lemberg <Alex.Lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 20 Jun 2016 13:33:30 +0000
Message-ID: <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD@sandisk.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
 <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <d5c75760-e8b4-1784-a7de-3d78eeca1d0e-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
Content-ID: <24FB7E168B311C4C806FBE03E87CD017-GsdMcTDXqN6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SGkgU2hhd24sDQoNClvigKZdDQoNCj4+PiArDQo+Pj4gK3N0YXRpYyBpbnQgbW1jX3N0b3BfYXV0
b19ia29wcyhzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpDQo+Pj4gK3sNCj4+PiArCWludCBlcnIgPSAw
Ow0KPj4+ICsNCj4+PiArCWlmICghY2FyZC0+ZXh0X2NzZC5hdXRvX2Jrb3BzX2VuKQ0KPj4+ICsJ
CXJldHVybiAwOw0KPj4+ICsNCj4+DQo+PiBTaG91bGRu4oCZdCB0aGUgQktPUFNfU1RBVFVTIGJl
IGNoZWNrZWQgcHJpb3IgdG8gZGlzYWJsaW5nIHRoZSBCS09QUyBhY3Rpdml0eSBvZiB0aGUgZGV2
aWNlPw0KPj4NCj4NCj5Icm1tLi4gSSByZWFkIHRoZSB3aG9sZSBzZWN0aW9uIG9mIHNwZWMgZm9y
IGl0LCBhbmQgSSBkaWQgZmluZCB0aGlzDQo+cmVxdWlyZW1lbnQgZm9yIG1hbnVsIGJrb3BzIGJ1
dCBub3QgZm9yIHRoZSBhdXRvIG9uZS4gU28gd2hhdCBzaG91bGQgd2UNCj5kbyBpZiB1c2luZyB0
aGUgYXV0byBvbmU/DQo+DQoNCkluIGNhc2Ugb2YgQVVUTyBCS09QUywgdGhlIGVNTUMgRGV2aWNl
IHNob3VsZCBwZXJmb3JtIGludGVybmFsIEdDIA0KaW4gdGhlIHNhbWUgd2F5IGFzIGluIGNhc2Ug
b2YgTUFOVUFMIEJLT1BTLg0KVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBhIGhvc3QgYXdhcmVuZXNz
LiANCkFsdGhvdWdoIHRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IGluIHRoZSBzcGVjLCBJIHRoaW5r
IHRoZSBkcml2ZXIgY2FuDQpnaXZlIHNvbWUgdGltZSB0byB0aGUgZGV2aWNlIHRvIHBlcmZvcm0v
Y29tcGxldGUgaXRzIGludGVybmFsIEdDIGR1cmluZyB0aGUgaWRsZSB0aW1lLg0KVGh1cyBJIHRo
aW5rIHdlIGNhbiBjaGVjayB0aGUgQktPUFNfU1RBVFVTIG9uIFJ1bnRpbWUgc3VzcGVuZC4NCg0K
W+KApl0NCg0KVGhhbmtzLA0KQWxleA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2No
aXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
