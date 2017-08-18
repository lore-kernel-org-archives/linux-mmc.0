From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] sdhci: remove redundant check of zero slots
Date: Fri, 18 Aug 2017 16:15:47 +0300
Message-ID: <024cfffc-cf86-745b-e13d-88dc0d351426@intel.com>
References: <20170818123703.14870-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170818123703.14870-1-colin.king@canonical.com>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 18/08/17 15:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Slots can never be zero, PCI_SLOTS_INFO_SLOTS returns a value in the
> range 0..7; slots is one more than this, 1..8 so cannot be zero and
> so the zero check is redundant and can be removed.
> 
> Detected by CoverityScan, CID#744269 ("Logically Dead Code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 2c853cfa8389..43b2b09131bd 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1669,8 +1669,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>  	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> -	if (slots == 0)
> -		return -ENODEV;
>  
>  	BUG_ON(slots > MAX_SLOTS);

Isn't MAX_SLOTS == 8? So that is dead too.

>  
> 

