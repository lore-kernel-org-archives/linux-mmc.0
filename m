From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Tue, 21 Jun 2016 09:38:16 +0900
Message-ID: <57688C78.1020006@samsung.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
 <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
 <CGME20160620133336epcas1p4d315ce60d35d1544bf79592741a8edaa@epcas1p4.samsung.com>
 <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alex Lemberg <Alex.Lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

T24gMDYvMjAvMjAxNiAxMDozMyBQTSwgQWxleCBMZW1iZXJnIHdyb3RlOgo+IEhpIFNoYXduLAo+
IAo+IFvigKZdCj4gCj4+Pj4gKwo+Pj4+ICtzdGF0aWMgaW50IG1tY19zdG9wX2F1dG9fYmtvcHMo
c3RydWN0IG1tY19jYXJkICpjYXJkKQo+Pj4+ICt7Cj4+Pj4gKwlpbnQgZXJyID0gMDsKPj4+PiAr
Cj4+Pj4gKwlpZiAoIWNhcmQtPmV4dF9jc2QuYXV0b19ia29wc19lbikKPj4+PiArCQlyZXR1cm4g
MDsKPj4+PiArCj4+Pgo+Pj4gU2hvdWxkbuKAmXQgdGhlIEJLT1BTX1NUQVRVUyBiZSBjaGVja2Vk
IHByaW9yIHRvIGRpc2FibGluZyB0aGUgQktPUFMgYWN0aXZpdHkgb2YgdGhlIGRldmljZT8KPj4+
Cj4+Cj4+IEhybW0uLiBJIHJlYWQgdGhlIHdob2xlIHNlY3Rpb24gb2Ygc3BlYyBmb3IgaXQsIGFu
ZCBJIGRpZCBmaW5kIHRoaXMKPj4gcmVxdWlyZW1lbnQgZm9yIG1hbnVsIGJrb3BzIGJ1dCBub3Qg
Zm9yIHRoZSBhdXRvIG9uZS4gU28gd2hhdCBzaG91bGQgd2UKPj4gZG8gaWYgdXNpbmcgdGhlIGF1
dG8gb25lPwo+Pgo+IAo+IEluIGNhc2Ugb2YgQVVUTyBCS09QUywgdGhlIGVNTUMgRGV2aWNlIHNo
b3VsZCBwZXJmb3JtIGludGVybmFsIEdDIAo+IGluIHRoZSBzYW1lIHdheSBhcyBpbiBjYXNlIG9m
IE1BTlVBTCBCS09QUy4KPiBUaGUgb25seSBkaWZmZXJlbmNlIGlzIGEgaG9zdCBhd2FyZW5lc3Mu
IAo+IEFsdGhvdWdoIHRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IGluIHRoZSBzcGVjLCBJIHRoaW5r
IHRoZSBkcml2ZXIgY2FuCj4gZ2l2ZSBzb21lIHRpbWUgdG8gdGhlIGRldmljZSB0byBwZXJmb3Jt
L2NvbXBsZXRlIGl0cyBpbnRlcm5hbCBHQyBkdXJpbmcgdGhlIGlkbGUgdGltZS4KPiBUaHVzIEkg
dGhpbmsgd2UgY2FuIGNoZWNrIHRoZSBCS09QU19TVEFUVVMgb24gUnVudGltZSBzdXNwZW5kLgoK
SSdtIG5vdCBzdXJlIHdlIGNhbiBjaGVjayBCS09QU19TVEFUVVMgd2hlbiB1c2UgdGhlIEFVVE9f
QktPUFMuCkkgaGF2ZSBhbHNvIHJlYWQgdGhlIFNQRUMsIGJ1dCBpdCdzIG5vdCBjbGVhcmx5IGZv
ciBjaGVja2luZyB0aGUgQktPUFNfU1RBVFVTLgpKdXN0IGkgdW5kZXJzdG9vZCB0aGF0IGl0IHNo
b3VsZCBiZSBvcGVyYXRlZCB3aXRob3V0IGEgaG9zdCdzIGF3YXJlbmVzcy4KCkJlc3QgUmVnYXJk
cywKSmFlaG9vbiBDaHVuZwoKPiAKPiBb4oCmXQo+IAo+IFRoYW5rcywKPiBBbGV4Cj4gCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2No
aXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
