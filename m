From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for SOCFPGA
Date: Fri, 09 Aug 2013 22:31:07 +0900
Message-ID: <001401ce9504$b4554ce0$1cffe6a0$%jun@samsung.com>
References: <002601ce8e4e$027246c0$0756d440$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23465 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966148Ab3HINbK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 09:31:10 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR900116MVUB3M0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Aug 2013 22:31:08 +0900 (KST)
In-reply-to: <002601ce8e4e$027246c0$0756d440$@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Dinh Nguyen' <dinguyen@altera.com>

On Thu, August 01, 2013, Jingoo Han wrote:
> Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
> the following link error.
> 
> drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to `syscon_regmap_lookup_by_compatible'
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

