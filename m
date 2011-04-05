From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: mmc_card_keep_power cleanups
Date: Tue, 05 Apr 2011 11:25:07 -0400
Message-ID: <m3fwpw67qk.fsf@pullcord.laptop.org>
References: <1302014601-8089-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53109 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab1DEPTm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2011 11:19:42 -0400
In-Reply-To: <1302014601-8089-1-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 5 Apr 2011 17:43:20 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi Ohad,

On Tue, Apr 05 2011, Ohad Ben-Cohen wrote:
> mmc_card_is_powered_resumed is a mouthful; instead, simply use
> mmc_card_keep_power, which also better explains the purpose of
> the macro.
>
> Employ mmc_card_keep_power() where possible.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> Chris, these were already posted previously, i'm just pinging with a rebased version, thanks!

Thanks for the resend!  Have reviewed the threads, all six patches look
good, I've pushed them to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
