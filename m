From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/7 v2] dmaengine: add a simple dma library
Date: Thu, 26 Jan 2012 18:34:44 +0100
Message-ID: <20120126173444.GM5446@pengutronix.de>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
	<1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-mmc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Thu, Jan 26, 2012 at 03:56:18PM +0100, Guennadi Liakhovetski wrote:
> This patch adds a library of functions, helping to implement dmaengine
> drivers for hardware, unable to handle scatter-gather lists natively.
> The first version of this driver only supports memcpy and slave DMA
> operation.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 

[...]

> +
> +/*
> + * For slave DMA we assume, that there is a finite number of DMA slaves in the
> + * system, and that each such slave can only use a finite number of channels.
> + * We use slave channel IDs to make sure, that no such slave channel ID is
> + * allocated more than once.
> + */
> +static unsigned int slave_num = 256;
> +module_param(slave_num, uint, 0444);
> +
> +/* A bitmask with slave_num bits */
> +static unsigned long *simple_slave_used;

You never check that the slave ids passed into this code are
within the range of slave_num. Given that this is a user changeable
value this is a bit flawy.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
