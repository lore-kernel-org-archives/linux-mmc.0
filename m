From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: dw_mmc: clear IDSTS register when initialize IDMAC
Date: Fri, 26 Apr 2013 16:38:21 +0900
Message-ID: <001101ce4251$06a47b30$13ed7190$%jun@samsung.com>
References: <1366958122-14869-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49120 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3DZHiW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Apr 2013 03:38:22 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLU00HTAQJ4BS10@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 26 Apr 2013 16:38:21 +0900 (KST)
In-reply-to: <1366958122-14869-1-git-send-email-jy0922.shim@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, cjb@laptop.org, will.newton@gmail.com

On Friday, April 26, 2013, Joonyoung Shim wrote:
> If pending interrupt for IDMAC exists when initialize IDMAC, it will
> call interrupt handler unnecessarily.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
> Changes from previous patch v1:
> - Change subject and contents of commit
> - Define IDMAC_INT_CLR macro to clear IDSTS register
> - It moved to clear IDSTS register in dw_mci_idmac_init()

Acked-by: Seungwon Jeon <tgih.jun@samsung.com> 

Thanks,
Seungwon Jeon

