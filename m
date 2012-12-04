From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Tue, 04 Dec 2012 13:03:07 +0900
Message-ID: <50BD75FB.7070109@samsung.com>
References: <509B6ED1.7030707@samsung.com> <87zk1uhqem.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48276 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2LDEDZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Dec 2012 23:03:25 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEH008RWN8XNHO0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Dec 2012 13:03:24 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MEH00BFQN9NS7A0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Dec 2012 13:03:23 +0900 (KST)
In-reply-to: <87zk1uhqem.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Chris,

This patch has dependency with Abhilash's patch(mmc:dw-mmc: Add sdio power binding)
That patch is modified the dw_mci_setup_bus's argument.
So it is produced the compiler error.

Do you modify the dw_mci_bus_setup(slot, false) instead of dw_mci_bus_setup(slot)?
Otherwise, i will resend the patch after modify.

Best Regards,
Jaehoon Chung


On 12/04/2012 04:44 AM, Chris Ball wrote:
> Hi,
> 
> On Thu, Nov 08 2012, Jaehoon Chung wrote:
>> To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
>> If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks, pushed to mmc-next for 3.8 with Will's ACK.
> 
> - Chris.
> 

