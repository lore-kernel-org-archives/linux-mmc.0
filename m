From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Wed, 20 Jun 2012 01:46:44 -0400
Message-ID: <8762am5yd7.fsf@octavius.laptop.org>
References: <e89a8ff1c3b8b41f0104c26545d9@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58911 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab2FTFqv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 01:46:51 -0400
In-Reply-To: <e89a8ff1c3b8b41f0104c26545d9@google.com> (haojian zhuang's
	message of "Thu, 14 Jun 2012 02:15:23 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: haojian.zhuang@gmail.com
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

Hi Haojian,

On Wed, Jun 13 2012, haojian.zhuang@gmail.com wrote:
> Compatible node could be "mrvl,pxav3-mmc" or "mrvl,sdhci-pxav3". It's 
> depend on your choice. I prefer to use vendor name in compatible
> property.
> And we could avoid naming conflict.

Okay, I'll just stick with mrvl,pxav3-mmc.

> + if (of_find_property(np, "non-removable", NULL))
> + pdata->flags |= PXA_FLAG_CARD_PERMANENT;
> +
> + of_property_read_u32(np, "bus-width", &bus_width);
> + if (bus_width == 8)
> + pdata->flags |= PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;
> +
> + of_property_read_u32(np, "clk-delay-cycles", &clk_delay_cycles);
> + if (clk_delay_cycles > 0)
> + pdata->clk_delay_cycles = clk_delay_cycles;
> +
>
> These properties should be "mrvl,non-removable", "mrvl,bus-width", 
> "mrvl,clk-delay-cycles". Since it's mentioned in 
> Documentations/devicetree/booting-without-of.txt. "It is recommended 
> that if you add any "custom" property whose name may clash with 
> standard defined ones, you prefix them with your vendor name and 
> a comma."

Not quite -- the "non-removable" and "bus-width" properties are part of
the MMC core DT bindings as defined in:

  Documentation/devicetree/bindings/mmc/mmc.txt

They are not custom Marvell properties.  So, these two need to stay as
they are (one day we'll interpret them in the sdhci driver instead of in
sdhci-pxa) but I've changed clk_delay_cycles to mrvl,clk_delay_cycles in
v2 of the patch, which I'm about to send out.  I also applied all of
Zhangfei's changes.

Thanks for the review!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
