From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] mmc, sdhci, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Wed, 24 Sep 2014 11:22:50 +0200
Message-ID: <5774775.2EcFmuR4sV@wuerfel>
References: <20140923212922.GG12270@beef> <1411512908-19237-1-git-send-email-behanw@converseincode.com> <1411512908-19237-2-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58828 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaIXJW7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Sep 2014 05:22:59 -0400
In-Reply-To: <1411512908-19237-2-git-send-email-behanw@converseincode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: behanw@converseincode.com
Cc: bcm@fixthebug.org, chris@printf.net, gnurou@gmail.com, linus.walleij@linaro.org, mporter@linaro.org, ulf.hansson@linaro.org, bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rjui@broadcom.com

On Tuesday 23 September 2014 15:55:08 behanw@converseincode.com wrote:
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -225,7 +225,7 @@ static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
>                 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  };
>  
> -static struct __initconst of_device_id sdhci_bcm_kona_of_match[] = {
> +static struct of_device_id const sdhci_bcm_kona_of_match[] = {
>         { .compatible = "brcm,kona-sdhci"},
>         { .compatible = "bcm,kona-sdhci"}, /* deprecated name */
>         {}
> 

Sorry for giving you trouble over such a simple patch (especially
one that I have acked already), but I just noticed that this is
not following the common style we use in the kernel.

Almost everywhere in Linux, we use

static const struct of_device_id sdhci_bcm_kona_of_match[] = {

not

static struct of_device_id const sdhci_bcm_kona_of_match[] = {

AFAICT they behave in identical ways, but the first one seems
easier to read for someone familiar with kernel code.

	Arnd
