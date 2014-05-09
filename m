From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify
 errorhandleandremovesmatch warnings"
Date: Fri, 9 May 2014 09:09:36 +0800
Message-ID: <536C2AD0.7020104@realsil.com.cn>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>	<1076b1824732688774d223a14595ecf26a375d82.1398735435.git.micky_ching@realsil.com.cn>	<CAPDyKFoZ2_H6Jh0+84zLBhayMb0=q1eJw=vC_m41iCsbz0siFw@mail.gmail.com>	<536B1B05.6010604@realsil.com.cn>	<20140508075542.GC5307@lee--X1>
 <CAPDyKFqU+7NoZ1JjKa2YMj2DJsuBG5jD8fEt7WdLawA-mmqOjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFqU+7NoZ1JjKa2YMj2DJsuBG5jD8fEt7WdLawA-mmqOjw@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

SGkgVWxmCgpPbiAwNS8wOC8yMDE0IDA0OjIyIFBNLCBVbGYgSGFuc3NvbiB3cm90ZToKPiBPbiA4
IE1heSAyMDE0IDA5OjU1LCBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToK
Pj4+IEl0IHNlZW1zIENocmlzIGlzIHRvbyBidXN5IHRvIHJlc3BvbmRpbmcsIHNvIHdvdWxkIHlv
dSBoZWxwIHRvIHBpY2sKPj4+IHRoaXMgcGF0Y2ggZm9yIDMuMTUgZml4Lgo+PiBIbW1tbS4uLiB0
aGF0J3MgcHJldHR5IGJhZCB0aW1pbmcuICBJJ3ZlIGxpdGVyYWxseSBqdXN0IHNlbnQgdGhlCj4+
IHB1bGwtcmVxdWVzdCBjb250YWluaW5nIHRoZSBNRkQvTU1DIGZpeHVwIGJyYW5jaCB0byBMaW51
cy4gIEkgZ3Vlc3MKPj4gVWxmIHdpbGwgaGF2ZSB0byBkbyBpdC4KPiBUaGVyZSBzZWVtIHRvIGJl
IHNvbWUgY29uZnVzaW9uIGhlcmUuIDotKQo+Cj4gVGhpcyBwYXRjaCBpcyBfb25seV8gaW50ZW5k
ZWQgZm9yIENocmlzJyBtbWNfbmV4dCBicmFuY2gsIHNvIGl0Cj4gc2hvdWxkbid0IGdvIGZvciAz
LjE1IGZpeGVzLiBPciBiZXR0ZXIsIENocmlzIHNob3VsZCBkcm9wIHRoZSBwYXRjaAo+IHRoaXMg
b25lIGlzIHJldmVydGluZy4KU29ycnkgZm9yIHRoZSBtaXN0YWtlLCBvbmx5IHRoZSBzZWNvbmQg
cGF0Y2ggb2YgdGhlIHBhdGNoIHNldCBpcyBuZWVkIApmb3IgMy4xNSBmaXguCkkgd3JvdGUgdGhp
cyBlbWFpbCBpbiBhIHdyb25nIHBsYWNlLgoKQmVzdCBSZWdhcmRzLgo+IExpa2VseSB3ZSB3aWxs
IHNlZSBhIG1lcmdlIHByb2JsZW0gaW4gU3RlcGhlbiBSb3Rod2VsbCdzIGxpbnV4LW5leHQKPiB0
cmVlLCB1bnRpbCBDaHJpcycgZHJvcHMgdGhpcyBwYXRjaCAtIGNhdXNpbmcgU3RlcGhlbiB0byBu
b3QgbWVyZ2UgdGhlCj4gbW1jIHRyZWUgZm9yIGEgd2hpbGUuIEkgc3VwcG9zZSB0aGF0J3MgdGhl
IGJlc3Qgd2UgY2FuIGRvLCB1bnRpbCBDaHJpcwo+IHNob3dzIHVwIGFnYWluLgo+Cj4gS2luZCBy
ZWdhcmRzCj4gVWxmIEhhbnNzb24KPgo+Pj4+Pj4gRnJvbTogTWlja3kgQ2hpbmc8bWlja3lfY2hp
bmdAcmVhbHNpbC5jb20uY24+Cj4+Pj4+Pgo+Pj4+Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCAxZjdi
NTgxYjNmZmNiMmE4NDM3Mzk3YTAyZjRhZjg5ZmE2OTM0ZDA4Lgo+Pj4+Pj4KPj4+Pj4+IFRoZSBw
YXRjaCBkZXBlbmQgb24gY29tbWl0IGM0MmRlZmZkNWI1M2M5ZTU4M2Q4M2M3OTY0ODU0ZWRlMmYx
MjQxMGQKPj4+Pj4+IDxtbWM6IHJ0c3g6IGFkZCBzdXBwb3J0IGZvciBwcmVfcmVxIGFuZCBwb3N0
X3JlcT4sIGJ1dCB0aGUgcHJldmlvdXMKPj4+Pj4+IHBhdGNoIHdhcyBkaXNjYXJkLiBTbyB3ZSBo
YXZlIHRvIGRlbGV0ZSB0aGUgcGF0Y2guCj4+Pj4+Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTWlj
a3kgQ2hpbmc8bWlja3lfY2hpbmdAcmVhbHNpbC5jb20uY24+Cj4+Pj4gQWNrZWQtYnk6IFVsZiBI
YW5zc29uPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Cj4+IC0tCj4+IExlZSBKb25lcwo+PiBMaW5h
cm8gU1RNaWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCj4+IExpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+PiBGb2xsb3cgTGluYXJvOiBGYWNl
Ym9vayB8IFR3aXR0ZXIgfCBCbG9nCj4gLgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJw
cm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
