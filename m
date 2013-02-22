From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Feb 2013 20:16:53 +0900
Message-ID: <001101ce10ee$1df30610$59d91230$%jun@samsung.com>
References: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43062 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3BVLQy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Feb 2013 06:16:54 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIM00IEFCNWOVG0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 20:16:53 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIM00HBUCO56O10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 20:16:53 +0900 (KST)
In-reply-to: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Hyeonsu Kim' <hyeonsu.kim@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com

On Friday, February 22, 2013, Hyeonsu Kim wrote:
> In the legacy code, driver clear not only UHS_REG 16 bit also 0-15bit.
> If we use UHS-1 mode spec card like SDR50, SDR104. UHS_REG 0-15 should be set by
> 1 according to slot id. In this case, legacy code can make problem.
> 
> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

