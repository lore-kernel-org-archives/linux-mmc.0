From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 04/15] media: pxa_camera: remove the dmaengine compat need
Date: Fri, 4 May 2018 16:29:32 -0300
Message-ID: <20180504162932.52a020cc@vento.lan>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-5-robert.jarzmik@free.fr>
 <89f3e97c-08a4-33b6-8fd3-0c1b4dea2065@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <89f3e97c-08a4-33b6-8fd3-0c1b4dea2065@xs4all.nl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-ide@vger.kernel.org, Pravin Shedge <pravin.shedge4linux@gmail.com>, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devel@driverdev.osuosl.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>, Robert Jarzmik <robert.jarzmik@renault.com>, Marek Vasut <marek.vasut@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Flavio Ceolin <flavio.ceolin@intel.com>, Mark
List-Id: linux-mmc@vger.kernel.org

Em Sun, 22 Apr 2018 13:06:12 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 04/02/2018 04:26 PM, Robert Jarzmik wrote:
> > From: Robert Jarzmik <robert.jarzmik@renault.com>
> > 
> > As the pxa architecture switched towards the dmaengine slave map, the
> > old compatibility mechanism to acquire the dma requestor line number and
> > priority are not needed anymore.
> > 
> > This patch simplifies the dma resource acquisition, using the more
> > generic function dma_request_slave_channel().
> > 
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>  
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

I'm assuming that you'll be applying it together with other PXA patches.
So:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Regards,
Mauro
> 
> Regards,
> 
> 	Hans
> 
> > ---
> >  drivers/media/platform/pxa_camera.c | 22 +++-------------------
> >  1 file changed, 3 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
> > index c71a00736541..4c82d1880753 100644
> > --- a/drivers/media/platform/pxa_camera.c
> > +++ b/drivers/media/platform/pxa_camera.c
> > @@ -2357,8 +2357,6 @@ static int pxa_camera_probe(struct platform_device *pdev)
> >  		.src_maxburst = 8,
> >  		.direction = DMA_DEV_TO_MEM,
> >  	};
> > -	dma_cap_mask_t mask;
> > -	struct pxad_param params;
> >  	char clk_name[V4L2_CLK_NAME_SIZE];
> >  	int irq;
> >  	int err = 0, i;
> > @@ -2432,34 +2430,20 @@ static int pxa_camera_probe(struct platform_device *pdev)
> >  	pcdev->base = base;
> >  
> >  	/* request dma */
> > -	dma_cap_zero(mask);
> > -	dma_cap_set(DMA_SLAVE, mask);
> > -	dma_cap_set(DMA_PRIVATE, mask);
> > -
> > -	params.prio = 0;
> > -	params.drcmr = 68;
> > -	pcdev->dma_chans[0] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_Y");
> > +	pcdev->dma_chans[0] = dma_request_slave_channel(&pdev->dev, "CI_Y");
> >  	if (!pcdev->dma_chans[0]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
> >  		return -ENODEV;
> >  	}
> >  
> > -	params.drcmr = 69;
> > -	pcdev->dma_chans[1] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_U");
> > +	pcdev->dma_chans[1] = dma_request_slave_channel(&pdev->dev, "CI_U");
> >  	if (!pcdev->dma_chans[1]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
> >  		err = -ENODEV;
> >  		goto exit_free_dma_y;
> >  	}
> >  
> > -	params.drcmr = 70;
> > -	pcdev->dma_chans[2] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_V");
> > +	pcdev->dma_chans[2] = dma_request_slave_channel(&pdev->dev, "CI_V");
> >  	if (!pcdev->dma_chans[2]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for V\n");
> >  		err = -ENODEV;
> >   
> 



Thanks,
Mauro
