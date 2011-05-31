From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH 0/2] sdio: make sdio_single_irq optional due to suprious IRQ
Date: Tue, 31 May 2011 22:52:57 +0100
Message-ID: <BANLkTimRB8z16wjyH1fuXbiybQuaJL4Qug@mail.gmail.com>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec521579351bc0604a4996de2
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61051 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab1EaVw6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 17:52:58 -0400
Received: by pzk9 with SMTP id 9so2218413pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2011 14:52:58 -0700 (PDT)
In-Reply-To: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

--bcaec521579351bc0604a4996de2
Content-Type: text/plain; charset=ISO-8859-1

On 31 May 2011 21:33, Per Forlin <per.forlin@linaro.org> wrote:
> Daniel Drake reported an issue in the libertas sdio client that was
> triggered by the sdio_single_irq functionality. His SDIO device seems to
> raise an interrupt even though there are no bits set in the CCCR_INTx
> register. This behaviour is not supported by the sdio_single_irq feature nor
> the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
> overhead of checking the CCCR_INTx registers, this result in no error
> handling of the case if there is a pending IRQ with none CCCR_INTx bits set.

Thanks a lot for diagnosing this and nice work on figuring out the
root cause presumably without even having access to the hardware!

I've looked further, based on your findings, and have found that you
are correct. During initialisation, exactly one interrupt is received
with CCCR_INTx=0. Previously the mmc stack threw this interrupt away,
after the optimization it now calls into libertas before it is ready
to handle interrupts, leading to the crash. From that point, all other
interrupts that come in are "normal".

This is definitely a weird hardware issue, and it would annoy me for
this hardware to cause a second generic mmc layer feature be disabled
by default! And actually it is not much work to harden up the libertas
driver to be able to accept that spurious IRQ, and during the process
of fixing that it actually made the spurious IRQ go away completely.

Patch attached.

So, I vote for that we work around this little hardware issue in the
libertas driver, and leave this optimization enabled by default until
we find a hardware issue that is more difficult to workaround. I can
take on submission of the libertas patch.

Thoughts?

Daniel

--bcaec521579351bc0604a4996de2
Content-Type: text/plain; charset=US-ASCII; name="lbs_sdio_irq.txt"
Content-Disposition: attachment; filename="lbs_sdio_irq.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goddt0cp0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2xpYmVydGFzL2lmX3NkaW8uYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2xpYmVydGFzL2lmX3NkaW8uYwppbmRleCBhN2I1Y2IwLi4yMjRl
OTg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9saWJlcnRhcy9pZl9zZGlvLmMK
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbGliZXJ0YXMvaWZfc2Rpby5jCkBAIC05MDcsNyAr
OTA3LDcgQEAgc3RhdGljIHZvaWQgaWZfc2Rpb19pbnRlcnJ1cHQoc3RydWN0IHNkaW9fZnVuYyAq
ZnVuYykKIAljYXJkID0gc2Rpb19nZXRfZHJ2ZGF0YShmdW5jKTsKIAogCWNhdXNlID0gc2Rpb19y
ZWFkYihjYXJkLT5mdW5jLCBJRl9TRElPX0hfSU5UX1NUQVRVUywgJnJldCk7Ci0JaWYgKHJldCkK
KwlpZiAocmV0IHx8ICFjYXVzZSkKIAkJZ290byBvdXQ7CiAKIAlsYnNfZGViX3NkaW8oImludGVy
cnVwdDogMHglWFxuIiwgKHVuc2lnbmVkKWNhdXNlKTsKQEAgLTEwMDgsMTAgKzEwMDgsNiBAQCBz
dGF0aWMgaW50IGlmX3NkaW9fcHJvYmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYywKIAlpZiAocmV0
KQogCQlnb3RvIHJlbGVhc2U7CiAKLQlyZXQgPSBzZGlvX2NsYWltX2lycShmdW5jLCBpZl9zZGlv
X2ludGVycnVwdCk7Ci0JaWYgKHJldCkKLQkJZ290byBkaXNhYmxlOwotCiAJLyogRm9yIDEtYml0
IHRyYW5zZmVycyB0byB0aGUgODY4NiBtb2RlbCwgd2UgbmVlZCB0byBlbmFibGUgdGhlCiAJICog
aW50ZXJydXB0IGZsYWcgaW4gdGhlIENDQ1IgcmVnaXN0ZXIuIFNldCB0aGUgTU1DX1FVSVJLX0xF
TklFTlRfRk4wCiAJICogYml0IHRvIGFsbG93IGFjY2VzcyB0byBub24tdmVuZG9yIHJlZ2lzdGVy
cy4gKi8KQEAgLTEwODMsNiArMTA3OSwyMSBAQCBzdGF0aWMgaW50IGlmX3NkaW9fcHJvYmUoc3Ry
dWN0IHNkaW9fZnVuYyAqZnVuYywKIAkJY2FyZC0+cnhfdW5pdCA9IDA7CiAKIAkvKgorCSAqIFNl
dCB1cCB0aGUgaW50ZXJydXB0IGhhbmRsZXIgbGF0ZS4KKwkgKgorCSAqIElmIHdlIHNldCBpdCB1
cCBlYXJsaWVyLCB0aGUgKGJ1Z2d5KSBoYXJkd2FyZSBnZW5lcmF0ZXMgYSBzcHVyaW91cworCSAq
IGludGVycnVwdCwgZXZlbiBiZWZvcmUgdGhlIGludGVycnVwdCBoYXMgYmVlbiBlbmFibGVkLCB3
aXRoCisJICogQ0NDUl9JTlR4ID0gMC4KKwkgKgorCSAqIFdlIHJlZ2lzdGVyIHRoZSBpbnRlcnJ1
cHQgaGFuZGxlciBsYXRlIHNvIHRoYXQgd2UgY2FuIGhhbmRsZSBhbnkKKwkgKiBzcHVyaW91cyBp
bnRlcnJ1cHRzLCBhbmQgYWxzbyB0byBhdm9pZCBnZW5lcmF0aW9uIG9mIHRoYXQga25vd24KKwkg
KiBzcHVyaW91cyBpbnRlcnJ1cHQgaW4gdGhlIGZpcnN0IHBsYWNlLgorCSAqLworCXJldCA9IHNk
aW9fY2xhaW1faXJxKGZ1bmMsIGlmX3NkaW9faW50ZXJydXB0KTsKKwlpZiAocmV0KQorCQlnb3Rv
IGRpc2FibGU7CisKKwkvKgogCSAqIEVuYWJsZSBpbnRlcnJ1cHRzIG5vdyB0aGF0IGV2ZXJ5dGhp
bmcgaXMgc2V0IHVwCiAJICovCiAJc2Rpb193cml0ZWIoZnVuYywgMHgwZiwgSUZfU0RJT19IX0lO
VF9NQVNLLCAmcmV0KTsK
--bcaec521579351bc0604a4996de2--
