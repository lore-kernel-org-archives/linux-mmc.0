From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 1/2] MMC: P2020 SDHC: Add support for 8-bit bus width and
 non-removable card
Date: Thu, 13 Jun 2013 11:17:59 -0700
Message-ID: <20130613181759.GA27040@teo>
References: <1371045205-3164-1-git-send-email-ogabbay@advaoptical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56403 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSSD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 14:18:03 -0400
Received: by mail-gh0-f174.google.com with SMTP id r17so1653457ghr.5
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 11:18:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371045205-3164-1-git-send-email-ogabbay@advaoptical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oded Gabbay <ogabbay@advaoptical.com>
Cc: cjb@laptop.org, shawn.guo@linaro.org, Chang-Ming.Huang@freescale.com, wfp5p@virginia.edu, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 12, 2013 at 04:53:25PM +0300, Oded Gabbay wrote:
> @@ -262,7 +288,23 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>  
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
> -	return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
> +	struct sdhci_host *host;
> +	int ret = 0;

No need for the 0 initializer.

Otherwise it looks OK, thanks!

Reviewed-by: Anton Vorontsov <anton@enomsg.org>
