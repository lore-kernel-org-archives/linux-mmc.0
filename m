From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 3/3 v2] dts: Add ESDHC weird voltage bits workaround
Date: Mon, 9 Aug 2010 21:33:20 +0400
Message-ID: <20100809173320.GA7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
 <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
 <1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65280 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab0HIRdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 13:33:25 -0400
Received: by bwz3 with SMTP id 3so1382449bwz.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Aug 2010 10:33:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Tue, Aug 03, 2010 at 11:11:12AM +0800, Roy Zang wrote:
> P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
> host controller capabilities register wrongly set the bits.
> This patch adds the workaround to correct the weird voltage setting bits.
> Only 3.3V voltage is supported for P4080 ESDHC controller.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Btw, where is implementation for the voltage-ranges handling?

> ---
>  arch/powerpc/boot/dts/p4080ds.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index efa0091..2f0de24 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -280,6 +280,7 @@
>  			reg = <0x114000 0x1000>;
>  			interrupts = <48 2>;
>  			interrupt-parent = <&mpic>;
> +			voltage-ranges = <3300 3300>;
>  			sdhci,auto-cmd12;
>  		};
>  
> -- 
> 1.5.6.5
