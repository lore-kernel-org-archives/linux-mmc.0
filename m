From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: Workaround for dev with broken CMD53
Date: Wed, 21 Sep 2011 14:17:59 -0400
Message-ID: <m2zkhx3gko.fsf@bob.laptop.org>
References: <1316101384-21009-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55719 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab1IUSSE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:18:04 -0400
In-Reply-To: <1316101384-21009-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 15 Sep 2011 17:43:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Hi Ulf,

On Thu, Sep 15 2011, Ulf Hansson wrote:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> Adds a quirk which can be turned on for SDIO devices
> that do not support 512 byte requests in byte mode during
> CMD53. These requests will always be sent in block mode
> instead.
>
> This patch also enables this quirk for ST-Ericsson
> CW1200 WLAN device.
>
> Change-Id: Id31787fcbfeb0b97ba2e8c583e9363a7c08811d2

Please don't include these lines when sending upstream.

> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>

Thanks, merged to mmc-next for 3.2 with Linus W's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
