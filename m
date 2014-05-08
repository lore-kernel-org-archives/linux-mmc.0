From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: usb backend needs LED support
Date: Thu, 8 May 2014 10:29:56 +0200
Message-ID: <CAPDyKFo_ZG9e4kUHvze1FgCPXZjZR4BcmrNuZPwGEhjTvMx6og@mail.gmail.com>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
	<7208467.nZIXMIfPji@wuerfel>
	<CAPDyKFpJrrviaZo_L8MkLF=v7DqGEVj9=uSNsNtU-FXNwu-MmQ@mail.gmail.com>
	<201404300228.s3U2S7WA026782@rtits1.realtek.com>
	<53606F49.1000401@realtek.com>
	<CAPDyKFrA39eFnoy-sAGcAUeDqtB78cvAivV+mmRR5C-tov-9eg@mail.gmail.com>
	<536B3B6F.1010209@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:62747 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbaEHI35 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 04:29:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2467534qcx.27
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 01:29:56 -0700 (PDT)
In-Reply-To: <536B3B6F.1010209@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger <rogerable@realtek.com>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>

>>>
>>> From: Roger Tseng <rogerable@realtek.com>
>>> Date: Wed, 30 Apr 2014 11:11:25 +0800
>>> Subject: [PATCH] mmc: rtsx: fix possible linking error if built-in
>>>
>>> rtsx_usb_sdmmc module uses the LED classdev if available, but the code
>>> failed
>>> to consider the situation that it is built-in and the LED classdev is a
>>> module,
>>> leading to following linking error:
>>>
>>>    LD      init/built-in.o
>>> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_remove':
>>> rtsx_usb_sdmmc.c:(.text+0x2a018e): undefined reference to
>>> `led_classdev_unregister'
>>> drivers/built-in.o: In function `rtsx_usb_sdmmc_drv_probe':
>>> rtsx_usb_sdmmc.c:(.text+0x2a197e): undefined reference to
>>> `led_classdev_register'
>>>
>>> Fix by excluding such condition when defining macro
>>> RTSX_USB_USE_LEDS_CLASS.
>>>
>>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>>
>>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>
> Would this patch be merged into linux-next or Lee's mfd.git
> ib-mfd-mmc-memstick-3.16 branch?

This is for Chris' tree.

Kind regards
Ulf Hansson

>
> By the way, should I resend my version?
>
>
