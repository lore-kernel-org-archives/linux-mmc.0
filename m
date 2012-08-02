From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] mmc: dw_mmc: some fixes for error handling
Date: Thu, 02 Aug 2012 11:30:33 +0900
Message-ID: <5019E649.6040203@samsung.com>
References: <006201cd6f7c$c9c06730$5d413590$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51587 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2HBCam (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Aug 2012 22:30:42 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M8300HE8WAF2UA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Aug 2012 11:30:40 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M830029XWB3VZ20@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Aug 2012 11:30:40 +0900 (KST)
In-reply-to: <006201cd6f7c$c9c06730$5d413590$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

This patch-set looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 08/01/2012 09:29 AM, Seungwon Jeon wrote:
> This patch-set includes fixes for the Synopsys DesignWare MMC driver
> 
> Seungwon Jeon (3):
>       mmc: dw_mmc: amend using error interrupt status
>       mmc: dw_mmc: correct mishandling error interrupt
>       mmc: dw_mmc: fix error handling in PIO mode
> 
> drivers/mmc/host/dw_mmc.c |   44 ++++++++------------------------------------
> 1 files changed, 8 insertions(+), 36 deletions(-)
> 
> Best regards,
> Seungwon Jeon.
> --
> 1.7.2.3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


