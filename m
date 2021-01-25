Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE3DC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 07:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967DD22CA2
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 07:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbhAYHpS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:45:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:46190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbhAYHoo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 02:44:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CCFBAE66;
        Mon, 25 Jan 2021 07:24:56 +0000 (UTC)
Subject: Re: [PATCH] mmc: queue: Exclude unnecessary header file
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, baolin.wang@linaro.org, arnd@arndb.de,
        lee.jones@linaro.org, sartgarg@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
References: <CGME20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb@epcas1p3.samsung.com>
 <20210125064355.28545-1-cw9316.lee@samsung.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <3561e90d-97e3-03ad-6395-7e5ce726d496@suse.de>
Date:   Mon, 25 Jan 2021 15:24:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125064355.28545-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/25/21 2:43 PM, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> From the 4.19 kernel, thread related code has been removed in queue.c.
> So we can exclude unnecessary header file.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/mmc/core/queue.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c30..c7218da6f17c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -7,7 +7,6 @@
>  #include <linux/module.h>
>  #include <linux/blkdev.h>
>  #include <linux/freezer.h>
> -#include <linux/kthread.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/backing-dev.h>
> 

