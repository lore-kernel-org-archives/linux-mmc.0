From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 4/7] USB: mos7720: rename DCR
Date: Tue, 23 Jun 2015 12:09:18 +0200
Message-ID: <20150623100918.GG28202@localhost>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-5-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36287 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932615AbbFWKJS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jun 2015 06:09:18 -0400
Content-Disposition: inline
In-Reply-To: <1434629873-11668-5-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org

On Thu, Jun 18, 2015 at 05:47:50PM +0530, Sudip Mukherjee wrote:
> While building with mn10300 it failed with:
> error: expected identifier before '(' token
>  #define __SYSREG(ADDR, TYPE) (*(volatile TYPE *)(ADDR))
> note: in expansion of macro '__SYSREG'
>  #define DCR   __SYSREG(0xc0000030, u16) /* Debug control register */
> 
> mn10300 has a register named as DCR, so when this driver used an enum
> named as DCR, build failed.
> Just rename the DCR in the driver to parport_DCR.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/usb/serial/mos7720.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 4f70df3..3263125 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -135,7 +135,7 @@ enum mos_regs {
>  	DLM,
>  	DPR,              /* parallel port regs */
>  	DSR,
> -	DCR,
> +	parport_DCR,
>  	ECR,
>  	SP1_REG,          /* device control regs */
>  	SP2_REG,          /* serial port 2 (7720 only) */

Please use a MOS_ (or MOS7720_) prefix instead and add it to all the
registers.

Thanks,
Johan
