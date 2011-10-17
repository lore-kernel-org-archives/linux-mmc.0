From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: add flag for devices that can support runtime PM
Date: Mon, 17 Oct 2011 08:56:56 -0400
Message-ID: <m21uub93on.fsf@bob.laptop.org>
References: <1318837964-28654-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48409 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab1JQM5E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 08:57:04 -0400
In-Reply-To: <1318837964-28654-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 17 Oct 2011 10:52:44 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Oct 17 2011, Adrian Hunter wrote:
> Only allow runtime PM for devices that specifically indicate
> that they support it.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>  drivers/mmc/host/sdhci-pci.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index f49b184..c22d810 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -47,6 +47,7 @@ struct sdhci_pci_slot;
>  
>  struct sdhci_pci_fixes {
>  	unsigned int		quirks;
> +	unsigned int		allow_runtime_pm:1;

Thanks -- any objection to using a bool type instead for allow_runtime_pm?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
