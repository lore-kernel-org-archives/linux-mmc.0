From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Tue, 28 Jun 2011 14:10:10 +0300
Message-ID: <BANLkTinGo0V=oOj+V_PBoiOyS=aPq2tVHw@mail.gmail.com>
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
 <BANLkTinD-3joE8QgeW07gWMW4gBwQRNzXg@mail.gmail.com> <BANLkTikkoD0vaxaFBbPd6UZa=iPJgaK2xQ@mail.gmail.com>
 <BANLkTik+0tgbWcfbUgAt6UxgEazt5i-yfQ@mail.gmail.com> <BANLkTi=4Q3x3QFB7pOPQpRzFJ1pW6OPjvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50212 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756804Ab1F1LKd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 07:10:33 -0400
Received: by vws1 with SMTP id 1so56098vws.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 04:10:32 -0700 (PDT)
In-Reply-To: <BANLkTi=4Q3x3QFB7pOPQpRzFJ1pW6OPjvQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>

Hi Zhangfei,

On Tue, Jun 28, 2011 at 12:13 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> One question :(

Np, feel free to ask !
(but it's usually better to start a new thread, rather then forking an
existing one under the same subject)

> Under pm_runtime mechanism, how to dynamically open/close wlan.

Actually it should be the other way around: when you enable/disable
WLAN (e.g. Ifconfig up/down), you then use the runtime PM API to power
up/down the device.

> If the wlan chip really power off, the firmware should be reloaded,
> since the firmware is download to ram and disappear after power off.

Right.

> So wlan probe function should be called for re-downloading, is it be
> achieved by calling pm_runtime_get_sync and mmc_power_restore_host?

Not really;

I assume you refer to libertas_sdio, which AFAICT, is built to power
on the device (and configure it) on ->probe(), and then power it off
on ->remove().
It then seems that this model was extended to support suspend/resume
by asking the MMC core to ->remove() the card on suspend, and then
relying on it to re-detect and re-add the card on resume, which will
trigger libertas' ->probe() again.

IMHO this model is a little awkward; as you can see, powering on/off
the chip requires re-probing the driver.

Take a look how mac80211 drivers (and wl12xx in particular) behave:
they are powered on (and firmware is downloaded) when the user brings
the wlan0 interface up, and then powered off when the wlan interface
is brought down.

The runtime PM API is only being used to control the power to the
device, but downloading the firmware and doing driver-specific
configuration is up to the driver to do.

> From Daniel's test log, "echo mem > /sys/power/state" is used to
> restart wlan, is this standard method?

That command was only used to trigger system suspend - Daniel was
testing libertas & runtime PM behavior in that scenario.

Thanks,
Ohad.
