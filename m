From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Add pinctrl support
Date: Mon, 25 Feb 2013 10:09:15 +0530
Message-ID: <CAK9yfHzXZ0Xjg02FGALAvbzm0P+Oo-XuSNciYj+cAOvOuOUL8w@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<1360238236-17694-2-git-send-email-sachin.kamat@linaro.org>
	<CACRpkdbJJq3+BkHwzM_osDxdY5ZuVyTuYDjejaqNRRETMf7a6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:54293 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505Ab3BYEjP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Feb 2013 23:39:15 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so2521402oag.15
        for <linux-mmc@vger.kernel.org>; Sun, 24 Feb 2013 20:39:15 -0800 (PST)
In-Reply-To: <CACRpkdbJJq3+BkHwzM_osDxdY5ZuVyTuYDjejaqNRRETMf7a6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com

On 7 February 2013 21:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 7, 2013 at 12:57 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>
>> Added support for pin configuration using pinctrl subsystem.
>>
>
> NACK.
>
> In the v3.9 merge window we will merge this patch:
> http://marc.info/?l=linux-kernel&m=135887740715083&w=2
>
> That should do the trick. Just define your tables properly.
>

Just a small clarification needed in this regard.
On systems that do not use pinctrl and need to configure the gpios, we
used to check the return value of devm_pinctrl_get_select_default()
for error and then parse the dt file for gpios and configure them if
needed. Now your latest patch "drivers/pinctrl: grab default handles
from device core" suggests not to use boilerplate code as it will
handle pinctrl configuration based on dt entries for it. So in the
case like dw_mmc (in my patch above), please suggest best way to avoid
parsing gpios from dt file in case where we have pinctrl defined.

The following 3 lines (with +) wouldn't be required according to the
patch and hence 'for' loop would get executed (which I want to avoid
as the system supports pinctrl in this case).

+       pctrl = devm_pinctrl_get_select_default(host->dev);
+       if (!IS_ERR(pctrl))
+               return 0;
+
        /* cmd + clock + bus-width pins */
        for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
                gpio = of_get_gpio(slot_np, idx);

-- 
With warm regards,
Sachin
