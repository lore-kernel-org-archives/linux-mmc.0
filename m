From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 20 Dec 2013 10:31:07 +0800
Message-ID: <52B3ABEB.2010502@linaro.org>
References: <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org> <1387199536-7053-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37950 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab3LTCbQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 21:31:16 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so1902620pdj.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 18:31:16 -0800 (PST)
In-Reply-To: <1387199536-7053-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>



On 12/16/2013 09:12 PM, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>   .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 +++++++++
>   drivers/mmc/host/Kconfig                           |   10 ++
>   drivers/mmc/host/Makefile                          |    1 +
>   drivers/mmc/host/dw_mmc-k3.c                       |  134 ++++++++++++++++++++
>   4 files changed, 205 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>   create mode 100644 drivers/mmc/host/dw_mmc-k3.c
>

Any comments?

Thanks
