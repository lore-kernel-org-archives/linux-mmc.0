From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC, USHC: Don't double include usb.h in ushc.c
Date: Mon, 24 Jan 2011 21:02:02 +0000
Message-ID: <20110124210202.GA11110@void.printf.net>
References: <alpine.LNX.2.00.1101242156050.10252@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101242156050.10252@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@csr.com>, Axel Lin <axel.lin@gmail.com>, trivial@kernel.org
List-Id: linux-mmc@vger.kernel.org

Jesper,

On Mon, Jan 24, 2011 at 09:59:25PM +0100, Jesper Juhl wrote:
> We include linux/usb.h twice in drivers/mmc/host/ushc.c - once is enough.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  ushc.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
> index f8f65df..f08f944 100644
> --- a/drivers/mmc/host/ushc.c
> +++ b/drivers/mmc/host/ushc.c
> @@ -19,7 +19,6 @@
>  #include <linux/module.h>
>  #include <linux/usb.h>
>  #include <linux/kernel.h>
> -#include <linux/usb.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mmc/host.h>
> 

I've already replied to you ACKing this patch, and pushed it to mmc-next. 

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
