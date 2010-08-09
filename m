From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/3 v2] dts: Add sdhci,auto-cmd12 field for p4080
 device tree
Date: Mon, 9 Aug 2010 21:36:47 +0400
Message-ID: <20100809173647.GB7665@oksana.dev.rtsoft.ru>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
 <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49622 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0HIRgw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 13:36:52 -0400
Received: by bwz3 with SMTP id 3so1384465bwz.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Aug 2010 10:36:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Tue, Aug 03, 2010 at 11:11:11AM +0800, Roy Zang wrote:
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
>  arch/powerpc/boot/dts/p4080ds.dts                |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> index 8a00407..64bcb8b 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
> @@ -14,6 +14,8 @@ Required properties:
>      reports inverted write-protect state;
>    - sdhci,1-bit-only : (optional) specifies that a controller can
>      only handle 1-bit data transfers.
> +  - sdhci,auto-cmd12: (optional) specifies that a controller can
> +    only handle auto CMD12.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

>  Example:
>  
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index 6b29eab..efa0091 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -280,6 +280,7 @@
>  			reg = <0x114000 0x1000>;
>  			interrupts = <48 2>;
>  			interrupt-parent = <&mpic>;
> +			sdhci,auto-cmd12;
>  		};
>  
>  		i2c@118000 {

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
