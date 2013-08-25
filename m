From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: include 'dw_mmc-pltfm.h'
Date: Sat, 24 Aug 2013 23:41:27 -0400
Message-ID: <87sixyqvx4.fsf@octavius.laptop.org>
References: <000e01ce9247$d6063f30$8212bd90$@samsung.com>
	<001601ce9504$c4da6d20$4e8f4760$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40345 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab3HYDld (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:41:33 -0400
In-Reply-To: <001601ce9504$c4da6d20$4e8f4760$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 09 Aug 2013 22:31:35 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jingoo Han' <jg1.han@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Dinh Nguyen' <dinguyen@altera.com>

Hi Seungwon,

On Fri, Aug 09 2013, Seungwon Jeon wrote:
> On Tue, August 06, 2013,Jingoo Han wrote:
>> Include 'dw_mmc-pltfm.h' header file in order to fix
>> the following sparse warnings:
>> 
>> drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol
>> dw_mci_pltfm_register' was not declared. Should
>> it be static?
>> drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol
>> dw_mci_pltfm_pmops' was not declared. Should it
>> be static?
>> drivers/mmc/host/dw_mmc-pltfm.c:118:5: warning: symbol
>> dw_mci_pltfm_remove' was not declared. Should
>> it be static?
>> 
>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
