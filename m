From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Re: [PATCH] mmc: sdhci: dove: Fix build breakage
Date: Wed, 23 Oct 2013 15:45:01 +0200
Message-ID: <5267D2DD.5000309@parrot.com>
References: <1382533832-21085-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:36272 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab3JWNq1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Oct 2013 09:46:27 -0400
In-Reply-To: <1382533832-21085-1-git-send-email-treding@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Soory, I thought I had corrected this typo.

Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>

-- 
Jeremie Samuel              Parrot S.A.
Software Engineer           14, quai de Jemmapes
R&D/OS Platform             75010 Paris, France
http://www.parrot.com

On 23/10/2013 15:10, Thierry Reding wrote:
> Commit 2d7c51f (mmc: sdhci: Use work structs instead of tasklets)
> converts tasklets to work structs, but typos the conversion in the Dove
> driver.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-dove.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index 45c7f25..95f1076 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -39,7 +39,7 @@ static irqreturn_t sdhci_dove_carddetect_irq(int irq, void *data)
>   {
>   	struct sdhci_host *host = data;
>   
> -	schedule_schedule(&host->card_detect_work);
> +	schedule_work(&host->card_detect_work);
>   	return IRQ_HANDLED;
>   }
>   

