From: Dinh Nguyen <dinguyen@altera.com>
Subject: RE: [RFC V3 2/4] mmc: dw_mmc: socfpga: move socfpga private init
Date: Wed, 4 Sep 2013 14:31:06 -0500
Message-ID: <1378323066.9054.3.camel@linux-builds1>
References: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
	 <1377691731-7226-3-git-send-email-yuvaraj.cd@samsung.com>
	 <001601cea4af$42e662f0$c8b328d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001601cea4af$42e662f0$c8b328d0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2013-08-29 at 20:59 +0900, Seungwon Jeon wrote:
> On Wed, August 28, 2013, Yuvaraj Kumar C D wrote:
> > Currently platform specific private data initialisation is done by
> > dw_mci_socfpga_priv_init and dw_mci_socfpga_parse_dt.As we already have
> > separate platform specific device tree parser dw_mci_socfpga_parse_dt,
> > move the dw_mci_socfpga_priv_init code to dw_mci_socfpga_parse_dt.
> > We can use the dw_mci_socfpga_priv_init to do some actual platform
> > specific initialisation.

I am looking to remove all of dw_mmc-socfpga file. The only reason for
this file is to set the sdr timing values. But since the register that
controls these SDR values are located out of the IP, it is probably best
to implement the settings in platform specific code.

Dinh
> > 
> > This patch is compile tested only.
> CC'ed Dinh Nguyen
> 
> Thanks,
> Seungwon Jeon
> 
> > 
> > changes since V2: none
> > 
> > Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-socfpga.c |   29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
> > index 14b5961..953f260 100644
> > --- a/drivers/mmc/host/dw_mmc-socfpga.c
> > +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> > @@ -38,20 +38,6 @@ struct dw_mci_socfpga_priv_data {
> > 
> >  static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> >  {
> > -	struct dw_mci_socfpga_priv_data *priv;
> > -
> > -	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> > -	if (!priv) {
> > -		dev_err(host->dev, "mem alloc failed for private data\n");
> > -		return -ENOMEM;
> > -	}
> > -
> > -	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> > -	if (IS_ERR(priv->sysreg)) {
> > -		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
> > -		return PTR_ERR(priv->sysreg);
> > -	}
> > -	host->priv = priv;
> > 
> >  	return 0;
> >  }
> > @@ -79,12 +65,24 @@ static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
> > 
> >  static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
> >  {
> > -	struct dw_mci_socfpga_priv_data *priv = host->priv;
> > +	struct dw_mci_socfpga_priv_data *priv;
> >  	struct device_node *np = host->dev->of_node;
> >  	u32 timing[2];
> >  	u32 div = 0;
> >  	int ret;
> > 
> > +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		dev_err(host->dev, "mem alloc failed for private data\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> > +	if (IS_ERR(priv->sysreg)) {
> > +		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
> > +		return PTR_ERR(priv->sysreg);
> > +	}
> > +
> >  	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
> >  	if (ret)
> >  		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
> > @@ -96,6 +94,7 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
> >  		return ret;
> > 
> >  	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
> > +	host->priv = priv;
> >  	return 0;
> >  }
> > 
> > --
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
