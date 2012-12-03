From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-imx-esdhc: use more devm_* functions
Date: Mon, 03 Dec 2012 14:14:25 -0500
Message-ID: <87txs3hrse.fsf@octavius.laptop.org>
References: <1353911983-10103-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59576 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2LCTOa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:14:30 -0500
In-Reply-To: <1353911983-10103-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Mon, 26 Nov 2012 14:39:43 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shawn,

On Mon, Nov 26 2012, Shawn Guo wrote:
> Use devm_kzalloc, devm_gpio_request_one and devm_request_irq to make
> cleanup path simpler.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
