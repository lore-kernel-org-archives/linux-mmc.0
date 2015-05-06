From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Wed, 06 May 2015 02:41:23 +0100
Message-ID: <1430876483.4222.45.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	 <554252A1.6070302@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554252A1.6070302-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 2015-04-30 at 19:04 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/30/2015 03:32 PM, Ben Hutchings wrote:
> 
> > Implement voltage switch, supporting modes up to SDR-50.
> 
> > Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
> 
> > This uses two voltage regulators, one external and one on the pfc.
> 
> > Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> > ---
> >   drivers/mmc/host/sh_mobile_sdhi.c |   48 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 48 insertions(+)
> 
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index 92a58c6007fe..c8538a256e22 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> [...]
> > @@ -148,6 +150,41 @@ static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
> >   	}
> >   }
> >
> > +static int sh_mobile_sdhi_start_signal_voltage_switch(
> > +	struct tmio_mmc_host *host, unsigned char signal_voltage)
> > +{
> > +	struct sh_mobile_sdhi *priv = host_to_priv(host);
> > +	int min_uV, max_uV;
> > +	int ret;
> > +
> > +	if (signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> > +		min_uV = 2700000;
> > +		max_uV = 3600000;
> > +	} else if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> > +		min_uV = 1700000;
> > +		max_uV = 1950000;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> 
>     The above is asking to be a *switch* statement.

I suppose so, yes.

Ben.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
