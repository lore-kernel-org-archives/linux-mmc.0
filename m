From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v3 4/6] mmc: sdhci-s3c: derive transfer width host capability
 from max_width in platform data
Date: Tue, 31 Jan 2012 22:12:13 +0300
Message-ID: <4F283D0D.3050508@ru.mvista.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <1328032576-9269-5-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1328032576-9269-5-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, ben-linux@fluff.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 01/31/2012 08:56 PM, Thomas Abraham wrote:

> max_width member in platform data can be used to derive the mmc bus transfer
> width that can be supported by the controller.

> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   drivers/mmc/host/sdhci-s3c.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)

> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index e1b685d..a57d7a0 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -562,6 +562,14 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>   	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>   		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>
> +	switch (pdata->max_width) {
> +	case 8:
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;

    A comment like /* FALL THRU */ is needed here.

> +	case 4:
> +		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		break;
> +	}
> +

WBR, Sergei
