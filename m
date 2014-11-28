From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/4] mmc: atmel-mci: remove __init/__exit attributes
Date: Fri, 28 Nov 2014 14:16:51 +0000
Message-ID: <20141128141651.GS3836@n2100.arm.linux.org.uk>
References: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
 <1417183686-31481-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39010 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaK1OTE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 09:19:04 -0500
Content-Disposition: inline
In-Reply-To: <1417183686-31481-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, arnd@arndb.de

On Fri, Nov 28, 2014 at 03:08:04PM +0100, Ludovic Desroches wrote:
> Using __init/__exit attributes can cause several breakages so remove
> them.

I've really no idea why people jump overboard with these things - it
seems people go from one extreme to the other (adding lots of __init /
__exit annotations everywhere to removing them all), but:

> @@ -2573,12 +2573,12 @@ static struct platform_driver atmci_driver = {
>  	},
>  };
>  
> -static int __init atmci_init(void)
> +static int atmci_init(void)
>  {
>  	return platform_driver_probe(&atmci_driver, atmci_probe);
>  }
>  
> -static void __exit atmci_exit(void)
> +static void atmci_exit(void)
>  {
>  	platform_driver_unregister(&atmci_driver);
>  }

These last two are totally fine to leave there.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
