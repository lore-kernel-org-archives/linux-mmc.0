From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/10] MXS-DMA : add more flags for MXS-DMA
Date: Thu, 19 Jan 2012 09:02:39 +0000
Message-ID: <20120119090238.GU1068@n2100.arm.linux.org.uk>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
	<1326953767-24155-7-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1326953767-24155-7-git-send-email-b32955@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huang Shijie <b32955@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, vinod.koul@intel.com, shijie8@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, linux-mtd@lists.infradead.org, artem.bityutskiy@intel.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 19, 2012 at 02:16:03PM +0800, Huang Shijie wrote:
> [1] Background :
>     The GPMI does ECC read page operation with a DMA chain consist of three DMA
>     Command Structures. The middle one of the chain is used to enable the BCH,
>     and read out the NAND page.
> 
>     The WAIT4END(wait for command end) is a comunication signal between
>     the GPMI and MXS-DMA.
> 
> [2] The current DMA code sets the WAIT4END bit at the last one, such as:
> 
>     +-----+               +-----+                      +-----+
>     | cmd | ------------> | cmd | ------------------>  | cmd |
>     +-----+               +-----+                      +-----+
>                                                           ^
>                                                           |
>                                                           |
>                                                      set WAIT4END here
> 
>     This chain works fine in the mx23/mx28.
> 
> [3] But in the new GPMI version (used in MX50/MX60), the WAIT4END bit should
>     be set not only at the last DMA Command Structure,
>     but also at the middle one, such as:
> 
>     +-----+               +-----+                      +-----+
>     | cmd | ------------> | cmd | ------------------>  | cmd |
>     +-----+               +-----+                      +-----+
>                              ^                            ^
>                              |                            |
>                              |                            |
>                         set WAIT4END here too        set WAIT4END here
> 
>    If we do not set WAIT4END, the BCH maybe stall in "ECC reading page" state.
>    In the next ECC write page operation, a DMA-timeout occurs.
>    This has been catched in the MX6Q board.
> 
> In order to fix the bug, we should let the driver to
> set the proper DMA flags in the DMA command structrues.
> 
> So add the new flags for MXS-DMA.
> The driver can use these flags to control the DMA in a more flexible way.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  include/linux/mxs-dma.h |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mxs-dma.h b/include/linux/mxs-dma.h
> index 203d7c4..3ef73b8 100644
> --- a/include/linux/mxs-dma.h
> +++ b/include/linux/mxs-dma.h
> @@ -11,6 +11,32 @@
>  
>  #include <linux/dmaengine.h>
>  
> +/*
> + * The drivers use these flags for ->device_prep_slave_sg() :
> + *    [1] If there is only one DMA command in the DMA chain, the code should be:
> + *            ......
> + *            ->device_prep_slave_sg(MXS_DMA_F_WAIT4END);
> + *            ......
> + *    [2] If there are two DMA commands in the DMA chain, the code should be
> + *            ......
> + *            ->device_prep_slave_sg(0);
> + *            ......
> + *            ->device_prep_slave_sg(MXS_DMA_F_LASTONE);
> + *            ......
> + *    [3] If there are more than two DMA commands in the DMA chain, the code
> + *        should be:
> + *            ......
> + *            ->device_prep_slave_sg(0);                 // First
> + *            ......
> + *            ->device_prep_slave_sg(MXS_DMA_F_APPEND [| MXS_DMA_F_WAIT4END]);
> + *            ......
> + *            ->device_prep_slave_sg(MXS_DMA_F_LASTONE); // Last
> + */
> +#define MXS_DMA_F_APPEND	(1 << 0)
> +#define MXS_DMA_F_WAIT4END	(1 << 1)
> +
> +#define MXS_DMA_F_LASTONE	(MXS_DMA_F_APPEND | MXS_DMA_F_WAIT4END)

Err, the 'flags' argument to device_prep_slave_sg() is supposed to be
from the set of enum dma_ctrl_flags.  What this means is that your
MXS_DMA_F_APPEND is equivalent to DMA_PREP_INTERRUPT, and
MXS_DMA_F_WAIT4END is equivalent to DMA_CTRL_ACK.

What this does is make your drivers completely dependent on your DMA
engine implementation.  That's not a good idea when devices get
reused in different SoCs.

If you need to supply extra flags which aren't in the dma_ctrl_flags,
at least make sure that they're using different bits.  For bonus points,
also have your driver _check_ the DMA engine it's connected to before
it passes these flags.
