From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Add pinctrl support
Date: Thu, 28 Feb 2013 00:19:16 +0100
Message-ID: <CACRpkdZ1Hw3YCDEQje=9sOntN7ft4Vsi=T3VBHb5nj_y=GRXXg@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<1360238236-17694-2-git-send-email-sachin.kamat@linaro.org>
	<CACRpkdbJJq3+BkHwzM_osDxdY5ZuVyTuYDjejaqNRRETMf7a6w@mail.gmail.com>
	<CAK9yfHzXZ0Xjg02FGALAvbzm0P+Oo-XuSNciYj+cAOvOuOUL8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65189 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3B0XTQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 18:19:16 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so1313145iea.38
        for <linux-mmc@vger.kernel.org>; Wed, 27 Feb 2013 15:19:16 -0800 (PST)
In-Reply-To: <CAK9yfHzXZ0Xjg02FGALAvbzm0P+Oo-XuSNciYj+cAOvOuOUL8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com

On Mon, Feb 25, 2013 at 5:39 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> Just a small clarification needed in this regard.
> On systems that do not use pinctrl and need to configure the gpios, we
> used to check the return value of devm_pinctrl_get_select_default()
> for error and then parse the dt file for gpios and configure them if
> needed.

The idea of pinctrl_get_select_default() is (as you could guess
from it's name) to get a pin ctrl handle and select the default state.

The return code from that function tells you whether that was
successful or not.

It does *NOT* tell you to go and look up GPIO values if it wasn't!

Then the function would be named
bool pinctrl_is_used_on_this_system().

Please review the recent conversation I had with Tomasz and
Heiko on this, especially this mail:
http://marc.info/?l=linux-kernel&m=136166647121345&w=2

Yours,
Linus Walleij
