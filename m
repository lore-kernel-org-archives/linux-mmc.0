From: saeed bishara <saeed.bishara-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Mon, 27 Jun 2011 13:34:48 +0300
Message-ID: <BANLkTimnuEK_9RedmD1OgcunX3rPvd-O0Q@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20110621075319.GN26089-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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

Pgo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19kbWFfc3luYyh2b2lkKQo+ICt7Cj4gKyDCoCDCoCDC
oCBkc2IoKTsKPiArfQo+ICsKPiDCoC8qCj4gwqAqIFJldHVybiB3aGV0aGVyIHRoZSBnaXZlbiBk
ZXZpY2UgRE1BIGFkZHJlc3MgbWFzayBjYW4gYmUgc3VwcG9ydGVkCj4gwqAqIHByb3Blcmx5LiDC
oEZvciBleGFtcGxlLCBpZiB5b3VyIGRldmljZSBjYW4gb25seSBkcml2ZSB0aGUgbG93IDI0LWJp
dHMKPiBAQCAtMzc4LDYgKzM4Myw3IEBAIHN0YXRpYyBpbmxpbmUgZG1hX2FkZHJfdCBkbWFfbWFw
X3NpbmdsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmNwdV9hZGRyLAo+IMKgIMKgIMKgIMKg
QlVHX09OKCF2YWxpZF9kbWFfZGlyZWN0aW9uKGRpcikpOwo+Cj4gwqAgwqAgwqAgwqBhZGRyID0g
X19kbWFfbWFwX3NpbmdsZShkZXYsIGNwdV9hZGRyLCBzaXplLCBkaXIpOwo+ICsgwqAgwqAgwqAg
X19kbWFfc3luYygpOwpSdXNzZWxsLAogIEknbSBjdXJpb3VzIGFib3V0IHRoZSBjb3JyZWN0bmVz
cyBvZiB0aGlzIHBhdGNoIGZvciBzeXN0ZW1zIHdpdGgKb3V0ZXIgY2FjaGUuIHNob3VsZG4ndCB0
aGUgZHNiIGJlIGlzc3VlZCBiZWZvcmUgdGhlIG91dGVyIGNhY2hlCm1haW50ZW5hbmNlPwpzYWVl
ZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGluYXJv
LWRldiBtYWlsaW5nIGxpc3QKbGluYXJvLWRldkBsaXN0cy5saW5hcm8ub3JnCmh0dHA6Ly9saXN0
cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vbGluYXJvLWRldgo=
