From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 20:55:54 +0100
Message-ID: <BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34032 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab1FITzz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 15:55:55 -0400
Received: by pvg12 with SMTP id 12so900998pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 12:55:54 -0700 (PDT)
In-Reply-To: <BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 9 June 2011 19:25, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> let's update that patch. I'd send you an updated one, but I have to go
> for awhile, so here's the quick change you need to do.

Unfortunately it doesn't help.

New patch:
http://dev.laptop.org/~dsd/20110609/sd-pwr-debug6.patch

During resume, this happens:
[  152.156215] mmc1: new SDIO card at address 0001
[  152.198193] mmc_power_save_host mmc1
[  152.212397] mmc_power_restore_host mmc1
[  152.311567] CMD5 reset failed, err=-110
[  152.315513] libertas_sdio: probe of mmc1:0001:1 failed with error -16

bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		400000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	1 (open drain)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	0 (1 bits)
timing spec:	0 (legacy)



(I had forgotten to include final ios output in my last test, sorry about that)

Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug6.txt

What next? Is it concerning that ios ends up running at the wrong
frequency and voltage?
Daniel
