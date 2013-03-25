From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: dw_mmc updates
Date: Mon, 25 Mar 2013 12:08:44 +0900
Message-ID: <000801ce2906$0fd2aa10$2f77fe30$%jun@samsung.com>
References: <000601ce262f$5adc52b0$1094f810$%jun@samsung.com>
 <87boabl5it.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35853 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab3CYDIq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Mar 2013 23:08:46 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK7002AS4Q9A2F0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 25 Mar 2013 12:08:45 +0900 (KST)
In-reply-to: <87boabl5it.fsf@octavius.laptop.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

Saturday, March 23, 2013, Chris Ball wrote:
> Hi,
> 
> On Thu, Mar 21 2013, Seungwon Jeon wrote:
> > Hi Chris,
> >
> > There are pending patches for dw_mmc a little bit.
> > Please could you pick the following patches to your tree?
> > These patches are sorted and there are currently no conflicts.
> >
> > [PATCH v3] mmc: dw_mmc: read all data in FIFO after Data transfer over
> > interrupt in pio mode
> > [PATCH] mmc: dw-mmc: return the result of mmc_add_host()
> > [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
> > [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
> > [PATCH v4] mmc: dw_mmc: Add MSHC compatible for Exynos4412
> > [PATCH] mmc: dw_mmc: move host->data_offset init earlier
> > [PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
> > [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
> 
> Thanks, I've got all of these (and more) now.
Thank you for taking care of all.

Thanks,
Seungwon Jeon
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

