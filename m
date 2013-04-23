From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH -next] mmc: dw_mmc: fix error return code in dw_mci_probe()
Date: Tue, 23 Apr 2013 18:59:21 +0900
Message-ID: <002301ce4009$3a3099b0$ae91cd10$%jun@samsung.com>
References: <CAPgLHd9RGHwoitQ0EusPepKK+AApKJ=ryRbm4S32o_vOonUgeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19380 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab3DWJ7X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Apr 2013 05:59:23 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLP00N90D2X4NY0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Apr 2013 18:59:22 +0900 (KST)
In-reply-to: <CAPgLHd9RGHwoitQ0EusPepKK+AApKJ=ryRbm4S32o_vOonUgeQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Wei Yongjun' <weiyj.lk@gmail.com>, jh80.chung@samsung.com, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Friday, April 19, 2013 , Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -ENOMEM in alloc workqueue error case instead
> of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

