From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Huge lockdep warning from sdhci/imx esdhc code
Date: Thu, 16 Jan 2014 10:16:33 -0200
Message-ID: <CAOMZO5B6Z8oExL27gue5BL6kLdL=9opB7x0jXXu=FJ4zFCuabA@mail.gmail.com>
References: <20140116114654.GU15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:36603 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaAPMQe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 07:16:34 -0500
Received: by mail-ve0-f180.google.com with SMTP id jz11so974597veb.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 04:16:33 -0800 (PST)
In-Reply-To: <20140116114654.GU15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Thu, Jan 16, 2014 at 9:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> ======================================================
> [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
> 3.13.0-rc7+ #401 Not tainted
> ------------------------------------------------------
> kworker/u8:1/44 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (prepare_lock){+.+.+.}, at: [<c04d10d4>] clk_prepare_lock+0x80/0xf4
>
> and this task is already holding:
>  (&(&host->lock)->rlock){-.-...}, at: [<c04b0528>] sdhci_do_set_ios+0x20/0x740
> which would create a new lock dependency:
>  (&(&host->lock)->rlock){-.-...} -> (prepare_lock){+.+.+.}

Please apply this patch:
https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/commit/?h=mmc-next&id=a974862faee199cba3ff36b5a148df5fd34bd1e7

Regards,

Fabio Estevam
