From: Viresh KUMAR <viresh.kumar@st.com>
Subject: Re: [PATCH] sdhci-spear: ST SPEAr based SDHCI controller glue
Date: Thu, 20 May 2010 10:47:59 +0530
Message-ID: <4BF4C607.6070604@st.com>
References: <1273052118-15513-1-git-send-email-viresh.kumar@st.com> <20100519141013.ccb8ca9d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:35481 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752826Ab0ETFSS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2010 01:18:18 -0400
In-Reply-To: <20100519141013.ccb8ca9d.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org, shiraz.hashim@st.com

On 5/20/2010 2:40 AM, Andrew Morton wrote:
> On Wed,  5 May 2010 15:05:18 +0530
> Viresh KUMAR <viresh.kumar@st.com> wrote:
> 
>> This patch adds glue layer for support of sdhci driver on ST SPEAr platform.
>>
> 
> Looks OK to my untrained eye.  A few very minor things:
> 
>>
>> ...
>>
>> +static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
>> +{
>> +	struct platform_device *pdev = dev_id;
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct spear_sdhci *sdhci =
>> +		(struct spear_sdhci *)(pdev->dev.platform_data);
> 
> Seems wrong to open-code all of this.  There should be a
> 
> void *platform_device_get_platform_data(struct platform_device *);
> 
> but I can't find it.  The code can use dev_get_platdata(), however.

OK.

> 
> 
> Also, you don't _have_ to initialise things at the definition site.  If
> you were to do:
> 
> 	struct platform_device *pdev;
> 	struct sdhci_host *host;
> 	struct spear_sdhci *sdhci;
> 
> 	pdev = dev_id;
> 	host = platform_get_drvdata(pdev);
> 	sdhci = (struct spear_sdhci *)(pdev->dev.platform_data);
> 
> then you wouldn't need to do weird things to fit the code in 80-cols.
> 
> Also, platform_data has type void*, so the typecast here is unneeded
> and, because it defeats typechecking it is undesirable.

OK.

> 
>> +	unsigned long gpio_irq_type;
>> +	int val;
>> +
>> +	val = gpio_get_value(sdhci->data->card_int_gpio);
>> +
>> +	/* val == 1 -> card removed, val == 0 -> card inserted */
>> +	/* if card removed - set irq for low level, else vice versa */
>> +	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
>> +	set_irq_type(irq, gpio_irq_type);
>> +
>> +	if (sdhci->data->card_power_gpio >= 0) {
>> +		if (!sdhci->data->power_always_enb) {
>> +			/* if card inserted, give power, otherwise remove it */
>> +			val = sdhci->data->power_active_high ? !val : val ;
>> +			gpio_set_value(sdhci->data->card_power_gpio, val);
>> +		}
>> +	}
>> +
>> +	/* inform sdhci driver about card insertion/removal */
>> +	tasklet_schedule(&host->card_tasklet);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit sdhci_probe(struct platform_device *pdev)
>> +{
>> +	struct sdhci_host *host;
>> +	struct resource *iomem;
>> +	struct spear_sdhci *sdhci;
>> +	int ret;
>> +
>> +	BUG_ON(pdev == NULL);
>> +
>> +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!iomem) {
>> +		ret = -ENOMEM;
>> +		dev_dbg(&pdev->dev, "memory resource not defined\n");
>> +		goto err;
>> +	}
>> +
>> +	if (!request_mem_region(iomem->start, resource_size(iomem),
>> +				"spear-sdhci")) {
>> +		ret = -EBUSY;
>> +		dev_dbg(&pdev->dev, "cannot request region\n");
>> +		goto err;
>> +	}
>> +
>> +	sdhci = kzalloc(sizeof(*sdhci), GFP_KERNEL);
>> +	if (!sdhci) {
>> +		ret = -ENOMEM;
>> +		dev_dbg(&pdev->dev, "cannot allocate memory for sdhci\n");
>> +		goto err_kzalloc;
>> +	}
>> +
>> +	/* clk enable */
>> +	sdhci->clk = clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(sdhci->clk)) {
>> +		ret = PTR_ERR(sdhci->clk);
>> +		dev_dbg(&pdev->dev, "Error getting clock\n");
>> +		goto err_clk_get;
>> +	}
>> +
>> +	ret = clk_enable(sdhci->clk);
>> +	if (ret) {
>> +		dev_dbg(&pdev->dev, "Error enabling clock\n");
>> +		goto err_clk_enb;
>> +	}
>> +
>> +	/* overwrite platform_data */
>> +	sdhci->data = (struct sdhci_plat_data *)(pdev->dev.platform_data);
> 
> Similarly.

OK.

> 
>> +	pdev->dev.platform_data = sdhci;
>> +
>> +	if (pdev->dev.parent)
>> +		host = sdhci_alloc_host(pdev->dev.parent, 0);
>> +	else
>> +		host = sdhci_alloc_host(&pdev->dev, 0);
>> +
>> +	if (IS_ERR(host)) {
>> +		ret = PTR_ERR(host);
>> +		dev_dbg(&pdev->dev, "error allocating host\n");
>> +		goto err_alloc_host;
>> +	}
>> +
>> +	host->hw_name = "sdhci";
>> +	host->ops = &sdhci_pltfm_ops;
>> +	host->irq = platform_get_irq(pdev, 0);
>> +	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>> +
>> +	host->ioaddr = ioremap(iomem->start, resource_size(iomem));
>> +	if (!host->ioaddr) {
>> +		ret = -ENOMEM;
>> +		dev_dbg(&pdev->dev, "failed to remap registers\n");
>> +		goto err_ioremap;
>> +	}
>> +
>> +	ret = sdhci_add_host(host);
>> +	if (ret) {
>> +		dev_dbg(&pdev->dev, "error adding host\n");
>> +		goto err_add_host;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, host);
>> +
>>
>> ...
>>
>> +static int __devexit sdhci_remove(struct platform_device *pdev)
>> +{
>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>> +	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	struct spear_sdhci *sdhci =
>> +		(struct spear_sdhci *)(pdev->dev.platform_data);
> 
> Again.

OK. Will be corrected everywhere.
