From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 1/4] mmc: sdhci: Change timeout of loop for checking
 internal clock stable
Date: Wed, 21 Aug 2019 15:04:32 +0300
Message-ID: <4e494909-01ba-bf23-2e01-faa131d75b00@intel.com>
References: <20190820020625.8230-1-benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820020625.8230-1-benchuanggli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
List-Id: linux-mmc@vger.kernel.org

On 20/08/19 5:06 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> According to section 3.2.1 internal clock setup in SD Host Controller
> Simplified Specifications 4.20, the timeout of loop for checking
> internal clock stable is defined as 150ms.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..bed0760a6c2a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> +	/* Wait max 150 ms */
> +	timeout = ktime_add_ms(ktime_get(), 150);
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> 
