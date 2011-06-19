From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun, 19 Jun 2011 14:00:46 +0300
Message-ID: <BANLkTinD-3joE8QgeW07gWMW4gBwQRNzXg@mail.gmail.com>
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
 <BANLkTinJe2wAQwSrb+V3e2Xd87d+UQzFWQ@mail.gmail.com> <BANLkTinTV-0eCR+U4M+73Fo_z_izyQjGKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44229 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab1FSLBJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jun 2011 07:01:09 -0400
Received: by wyb38 with SMTP id 38so1102663wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jun 2011 04:01:07 -0700 (PDT)
In-Reply-To: <BANLkTinTV-0eCR+U4M+73Fo_z_izyQjGKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Sun, Jun 19, 2011 at 1:33 PM, Daniel Drake <dsd@laptop.org> wrote:
> So, as I found here: http://article.gmane.org/gmane.linux.kernel.mmc/8605
> This is an OLPC-specific issue due to lack of power clamping on the
> motherboard's power supply, which might not be shared by other sd8686
> users, and a long delay is expected.
>
> I have been testing further and I have seen a couple of times that
> msleep(300) is not enough, or at least the card failed to do the cmd5
> reset in those cases. The sdio_reset() method seems to be 100%
> reliable however, I haven't seen a single failure with that yet.

Then sdio_reset() it is.

We're taking a risk of covering up bugs like the one we just found here:

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg08371.html

So people will be happy that everything (seem to) work, without even
knowing their card might not have been powered off at all.

But I still think it's generally better, given the alternatives.

And since this should not have any bad effect for anyone else, I'm
also OK with not wrapping the sdio_reset and the CMD5 arg=0 you're
adding with a quirk.

After that's in place, I plan to completely get rid of
MMC_CAP_POWER_OFF_CARD, since the only evidence we had when we added
it was the sd8686, and today we know it's not necessary at all.

Thanks,
Ohad.
