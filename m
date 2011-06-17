From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Fri, 17 Jun 2011 14:58:08 +0100
Message-ID: <BANLkTimMPXdSKf3bO8ymco+Z8D215Fy5TQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63619 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab1FQN6J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 09:58:09 -0400
Received: by pzk9 with SMTP id 9so1780825pzk.19
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2011 06:58:09 -0700 (PDT)
In-Reply-To: <BANLkTi=2EFMDNjOdmfqkWD1pQJthgR4uKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 16 June 2011 22:22, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Thu, Jun 16, 2011 at 8:27 PM, Daniel Drake <dsd@laptop.org> wrote:
>> Why is there so much power flipping going on during resume?
>
> There isn't.
>
> You see this with libertas, because it doesn't really suspend/resume cleanly.

It's not related to suspend/resume. If I build libertas_sdio into the
kernel I see the same thing happening during boot:

http://dev.laptop.org/~dsd/20110617/dmesg.txt

[    3.023445] mmc1: new SDIO card at address 0001
[    3.039597] mmc_power_save_host mmc1
[    3.054897] mmc_power_restore_host mmc1
[    3.409482] CMD5 reset failed, err=-110
[    3.427733] libertas_sdio: probe of mmc1:0001:1 failed with error -16

Ignore the probe error - just observe the fact that the card was
detected and powered on, powered off, powered on and *then* probed.
That's the same thing that happens in the resume path. Couldn't the
power have just been maintained from when the card was detected, given
that the driver was loaded and ready to go?

> Could you also trigger this with the previous power off/on mechanism
> you used (an rfkill driver IIRC) ? if not, what's the difference ? did
> you have just enough delay there which didn't trigger this problem ?

No, it couldn't be triggered. This is because our rfkill driver used
the "normal" MMC card powerup routine (which runtime PM doesn't use)
which unconditionally calls sdio_reset().

Thinking more, I think I prefer sdio_reset() as a quirk/workaround
instead of the sleep, because the sleep is quite long. What do you
think?

> First, I suggest to understand where does this requirement come from.
> Is this a rigid hardware requirement ? Does it always require waiting
> 250ms before powering it on again ?

Any suggestions for how I go about doing that? Unfortunately we have a
backlog of support requests with Marvell which have not yet been
responded to.

> If yes, then why not let the relevant regulator take care of it ? this
> way you never have to care. you just power it off and on as you
> please, and things just work.

Yes, a regulator could work. But, aren't regulators linked to the
platform rather than to the card? I would imagine that this quirk
needs to be applied to all users of the card, therefore a card quirk
could be more appropriate? Also, if you think the sdio_reset() option
is preferable to the sleep, can that be done from a regulator?

Thanks
Daniel
