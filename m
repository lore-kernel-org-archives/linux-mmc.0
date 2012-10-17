From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Wed, 17 Oct 2012 11:15:47 +0200
Message-ID: <201210171115.48401.heiko@sntech.de>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org> <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55285 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424Ab2JQJPx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Oct 2012 05:15:53 -0400
In-Reply-To: <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Hi,

Am Freitag, 14. September 2012, 11:08:51 schrieb Chander Kashyap:
> Perform clock disable/enable in runtime suspend/resume.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>

It seems this patch breaks my S3C2416 based machine with 3.7-rc1. I'm not 
yet sure why, but the only response I get is loop of:

	mmc0: Timeout waiting for hardware interrupt.
	mmc0: Internal clock never stabilised.
	mmc0: Timeout waiting for hardware interrupt.
	mmc0: Internal clock never stabilised.


This only happens on the hsmmc channel using the gpio-based card detect and 
even prevents the card from beeing fully detected. The other hsmmc channel 
using a permanent emmc seems to be working fine.

And of course, when I revert this patch everything works fine again.

I'll investigate further, but it'd be also ok if someone has a fix for this 
before me :-) .


Heiko
