From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Fri, 17 Jun 2011 00:22:16 +0300
Message-ID: <BANLkTi=2EFMDNjOdmfqkWD1pQJthgR4uKQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33436 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608Ab1FPVWh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2011 17:22:37 -0400
Received: by wya21 with SMTP id 21so1346570wya.19
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 14:22:36 -0700 (PDT)
In-Reply-To: <BANLkTi==drxM8Y4BffQwDSzraWXQ3-ta0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 16, 2011 at 8:27 PM, Daniel Drake <dsd@laptop.org> wrote:
> Why is there so much power flipping going on during resume?

There isn't.

You see this with libertas, because it doesn't really suspend/resume cleanly.

Instead, it uses a pretty awkward (in my opinion) mechanism to remove
the card on suspend, and then let the system re-probe it on resume.

> But even if that gets fixed, we still need to fix the case where the
> network interface is brought down then up immediately (another way to
> trigger the issue).

Could you also trigger this with the previous power off/on mechanism
you used (an rfkill driver IIRC) ? if not, what's the difference ? did
you have just enough delay there which didn't trigger this problem ?

> Would you suggest a card quirk for that? Adding
> another 250ms to the already-slow libertas powerup routine would be a
> bit painful, would you support the added complexity needed to make the
> 250ms delay only occur when >250ms has passed since it was powered
> off?

First, I suggest to understand where does this requirement come from.
Is this a rigid hardware requirement ? Does it always require waiting
250ms before powering it on again ?

If yes, then why not let the relevant regulator take care of it ? this
way you never have to care. you just power it off and on as you
please, and things just work.
