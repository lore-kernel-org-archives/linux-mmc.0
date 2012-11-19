From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 4/4] mmc: dw-mmc: remove complier warning
Date: Mon, 19 Nov 2012 12:53:36 +0000
Message-ID: <50AA2BD0.90200@imgtec.com>
References: <509B6ED5.6070101@samsung.com> <50AA24B1.8050303@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56833 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab2KSMyI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Nov 2012 07:54:08 -0500
In-Reply-To: <50AA24B1.8050303@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On 19/11/12 12:23, James Hogan wrote:
> On 08/11/12 08:35, Jaehoon Chung wrote:
>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_prepare_command':
>> drivers/mmc/host/dw_mmc.c:256:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_set_ios':
>> drivers/mmc/host/dw_mmc.c:805:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_init_slot':
>> drivers/mmc/host/dw_mmc.c:1849:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_parse_dt':
>> drivers/mmc/host/dw_mmc.c:2049:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>> drivers/mmc/host/dw_mmc.c: In function 'dw_mci_probe':
>> drivers/mmc/host/dw_mmc.c:2095:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Acked-by: James Hogan <james.hogan@imgtec.com>

Chris: Is it okay to get this patch into v3.7?

Thanks
James

