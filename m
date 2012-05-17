From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 09:38:03 -0400
Message-ID: <877gwb3p38.fsf@laptop.org>
References: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49670 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab2EQNiM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 May 2012 09:38:12 -0400
In-Reply-To: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
	(Saugata Das's message of "Thu, 17 May 2012 16:32:21 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, saugata.das@linaro.org, subhashj@codeaurora.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com, linkinjeon@gmail.com

Hi,

On Thu, May 17 2012, Saugata Das wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> This patch adds the support for large sector size of 4KB by disabling emulation.
> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
> mmc_blk_alloc_req.
>
> In order to use this patch for 4KB sector size, ensure that USE_NATIVE_SECTOR
> is enabled, partition table is 4KB sector size aligned and file system block
> and sector size are 4KB multiples.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
