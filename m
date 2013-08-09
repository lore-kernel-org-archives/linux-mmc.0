From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe()
Date: Fri, 09 Aug 2013 22:31:26 +0900
Message-ID: <001501ce9504$bf6099f0$3e21cdd0$%jun@samsung.com>
References: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22535 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967658Ab3HINb2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 09:31:28 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR900GCRMWEPBK0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Aug 2013 22:31:26 +0900 (KST)
In-reply-to: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Dinh Nguyen' <dinguyen@altera.com>

On Thu, August 01, 2013, Jingoo Han wrote:
> dw_mci_socfpga_probe() is used only in this file.
> Fix the following sparse warning:
> 
> drivers/mmc/host/dw_mmc-socfpga.c:116:5: warning: symbol 'dw_mci_socfpga_probe' was not declared.
> Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

