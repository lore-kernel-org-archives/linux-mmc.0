From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3] mmc: dw_mmc: let device core setup the default pin
 configuration
Date: Mon, 08 Apr 2013 21:19:27 +0900
Message-ID: <003501ce3453$502adf80$f0809e80$%jun@samsung.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15768 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935057Ab3DHMT3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 08:19:29 -0400
In-reply-to: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, linux-arm-kernel@lists.infradead.org, t.figa@samsung.com, heiko@sntech.de, linus.walleij@linaro.org, patches@linaro.org

On Friday, April 05, 2013, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

I hope that your another patch is merged.
 ARM: dts: add pinctrl nodes for Exynos5250 SoC
I didn't check whether it is applied.

Thanks,
Seungwon Jeon

