From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Properly set corecfg_clockmultipler
 on rk3399
Date: Sat, 27 Aug 2016 10:10:40 +0800
Message-ID: <85d066af-e41b-90c5-a567-6727c6da6438@rock-chips.com>
References: <1472181736-17848-1-git-send-email-shawn.lin@rock-chips.com>
 <1dc7898d-ee35-4166-6313-64e9c50f8db8@rock-chips.com>
 <d6c3b728-af01-e724-3278-1bc0801f8fb4@rock-chips.com>
 <7490888.x1BxhdeR20@diego>
 <CAD=FV=UD-9PwQFm4x4Uqx5mQjEirD9icyYHPDaVjU4tRgk-f+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAD=FV=UD-9PwQFm4x4Uqx5mQjEirD9icyYHPDaVjU4tRgk-f+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

T24gMjAxNi84LzI2IDIzOjQ2LCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+IEhpLAo+Cj4gT24gRnJp
LCBBdWcgMjYsIDIwMTYgYXQgMTozMSBBTSwgSGVpa28gU3TDvGJuZXIgPGhlaWtvQHNudGVjaC5k
ZT4gd3JvdGU6Cj4+IFRoZSBhY2xrX2VtbWNfZ3JmIGlzIChzaW1pbGFyIHRvIGFjbGtfdmlvX2dy
ZiBldGMpIHBhcnQgb2YgdGhlIGVtbWMgYmxvY2suCj4KPiBSaWdodCBub3cgYWNsa19lbW1jX2dy
ZiBpcyBzZXQgYXMgQ0xLX0lHTk9SRV9VTlVTRUQsIHdoaWNoIGlzIG15IGxlYXN0Cj4gZmF2b3Jp
dGUgY2xvY2sgcHJvcGVydHkuICA7KQo+Cj4gRHVlIHRvIHRoZSBwYXJlbnRpbmcgc3RydWN0dXJl
IGFuZCB0aGUgZmFjdCB0aGF0IHdlIGp1c3QgYWRkZWQKPiAiYWNsa19lbW1jX25vYyIgYXMgYSBj
cml0aWNhbCBjbG9jaywgSSBiZWxpZXZlIHRoYXQgdGhpcyBtZWFucyB0aGF0Cj4gYWNsa19lbW1j
X2dyZiB3aWxsIG5ldmVyIHR1cm4gb2ZmLiAgSXQgd291bGQgYmUgYXdmdWxseSBuaWNlIGlmIHlv
dQoKSXQganVzdCBtZWFucyB3ZSBkb24ndCBnYXRlIGFjbGtfZW1tY19ncmYvYWNsa19lbW1jX25v
YyBpZiBub3QgCnJlZmVyZW5jZWQsIGJ1dCBhY3R1YWxseSB3ZSBkb24ndCBwcmV2ZW50IGNsayBk
cml2ZXIgdG8gZ2F0ZSBpdHMgcGFyZW50CndoaWNoIG1lYW5zIGl0IGlzbid0IHJlYWxseSBDTEtf
SUdOT1JFX1VOVVNFRCBvciBjcml0aWNhbCB0byBhIGNlcnRhaW4KZGVncmVlIGZyb20gbXkgcGVy
c29uYWwgdmlldyBhcyB3ZSBtYXkgbmVlZCB0byBwcm9wYWdhdGUgdGhpcyBmZWF0dXJlCmZvcndh
cmQgdG8gaXRzIHBhcmVudHMuCgpBbnl3YXksIHRoYXQgc2VlbXMgYSBiaXQgYmV5b25kIHRoZSB0
b3BpYyBvZiB3aGF0ICRTVUJKRUNUIHdhbm5hIGhhbmRsZQp3aXRoLiBCdXQgSSBhZ3JlZSB0aGF0
IHdlIHNob3VsZCBtYWtlIHRoaXMgZGVwZW5kZW5jeSByZWxhdGlvbnNoaXAgbW9yZQpleGxpY2l0
IHRvIHVzZXJzIGFueXdheS4KCkkgd2lsbCBkbyBpdCBvbmNlICRTVUJKRUNUIGFwcGxpZWQuIDop
CgpUaGFua3MuCgo+IGNvdWxkIHNlbmQgdXAgYSBwYXRjaCB0byBhY3R1YWxseSB0dXJuIHRoZSAi
Z3JmIiBjbG9jayBvbiB3aGVuIG5lZWRlZAo+IGFuZCB0dXJuIGl0IG9mZiB3aGVuIG5vdCBuZWVk
ZWQuICBUaGF0IHdvdWxkIGxldCB1cyByZW1vdmUgdGhlCj4gIkNMS19JR05PUkVfVU5VU0VEIiBm
cm9tIGFsbCBvZiB0aGUgZU1NQyBjbG9ja3MgaW4gcmszMzk5Lgo+Cj4gSSBub3RpY2VkIHlvdSBz
ZW5kIHYyIG9mIHlvdXIgcGF0Y2ggc2VyaWVzIGFuZCB0aGF0IGxvb2tzIGZpbmUgdG8gbWUuCj4g
VGhlIGlzc3VlIHdpdGggbm90IGhhbmRsaW5nIHRoZSAiZ3JmIiBjbG9jayBpcyBub3QgYSBuZXcg
b25lIGFuZAo+IHNob3VsZG4ndCBibG9jayB5b3VyIHBhdGNoLiAgLi4uYnV0IGl0IHdvdWxkIHN0
aWxsIGJlIG5pY2UgdG8gaGFuZGxlCj4gcHJvcGVybHkuCj4KPiAtRG91Zwo+Cj4KPgoKCi0tIApC
ZXN0IFJlZ2FyZHMKU2hhd24gTGluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlw
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1yb2NrY2hpcAo=
