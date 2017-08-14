From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v10 1/2] mmc: dw_mmc: move controller reset before driver
 init
Date: Mon, 14 Aug 2017 09:18:36 +0800
Message-ID: <e1297f68-112e-1a93-d769-ad06b04714cd@rock-chips.com>
References: <20170811080624.42173-1-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:38039 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdHNBSj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Aug 2017 21:18:39 -0400
In-Reply-To: <20170811080624.42173-1-liwei213@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Li Wei <liwei213@huawei.com>, ulf.hansson@linaro.org, jh80.chung@samsung.com, hkallweit1@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawn.lin@rock-chips.com, guodong.xu@linaro.org

Trim cc

On 2017/8/11 16:06, Li Wei wrote:
> This commit modifies dw_mci_probe(), it moves reset assertion before
> drv_data->init(host)
> 
> Some driver needs to access controller registers in its .init() ops. So,
> in order to make such access safe, we should do controller reset before
> .init() being called.
> 

LGTM

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>
> ---

