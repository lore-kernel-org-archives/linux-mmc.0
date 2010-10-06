From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH V2 1/3] ARM: S5PV310: Add support HSMMC and SDHCI
 configuration
Date: Wed, 06 Oct 2010 17:22:16 +0900
Message-ID: <000b01cb652f$ab6125d0$02237170$%kim@samsung.com>
References: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
 <1286344846-21244-2-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58597 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab0JFIWe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2010 04:22:34 -0400
In-reply-to: <1286344846-21244-2-git-send-email-jeongbae.seo@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jeongbae Seo' <jeongbae.seo@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>

Jeongbae Seo wrote:
> 
> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> This patch adds support HSMMC for S5PV310 and S5PC210 and
> setup for HSMMC host controller and also related GPIO.
> At most 4 channel can be used at the same time.
> A user can configure SDHCI data bus as 8bit or 4bit.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---

(snip)

> +	/* Set all the necessary GPK0[0:1] pins to special-function 2 */
> +	for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);

Hi

Maybe as you know, above lines can be changed like below.

s3c_gpio_cfgrange_nopull(S5PV310_GPK0(0), 2, S3C_GPIO_SFN(2));

Of course regarding gpio update patches are not pulled in my for-next yet,
because under reviewing in ML now.
But I think, you can do it against dev/gpio-update.

Anyway could you please make additional patch for it?
It would be nice if you could do it :-)

Others ok to me...but I will sort out regarding sdhci gpio configuration in
future time.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

