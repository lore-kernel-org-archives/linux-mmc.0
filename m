From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [RFC PATCH 2/7] mmc: sh_mobile_sdhi: Add actual clock rate
 support
Date: Wed, 06 May 2015 02:10:28 +0100
Message-ID: <1430874628.4222.20.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397081.5802.41.camel@xylophone.i.decadent.org.uk>
	 <554259A0.9030307@cogentembedded.com>
	 <1430874332.4222.18.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430874332.4222.18.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Shinobu Uehara <shinobu.uehara.xc@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2015-05-06 at 02:05 +0100, Ben Hutchings wrote:
> On Thu, 2015-04-30 at 19:34 +0300, Sergei Shtylyov wrote:
> > On 04/30/2015 03:31 PM, Ben Hutchings wrote:
> > 
> > > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > 
> > > It is necessary to stop the SD clock before using
> > > the actual clock in case of SDHI controller.
> > 
> > > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > > ---
> > >   drivers/mmc/host/sh_mobile_sdhi.c |   14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > 
> > > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > > index 6906a905cd54..92a58c6007fe 100644
> > > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > > @@ -136,6 +136,18 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
> > >   	clk_disable_unprepare(priv->clk);
> > >   }
> > >
> > > +static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
> > > +{
> > > +	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
> > > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > > +
> > > +	if (clk == true) {
> > 
> >     'clk' is *int*. Perhaps, should be just *if* (clk)?
> 
> clk is either 0 or 1 and should maybe be bool.  But you're right,
> regardless of its type, it doesn't make sense to compare with true.
[...]

Anyway, I think this is redundant with:

commit b30d6958a014812158d9729a3e0b6d448f6e8968
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Sun Aug 24 20:02:16 2014 -0700

    mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_clock()

commit da29fe2bf573f0ae56fdc2e790387cb73fc8c6f8
Author: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Date:   Sun Aug 24 20:03:00 2014 -0700

    mmc: tmio: add actual clock support as option

so I will probably just drop it.

Ben.


