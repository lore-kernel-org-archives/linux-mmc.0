From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 29 Jun 2011 16:43:31 +0800
Message-ID: <BANLkTim-OECxe1Y5rDKyT19UjxDDsfwsbQ@mail.gmail.com>
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
	<BANLkTikkoD0vaxaFBbPd6UZa=iPJgaK2xQ@mail.gmail.com>
	<BANLkTik+0tgbWcfbUgAt6UxgEazt5i-yfQ@mail.gmail.com>
	<BANLkTi=4Q3x3QFB7pOPQpRzFJ1pW6OPjvQ@mail.gmail.com>
	<BANLkTinGo0V=oOj+V_PBoiOyS=aPq2tVHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47678 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab1F2Inb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 04:43:31 -0400
Received: by qyk29 with SMTP id 29so2392711qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jun 2011 01:43:31 -0700 (PDT)
In-Reply-To: <BANLkTinGo0V=oOj+V_PBoiOyS=aPq2tVHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Bing Zhao <bzhao@marvell.com>

>> So wlan probe function should be called for re-downloading, is it be
>> achieved by calling pm_runtime_get_sync and mmc_power_restore_host?
>
> Not really;
>
> I assume you refer to libertas_sdio, which AFAICT, is built to power
> on the device (and configure it) on ->probe(), and then power it off
> on ->remove().
> It then seems that this model was extended to support suspend/resume
> by asking the MMC core to ->remove() the card on suspend, and then
> relying on it to re-detect and re-add the card on resume, which will
> trigger libertas' ->probe() again.
>
> IMHO this model is a little awkward; as you can see, powering on/off
> the chip requires re-probing the driver.
>
> Take a look how mac80211 drivers (and wl12xx in particular) behave:
> they are powered on (and firmware is downloaded) when the user brings
> the wlan0 interface up, and then powered off when the wlan interface
> is brought down.
>
> The runtime PM API is only being used to control the power to the
> device, but downloading the firmware and doing driver-specific
> configuration is up to the driver to do.

Thanks Ohad for your kind explanation.

However still not fully understand how to call ->remove to power off
wlan, using suspend system looks to me is only test method, which
counting on bus_ops->suspend returns -ENOSYS.

What we do before is
1. From user space use rfkill unblock wifi, or echo on/off > "/sys/~"
to enable/disable wlan power, which could be replaced by pm_runtime of
course.
2. Explicitly call mmc_detect_change,
when power off, mmc_rescan -> bus_ops->detect(host) -> mmc_select_card
fail -> mmc_sdio_remove;
when power on, mmc_rescan ->  mmc_attach_sdio->wlan probe.

However, this is not workable if using mmc_power_save_host, since
bus_ops->detect not workable after power off card.
1. detect is only for !MMC_CAP_NONREMOVABLE
2. In mmc_sdio_detect, power is provided before mmc_select_card via
pm_runtime_get_sync.
3. Most important, mmc_power_save_host->mmc_power_off->set clk=0 via
set_ios, so controller will no response and timeout.

How to enable/disable mac80211 at runtime from user space?
In wl12xx/debugfs.c, gpio_power_write->wl1271_sdio_power_off? still
unclear how remove is called.

Thanks
