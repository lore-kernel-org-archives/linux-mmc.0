From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 4/4] mmc: meson-gx: add CMD23 mode
Date: Fri, 24 Mar 2017 16:19:58 -0700
Message-ID: <m2mvcadzz5.fsf@baylibre.com>
References: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com>
        <51dcee34-1cfe-641e-5e06-aa7ef667831e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35167 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbdCXXUB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 19:20:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id 20so1803692pfk.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 16:20:00 -0700 (PDT)
In-Reply-To: <51dcee34-1cfe-641e-5e06-aa7ef667831e@gmail.com> (Heiner
        Kallweit's message of "Fri, 24 Mar 2017 23:15:33 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> CMD23 mode (use "set block count" command before transferring multiple
> data blocks) typically is more performant as host / card know upfront
> how many data blocks to expect. Therefore add support for this mode to
> the driver.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
