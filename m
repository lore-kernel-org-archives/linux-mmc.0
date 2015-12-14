From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Mon, 14 Dec 2015 10:13:55 +0100
Message-ID: <CAOQ7t2YOd9TtAHHUBhF4n_POQURhfaqC_9Tg-b8d1Bf2QCyoYA@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
	<CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
	<CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
	<CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
	<CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
	<CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
	<CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
	<CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
	<CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
	<edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38747 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbLNJN4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2015 04:13:56 -0500
Received: by wmpp66 with SMTP id p66so51584209wmp.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2015 01:13:55 -0800 (PST)
In-Reply-To: <edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Yang, York" <weijuny@qti.qualcomm.com>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <21cnbao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Song, Barry" <baohuas@qti.qualcomm.com>

On Mon, Dec 14, 2015 at 9:46 AM, Yang, York <weijuny@qti.qualcomm.com> wrote:
> Hi, Carlo
>         In 9faac7b95, tuning for DDR50 is enabled in mmc_sd_init_uhs_card(), so only SD card is affected.
>         This is based on the SD spec version 3.01.
>         mmc_sdio_init_uhs_card() is untouched. I don't know who add the code into mmc_sdio_init_uhs_card() and you may have a check on your side.

Hi Yang,
sorry for not being clear. Modifying mmc_sdio_init_uhs_card() was only
a test I did to check whether that could fix the issue, but it didn't.

Right now the situation is:
- In the latest master with commit 9faac7b95 WiFi is broken on the
ASUS X205TA (bcm43341)
- Reverting 9faac7b95 makes it working fine again

My conclusion is that issuing the CMD19 is basically breaking WiFi on
this platform.

-- 
Carlo Caione
