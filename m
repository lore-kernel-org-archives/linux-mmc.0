From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix error return code in
 sh_mobile_sdhi_probe()
Date: Wed, 29 May 2013 10:20:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305291012180.15070@axis700.grange>
References: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
 <Pine.LNX.4.64.1305290841080.14157@axis700.grange>
 <CAPgLHd-Qv5fdoxd6HmO8LbDpLZAxYP8e8x4FqAutg_8T4-DRtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAPgLHd-Qv5fdoxd6HmO8LbDpLZAxYP8e8x4FqAutg_8T4-DRtg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 29 May 2013, Wei Yongjun wrote:

> Hi
> 
> On 05/29/2013 02:58 PM, Guennadi Liakhovetski wrote:
> > Hi
> >
> > On Tue, 28 May 2013, Wei Yongjun wrote:
> >
> >> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> >>
> >> Fix to return a negative error code instead of 0 when we cannot get
> >> IRQ source by platform_get_irq(), as done elsewhere in this function.
> >>
> >> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> > Thanks for the patch. Do you think the following version would be even a 
> > bit simpler?
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index fe90853..76661b6 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -255,18 +255,17 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
> >  	if (multiplexed_isr) {
> >  		while (1) {
> >  			irq = platform_get_irq(pdev, i);
> > -			if (irq < 0)
> > -				break;
> > +			/* There must be at least one IRQ source */
> > +			if (irq < 0) {
> > +				ret = irq;
> > +				goto eirq;
> > +			}
> >  			i++;
> >  			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
> >  					  dev_name(&pdev->dev), host);
> >  			if (ret)
> >  				goto eirq;
> >  		}
> > -
> > -		/* There must be at least one IRQ source */
> > -		if (!i)
> > -			goto eirq;
> >  	}
> >  
> >  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
> 
> The orig code used while loop to get many irqs, but with your change,
> we will leave the loop util platform_get_irq() or request_irq() fail
> and nerver success.

Mmmh, ok, right. You mean, the original code wouldn't error out if at 
least 1 IRQ had been detected, whereas my change would, which is wrong. 
Sorry, forget about my version, yours was right.

Acked-by: Guennadi Liakhovetski <g.liakhovetski+renesas-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Thanks
Guennadi

> Do your means remove the while loop and this device
> need only one irq?
> 
> >
> > If you agree, maybe you could send a v2 of your patch in this form, I'll 
> > ack it then.
> >
> > Thanks
> > Guennadi
> >
> >> ---
> >>  drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> >> index cc4c872..a4316b3 100644
> >> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> >> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> >> @@ -273,8 +273,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
> >>  		}
> >>  
> >>  		/* There must be at least one IRQ source */
> >> -		if (!i)
> >> +		if (!i) {
> >> +			ret = irq;
> >>  			goto eirq;
> >> +		}
> >>  	}
> >>  
> >>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
> >>

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
