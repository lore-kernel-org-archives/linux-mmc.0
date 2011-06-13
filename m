From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Mon, 13 Jun 2011 22:52:52 +0300
Message-ID: <BANLkTino3hz9NCfjtqM2UYtncYa6y_k=Qg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61045 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1FMTxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 15:53:14 -0400
Received: by wwa36 with SMTP id 36so5172913wwa.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 12:53:13 -0700 (PDT)
In-Reply-To: <BANLkTimOVsSe=mPOZ=ArGfy4w2QrYgLA+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, Jun 10, 2011 at 7:15 PM, Daniel Drake <dsd@laptop.org> wrote:
> Done. Without bringing suspend/resume into the picture, this is
> working fine. Power is removed when the interface goes down, and is
> restored when the interface is brought up. ios values look fine at
> every stage. Wireless card works fine after several power cycles.

That sounds great.

> Patches here: http://dev.laptop.org/~dsd/20110610/
> The most relevant ones for this discussion are 6 and 7.
>
> What next?

We need to debug the suspend/resume path. Now that we have the other
runtime pm paths working, we can pretty much tell there's no hw issue
at hand.

I definitely plan to help you nail this, but I'm a little tied up with
some tight schedule for a little while.
