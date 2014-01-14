From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH -next] mmc: dw_mmc: fix sparse non static symbol warning
Date: Tue, 14 Jan 2014 02:07:11 +0000
Message-ID: <86bnzf9v00.fsf@void.printf.net>
References: <CAPgLHd8yJdkvVh6AkifxVMeudyA5bYF-QrEOzJrn1K_q8Mfm1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49488 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbaANCHZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 21:07:25 -0500
In-Reply-To: <CAPgLHd8yJdkvVh6AkifxVMeudyA5bYF-QrEOzJrn1K_q8Mfm1A@mail.gmail.com>
	(Wei Yongjun's message of "Tue, 14 Jan 2014 10:03:33 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, grant.likely@linaro.org, robh+dt@kernel.org, zhangfei.gao@linaro.org, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 14 2014, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warning:
>
> drivers/mmc/host/dw_mmc-k3.c:116:1: warning:
>  symbol 'dw_mci_k3_pmops' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
