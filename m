From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Thu, 9 Jan 2014 15:45:16 +0100
Message-ID: <201401091545.16671.arnd@arndb.de>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaAIOpi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 09:45:38 -0500
In-Reply-To: <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>

On Thursday 09 January 2014, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>

This looks basically, sorry for taking so long for the review.
I thought there were a couple of tricky bugs in there, but
discussing them on IRC showed that I was wrong about all of them.

Acked-by: Arnd Bergmann <arnd@arndb.de>
