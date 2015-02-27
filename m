From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] mmc: mmc_oops: support mmc_oops feature
Date: Fri, 27 Feb 2015 09:31:22 +0100
Message-ID: <41342138.MjUK31a4Mt@wuerfel>
References: <1425015219-19849-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50428 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbbB0Ibg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 03:31:36 -0500
In-Reply-To: <1425015219-19849-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Friday 27 February 2015 14:33:39 Jaehoon Chung wrote:
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -68,3 +68,11 @@ config MMC_TEST
>  
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
> +
> +config MMC_OOPS
> +       tristate "Log panic/oops to a MMC buffer"
> +       depends on OF
> +       help
> +         This enables panic and oops messages to be logged to a circular
> +         buffer in a MMC sectors where it can be read back at some
> +         later point.
> 

This sounds a lot like the implementation should be using
the fs/pstore infrastructure like we do for ramoops, chromeos
and the EFI runtime services logger.

	Arnd
