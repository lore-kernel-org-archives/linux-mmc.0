From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH -next] mmc: dw_mmc: fix sparse non static symbol warning
Date: Tue, 14 Jan 2014 10:09:22 +0800
Message-ID: <52D49C52.203@linaro.org>
References: <CAPgLHd8yJdkvVh6AkifxVMeudyA5bYF-QrEOzJrn1K_q8Mfm1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53921 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaANCJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 21:09:34 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so785292pab.15
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 18:09:33 -0800 (PST)
In-Reply-To: <CAPgLHd8yJdkvVh6AkifxVMeudyA5bYF-QrEOzJrn1K_q8Mfm1A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, grant.likely@linaro.org, robh+dt@kernel.org
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org



On 01/14/2014 10:03 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warning:
>
> drivers/mmc/host/dw_mmc-k3.c:116:1: warning:
>   symbol 'dw_mci_k3_pmops' was not declared. Should it be static?

Thanks for catching up, my mistake.
