From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: fix debug_quirks2 module parameter description
Date: Wed, 12 Oct 2011 11:30:50 -0400
Message-ID: <m2ipnui5w5.fsf@bob.laptop.org>
References: <1318423479-3805-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58207 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab1JLPa7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Oct 2011 11:30:59 -0400
In-Reply-To: <1318423479-3805-1-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Wed, 12 Oct 2011 15:44:39 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Wed, Oct 12 2011, Adrian Hunter wrote:
> debug_quirks2 module parameter description was inadvertently added
> as debug_quirks.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f530de6..2cc3ffa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3058,4 +3058,4 @@ MODULE_DESCRIPTION("Secure Digital Host
> Controller Interface core driver");
>  MODULE_LICENSE("GPL");
>  
>  MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
> -MODULE_PARM_DESC(debug_quirks, "Force certain other quirks.");
> +MODULE_PARM_DESC(debug_quirks2, "Force certain other quirks.");

Thanks, I've folded this into the original "sdhci-pci: add runtime pm
support" patch in mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
