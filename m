From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 10:29:40 -0800
Message-ID: <87y52fok4r.fsf@linaro.org>
References: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
	<1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43113 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbaAPS3p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 13:29:45 -0500
Received: by mail-pb0-f51.google.com with SMTP id rp16so2996867pbb.24
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 10:29:43 -0800 (PST)
In-Reply-To: <1389876527-13498-1-git-send-email-zhangfei.gao@linaro.org>
	(Zhangfei Gao's message of "Thu, 16 Jan 2014 20:48:47 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Zhangfei Gao <zhangfei.gao@linaro.org> writes:

> Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
> CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
> can not be checked by IS_ERR_VALUE.
> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
> otherwise sd detect may occasionally fail.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>

I didn't look at the patch in detail, but can at least confirm that
Arndale boots again in -next with this patch applied.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
