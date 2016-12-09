From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/5] Documentation: synopsys-dw-mshc: add binding for
 fifo quirks
Date: Fri, 9 Dec 2016 15:51:23 -0600
Message-ID: <20161209215123.yooghvhrjsbkajkn@rob-hp-laptop>
References: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
 <1480904976-7081-4-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33488 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcLIVv1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 16:51:27 -0500
Content-Disposition: inline
In-Reply-To: <1480904976-7081-4-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org

On Mon, Dec 05, 2016 at 10:29:34AM +0800, Jun Nie wrote:
> Add fifo-addr property and fifo-watermark-quirk property to
> synopsys-dw-mshc bindings. It is intended to provide more
> dt interface to support SoCs specific configuration.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

This patch should come before patch 1 since you use these there.

Acked-by: Rob Herring <robh@kernel.org>
