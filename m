From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 29 Jun 2011 17:19:14 +0800
Message-ID: <BANLkTinpAc0GeB1Lccg6f-R54qXN9Rq0Uw@mail.gmail.com>
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
	<BANLkTim-OECxe1Y5rDKyT19UjxDDsfwsbQ@mail.gmail.com>
	<BANLkTinAPGWH-hZiqc8zWA_Mifa_TPk3OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60165 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1F2JTP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 05:19:15 -0400
Received: by qwk3 with SMTP id 3so515810qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jun 2011 02:19:14 -0700 (PDT)
In-Reply-To: <BANLkTinAPGWH-hZiqc8zWA_Mifa_TPk3OA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Bing Zhao <bzhao@marvell.com>

On Wed, Jun 29, 2011 at 4:57 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Jun 29, 2011 at 11:43 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> However still not fully understand how to call ->remove to power off
>> wlan, using suspend system looks to me is only test method, which
>> counting on bus_ops->suspend returns -ENOSYS.
>
> Please take a look at mac80211 and wl12xx.
>
> We're not using ->remove, ->probe or -ENOSYS at all.
>
> When the user brings up the interface, we then power up the chip and
> download the firmware.
> Likewise, when the interface is brought down, we just power off the chip.

Thanks a lot Ohad & Daniel :)

Enable wlan: # ifconfig up mlan0 -> power up the chip via runtime PM
-> wlan_probe download the firmware
Disable wlan: # ifconfig down mlan0 -> power down the chip via runtime
PM -> wlan_remove ?

So every time ifconfig up/down, the chip is power up/down, and
firmware reloaded?

Is this understand correct?
Then runtime pm should also integrated into wlan driver as well.
