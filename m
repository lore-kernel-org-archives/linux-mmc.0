From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH 4/6] mmc: sdhci-esdhc-imx: config watermater levles and
 burst lengths
Date: Wed, 10 Jun 2015 07:36:00 -0700
Message-ID: <55784B50.6030101@boundarydevices.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com> <1433926244-29244-5-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33667 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbbFJOgD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jun 2015 10:36:03 -0400
Received: by pdjn11 with SMTP id n11so39251247pdj.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2015 07:36:02 -0700 (PDT)
In-Reply-To: <1433926244-29244-5-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>, linux-mmc@vger.kernel.org
Cc: aisheng.dong@freescale.com, ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

Hi Haibo,

On 06/10/2015 01:50 AM, Haibo Chen wrote:
> i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
> DDR mode. So the I/O speed improve a lot compare to SD3.0
> 
> The default burst length is 8, if we don't change this value, in
> HS400 mode, when we do eMMC read operation, we can find that the
> clock signal will stop for a period of time. This means the speed
> of data moving on AHB bus is slower than I/O speed. So we should
> improve the speed of data moving on AHB bus.
> 
> For imx7d usdhc, this patch set the burst length as 16, and set
> watermater levle as 64. The test result is the clock signal has
> no stop during the eMMC HS400 operation. For other imx usdhc, remain

"watermark", not "watermater".

> the default value: burst length as 8, watermater level as 16.
> 
Same goes for the subject.

Also "levels", not "levles", so:
	mmc: sdhci-esdhc-imx: config watermark level and burst length


