From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: mmc: core: Fix access to HS400-ES devices
Date: Fri, 10 Mar 2017 09:46:08 +0100
Message-ID: <7839966.gC4mPiIIyr@diego>
References: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:48258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbdCJIqN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Mar 2017 03:46:13 -0500
In-Reply-To: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

Am Mittwoch, 1. März 2017, 14:11:47 CET schrieb Guenter Roeck:
> HS400-ES devices fail to initialize with the following error messages.
> 
> mmc1: power class selection to bus width 8 ddr 0 failed
> mmc1: error -110 whilst initialising MMC card
> 
> This was seen on Samsung Chromebook Plus. Code analysis points to
> commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
> high-speed mode"), which attempts to set the bus width for all but
> HS200 devices unconditionally. However, for HS400-ES, the bus width
> is already selected.
> 
> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Fixes: 3d4ef329757c ("mmc: core: fix multi-bit bus width ...")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chip.com>

On a rk3399-kevin and the current mainline kernel from 20170309 it makes the 
issue go away and the emmc work again, so

Tested-by: Heiko Stuebner <heiko@sntech.de>

