From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Restructure and simplify code for mmc sleep|awake
Date: Sun, 26 May 2013 13:39:25 -0400
Message-ID: <87sj19ljxu.fsf@octavius.laptop.org>
References: <1366377131-2984-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56715 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207Ab3EZRj2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:39:28 -0400
In-Reply-To: <1366377131-2984-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Fri, 19 Apr 2013 15:12:11 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On Fri, Apr 19 2013, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The mmc_card_sleep|awake APIs are not being used since the support is
> already properly encapsulated within the suspend sequence. Sleep|awake
> command is also specific for eMMC.
>
> We remove the sleep|awake bus_ops, the mmc_card_sleep|awake APIs and
> move the code into the mmc specific core instead. This also includes
> the mmc ops function, mmc_sleepawake. All releated functions have then
> become static and we have got far less code to maintain.
>
> Additionally this patch also simplifies the code from mmc_sleepawake,
> since it is only used to put the card to sleep and not awake.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for doing this!  Merged to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
