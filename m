From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/15] net: irda: pxaficp_ir: remove the dmaengine compat
 need
Date: Mon, 23 Apr 2018 10:37:20 +0200
Message-ID: <20180423083720.GA25048@kroah.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-10-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20180402142656.26815-10-robert.jarzmik@free.fr>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-ide@vger.kernel.org, Pravin Shedge <pravin.shedge4linux@gmail.com>, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, netdev@vger.kernel.org, linux-mmc
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 02, 2018 at 04:26:50PM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/staging/irda/drivers/pxaficp_ir.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This file is no longer in Linus's tree :)

thanks,

greg k-h
