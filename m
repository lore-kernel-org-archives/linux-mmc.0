From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: Fix select power class after resume
Date: Sun, 26 May 2013 13:44:12 -0400
Message-ID: <87obbxljpv.fsf@octavius.laptop.org>
References: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44859 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608Ab3EZRoS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:44:18 -0400
In-Reply-To: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
	(Fredrik Soderstedt's message of "Tue, 23 Apr 2013 16:27:07 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>

Hi Fredrik,

On Tue, Apr 23 2013, Fredrik Soderstedt wrote:
> Use the saved values in card->ext_csd when selecting power class.
> By doing this the power class will be selected even if mmc_init_card
> is called with oldcard != NULL, which is the case after a suspend/resume.
>
> Today ext_csd is NULL if mmc_init_card is called with oldcard != NULL
> and power class will not be selected.
>
> According to the eMMC specification the POWER_CLASS value is reset after
> power failure, H/W reset assertion and any CMD0 reset.
>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
