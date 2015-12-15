From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Wed, 16 Dec 2015 08:56:39 +0900
Message-ID: <5670A8B7.7080808@samsung.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42951 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbLOX4r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2015 18:56:47 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZF00LCMBULGQ80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Dec 2015 08:56:45 +0900 (KST)
In-reply-to: <CAOQ7t2Z=4Mc9Ev9OBxXiLDtiXaTr5jQzc-gVwU_xJnHLrumd0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>, "Yang, York" <weijuny@qti.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <21cnbao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Song, Barry" <baohuas@qti.qualcomm.com>

Hi,

On 12/14/2015 07:56 PM, Carlo Caione wrote:
> On Mon, Dec 14, 2015 at 10:24 AM, Yang, York <weijuny@qti.qualcomm.com> wrote:
>> Hi, Carlo
>>
>>         I don't think so. You may check the 9faac7b95, there are two changes in sd.c and sdhc.c.
>>         Surely the change in sdhc.c will not affect ASUS X205TA (bcm43341) since it is a SDIO device.
>>         Actually the calling sequence is this: mmc_sd_init_uhs_card() calls sdhci_execute_tuning(). In 9faac7b95, I enabled tuning for DDR50 in these two functions.
>>         If your function calling sequence is mmc_sdio_init_uhs_card()->sdhci_execute_tuning(), the tuning will not carried out, since you didn't enable tuning for DDR50 in mmc_sdio_init_uhs_card().
>>         Unless you call sdhci_execute_tuning directly, the tuning command may go through be sent out.
> 
> Hi Yang,
> 
> On the unmodified master what I see is:
> 
> - mmc_sdio_init_uhs_card() is called
> - card->sw_caps.sd3_bus_mode is 0x14
> - card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50 is actually verified
> (even though the tuning for DDR50 is not enabled)
> - mmc_execute_tuning() is actually called

As i know, When mode is UHS_SDR50, tuning is not mandatory.
Even though i need to check the spec file, i think that condition check is strange.

Best Regards,
Jaehoon Chung

> 

