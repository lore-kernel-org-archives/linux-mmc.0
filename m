From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of
 of_match_ptr()
Date: Wed, 13 Mar 2013 23:17:43 +0900
Message-ID: <002201ce1ff5$874c82b0$95e58810$%jun@samsung.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
 <1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26144 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449Ab3CMORp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 10:17:45 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJL00K0QRPJRRO0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 23:17:44 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJL003IMRPJBO40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 23:17:43 +0900 (KST)
In-reply-to: <1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, jh80.chung@samsung.com, patches@linaro.org

On Monday, February 18, 2013, Sachin Kamat wrote:
> 'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
> is not required.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

