From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Fri, 17 Jun 2011 16:19:04 +0100
Message-ID: <BANLkTin5o9e8vR=ijWrdb_=mTkYC=qbZZQ@mail.gmail.com>
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
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57453 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262Ab1FQPTF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 11:19:05 -0400
Received: by pzk9 with SMTP id 9so1845155pzk.19
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2011 08:19:04 -0700 (PDT)
In-Reply-To: <BANLkTinJe2wAQwSrb+V3e2Xd87d+UQzFWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 17 June 2011 15:31, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Jun 17, 2011 at 4:58 PM, Daniel Drake <dsd@laptop.org> wrote:
>> Ignore the probe error - just observe the fact that the card was
>> detected and powered on, powered off, powered on and *then* probed.
>
> This is the normal behavior today when drivers are probed: we power up
> the card before probing a driver, and if the probe fails, we power it
> off.

The power off happens before the libertas-level probe starts. Is that
still in line with your expectations?

[    3.023445] mmc1: new SDIO card at address 0001
[    3.039597] mmc_power_save_host mmc1
[    3.054897] mmc_power_restore_host mmc1
<now libertas probe starts>

> Most cards wouldn't care too much: we're not loading/unloading drivers
> too frequently, and the advantage of the current solution is
> simplicity.
>
> But you are welcome to change this if you need to. I don't see how it
> can hurt anyone, and anyway it can also happen today too in some
> cases.

OK - if you are aware of it and expect it then I'm fine with it.
Likewise I'm trying to maximise our understanding on these issues.

I'll start digging on that 250ms delay thing. Today I find that 250ms
is unreliable so I'm now looking at 300ms...

cheers
Daniel
