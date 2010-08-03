From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 3 Aug 2010 16:43:46 -0700
Message-ID: <20100803164346.69a63557.akpm@linux-foundation.org>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40807 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756841Ab0HCXnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Aug 2010 19:43:55 -0400
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tue, 3 Aug 2010 11:11:10 +0800
Roy Zang <tie-fei.zang@freescale.com> wrote:

> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -240,6 +240,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)

This becomes 1<<29 in my tree.

We're about to run out.  What happens then?
