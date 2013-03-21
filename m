From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: dw_mmc updates
Date: Thu, 21 Mar 2013 21:26:46 +0900
Message-ID: <000601ce262f$5adc52b0$1094f810$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34981 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab3CUM0t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Mar 2013 08:26:49 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK0006B8FWNI450@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 21 Mar 2013 21:26:47 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi Chris,

There are pending patches for dw_mmc a little bit.
Please could you pick the following patches to your tree?
These patches are sorted and there are currently no conflicts.

[PATCH v3] mmc: dw_mmc: read all data in FIFO after Data transfer over interrupt in pio mode
[PATCH] mmc: dw-mmc: return the result of mmc_add_host()
[PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
[PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
[PATCH v4] mmc: dw_mmc: Add MSHC compatible for Exynos4412
[PATCH] mmc: dw_mmc: move host->data_offset init earlier
[PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
[PATCH 1/3] dw_mmc: Don't loop when handling an interrupt

Thanks,
Seungwon Jeon

