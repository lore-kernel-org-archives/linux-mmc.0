From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: clear IDSTS register when initialize IDMAC
Date: Mon, 29 Apr 2013 13:59:13 +0900
Message-ID: <517DFE21.5030106@samsung.com>
References: <1366958122-14869-1-git-send-email-jy0922.shim@samsung.com>
 <001101ce4251$06a47b30$13ed7190$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14394 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3D2E7E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Apr 2013 00:59:04 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MM00096A3689LH0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 29 Apr 2013 13:58:56 +0900 (KST)
In-reply-to: <001101ce4251$06a47b30$13ed7190$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Joonyoung Shim' <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, jh80.chung@samsung.com, cjb@laptop.org, will.newton@gmail.com

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

On 04/26/2013 04:38 PM, Seungwon Jeon wrote:
> On Friday, April 26, 2013, Joonyoung Shim wrote:
>> If pending interrupt for IDMAC exists when initialize IDMAC, it will
>> call interrupt handler unnecessarily.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>> Changes from previous patch v1:
>> - Change subject and contents of commit
>> - Define IDMAC_INT_CLR macro to clear IDSTS register
>> - It moved to clear IDSTS register in dw_mci_idmac_init()
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com> 
> 
> Thanks,
> Seungwon Jeon
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

