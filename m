From: Chris Ball <cjb@laptop.org>
Subject: Re: [RESEND PATCH] mmc: core: Re-use code for MMC_CAP2_DETECT_ON_ERR in polling mode
Date: Sun, 26 May 2013 13:19:18 -0400
Message-ID: <87txlpr755.fsf@octavius.laptop.org>
References: <1366275727-6380-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47473 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424Ab3EZRTV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:19:21 -0400
In-Reply-To: <1366275727-6380-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 18 Apr 2013 11:02:07 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On Thu, Apr 18 2013, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Previously the MMC_CAP2_DETECT_ON_ERR was invented for detecting
> slow card removal. In was never a realy good solution and a proper
> fix has been merged using gpio debouncing instead. We remove this
> cap in this patch.
>
> Although when using polling card detect mode, the code invented for
> MMC_CAP2_DETECT_ON_ERR is re-used to complete card removal in an
> earlier phase. There are no need waiting for the polling timeout to
> elapse in this case.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Liu <kliu5@marvell.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
