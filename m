From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Tue, 28 Jun 2011 17:13:22 +0800
Message-ID: <BANLkTi=4Q3x3QFB7pOPQpRzFJ1pW6OPjvQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42534 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab1F1JNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 05:13:24 -0400
Received: by qyk9 with SMTP id 9so3119124qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 02:13:22 -0700 (PDT)
In-Reply-To: <BANLkTik+0tgbWcfbUgAt6UxgEazt5i-yfQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>

Hi, Ohad

One question :(

Under pm_runtime mechanism, how to dynamically open/close wlan.

If the wlan chip really power off, the firmware should be reloaded,
since the firmware is download to ram and disappear after power off.
So wlan probe function should be called for re-downloading, is it be
achieved by calling pm_runtime_get_sync and mmc_power_restore_host?

>From Daniel's test log, "echo mem > /sys/power/state" is used to
restart wlan, is this standard method?
Since host->bus_ops is already not NULL, mmc_rescan will return direclty.

Thanks
