From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Thu, 17 May 2012 09:41:21 -0400
Message-ID: <87396y53i6.fsf@laptop.org>
References: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
	<1337252542-25795-2-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49688 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab2EQNlY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 May 2012 09:41:24 -0400
In-Reply-To: <1337252542-25795-2-git-send-email-saugata.das@stericsson.com>
	(Saugata Das's message of "Thu, 17 May 2012 16:32:22 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, saugata.das@linaro.org, subhashj@codeaurora.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com, linkinjeon@gmail.com

Hi,

On Thu, May 17 2012, Saugata Das wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> In this patch, we add utility to disable emulation mode in the eMMC-4.5.
> This is done to increase the data sector size to 4KB.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>
> changes in v2:
> 	Removed extra blank lines around do_disable_512B_emulation
> 	Review rework based on comments from Subhash
> ---

Pushed to mmc-utils, thanks!

(Please put your patch changelogs below the "---", so that they don't
end up in the commit message.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
