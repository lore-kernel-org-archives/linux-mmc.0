From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix PowerOff Notify suspend/resume
Date: Sat, 04 Feb 2012 21:03:52 -0500
Message-ID: <m239aq829j.fsf@bob.laptop.org>
References: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46329 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab2BECD7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:03:59 -0500
In-Reply-To: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Tue, 31 Jan 2012 15:44:03 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, saugata.das@linaro.org

Hi,

On Tue, Jan 31 2012, Girish K S wrote:
> Modified the mmc_poweroff to resume before sending the
> poweroff notification command. In sleep mode only AWAKE
> and RESET commands are allowed, so before sending the
> poweroff notification command resume from sleep mode and
> then send the notification command.
>
> POwerOff Notify is tested on a Synopsis Designware Host
> Controller(eMMC 4.5). The suspend to RAM and resume works fine.
>
> This patch is successfully applied on the Chris's mmc-next
> branch
>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> Tested-by: Girish K S <girish.shivananjappa@linaro.org>

Thanks, pushed to mmc-next for 3.3 with Saugata's Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
