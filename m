From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH 2/9] mmc: sdhci: add a callback for signal voltage
 switching
Date: Fri, 3 Mar 2017 07:38:01 +0000
Message-ID: <DB6PR0401MB253689E333DF8974968CB03CF82B0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
 <1488448050-7574-3-git-send-email-yangbo.lu@nxp.com>
 <bf18ad90-e622-1b9f-d6f7-0becbe57ea76@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <bf18ad90-e622-1b9f-d6f7-0becbe57ea76@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will.deacon@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Thursday, March 02, 2017 10:19 PM
> To: Y.B. Lu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Rob
> Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Xiaobo Xie
> Subject: Re: [PATCH 2/9] mmc: sdhci: add a callback for signal voltage
> switching
> 
> On 02/03/17 11:47, Yangbo Lu wrote:
> > Add a callback for signal voltage switching to let host driver switch
> > signal voltage in its own way.
> 
> That is not how we do things now.  Please just replace the host operation
> instead e.g.
> 
> host->mmc_host_ops.start_signal_voltage_switch =
> 				esdhc_signal_voltage_switch;
> 

[Lu Yangbo-B47093] Hi Adrian, your method is great! I will use this in v2.
Thanks.

> 
> 
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 6 ++++++
> >  drivers/mmc/host/sdhci.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 6fdd7a7..3c9a924 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1852,6 +1852,12 @@ static int
> sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >  	if (host->version < SDHCI_SPEC_300)
> >  		return 0;
> >
> > +	if (host->ops->start_signal_voltage_switch) {
> > +		ret = host->ops->start_signal_voltage_switch(
> > +					host, ios->signal_voltage);
> > +		return ret;
> > +	}
> > +
> >  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >
> >  	switch (ios->signal_voltage) {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> > edf3adf..04af687 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -566,6 +566,8 @@ struct sdhci_ops {
> >  					 struct mmc_card *card,
> >  					 unsigned int max_dtr, int host_drv,
> >  					 int card_drv, int *drv_type);
> > +	int	(*start_signal_voltage_switch)(struct sdhci_host *host,
> > +					       unsigned char signal_voltage);
> >  };
> >
> >  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> >
