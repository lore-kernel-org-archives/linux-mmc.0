From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/4] mmc: core: Clean-up and improve polling code in
 __mmc_switch()
Date: Fri, 21 Oct 2016 16:49:13 +0900
Message-ID: <1ba11108-0804-950d-5410-646b53c798e8@samsung.com>
References: <CGME20161020082027epcas1p47e0913622727117286f7ad026259eb2b@epcas1p4.samsung.com>
 <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53786 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbcJUHtQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 03:49:16 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OFE00JOT0E1OR30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 21 Oct 2016 16:49:13 +0900 (KST)
In-reply-to: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

On 10/20/2016 05:19 PM, Ulf Hansson wrote:
> The code in __mmc_switch() is rather messy and hard to follow/understand. This
> series starts out by cleaning-up and re-factoring that code. In the final patch
> I intend to improve the behaviour regarding the polling method, which is being
> used to know when the card stops signal busy.

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

(Tested on Exynos Series)

Best Regards,
Jaehoon Chung

> 
> Ulf Hansson (4):
>   mmc: core: Make mmc_switch_status() available for mmc core
>   mmc: core: Clarify code which deals with polling in __mmc_switch()
>   mmc: core: Factor out code related to polling in __mmc_switch()
>   mmc: core: Don't use ->card_busy() and CMD13 in combination when
>     polling
> 
>  drivers/mmc/core/mmc.c     |  13 -----
>  drivers/mmc/core/mmc_ops.c | 138 +++++++++++++++++++++++++--------------------
>  drivers/mmc/core/mmc_ops.h |   2 +-
>  3 files changed, 79 insertions(+), 74 deletions(-)
> 

