From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Fri, 17 Jun 2011 17:31:08 +0300
Message-ID: <BANLkTinJe2wAQwSrb+V3e2Xd87d+UQzFWQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com> <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
 <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com> <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
 <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com> <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
 <BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com> <BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
 <BANLkTi=6Fa66QYay_R6vkmREPcb1Bw_FRw@mail.gmail.com> <BANLkTimOVsSe=mPOZ=ArGfy4w2QrYgLA+Q@mail.gmail.com>
 <BANLkTino3hz9NCfjtqM2UYtncYa6y_k=Qg@mail.gmail.com> <BANLkTi==drxM8Y4BffQwDSzraWXQ3-ta0g@mail.gmail.com>
 <BANLkTi=2EFMDNjOdmfqkWD1pQJthgR4uKQ@mail.gmail.com> <BANLkTimMPXdSKf3bO8ymco+Z8D215Fy5TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42599 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759030Ab1FQOb3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 10:31:29 -0400
Received: by wwe5 with SMTP id 5so522857wwe.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2011 07:31:28 -0700 (PDT)
In-Reply-To: <BANLkTimMPXdSKf3bO8ymco+Z8D215Fy5TQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, Jun 17, 2011 at 4:58 PM, Daniel Drake <dsd@laptop.org> wrote:
> Ignore the probe error - just observe the fact that the card was
> detected and powered on, powered off, powered on and *then* probed.

This is the normal behavior today when drivers are probed: we power up
the card before probing a driver, and if the probe fails, we power it
off.

To be exact, we're not even doing that deterministically. We are
powering off the *SDIO function*, and not the card. I once changed
this to be deterministic, but didn't pursue this eventually, because
frankly it's not hugely important.

> That's the same thing that happens in the resume path.

You mean on *libertas'* resume path, which doesn't really do
suspend/resume - it just removes the card, and let it be re-probed
later.

> Couldn't the
> power have just been maintained from when the card was detected, given
> that the driver was loaded and ready to go?

Most cards wouldn't care too much: we're not loading/unloading drivers
too frequently, and the advantage of the current solution is
simplicity.

But you are welcome to change this if you need to. I don't see how it
can hurt anyone, and anyway it can also happen today too in some
cases.

> Thinking more, I think I prefer sdio_reset() as a quirk/workaround
> instead of the sleep, because the sleep is quite long. What do you
> think?

I agree that a 250ms delay on the power up path is way too long.

But let's first try to understand what's the real problem it is
solving before picking a solution. This usually pays off, and
eventually you'd be happier with the end result.

> Any suggestions for how I go about doing that? Unfortunately we have a
> backlog of support requests with Marvell which have not yet been
> responded to.

Use the mailing list :)

The Marvell guys were very nice and replied my questions pretty fast.

> Yes, a regulator could work. But, aren't regulators linked to the
> platform rather than to the card? I would imagine that this quirk
> needs to be applied to all users of the card, therefore a card quirk
> could be more appropriate? Also, if you think the sdio_reset() option
> is preferable to the sleep, can that be done from a regulator?

I'd really prefer to understand what's wrong first.

If we have a rigid hardware requirement that demands waiting before
powering it up again, then we better obey it. But I somehow doubt that
a 250ms delay is required. That's way too much...

Thanks,
Ohad.
