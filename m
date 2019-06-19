From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Date: Wed, 19 Jun 2019 08:56:25 -0600
Message-ID: <20190619145625.GA50985@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 11, 2019 at 01:30:55PM +0300, Adrian Hunter wrote:
> Does the following work?
> 
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0cd5f2ce98df..f672171246b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -341,8 +341,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> +	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +
>  	sdhci_init(host, 0);
>  	sdhci_enable_card_detection(host);
> +
> +	/*
> +	 * A change to the card detect bits indicates a change in present state,
> +	 * refer sdhci_set_card_detection(). A card detect interrupt might have
> +	 * been missed while the host controller was being reset, so trigger a
> +	 * rescan to check.
> +	 */
> +	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
> +		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>  
>  static void __sdhci_led_activate(struct sdhci_host *host)

Your patch looks good. I tried it out and got over 57k insertion/removal
iterations. Do you want me to send out your patch, or do you want to do
it?

Just to recap, the patch you proposed + the AMD SDHCI specific patch fix
the problem.

Thanks!
