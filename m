From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH Resend 2/2] mmc: dw_mmc: Use pr_info instead of printk
Date: Thu, 04 Apr 2013 14:50:28 +0900
Message-ID: <004501ce30f8$4f974760$eec5d620$%jun@samsung.com>
References: <1364451321-4383-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13347 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab3DDFu3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 01:50:29 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKP008GHUVH0SL0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 04 Apr 2013 14:50:28 +0900 (KST)
In-reply-to: <1364451321-4383-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, cjb@laptop.org, patches@linaro.org

On Thursday, March 28, 2013, Sachin Kamat wrote:
> pr_info(... is preferred to printk(KERN_INFO ...
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

