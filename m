From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: use clk_prepare_enable and clk_disable_unprepare
Date: Tue, 23 Oct 2012 17:10:02 -0400
Message-ID: <87txtkhp3p.fsf@octavius.laptop.org>
References: <1349220943-2636-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56675 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933724Ab2JWVKH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:10:07 -0400
In-Reply-To: <1349220943-2636-1-git-send-email-thomas.abraham@linaro.org>
	(Thomas Abraham's message of "Wed, 3 Oct 2012 08:35:43 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org

Hi,

On Tue, Oct 02 2012, Thomas Abraham wrote:
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
