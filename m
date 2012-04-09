From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/2] mmc: fixes for eMMC v4.5 discard / sanitize operations
Date: Mon, 09 Apr 2012 14:08:43 +0900
Message-ID: <4F826EDB.3000007@samsung.com>
References: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40632 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2DIFIq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 01:08:46 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M2700I034YG8AL0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Apr 2012 14:08:45 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M2700FUQ4YKYJ10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Apr 2012 14:08:45 +0900 (KST)
In-reply-to: <1333626348-11170-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Adrian.

This patch is make sense.
It looks fine to me. 
I tested with eMMC4.5 and triggered the secdiscard/discard with ioctl.
(But i didn't have the iNAND.)

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 04/05/2012 08:45 PM, Adrian Hunter wrote:

> Hi
> 
> Here are patches in response to the thread
> "mmc: card: move variable initialization earlier"
> 
> The patches have not been tested on eMMC v4.5
> because I do not have one.  Consequently, these
> patches need an ack or tested-by someone who has
> one that supports discard and sanitize.
> 
> 
> Adrian Hunter (2):
>       mmc: fixes for eMMC v4.5 discard operation
>       mmc: fixes for eMMC v4.5 sanitize operation
> 
>  drivers/mmc/card/block.c |   54 ++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/card/queue.c |    2 +-
>  drivers/mmc/core/core.c  |    9 +++++--
>  3 files changed, 45 insertions(+), 20 deletions(-)
> 
> 
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


