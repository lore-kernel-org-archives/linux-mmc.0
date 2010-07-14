From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 4/5] drivers/mmc/host/msm-sdcc: Remove dead config options
Date: Wed, 14 Jul 2010 08:39:36 -0700
Message-ID: <201007140839.37494.davidb@codeaurora.org>
References: <c3c850bed3f5714f1efcfad24ad4f8bfcb6b5b54.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de> <459cdebccb9bfaa88194b47608e7e739339aae55.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:50459 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab0GNPjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 11:39:55 -0400
In-Reply-To: <459cdebccb9bfaa88194b47608e7e739339aae55.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Cc: Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, San Mehat <san@google.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@i4.informatik.uni-erlangen.de

On Wednesday 14 July 2010 07:04:53 Christian Dietrich wrote:

> CONFIG_MMC_MSM7X00A_RESUME_IN_WQ and CONFIG_MMC_EMBEDDED_SDIO don't
> exist in Kconfig and is never defined anywhere else, therefore removing
> all references for it from the source code.
> 
> Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
> ---
>  drivers/mmc/host/msm_sdcc.c |   25 -------------------------
>  drivers/mmc/host/msm_sdcc.h |    4 ----
>  2 files changed, 0 insertions(+), 29 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

We'll put appropriate versions of this code back in when we get the
rest of the functionality in the kernel.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
