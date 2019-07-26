From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
Date: Fri, 26 Jul 2019 16:17:31 +0930
Message-ID: <4c6c020d-5985-4c57-aaae-c2393f9cc2fc@www.fastmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
 <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
 <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
 <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, Ryan Chen <ryanchen.aspeed@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Fri, 26 Jul 2019, at 15:27, Adrian Hunter wrote:
> On 26/07/19 3:52 AM, Andrew Jeffery wrote:
> > On Thu, 25 Jul 2019, at 22:49, Adrian Hunter wrote:
> >> On 12/07/19 6:32 AM, Andrew Jeffery wrote:
> >>> +static int aspeed_sdhci_probe(struct platform_device *pdev)
> >>> +{
> >>> +	struct sdhci_pltfm_host *pltfm_host;
> >>> +	struct aspeed_sdhci *dev;
> >>> +	struct sdhci_host *host;
> >>> +	struct resource *res;
> >>> +	int slot;
> >>> +	int ret;
> >>> +
> >>> +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
> >>> +	if (IS_ERR(host))
> >>> +		return PTR_ERR(host);
> >>> +
> >>> +	pltfm_host = sdhci_priv(host);
> >>> +	dev = sdhci_pltfm_priv(pltfm_host);
> >>> +	dev->parent = dev_get_drvdata(pdev->dev.parent);
> >>> +
> >>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> +	slot = aspeed_sdhci_calculate_slot(dev, res);
> >>> +	if (slot < 0)
> >>> +		return slot;
> >>> +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> >>> +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> >>
> >> That implies that you only support 2 slots which begs the question why
> >> you don't validate slot.
> > 
> > I'm not sure what you mean here, but I'll dig into it.
> 
> I just meant, if you only support 2 slots:
> 
> 	if (slot > 1)
> 		return -EINVAL;
>

Oh, sure.
