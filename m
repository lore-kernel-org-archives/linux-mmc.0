From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun, 19 Jun 2011 11:33:20 +0100
Message-ID: <BANLkTinTV-0eCR+U4M+73Fo_z_izyQjGKw@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
	<BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
	<BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
	<BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
	<BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
	<BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
	<BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
	<BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
	<BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com>
	<BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
	<BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com>
	<BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
	<BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com>
	<BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
	<BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com>
	<BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
	<BANLkTi=6Fa66QYay_R6vkmREPcb1Bw_FRw@mail.gmail.com>
	<BANLkTimOVsSe=mPOZ=ArGfy4w2QrYgLA+Q@mail.gmail.com>
	<BANLkTino3hz9NCfjtqM2UYtncYa6y_k=Qg@mail.gmail.com>
	<BANLkTi==drxM8Y4BffQwDSzraWXQ3-ta0g@mail.gmail.com>
	<BANLkTi=2EFMDNjOdmfqkWD1pQJthgR4uKQ@mail.gmail.com>
	<BANLkTimMPXdSKf3bO8ymco+Z8D215Fy5TQ@mail.gmail.com>
	<BANLkTinJe2wAQwSrb+V3e2Xd87d+UQzFWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54646 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab1FSKdV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jun 2011 06:33:21 -0400
Received: by pvg12 with SMTP id 12so56064pvg.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jun 2011 03:33:20 -0700 (PDT)
In-Reply-To: <BANLkTinJe2wAQwSrb+V3e2Xd87d+UQzFWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi Ohad,

On 17 June 2011 15:31, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Yes, a regulator could work. But, aren't regulators linked to the
>> platform rather than to the card? I would imagine that this quirk
>> needs to be applied to all users of the card, therefore a card quirk
>> could be more appropriate? Also, if you think the sdio_reset() option
>> is preferable to the sleep, can that be done from a regulator?
>
> I'd really prefer to understand what's wrong first.
>
> If we have a rigid hardware requirement that demands waiting before
> powering it up again, then we better obey it. But I somehow doubt that
> a 250ms delay is required. That's way too much...

So, as I found here: http://article.gmane.org/gmane.linux.kernel.mmc/8605
This is an OLPC-specific issue due to lack of power clamping on the
motherboard's power supply, which might not be shared by other sd8686
users, and a long delay is expected.

I have been testing further and I have seen a couple of times that
msleep(300) is not enough, or at least the card failed to do the cmd5
reset in those cases. The sdio_reset() method seems to be 100%
reliable however, I haven't seen a single failure with that yet.

Where do we go from here? Any suggested implementation approach?

Thanks,
Daniel
