From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-sirf: let device core setup the default pin configuration
Date: Tue, 14 May 2013 11:01:34 +0200
Message-ID: <CACRpkdY_Y1JWxS5QfPKwpt6nMvWzuYK4g=MX=ztsxNTE8dqyaA@mail.gmail.com>
References: <1368510549-7230-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52348 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3ENJBe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 05:01:34 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so481337iec.8
        for <linux-mmc@vger.kernel.org>; Tue, 14 May 2013 02:01:34 -0700 (PDT)
In-Reply-To: <1368510549-7230-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Baohua.Song@csr.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

On Tue, May 14, 2013 at 7:49 AM, Barry Song <Baohua.Song@csr.com> wrote:

> With device core now able to setup the default pin configuration, the call
> to devm_pinctrl_get_select_default can be removed. And the pin configuration
> code based on the deprecated Samsung specific gpio bindings is also removed.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Also delete this line:
#include <linux/pinctrl/consumer.h>

After that: Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
