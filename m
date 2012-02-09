From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 2/2]  mmc: sdhci-s3c: add platform data for the second
 capability
Date: Thu, 09 Feb 2012 19:23:10 +0900
Message-ID: <067b01cce714$d2b71dc0$78255940$%kim@samsung.com>
References: <4F2F86DA.6030106@samsung.com> <m239ao5hve.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m239ao5hve.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Girish K S' <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Chris Ball wrote:
> 
> Hi,
> 
Hi,

> On Mon, Feb 06 2012, Jaehoon Chung wrote:
> > This patch is added host_caps2 in sdhci-s3c.c
> > It's necessary that use the second capabilities.
> > And removed the duplicated host_caps.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > Changelog v3:
> > 	- based-on latest mmc-next tree
> > Changelog v2:
> > 	- remove the duplicated host_caps.
> >
> >  drivers/mmc/host/sdhci-s3c.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> > index d065e37..46b9782 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -521,9 +521,6 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> >  	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
> >  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
> >
> > -	if (pdata->host_caps)
> > -		host->mmc->caps |= pdata->host_caps;
> > -
> >  	if (pdata->pm_caps)
> >  		host->mmc->pm_caps |= pdata->pm_caps;
> >
> > @@ -547,6 +544,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> >  	if (pdata->host_caps)
> >  		host->mmc->caps |= pdata->host_caps;
> >
> > +	if (pdata->host_caps2)
> > +		host->mmc->caps2 |= pdata->host_caps2;
> > +
> >  	ret = sdhci_add_host(host);
> >  	if (ret) {
> >  		dev_err(dev, "sdhci_add_host() failed\n");
> 
> In case you'd rather merge both of these via the samsung-soc tree:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
OK, will apply this series with Chris' ack in samsung tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
