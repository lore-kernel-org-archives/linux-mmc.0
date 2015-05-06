From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] mmc: sh_mobile_sdhi: Add actual clock rate
 support
Date: Wed, 06 May 2015 02:05:32 +0100
Message-ID: <1430874332.4222.18.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397081.5802.41.camel@xylophone.i.decadent.org.uk>
	 <554259A0.9030307@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554259A0.9030307-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Shinobu Uehara <shinobu.uehara.xc-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2015-04-30 at 19:34 +0300, Sergei Shtylyov wrote:
> On 04/30/2015 03:31 PM, Ben Hutchings wrote:
> 
> > From: Shinobu Uehara <shinobu.uehara.xc-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> > It is necessary to stop the SD clock before using
> > the actual clock in case of SDHI controller.
> 
> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> > ---
> >   drivers/mmc/host/sh_mobile_sdhi.c |   14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> 
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index 6906a905cd54..92a58c6007fe 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -136,6 +136,18 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
> >   	clk_disable_unprepare(priv->clk);
> >   }
> >
> > +static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
> > +{
> > +	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +
> > +	if (clk == true) {
> 
>     'clk' is *int*. Perhaps, should be just *if* (clk)?

clk is either 0 or 1 and should maybe be bool.  But you're right,
regardless of its type, it doesn't make sense to compare with true.

Ben.

> > +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
> > +				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> > +		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x00ff);
> > +	}
> > +}
> > +
> >   static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> >   {
> >   	int timeout = 1000;
> [...]
> 
> WBR, Sergei
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
