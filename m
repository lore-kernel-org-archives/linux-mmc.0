From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 1/5] Documentation: synopsys-dw-mshc: add binding for
 fifo quirks
Date: Thu, 22 Dec 2016 17:04:24 -0600
Message-ID: <20161222230424.bxe4pirlfkouq4ie@rob-hp-laptop>
References: <1482382657-16681-1-git-send-email-jun.nie@linaro.org>
 <1482382657-16681-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35408 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941783AbcLVXE1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 18:04:27 -0500
Content-Disposition: inline
In-Reply-To: <1482382657-16681-2-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org

On Thu, Dec 22, 2016 at 12:57:33PM +0800, Jun Nie wrote:
> Add fifo-addr property and fifo-watermark-quirk property to
> synopsys-dw-mshc bindings. It is intended to provide more
> dt interface to support SoCs specific configuration.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Add acks when reposting.

Acked-by: Rob Herring <robh@kernel.org>

Rob
