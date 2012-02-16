From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Thu, 16 Feb 2012 12:40:17 +0900
Message-ID: <000001ccec5c$b34a5040$19def0c0$%jun@samsung.com>
References: <4F3C67BA.7040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35793 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab2BPDkT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 22:40:19 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZG00IU8VJ5UGE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 16 Feb 2012 12:40:17 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZG006GYVJ51800@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Thu, 16 Feb 2012 12:40:17 +0900 (KST)
In-reply-to: <4F3C67BA.7040309@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

Jaehoon Chung <jh80.chung@samsung.com> wrote:
> When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
> Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
> But that function is in #ifdef CONFIG_MMC_DW_IDMAC.
> 
> I think that function is generic function.
> Not need the CONFIG_MMC_DW_IDMAC.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I tested it. Looks ok to me.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

