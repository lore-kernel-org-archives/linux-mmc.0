From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-s3c: Use mmc_gpio_request_cd function
Date: Thu, 12 Dec 2013 11:02:11 +0100
Message-ID: <201312121102.12303.heiko@sntech.de>
References: <52A7FD6B.6090406@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51077 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab3LLKZb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Dec 2013 05:25:31 -0500
In-Reply-To: <52A7FD6B.6090406@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Am Mittwoch, 11. Dezember 2013, 06:51:39 schrieb Beomho Seo:
> This patch use mmc_gpio_request_cd function.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   56
> +++++++++++------------------------------- 1 file changed, 14
> insertions(+), 42 deletions(-)
> 

Acked-by: Heiko Stuebner <heiko@sntech.de>
on a s3c2416
Tested-by: Heiko Stuebner <heiko@sntech.de>


But it may be good to also include the linux-samsung list
(linux-samsung-soc@vger.kernel.org) in future submissions.


Heiko
