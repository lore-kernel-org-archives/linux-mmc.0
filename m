From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: use slot-gpio to handle cd pin
Date: Thu, 9 Jan 2014 15:38:47 +0100
Message-ID: <201401091538.48127.arnd@arndb.de>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54198 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaAIOjI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 09:39:08 -0500
In-Reply-To: <1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

On Thursday 09 January 2014, Zhangfei Gao wrote:
> Suggested by Jaehoon: Use slot-gpio to handle cd-gpio
> Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
> mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   48 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 13 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
