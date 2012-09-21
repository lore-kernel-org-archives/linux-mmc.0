From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Fri, 21 Sep 2012 02:49:03 -0400
Message-ID: <m37grng9b4.fsf@pullcord.laptop.org>
References: <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
	<1348206128-11083-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56326 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab2IUGsj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Sep 2012 02:48:39 -0400
In-Reply-To: <1348206128-11083-1-git-send-email-chander.kashyap@linaro.org>
	(Chander Kashyap's message of "Fri, 21 Sep 2012 11:12:08 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org, Chander Kashyap <chander.kashyap@gmail.com>

Hi Chander,

On Fri, Sep 21 2012, Chander Kashyap wrote:
> From: Chander Kashyap <chander.kashyap@gmail.com>
>
> Perform clock disable/enable in runtime suspend/resume.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog:
> v2:
> - Wrapped clk_disable in probe and clk_enable in remove with
>   #ifdef CONFIG_PM_RUNTIME conditional check.

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
