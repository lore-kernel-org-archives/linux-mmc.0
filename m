From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
Date: Thu, 9 Jan 2014 15:38:07 +0100
Message-ID: <201401091538.07496.arnd@arndb.de>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-4-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58272 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaAIOij (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 09:38:39 -0500
In-Reply-To: <1389278112-7099-4-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

On Thursday 09 January 2014, Zhangfei Gao wrote:
> Suggest by Arnd: abstract mmc tuning as clock behavior,
> also because different soc have different tuning method and registers.
> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
