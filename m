From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio_mmc: silence compiler warnings
Date: Wed, 5 Jan 2011 20:48:27 +0000
Message-ID: <20110105204827.GE9198@void.printf.net>
References: <Pine.LNX.4.64.1011231723090.25676@axis700.grange> <1292793367-5638-1-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292793367-5638-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Dec 19, 2010 at 09:16:07PM +0000, Arnd Hannemann wrote:
> with "mmc: tmio: implement a bounce buffer for unaligned DMA"
> gcc generates the following warnings:
> 
> drivers/mmc/host/tmio_mmc.c:654:6: warning: 'ret' may be used uninitialized in this function
> drivers/mmc/host/tmio_mmc.c:730:6: warning: 'ret' may be used uninitialized in this function
> 
> This patch fixes these by setting ret to -EINVAL in the affected code paths.
> 
> This patch applies on top of -rc6 plus the following patches:
>   mmc: tmio_mmc: allow multi-element scatter-gather lists
>   mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
>   mmc: tmio: merge the private header into the driver
>   mmc: tmio: implement a bounce buffer for unaligned DMA
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Thanks, pushed to mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
