From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Wed, 13 Mar 2013 13:20:59 +0900
Message-ID: <513FFEAB.3090801@samsung.com>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
 <8738w0ixc8.fsf@octavius.laptop.org>
 <CAK9yfHwT5scTmgRF7dwGf2syyHj=N4ipMfFgcOs=W6Rd1eUU+g@mail.gmail.com>
 <87r4jkhde7.fsf@octavius.laptop.org>
 <CAK9yfHwPYE-3Jgg7kz0eex9avMdWAgnAXAPeFzpuUNU7wpC-Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25315 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3CMEUy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 00:20:54 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJL006W902QR830@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 13:20:52 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MJL00GIR02S8181@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Mar 2013 13:20:52 +0900 (KST)
In-reply-to: <CAK9yfHwPYE-3Jgg7kz0eex9avMdWAgnAXAPeFzpuUNU7wpC-Yg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi All,

this patch has already got acked-by of Seungwon and me.

Best Regards,
Jaehoon Chung

On 03/13/2013 12:04 AM, Sachin Kamat wrote:
> On 12 March 2013 20:30, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Tue, Mar 12 2013, Sachin Kamat wrote:
>>> There is also another patch in this series [1] that needs your attention.
>>> [1] https://patchwork.kernel.org/patch/2156621/
>>
>> I'd rather have one of the dw_mmc maintainers handle ACKing patches
>> before I apply them.  If they haven't reviewed it by the time we're
>> getting ready to merge for 3.10, I can overrule them and apply it.
> 
> Thanks Chris.
> 
> Seungwon, Jaehoon,
> Can you please review this patch?
> https://patchwork.kernel.org/patch/2156621/
> 
> 

