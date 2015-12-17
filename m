From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Thu, 17 Dec 2015 20:54:24 +0100
Message-ID: <CAOQ7t2YB8VHw4+v=_5tMU5tAn4oE8KfCOPPAMbZx+2QyY7N5Zg@mail.gmail.com>
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
	<CAOQ7t2YOd9TtAHHUBhF4n_POQURhfaqC_9Tg-b8d1Bf2QCyoYA@mail.gmail.com>
	<a2ffc219b04b483b87696ffc81a60787@aptaiexm02f.ap.qualcomm.com>
	<CAOQ7t2Z=4Mc9Ev9OBxXiLDtiXaTr5jQzc-gVwU_xJnHLrumd0g@mail.gmail.com>
	<7a1072e99c8149a5b08d1bf260808ce7@aptaiexm02f.ap.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37009 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbLQTy0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 14:54:26 -0500
Received: by mail-wm0-f47.google.com with SMTP id p187so36608555wmp.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2015 11:54:25 -0800 (PST)
In-Reply-To: <7a1072e99c8149a5b08d1bf260808ce7@aptaiexm02f.ap.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Yang, York" <weijuny@qti.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <21cnbao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Song, Barry" <baohuas@qti.qualcomm.com>

On gio, dic 17, 2015 at 02:00:17 +0000, Yang, York wrote:
> Hi, Carlo

Hi Yang,

> I don't understand. We can see that 9faac7b95 is all about
> DDR50. It should not affect the behavior of SDR50.

What I'm saying is that this commit is negatively affecting some DDR50
SDIO card as in my case.

Ok, let's try to go through the code with and without 9faac7b95.

Without 9faac7b95:
- mmc_sdio_init_uhs_card() is called
- sw_caps.sd3_bus_mode is 0x14 (SD_MODE_UHS_SDR50 | SD_MODE_UHS_DDR50)
- card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50 is verified and
mmc_execute_tuning() is called
- sdhci_execute_tuning() is called
- host->timing is MMC_TIMING_UHS_DDR50
- since there is no case for that we end up in 'default', goto
out_unlock and CMD19 is never issued

With 9faac7b95:
- mmc_sdio_init_uhs_card() is called
- sw_caps.sd3_bus_mode is 0x14 (SD_MODE_UHS_SDR50 | SD_MODE_UHS_DDR50)
- card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50 is verified and
  mmc_execute_tuning() is called
- sdhci_execute_tuning() is called
- host->timing is MMC_TIMING_UHS_DDR50
- this time we have the the 'case MMC_TIMING_UHS_DDR50' and we break on that
- CMD19 is issued and the card stops working

> Since the commit is very simple, you may remove the change one by one
> by yourself. And see if any difference occurs.

As stated above the problem is in the new 'case MMC_TIMING_UHS_DDR50'
we have in sdhci_execute_tuning()

> Besides, please check
> if the card->sw_caps.sd3_bus_mode changes with or without DDR50 tuning
> enabled.

It doesn't.

-- 
Carlo Caione
