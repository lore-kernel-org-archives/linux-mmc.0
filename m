From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patchv3 5/5] MMC: SDHCI AutoCMD23 support.
Date: Sun, 17 Apr 2011 19:25:10 +0200
Message-ID: <201104171925.10929.arnd@arndb.de>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com> <1302950458-1969-6-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55511 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1DQRZX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Apr 2011 13:25:23 -0400
In-Reply-To: <1302950458-1969-6-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, subhashj@codeaurora.org

On Saturday 16 April 2011, Andrei Warkentin wrote:
> @@ -68,6 +68,15 @@ config MMC_SDHCI_PCI
>  
>           If unsure, say N.
>  
> +config MMC_SDHCI_AUTO_CMD23
> +       tristate "SDHCI 3.0 Auto-CMD23 support (EXPERIMENTAL)"
> +       depends on MMC_SDHCI && EXPERIMENTAL
> +       help
> +         This enables the Auto-CMD23 optimization for multiblock
> +         transfers where a CMD23 would be sent
> +
> +         If unsure, say N.
> +
>  config MMC_RICOH_MMC
>         bool "Ricoh MMC Controller Disabler  (EXPERIMENTAL)"
>         depends on MMC_SDHCI_PCI

Does this need to be a Konfig option? We are already asking too many
questions here IMHO.

	Arnd
