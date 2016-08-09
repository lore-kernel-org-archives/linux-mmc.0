From: Amitkumar Karwar <akarwar@marvell.com>
Subject: RE: [PATCH v4 1/2] mmc: API for accessing host supported maximum
 segment count and size
Date: Tue, 9 Aug 2016 10:16:24 +0000
Message-ID: <ee910d6f6d1f4d218586bddd5a7627b0@SC-EXCH04.marvell.com>
References: <1466069006-10757-1-git-send-email-akarwar@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34627 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752019AbcHIKQf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Aug 2016 06:16:35 -0400
In-Reply-To: <1466069006-10757-1-git-send-email-akarwar@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishant Sarmukadam <nishants@marvell.com>, Wei-Ning Huang <wnhuang@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Cathy Luo <cluo@marvell.com>, Xinming Hu <huxm@marvell.com>

Hi Ulf,

> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
> Sent: Thursday, June 16, 2016 2:53 PM
> To: linux-wireless@vger.kernel.org
> Cc: Nishant Sarmukadam; Wei-Ning Huang; linux-mmc@vger.kernel.org; Cathy
> Luo; Xinming Hu; Amitkumar Karwar
> Subject: [PATCH v4 1/2] mmc: API for accessing host supported maximum
> segment count and size
> 
> From: Xinming Hu <huxm@marvell.com>
> 
> sdio device drivers need be able to get the host supported max_segs and
> max_seg_size, so that they know the buffer size to allocate while
> utilizing the scatter/gather DMA buffer list.
> 
> This patch provides API for this purpose.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: v2 was submitted with minor improvement like replacing BUG_ON() with
> WARN_ON()
> v3: Addressed below review comments from Ulf Hansson
>     a) In v3, patch has been split into two separate patches.
>     b) Patch 1/2 introduces an API to fetch max_seg_size and max_segs
>     c) Replaced WARN_ON() with proper error code when sg_ptr->length is
> invalid
>     d) Instead of duplicating the code in mmc_io_rw_extended(), extra
> bool parameter
>        has been added to this function and used it in new APIs for SG.
> v4: Removed WARN_ON() calls in newly added APIs. It's gets called in
> probe handler.
>     Caller already takes care of it(Shawn Lin).
> ---
>  drivers/mmc/core/sdio_io.c                          | 21
> +++++++++++++++++++++
>  .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |  6 +++---
>  include/linux/mmc/sdio_func.h                       |  3 +++
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 

Please let me know if you have any further review comments for this patch series.

Regards,
Amitkumar
