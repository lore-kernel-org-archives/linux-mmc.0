From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [patch 084/232] powerpc/85xx: add eSDHC support for MPC8536DS
 boards
Date: Wed, 23 Sep 2009 04:32:00 +0400
Message-ID: <20090923003200.GA21228@oksana.dev.rtsoft.ru>
References: <200909222345.n8MNjHtJ013999@imap1.linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:51782 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbZIWAcA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:32:00 -0400
Received: by ewy7 with SMTP id 7so259882ewy.17
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2009 17:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200909222345.n8MNjHtJ013999@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, benh@kernel.crashing.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

On Tue, Sep 22, 2009 at 04:45:17PM -0700, akpm@linux-foundation.org wrote:
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> This patch simply adds sdhci node to the device tree.
> 
> We specify clock-frequency manually, so that eSDHC will work without
> upgrading U-Boot.  Though, that'll only work for default setup (1500 MHz)
> on new board revisions.  For non-default setups, it's recommended to
> upgrade U-Boot, since it will fixup clock-frequency automatically.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: David Vrabel <david.vrabel@csr.com>
> Cc: Ben Dooks <ben@fluff.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/boot/dts/mpc8536ds.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -puN arch/powerpc/boot/dts/mpc8536ds.dts~powerpc-85xx-add-esdhc-support-for-mpc8536ds-boards arch/powerpc/boot/dts/mpc8536ds.dts
> --- a/arch/powerpc/boot/dts/mpc8536ds.dts~powerpc-85xx-add-esdhc-support-for-mpc8536ds-boards
> +++ a/arch/powerpc/boot/dts/mpc8536ds.dts
> @@ -258,6 +258,14 @@
>  			clock-frequency = <250000000>;
>  		};

By "clock-frequency = <250000000>;" above and the one down below*
I can see that this patch is already applied (via powerpc tree).

Please don't merge this particular patch, it's already there.

> +		sdhci@2e000 {
> +			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
> +			reg = <0x2e000 0x1000>;
> +			interrupts = <72 0x2>;
> +			interrupt-parent = <&mpic>;
> +			clock-frequency = <250000000>;

*

> +		};
> +
>  		serial0: serial@4500 {
>  			cell-index = <0>;
>  			device_type = "serial";
> _

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
