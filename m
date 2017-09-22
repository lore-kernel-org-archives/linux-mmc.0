From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/4] use setup_timer() helper function.
Date: Fri, 22 Sep 2017 21:34:06 +0800
Message-ID: <06107213-d41b-e66b-060d-9a1b16a19fb1@rock-chips.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:32919 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdIVNeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 09:34:36 -0400
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Allen Pais <allen.lkml@gmail.com>
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org

On 2017/9/22 20:07, Allen Pais wrote:
> This series uses setup_timer() helper function. The series
> addresses the files under drivers/mmc/host/*.
>

Better to provide some solid info if that is done by some static tools
like coccinelle?

But looks like a nice cleanup,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


>
> Allen Pais (4):
>   mmc-host: wbsd: use setup_timer() helper.
>   mmc-host: via: use setup_timer() helper.
>   mmc-host: vub300: use setup_timer() helper.
>   mmc-host: mxcmmc: use setup_timer() helper.
>
>  drivers/mmc/host/mxcmmc.c    |  4 +---
>  drivers/mmc/host/via-sdmmc.c |  4 +---
>  drivers/mmc/host/vub300.c    | 10 ++++------
>  drivers/mmc/host/wbsd.c      |  5 ++---
>  4 files changed, 8 insertions(+), 15 deletions(-)
>


-- 
Best Regards
Shawn Lin

