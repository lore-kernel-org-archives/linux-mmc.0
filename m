From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: mxcmmc: DT support
Date: Fri, 12 Apr 2013 14:29:39 -0400
Message-ID: <87sj2vd2lo.fsf@octavius.laptop.org>
References: <1364225659-29677-1-git-send-email-mpa@pengutronix.de>
	<1364753258-16732-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51920 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab3DLS3u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 14:29:50 -0400
In-Reply-To: <1364753258-16732-1-git-send-email-agust@denx.de> (Anatolij
	Gustschin's message of "Sun, 31 Mar 2013 20:07:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: rob.herring@calxeda.com, rob@landley.net, kernel@pengutronix.de, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mpa@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>

Hi,

On Sun, Mar 31 2013, Anatolij Gustschin wrote:
> From: Markus Pargmann <mpa@pengutronix.de>
>
> Adding devicetree support for imx21-mmc and imx31-mmc. Based on generic
> gpio helper functions by Guennadi and generic DMA devicetree bindings.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by:: Anatolij Gustschin <agust@denx.de>

Sascha, Arnd, perhaps one of you could review this?  There's another
patchset waiting on it.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
