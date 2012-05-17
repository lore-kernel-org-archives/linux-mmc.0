From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2 1/2] [MMC-4.5] Disable emulation
Date: Thu, 17 May 2012 20:09:39 +0900
Message-ID: <CAKYAXd93md=jfgHPf_9u20QEnJTN5avF9MAhgfGtyuaywik_EA@mail.gmail.com>
References: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46936 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab2EQLJk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 07:09:40 -0400
Received: by weyu7 with SMTP id u7so1069810wey.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 May 2012 04:09:39 -0700 (PDT)
In-Reply-To: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, saugata.das@linaro.org, subhashj@codeaurora.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com

2012/5/17, Saugata Das <saugata.das@stericsson.com>:
> From: Saugata Das <saugata.das@linaro.org>
>
> This patch adds the support for large sector size of 4KB by disabling
> emulation.
> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
> mmc_blk_alloc_req.
>
> In order to use this patch for 4KB sector size, ensure that
> USE_NATIVE_SECTOR
> is enabled, partition table is 4KB sector size aligned and file system
> block
> and sector size are 4KB multiples.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
Looks good.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Thanks.
