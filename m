From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/5] mmc: sdhci-spear: fix error handling paths for DT
Date: Mon, 24 Feb 2014 11:29:18 +0530
Message-ID: <CAKohpok+p+7uBhO3GF18fSOTCb-=29sH7Ua_fSsGFzPc83bgsQ@mail.gmail.com>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
	<E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:34533 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaBXF7S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2014 00:59:18 -0500
Received: by mail-oa0-f42.google.com with SMTP id j17so4649253oag.15
        for <linux-mmc@vger.kernel.org>; Sun, 23 Feb 2014 21:59:18 -0800 (PST)
In-Reply-To: <E1WGnXX-0007Jg-JR@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Pratyush Anand <pratyush.anand@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel <spear-devel@list.st.com>, linux-mmc@vger.kernel.org

On 21 February 2014 16:11, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Fix the error handling paths for DT and simplify using the devm_* API
> for clk_get().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-spear.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

For all patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
