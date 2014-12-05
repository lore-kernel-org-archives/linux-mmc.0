From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Let mmc_send_tuning() to take struct mmc_host*
 as parameter
Date: Fri, 05 Dec 2014 10:10:00 -0800
Message-ID: <5481F4F8.8000008@codeaurora.org>
References: <1417776083-13499-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:46064 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaLESKC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 13:10:02 -0500
In-Reply-To: <1417776083-13499-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 12/05/2014 02:41 AM, Ulf Hansson wrote:
> To be able to use mmc_send_tuning() prior the struct mmc_card has been
> allocated, let's convert it to take the struct mmc_host* as parameter
> instead.
>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

