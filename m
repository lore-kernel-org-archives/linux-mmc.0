From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc-pltfm: include 'dw_mmc-pltfm.h'
Date: Fri, 09 Aug 2013 22:31:35 +0900
Message-ID: <001601ce9504$c4da6d20$4e8f4760$%jun@samsung.com>
References: <000e01ce9247$d6063f30$8212bd90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:62112 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966148Ab3HINbh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 09:31:37 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR9004R2MWNK1O0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Aug 2013 22:31:35 +0900 (KST)
In-reply-to: <000e01ce9247$d6063f30$8212bd90$@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Dinh Nguyen' <dinguyen@altera.com>

On Tue, August 06, 2013,Jingoo Han wrote:
> Include 'dw_mmc-pltfm.h' header file in order to fix
> the following sparse warnings:
> 
> drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol 'dw_mci_pltfm_register' was not declared. Should
> it be static?
> drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol 'dw_mci_pltfm_pmops' was not declared. Should it
> be static?
> drivers/mmc/host/dw_mmc-pltfm.c:118:5: warning: symbol 'dw_mci_pltfm_remove' was not declared. Should
> it be static?
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

