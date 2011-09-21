From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Set correct bus mode before card init
Date: Wed, 21 Sep 2011 14:20:09 -0400
Message-ID: <m2vcsl3gh2.fsf@bob.laptop.org>
References: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55736 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab1IUSUN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:20:13 -0400
In-Reply-To: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 15 Sep 2011 17:50:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Hi,

On Thu, Sep 15 2011, Ulf Hansson wrote:
> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>
> Earlier all cards where initiated with bus mode set as OPENDRAIN, and then
> later switched to PUSHPULL. According to the MMC/SD/SDIO specifications only
> MMC cards use OPENDRAIN during init. For both SD and SDIO the bus mode shall
> be PUSHPULL before attempting to init the card.
>
> The consequence of having incorrect bus mode can lead to not being able
> to detect the card. Therefore the default behavior have now been changed to
> PUSHPULL in mmc_power_up, and will only be temporarily switched when trying
> to attach or init a MMC card.
>
> Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>

Thanks, pushed to mmc-next for 3.2 with Linus W's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
