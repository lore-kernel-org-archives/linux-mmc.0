From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Call mmc_pwrseq_alloc()
Date: Wed, 8 Apr 2015 09:52:29 -0300
Message-ID: <CAOMZO5DEgSiMyYc89y8OTZ1rgsA1ghZP9Dz2b8ppaKQpN38zSQ@mail.gmail.com>
References: <1428368010-10094-1-git-send-email-festevam@gmail.com>
	<CAPDyKFodxVuT_dh4oRHRXndQq0X06j=nr2g6mEYSxL-orNBNNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33792 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbbDHMwa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 08:52:30 -0400
Received: by laat2 with SMTP id t2so58031210laa.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 05:52:29 -0700 (PDT)
In-Reply-To: <CAPDyKFodxVuT_dh4oRHRXndQq0X06j=nr2g6mEYSxL-orNBNNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Otavio Salvador <otavio@ossystems.com.br>, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Apr 8, 2015 at 6:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>> Changes since v1:
>> - Calling mmc_of_parse() breaks some boards due to bad card detect parsing.
>> Call only mmc_pwrseq_alloc() instead, which what we really need.
>
> Why can't we fix the card detect parsing instead?

That's a nicer approach indeed :-)

I have prepared a v3 and will submit it soon.

Thanks
