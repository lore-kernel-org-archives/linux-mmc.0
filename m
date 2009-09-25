From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [at91sam9g45] DMA driver for AC97 and MCI
Date: Fri, 25 Sep 2009 17:36:15 +0200
Message-ID: <4ABCE36F.1000205@atmel.com>
References: <4ABCBD32.7080408@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:45742 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZIYPgb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Sep 2009 11:36:31 -0400
In-Reply-To: <4ABCBD32.7080408@visionsystems.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yegor_sub1@visionsystems.de
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

Yegor Yefremov :

> I try to get sound and SD card working on at91sam9g45-ekes development
> board using linux-next tree. As far as I understand AT_HDMAC is the
> appropriate DMA driver for ARCH_AT91SAM9G45.

Correct.

> I resolved dependencies with this patch, so I could activate it for
> my platform.
>
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -48,7 +48,7 @@ config DW_DMAC
> 
>  config AT_HDMAC
>         tristate "Atmel AHB DMA support"
> -       depends on ARCH_AT91SAM9RL
> +       depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
>         select DMA_ENGINE
>         help
>           Support the Atmel AHB DMA controller.  This can be integrated in

Well, this patch was waiting for this other to reach mainline:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5621/1

It is true that you will need it.

> Should this driver be also used for sound driver and MCI?

Sure. For sound, maybe we will have to conform to the dma cyclic API
introduced by dw_dmac driver.

For MCI, here is a patch series that goes before the patch that will do
the link between atmel_mci, at_hdmac and at91sam9g45.

http://lkml.org/lkml/2009/9/17/224

This last patch is not posted to the mailing list yet, I am waiting for
the others to reach mainline.

I you are interested in it, you can have a preview here:
ftp://ftp.linux4sam.org/devel/linux/2630_lnx4sam_patchset-tmp_20090828.tgz
patch named :
"at91/atmel-mci: inclusion of sd/mmc driver in at91sam9g45 chip and
board" aka:
2630_lnx4sam_patchset-tmp/2.6.30-at91-exp-0033-at91-atmel-mci-inclusion-of-sd-mmc-driver-in-at91sa.patch

Hope this helps,

Best regards,
-- 
Nicolas Ferre

