From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc/spear: add pm callbacks to support hibernation
Date: Thu, 08 Mar 2012 23:31:28 -0500
Message-ID: <m2boo6qtsv.fsf@bob.laptop.org>
References: <452d8982fec5f41a3761a9e7b9bbe35e2f92c2a3.1330063674.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55650 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757437Ab2CIEbe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 23:31:34 -0500
In-Reply-To: <452d8982fec5f41a3761a9e7b9bbe35e2f92c2a3.1330063674.git.viresh.kumar@st.com>
	(Viresh Kumar's message of "Fri, 24 Feb 2012 11:55:35 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

Hi Viresh,

On Fri, Feb 24 2012, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
>
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  drivers/mmc/host/sdhci-spear.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index b7f8b33..6dfa82e 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -300,20 +300,15 @@ static int sdhci_resume(struct device *dev)
>  
>  	return sdhci_resume_host(host);
>  }
> -
> -const struct dev_pm_ops sdhci_pm_ops = {
> -	.suspend	= sdhci_suspend,
> -	.resume		= sdhci_resume,
> -};
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
> +
>  static struct platform_driver sdhci_driver = {
>  	.driver = {
>  		.name	= "sdhci",
>  		.owner	= THIS_MODULE,
> -#ifdef CONFIG_PM
>  		.pm	= &sdhci_pm_ops,
> -#endif
>  	},
>  	.probe		= sdhci_probe,
>  	.remove		= __devexit_p(sdhci_remove),

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
