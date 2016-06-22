From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Wed, 22 Jun 2016 17:03:57 +0200
Message-ID: <CAPDyKFpLEcXmYK9AM-WLt3_ehLPCx7-DgmVwKfA6f2OuKkGYTg@mail.gmail.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <575E52AC.6000902@intel.com>
 <8bbb3f13-efb3-e963-e53f-cf2ca796f319@rock-chips.com>
 <575E6C11.8060709@intel.com>
 <b22ae70d-5128-639d-eef0-8ac9cdd2b8e4@rock-chips.com>
 <575EA651.7060606@intel.com>
 <CAPDyKFq7Pr1YiacwpeDq3eAYmApydTj8Kbkyh=Cb6+vJC9BV3Q@mail.gmail.com>
 <B9A5F20C-E8A0-4E81-BA07-79E60017E728@sandisk.com>
 <CAPDyKFoerO18yQWGA=VBcRW5dy5Qie+m19mFr-FdDch2AckUJg@mail.gmail.com>
 <362217AA-5AE7-471A-AF58-985676E261A4@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <362217AA-5AE7-471A-AF58-985676E261A4-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alex Lemberg <Alex.Lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Wy4uLl0KCj4+PiA+RnJvbSBteSBmaXJzdCBpbXByZXNzaW9uIEkgYWdyZWUsIGFzIHRoYXQgaXMg
dGhlIHBvbGljeSB3ZSBoYXZlIGJlZW4KPj4+PnN0aWNraW5nIHRvIHdoZW4gd3JpdGluZyB0byBw
ZXJzaXN0ZW50IEVYVF9DU0QgcmVnaXN0ZXJzLgo+Pj4+QWx0aG91Z2gsIGluIHRoaXMgY2FzZSwg
SSBhbSBhY3R1YWxseSB3b25kZXJpbmcgb24gd2hhdCBpcyB0aGUgYmVzdCBhcHByb2FjaC4KPj4+
Pgo+Pj4+SXMgdGhlcmUgcmVhbGx5IGV2ZXIgYSBjYXNlIHdoZW4gd2UgZG9uJ3Qgd2FudCBhdXRv
IEJLT1BTIHRvIGJlIGRlZmF1bHQgZW5hYmxlZD8KPj4+PkkgdGhpbmsgQktPUFMgaXMgYSBmdW5k
YW1lbnRhbCBmZWF0dXJlIG9mIGFuIEZUTCBhbmQgSSBjYW4ndCBzZWUgYQo+Pj4+cmVhc29uIHRv
IHdoeSB3ZSBuZWVkIHRvIGludm9sdmUgbW1jLXV0aWxzL3VzZXJzcGFjZSB0byBlbmFibGUgaXQu
IEFtCj4+Pj5JIHdyb25nPwo+Pj4KPj4+IFRoZSBldmVuIHdvcnN0IGNhc2UgaXMg4oCTIGludm9s
dmUgbW1jLXV0aWxzL3VzZXJzcGFjZSB0byBESVNBQkxFIGl0Lgo+Pj4gSSB0aGluayB0aGlzIHJl
Z2lzdGVyIG5lZWQgdG8gYmUgc2V0IGJ5IHZlbmRvciBhbmQgbm8gbmVlZCB0byBiZSBjaGFuZ2Vk
IG9uIHJ1bnRpbWUuCj4+Cj4+SWYgaXQgaXMgc2V0IGJ5IHRoZSBWZW5kb3IsIHRoYXQncyBvZiBj
b3Vyc2UgdGhlIGJlc3QuCj4KPiBJdCBjYW4gYmUgc2V0IGJ5IFN0b3JhZ2UgVmVuZG9yLgo+IEFj
Y29yZGluZyB0byB0aGUgc3BlYywgdGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhpcyBiaXQgaXMgdmVu
ZG9yIHNwZWNpZmljLgo+Cj4+Cj4+QXJlIHlvdSBzYXlpbmcgdGhhdCB3ZSBzaG91bGRuJ3QgZW5h
YmxlIGl0IGR1cmluZyB0aGUgY2FyZCBpbml0Cj4+c2VxdWVuY2UgZnJvbSB0aGUga2VybmVsLCBp
biBjYXNlIGl0IGlzIGRpc2FibGVkPwo+Cj4gTm8uCj4gQnkgdGhlIHNwZWMg4oCTIGEgSG9zdCB0
aGF0IHdhbnRzIHRvIGVuYWJsZSB0aGUgZGV2aWNlIHRvIHBlcmZvcm0KPiBiYWNrZ3JvdW5kIG9w
ZXJhdGlvbnMgZHVyaW5nIGRldmljZSBpZGxlIHRpbWUsIHNob3VsZCBzaWduYWwgdGhlCj4gZGV2
aWNlIGJ5IHNldHRpbmcgQVVUT19FTiBpbiBCS09QU19FTiBmaWVsZCBbRVhUX0NTRCBieXRlIDE2
M10gdG8gMWIuCgpPa2F5LCB0aGFua3MhCgpLaW5kIHJlZ2FyZHMKVWZmZQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGlu
ZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
