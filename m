From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 29 May 2011 17:21:01 +0100
Message-ID: <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
	<AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
	<AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
	<AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
	<AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
	<AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
	<AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
	<AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
	<AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec51f8f8785921e04a46c8e09
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:50002 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1E2QVB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2011 12:21:01 -0400
Received: by pxi2 with SMTP id 2so2041893pxi.10
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2011 09:21:01 -0700 (PDT)
In-Reply-To: <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

--bcaec51f8f8785921e04a46c8e09
Content-Type: text/plain; charset=ISO-8859-1

Hi Ohad,

On 31 October 2010 19:06, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> OK, as expected.
>
> So to summarize:
> 1. Card is powered up at boot, and successfully initialized
> 2. After mmc + sdio devices are added to the device tree, power is
> (seemingly) taken down by runtime PM
> 3. When the driver is loaded, card is powered up again, but doesn't
> respond to CMD3
>
> The only explanation I can think of why the card doesn't respond to
> CMD3, after its power is brought up again, is that we didn't have a
> full reset here (i.e. mmc_power_off() didn't completely power off
> everything).

I have investigated this again, as we'd like runtime PM to work.

It's certainly possible that there's something weird about the
hardware in question, but we *are* able to successfully power down and
up the card with a hacky rfkill driver that calls mmc_stop_host /
mmc_start_host. So I went around finding out what the difference was
between these functions and the runtime PM implementation.

Through this comparison I think mmc_power_save_host() does almost
exactly the same as mmc_stop_host() (good), but
mmc_power_restore_host() lacks some steps which would otherwise be
taken by mmc_start_host(). These are:

in mmc_rescan_try_freq():

	/*
	 * sdio_reset sends CMD52 to reset card.  Since we do not know
	 * if the card is being re-initialized, just send it.  CMD52
	 * should be ignored by SD/eMMC cards.
	 */
	sdio_reset(host);
	mmc_go_idle(host);

	mmc_send_if_cond(host, host->ocr_avail);


In mmc_attach_sdio():

	err = mmc_send_io_op_cond(host, 0, &ocr);
	if (err)
		return err;

	mmc_attach_bus(host, &mmc_sdio_ops);
	if (host->ocr_avail_sdio)
		host->ocr_avail = host->ocr_avail_sdio;

	/*
	 * Sanity check the voltages that the card claims to
	 * support.
	 */
	if (ocr & 0x7F) {
		printk(KERN_WARNING "%s: card claims to support voltages "
		       "below the defined range. These will be ignored.\n",
		       mmc_hostname(host));
		ocr &= ~0x7F;
	}

	host->ocr = mmc_select_voltage(host, ocr);

	/*
	 * Can we support the voltage(s) of the card(s)?
	 */
	if (!host->ocr) {
		err = -EINVAL;
		goto err;
	}


Should anything in those code snippets be running during runtime PM resume?

I went ahead and ran the obvious test by putting those bits of code in
the runtime PM resume path... the first snippet doesn't seem to
improve or hurt anything, but the second snippet fixes the problem. At
least it means I can boot, the card gets powered down during boot,
then I load the module and it powers up and initialises correctly.
Patch attached for clarity.

Any thoughts?

Thanks,
Daniel

--bcaec51f8f8785921e04a46c8e09
Content-Type: text/plain; charset=US-ASCII; name="fix-sdio-power-restore.txt"
Content-Disposition: attachment; filename="fix-sdio-power-restore.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goa77p9i0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMvY29yZS9z
ZGlvLmMKaW5kZXggNGQwYzE1Yi4uM2IwNjM3OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29y
ZS9zZGlvLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMKQEAgLTY5MSwxNSArNjkxLDQ3
IEBAIHN0YXRpYyBpbnQgbW1jX3NkaW9fcmVzdW1lKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkKIHN0
YXRpYyBpbnQgbW1jX3NkaW9fcG93ZXJfcmVzdG9yZShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiB7
CiAJaW50IHJldDsKKwl1MzIgb2NyOwogCiAJQlVHX09OKCFob3N0KTsKIAlCVUdfT04oIWhvc3Qt
PmNhcmQpOwogCiAJbW1jX2NsYWltX2hvc3QoaG9zdCk7CisKKwlyZXQgPSBtbWNfc2VuZF9pb19v
cF9jb25kKGhvc3QsIDAsICZvY3IpOworCWlmIChyZXQpCisJCWdvdG8gb3V0OworCisJaWYgKGhv
c3QtPm9jcl9hdmFpbF9zZGlvKQorCQlob3N0LT5vY3JfYXZhaWwgPSBob3N0LT5vY3JfYXZhaWxf
c2RpbzsKKworCS8qCisJICogU2FuaXR5IGNoZWNrIHRoZSB2b2x0YWdlcyB0aGF0IHRoZSBjYXJk
IGNsYWltcyB0bworCSAqIHN1cHBvcnQuCisJICovCisJaWYgKG9jciAmIDB4N0YpIHsKKwkJcHJp
bnRrKEtFUk5fV0FSTklORyAiJXM6IGNhcmQgY2xhaW1zIHRvIHN1cHBvcnQgdm9sdGFnZXMgIgor
CQkgICAgICAgImJlbG93IHRoZSBkZWZpbmVkIHJhbmdlLiBUaGVzZSB3aWxsIGJlIGlnbm9yZWQu
XG4iLAorCQkgICAgICAgbW1jX2hvc3RuYW1lKGhvc3QpKTsKKwkJb2NyICY9IH4weDdGOworCX0K
KworCWhvc3QtPm9jciA9IG1tY19zZWxlY3Rfdm9sdGFnZShob3N0LCBvY3IpOworCisJLyoKKwkg
KiBDYW4gd2Ugc3VwcG9ydCB0aGUgdm9sdGFnZShzKSBvZiB0aGUgY2FyZChzKT8KKwkgKi8KKwlp
ZiAoIWhvc3QtPm9jcikgeworCQlyZXQgPSAtRUlOVkFMOworCQlnb3RvIG91dDsKKwl9CisKIAly
ZXQgPSBtbWNfc2Rpb19pbml0X2NhcmQoaG9zdCwgaG9zdC0+b2NyLCBob3N0LT5jYXJkLAogCQkJ
CW1tY19jYXJkX2tlZXBfcG93ZXIoaG9zdCkpOwogCWlmICghcmV0ICYmIGhvc3QtPnNkaW9faXJx
cykKIAkJbW1jX3NpZ25hbF9zZGlvX2lycShob3N0KTsKKworb3V0OgogCW1tY19yZWxlYXNlX2hv
c3QoaG9zdCk7CiAKIAlyZXR1cm4gcmV0Owo=
--bcaec51f8f8785921e04a46c8e09--
