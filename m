From: saeed bishara <saeed.bishara-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Tue, 28 Jun 2011 09:22:20 +0300
Message-ID: <BANLkTin80Z34=_uQaP=Dbv7eDxU1PH_qSw@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
	<20110627110234.GC16103@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20110627110234.GC16103-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

T24gTW9uLCBKdW4gMjcsIDIwMTEgYXQgMjowMiBQTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4
CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBNb24sIEp1biAyNywgMjAxMSBh
dCAwMTozNDo0OFBNICswMzAwLCBzYWVlZCBiaXNoYXJhIHdyb3RlOgo+PiBSdXNzZWxsLAo+PiDC
oCBJJ20gY3VyaW91cyBhYm91dCB0aGUgY29ycmVjdG5lc3Mgb2YgdGhpcyBwYXRjaCBmb3Igc3lz
dGVtcyB3aXRoCj4+IG91dGVyIGNhY2hlLiBzaG91bGRuJ3QgdGhlIGRzYiBiZSBpc3N1ZWQgYmVm
b3JlIHRoZSBvdXRlciBjYWNoZQo+PiBtYWludGVuYW5jZT8KPgo+IE1heWJlIHdlIHNob3VsZCBk
byB0d28gcGFzc2VzIG92ZXIgU0cgbGlzdHMgdGhlbiAtIG9uZSBmb3IgdGhlIGlubmVyIGFuZAo+
IGFub3RoZXIgZm9yIHRoZSBvdXRlciBjYWNoZT8KPgo+IEluIGVmZmVjdCB3ZSBjb3VsZCBkbyB0
aHJlZSBwYXNzZXM6Cj4KPiAxLiBDYWxjdWxhdGUgdGhlIHRvdGFsIHNpemUgb2YgdGhlIFNHIGxp
c3QgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgZnVsbAo+IMKgIGNhY2hlIGZsdXNoIGlzIG1vcmUgZWZm
aWNpZW50Lgo+IDIuIEZsdXNoIGlubmVyIGNhY2hlCj4gwqAgVGhlbiBkc2IoKQo+IDMuIEZsdXNo
IG91dGVyIGNhY2hlCj4gwqAgQW5vdGhlciBkc2IoKQo+Cmxvb2tpbmcgYXQgbDJ4MCBjYWNoZSwg
aXQgc2VlbXMgdG8gbWUgdGhhdCBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBkbwphc3luY2hyb25v
dXMgbDIgY2FjaGUgbWFpbnRlbmFuY2UgZm9yCnJhbmdlIG9wZXJhdGlvbnMsIHNvIG1heWJlIHRo
YXQgY2FuIGJlIHV0aWxpemVkIGluIG9yZGVyIHRvCnBhcmFsbGVsaXNtIGJldHdlZW4gaW5uZXIg
Y2FjaGUgYW5kIG91dGVyIGNhY2hlIG1haW50ZW5hbmNlLApzbyB0aGUgZmxvdyBjYW4gYmU6CjIu
IEZsdXNoIHNnIGJ1ZmZlciBmcm9tIGlubmVyIGNhY2hlCjMuIGRzYigpCjQuIHN0YXJ0IEZsdXNo
IG91dGVyIGNhY2hlIGZvciB0aGF0IGJ1ZmZlcgo1LiBGbHVzaCBuZXh0IHNnIGJ1ZmZlciBmcm9t
IGlubmVyIGNhY2hlCjYuIGRzYgo3LiBnb3RvIDQuCjguIHdoZW4gbm8gbW9yZSBidWZmZXJzIGxl
ZnQsIHdhaXQgZm9yIG91dGVyIGNhY2hlIG9wZXJhdGlvbnMKCnNhZWVkCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW5hcm8tZGV2IG1haWxpbmcgbGlz
dApsaW5hcm8tZGV2QGxpc3RzLmxpbmFyby5vcmcKaHR0cDovL2xpc3RzLmxpbmFyby5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW5hcm8tZGV2Cg==
