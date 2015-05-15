From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/3] dw_mmc-k3 support hi6220
Date: Fri, 15 May 2015 18:41:47 +0900
Message-ID: <5555BF5B.9070604@samsung.com>
References: <1431593119-31889-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52204 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbEOJmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 05:42:08 -0400
In-reply-to: <1431593119-31889-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Hi, Zhangfei.

I will apply this patchset at my dw-mmc tree.
Thanks!

Best Regards,
Jaehoon Chung

On 05/14/2015 05:45 PM, Zhangfei Gao wrote:
> v3:
> Suggested by Jaehoon
> Add comments about register AO_SCTRL_CTRL3 and remove one unused vector
> 
> v2: 
> fix comments from Jaehoon
> fix some issues in sdr12 & sdr25 mode
> 
> Zhangfei Gao (3):
>   Document: dw_mmc-k3: add document of hi6220 mmc
>   mmc: dw_mmc: add switch_voltage
>   mmc: dw_mmc: k3: support hi6220
> 
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  28 ++++++
>  drivers/mmc/host/dw_mmc-k3.c                       | 103 ++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.c                          |   4 +
>  drivers/mmc/host/dw_mmc.h                          |   2 +
>  4 files changed, 135 insertions(+), 2 deletions(-)
> 

