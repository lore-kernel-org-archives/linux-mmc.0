From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS
Date: Sat, 22 Feb 2014 12:05:43 -0300
Message-ID: <CAOMZO5DF5DOBMoD7G3237ecPW6YRmEx-KH0pQu4GiSoS+4f5eg@mail.gmail.com>
References: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
	<1393081043.986934859@f421.i.mail.ru>
	<CAOMZO5DesjMCGXeYxaO8y1s7zNfP1z9qr_SsQA2W178n4rcW4A@mail.gmail.com>
	<1393081369.457413293@f421.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:40303 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaBVPFo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 10:05:44 -0500
Received: by mail-vc0-f177.google.com with SMTP id if11so4248555vcb.22
        for <linux-mmc@vger.kernel.org>; Sat, 22 Feb 2014 07:05:43 -0800 (PST)
In-Reply-To: <1393081369.457413293@f421.i.mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>

On Sat, Feb 22, 2014 at 12:02 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

>> but then you would get a warning saying that "mxcmci_suspend/resume"
>> are defined by not used" when CONFIG_PM_SLEEP=n
>
> Please see the patch first,
> this warnings is avoided by "__maybe_unused" attributes.

Ok, I see it now ;-)

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
