From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Add a common clk API based implementation of get_timeout_clock
Date: Mon, 11 Feb 2013 11:26:03 -0500
Message-ID: <87obfqstpg.fsf@octavius.laptop.org>
References: <1359397632-31646-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55262 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757575Ab3BKQ0J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 11:26:09 -0500
In-Reply-To: <1359397632-31646-1-git-send-email-lars@metafoo.de> (Lars-Peter
	Clausen's message of "Mon, 28 Jan 2013 19:27:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Shawn Guo <shawn.guo@linaro.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

Hi Lars-Peter,

On Mon, Jan 28 2013, Lars-Peter Clausen wrote:
> Quite a few drivers have a implementation of the get_timeout_clock callback
> which simply returns the result of clk_get_rate on devices clock. This patch
> adds a common implementation of this to the sdhci-pltfm module and replaces all
> custom implementations with the common one.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I've only runtime tested this patch on a platform which is not yet upstream. For
> the drivers which are modified in this patch I've only done compile time
> testing. But I think all changes, but maybe the bcm2835 one, are straight
> forward.

Looks like this has good testing coverage now; pushed to mmc-next for
3.9, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
