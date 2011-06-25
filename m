From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sat, 25 Jun 2011 19:23:16 +0100
Message-ID: <BANLkTikkoD0vaxaFBbPd6UZa=iPJgaK2xQ@mail.gmail.com>
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
	<BANLkTinTV-0eCR+U4M+73Fo_z_izyQjGKw@mail.gmail.com>
	<BANLkTinD-3joE8QgeW07gWMW4gBwQRNzXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50482 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab1FYSXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jun 2011 14:23:16 -0400
Received: by pvg12 with SMTP id 12so2234973pvg.19
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jun 2011 11:23:16 -0700 (PDT)
In-Reply-To: <BANLkTinD-3joE8QgeW07gWMW4gBwQRNzXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi Ohad,

On 19 June 2011 12:00, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> But I still think it's generally better, given the alternatives.
>
> And since this should not have any bad effect for anyone else, I'm
> also OK with not wrapping the sdio_reset and the CMD5 arg=0 you're
> adding with a quirk.
>
> After that's in place, I plan to completely get rid of
> MMC_CAP_POWER_OFF_CARD, since the only evidence we had when we added
> it was the sd8686, and today we know it's not necessary at all.

Thanks - I've just submitted this patch.

Now we just need you to submit the remaining parts of
http://dev.laptop.org/~dsd/20110609/sd-pwr-debug6.patch - can you take
care of that? I'm not sure if/how it should be split up or how to
write the commit message.

Then we can get rid of MMC_CAP_POWER_OFF_CARD, which would be good to
do ASAP to maximize testing before Linux 3.1.

Thanks,
Daniel
