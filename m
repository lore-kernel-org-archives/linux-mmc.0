From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 09/30] mmc: sdhci-s3c: remove platform dependencies
Date: Wed, 10 Apr 2013 21:06:18 -0400
Message-ID: <877gk9j2ph.fsf@octavius.laptop.org>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
	<1365638712-1028578-10-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37378 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935469Ab3DKBG0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Apr 2013 21:06:26 -0400
In-Reply-To: <1365638712-1028578-10-git-send-email-arnd@arndb.de> (Arnd
	Bergmann's message of "Thu, 11 Apr 2013 02:04:51 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 10 2013, Arnd Bergmann wrote:
> plat/regs-sdhci.h is not used anywhere but in the sdhci-s3c
> driver, so it can become a local file there and all other
> inclusions removed.
>
> plat/sdhci.h is used only to define the platform devices,
> and with the exception of the platform_data structure not
> needed by the driver, so we can split out the platform_data
> definition instead and leave the rest to platform code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mmc@vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
