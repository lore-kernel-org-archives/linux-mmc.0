From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Fri, 8 May 2015 02:59:05 -0300
Message-ID: <CAOMZO5DJ7GMAn7we2Xoa4OrDtfnyGTU=EfVLEWZnufC_sqYhbw@mail.gmail.com>
References: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
	<20150508044124.GU6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36536 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbEHF7H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 01:59:07 -0400
Received: by lagv1 with SMTP id v1so45673485lag.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 22:59:05 -0700 (PDT)
In-Reply-To: <20150508044124.GU6325@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Hi Sascha,

On Fri, May 8, 2015 at 1:41 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Commit 8d86e4fcccf61ba mmc: sdhci-esdhc-imx: Call mmc_of_parse()
> is seriously broken. It removed the calls to
>
> mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
>
> and
>
> mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
>
> This makes the boarddata gpios unused, thus effectivly breaking
> platform_data provided cd/wp gpios. Not that I care much about
> platform_data based boards, but maybe we should make that explicit.

You are right. I forgot about the non-dt case.

This affects mach-pcm043.c, so I am sending a series that will restore
the cd/wp functionality for the non-dt case.

Regards,

Fabio Estevam
