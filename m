From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Fri, 8 May 2015 09:27:54 -0300
Message-ID: <CAOMZO5D5PppBsoA4ti+2Wogo+_YUxwWy0tDK1whto9W_G_CXPw@mail.gmail.com>
References: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
	<CAPDyKFoWDCYq94jFXq5bO736hPvZLN7uiVWu2SHxUUPawc3xaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35069 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbEHM14 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 08:27:56 -0400
Received: by lbbuc2 with SMTP id uc2so51928072lbb.2
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 05:27:54 -0700 (PDT)
In-Reply-To: <CAPDyKFoWDCYq94jFXq5bO736hPvZLN7uiVWu2SHxUUPawc3xaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On Fri, May 8, 2015 at 8:49 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>> -
>>         boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
>
> This seems like a leftover as well!?

Please discard this patch. I have sent another series that restores
the non-dt functionality.

Thanks
