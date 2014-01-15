From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 15:31:45 +0800
Message-ID: <52D63961.1030808@linaro.org>
References: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com> <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63266 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaAOHb7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 02:31:59 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so756839pdj.25
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 23:31:58 -0800 (PST)
In-Reply-To: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Kevin Hilman <khilman@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Kevin

Would you mind check whehter this patch solve the issue of "The Samsung 
Arndale board started failing boot from MMC".

I am sorry about that.

On 01/15/2014 03:15 PM, Zhangfei Gao wrote:
> Introdeced from commit b7db86adfa58b
commit should be bf626e5550f24aec24975a0e85ad8e572ca76a6b, from mmc-next

> CDETECT is ingored since IS_ERR_VALUE(!mmc_gpio_get_cd(mmc)) does not work
> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> ---
>   drivers/mmc/host/dw_mmc.c |    9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

