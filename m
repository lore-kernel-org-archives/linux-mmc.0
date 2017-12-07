From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/6 v3] mmc: meson-gx-mmc: Fix platform_get_irq's error checking
Date: Wed, 06 Dec 2017 16:58:27 -0800
Message-ID: <7h4lp3mk0c.fsf@baylibre.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:38382 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdLGA6a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Dec 2017 19:58:30 -0500
Received: by mail-pg0-f46.google.com with SMTP id f12so3238607pgo.5
        for <linux-mmc@vger.kernel.org>; Wed, 06 Dec 2017 16:58:30 -0800 (PST)
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
        (Arvind Yadav's message of "Sun, 19 Nov 2017 10:22:43 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ben-linux@fluff.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
