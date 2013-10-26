From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] mmc:sdhci-esdhc-imx: Use NULL instead of zero
Date: Sat, 26 Oct 2013 16:11:04 -0200
Message-ID: <CAOMZO5B4NayQWLBCdxOeMC2nqF9ODn-G2uvuPy-k2Ekbj1UMWA@mail.gmail.com>
References: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:52667 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab3JZSLG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Oct 2013 14:11:06 -0400
Received: by mail-ve0-f180.google.com with SMTP id oy12so1636610veb.39
        for <linux-mmc@vger.kernel.org>; Sat, 26 Oct 2013 11:11:05 -0700 (PDT)
In-Reply-To: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

Chris,

On Fri, Oct 4, 2013 at 10:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Fix the following sparse warning:
>
> drivers/mmc/host/sdhci-esdhc-imx.c:617:35: warning: Using plain integer as NULL pointer
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Any comments on this one?

Regards,

Fabio Estevam
