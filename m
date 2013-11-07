From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: mmc: dw_mmc: rework the code related to cmd/data completion
Date: Thu, 07 Nov 2013 12:54:39 +0900
Message-ID: <001e01cedb6d$1559fbe0$400df3a0$%jun@samsung.com>
References: <20131106161635.GJ15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37748 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3KGDyv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 22:54:51 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVV00EH1K73IUG0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Nov 2013 12:54:43 +0900 (KST)
In-reply-to: <20131106161635.GJ15603@elgon.mountain>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org

Hi Dan Carpenter,

On Thur, November 07, 2013, Dan Carpenter wrote:
> Hello Seungwon Jeon,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch e352c8131100: "mmc: dw_mmc: rework the code related to
> cmd/data completion" from Aug 31, 2013, leads to the following Smatch
> complaint:
> 
> drivers/mmc/host/dw_mmc.c:1339 dw_mci_tasklet_func()
> 	 error: we previously assumed 'data->stop' could be null (see line 1337)
> 
> drivers/mmc/host/dw_mmc.c
>   1336				if (!err) {
>   1337					if (!data->stop || mrq->sbc) {
>                                              ^^^^^^^^^^
> New check.
> 
>   1338						if (mrq->sbc)
>   1339							data->stop->error = 0;
>                                                         ^^^^^^^^^^
> New unchecked dereference.  Should the check be "if (data->stop)"
> instead of "if (mrq->sbc)"?
It assumes that Upper layer sets all together. Actually, it does.
If 'mrq->sbc' is valid, it means that 'data->stop' must be also valid.
But if '&& data->stop' condition is added , it would be certain.
Ok. Thank you for report.

Thanks,
Seungwon Jeon.

