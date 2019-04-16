From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] mmc: cqhci: clear pending interrupt and halt
Date: Tue, 16 Apr 2019 11:32:03 +0300
Message-ID: <83ba5bb2-2d59-1f67-b1a1-cb5e20985a1f@intel.com>
References: <DB7PR04MB44904965E8F1BF09A5C150B288240@DB7PR04MB4490.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB44904965E8F1BF09A5C150B288240@DB7PR04MB4490.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>, "riteshh@codeaurora.org" <riteshh@codeaurora.org>, "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, BOUGH CHEN <haibo.chen@nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "van.freenix@gmail.com" <van.freenix@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 16/04/19 10:27 AM, Peng Fan wrote:
> Hi Adrian,
> 
>>
>> On 16/04/19 9:48 AM, Peng Fan wrote:
>>> On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
>>> as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
>>> the 1st linux configure power/clock for the 2nd Linux.
>>>
>>> When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
>>> to destroy the 2nd linux, then restart the 1st linux, we met SDHCI
>>> dump as following, after we clear the pending interrupt and halt
>>> CQCTL, issue gone.
>>
>> I think it is better if the vendor driver does any necessary resets before
>> initialization.
> 
> In drivers/mmc/host/sdhci-esdhc-imx.c, there is a call to cqhci_init
> " 1525                 err = cqhci_init(cq_host, host->mmc, false);"
> 
> You mean I put the following piece code into sdhci-esdhc-imx.c?
> 
> "
>      status = cqhci_readl(cq_host, CQHCI_IS);
>      cqhci_writel(cq_host, status, CQHCI_IS);
>      cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> "
> 
> How about the following patch?
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b8e11a77e274..f2e46ddf9695 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1435,6 +1435,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         struct cqhci_host *cq_host;
>         int err;
>         struct pltfm_imx_data *imx_data;
> +       u32 status;
> 
>         host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata,
>                                 sizeof(*imx_data));
> @@ -1542,6 +1543,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 err = cqhci_init(cq_host, host->mmc, false);
>                 if (err)
>                         goto disable_ahb_clk;
> +
> +               status = cqhci_readl(cq_host, CQHCI_IS);
> +               cqhci_writel(cq_host, status, CQHCI_IS);
> +               cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> +
>         }
> 

It would be nicer to:
1. Define how CQHCI gets reset.  For example, with our controllers
SDHCI_RESET_ALL also resets CQHCI.
2. Define when CQHCI should be reset. e.g. using the ->reset() host op for
example.
3. Implement a patch that meets those requirements.
