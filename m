From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: Enable BUS WIDTH testing for MMC/eMMC cards
Date: Thu, 19 May 2011 14:53:21 -0400
Message-ID: <m3wrhmbjz2.fsf@pullcord.laptop.org>
References: <162BA714-31AB-44B8-901A-5324E4F49F4C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34005 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977Ab1ESSvf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 May 2011 14:51:35 -0400
In-Reply-To: <162BA714-31AB-44B8-901A-5324E4F49F4C@marvell.com> (Philip
	Rakity's message of "Fri, 21 Jan 2011 11:25:44 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

On Fri, Jan 21 2011, Philip Rakity wrote:
> The PXA family of controllers (PXA168/PXA910/MMP2) support CMD14/CMD19
> transactions that are used to test the MMC/eMMC bus width for 1, 4, or
> 8 bits.
>
> Indicate to the mmc layer that it is safe to do bus width testing.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxa.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index ed044a8..0afc763 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -121,6 +121,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
>  	host->irq = irq;
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
> +	/* enable mmc bus width testing */
> +	host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
> +
>  	/* If slot design supports 8 bit data, indicate this to MMC. */
>  	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>  		host->mmc->caps |= MMC_CAP_8_BIT_DATA;

This patch causes a 10 second boot time delay here, on XO-1.75/MMP2:

[  625.245478] Waiting for root device /dev/mmcblk0p2...
[  634.877598] mmc2: Timeout waiting for hardware interrupt.
[  634.882966] sdhci: =========== REGISTER DUMP (mmc2)===========
[  634.888756] sdhci: Sys addr: 0x1cfc7864 | Version:  0x00000002
[  634.888756] sdhci: Blk size: 0x00007004 | Blk cnt:  0x00000000
[  634.894544] sdhci: Argument: 0x00000000 | Trn mode: 0x00000003
[  634.900334] sdhci: Present:  0x01fa0000 | Host ctl: 0x00000007
[  634.911913] sdhci: Power:    0x0000000b | Blk gap:  0x00000000
[  634.911913] sdhci: Wake-up:  0x00000000 | Clock:    0x00000207
[  634.917703] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[  634.929283] sdhci: Int enab: 0x02ff000b | Sig enab: 0x02ff000b
[  634.929283] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[  634.935071] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
[  634.940861] sdhci: Cmd:      0x0000133a | Max curr: 0x00000000
[  634.946651] sdhci: Host ctl2: 0x00000000
[  634.952438] sdhci: ===========================================
[  634.962269] mmc2: new high speed DDR MMC card at address 0001

Everything seems to work after the delay, though.  Any ideas?
Doesn't seem to happen with CONFIG_MMC_DEBUG=y.
(Maybe you can test on an XO?)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
