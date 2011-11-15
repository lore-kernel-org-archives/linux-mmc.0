From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix power_off_notify during suspend
Date: Tue, 15 Nov 2011 08:17:29 -0500
Message-ID: <8739dpjziu.fsf@laptop.org>
References: <1321338346-10911-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36025 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab1KONRZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Nov 2011 08:17:25 -0500
In-Reply-To: <1321338346-10911-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Tue, 15 Nov 2011 11:55:46 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi,

On Tue, Nov 15 2011, Girish K S wrote:
> The eMMC 4.5 devices respond to only RESET and AWAKE command in the sleep
> state. Hence the mmc switch command to notify power off state should be sent
> before the device enters sleep state.
>
> This patch fixes the same.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
