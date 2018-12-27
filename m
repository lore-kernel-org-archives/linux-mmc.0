From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: handle mmc_of_parse() errors
 during probe
Date: Thu, 27 Dec 2018 09:06:10 +0200
Message-ID: <ae20c332-17a3-d135-ae93-391f1cf989d3@intel.com>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
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
To: Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 23/12/18 10:59 PM, Stefan Wahren wrote:
> We need to handle mmc_of_parse() errors during probe otherwise the
> MMC driver could start without proper initialization (e.g. power sequence).
> 
> Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Hi,
> since i don't have this hardware, so it is only compile tested.
> Would be nice to get a Tested-by.
> 
> Regards
> Stefan 
> 
> 
>  drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 552bddc..1cd1035 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -55,7 +55,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	}
>  
>  	sdhci_get_of_property(pdev);
> -	mmc_of_parse(host->mmc);
> +	res = mmc_of_parse(host->mmc);
> +	if (res)
> +		goto err;
>  
>  	/*
>  	 * Supply the existing CAPS, but clear the UHS modes. This
> 
