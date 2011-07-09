From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Fix return value in sdhci_s3c_suspend/resume()
Date: Sat, 09 Jul 2011 16:50:09 -0400
Message-ID: <m2vcvbkwla.fsf@bob.laptop.org>
References: <1309315118-16133-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1309315118-16133-1-git-send-email-kgene.kim@samsung.com> (Kukjin
	Kim's message of "Wed, 29 Jun 2011 11:38:38 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Wonil Choi <wonil22.choi@samsung.com>, Minho Ban <mhban@samsung.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

Hi Kukjin,

On Tue, Jun 28 2011, Kukjin Kim wrote:
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 69e3ee3..460ffaf 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -612,16 +612,14 @@ static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(dev);
>  
> -	sdhci_suspend_host(host, pm);
> -	return 0;
> +	return sdhci_suspend_host(host, pm);
>  }
>  
>  static int sdhci_s3c_resume(struct platform_device *dev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(dev);
>  
> -	sdhci_resume_host(host);
> -	return 0;
> +	return sdhci_resume_host(host);
>  }
>  
>  #else

Thanks, pushed to mmc-next for 3.1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
