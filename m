From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: Move the mmc tree to kernel.org
Date: Tue, 18 Oct 2016 11:19:44 +0800
Message-ID: <e4cfb009-07a3-972c-d93c-d777c5da3899@rock-chips.com>
References: <1476708880-5333-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:41924 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754832AbcJRDUI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 23:20:08 -0400
In-Reply-To: <1476708880-5333-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Ulf,

On 2016/10/17 20:54, Ulf Hansson wrote:
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a009e00..e685724 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8164,7 +8164,7 @@ F:	include/linux/mfd/
>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
>  M:	Ulf Hansson <ulf.hansson@linaro.org>
>  L:	linux-mmc@vger.kernel.org
> -T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

I cannot clone this tree, and I have tried some of my servers, although.

remote: Total 5031043 (delta 4225582), reused 5030965 (delta 4225531)
Resolving deltas: 100% (4225582/4225582), done.
Checking connectivity... done.
warning: remote HEAD refers to nonexistent ref, unable to checkout.

...then the clone process failed.

>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mmc/
>  F:	drivers/mmc/
>


-- 
Best Regards
Shawn Lin

