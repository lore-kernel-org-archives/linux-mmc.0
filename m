From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 29/34] mmc: mxcmmc: remove mach/hardware.h inclusion
Date: Mon, 17 Sep 2012 01:41:26 -0400
Message-ID: <m3392h1a0p.fsf@pullcord.laptop.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
	<1347860103-4141-30-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47767 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab2IQFlR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 01:41:17 -0400
In-Reply-To: <1347860103-4141-30-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Mon, 17 Sep 2012 13:34:58 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Mon, Sep 17 2012, Shawn Guo wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the controller type, and updates the platform code
> accordingly.
>
> As the result, mach/hardware.h inclusion gets removed from the driver.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
