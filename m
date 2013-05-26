From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH -next] mmc: mxs-mmc: fix error return code in mxs_mmc_probe()
Date: Sun, 26 May 2013 13:29:25 -0400
Message-ID: <8761y5r6oa.fsf@octavius.laptop.org>
References: <CAPgLHd8+rdPX-B8raEjF0ygrG1QC2OFkuTzXw1eeaWsO0dHmcg@mail.gmail.com>
	<201304191407.33143.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38823 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592Ab3EZR3a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:29:30 -0400
In-Reply-To: <201304191407.33143.marex@denx.de> (Marek Vasut's message of
	"Fri, 19 Apr 2013 14:07:32 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, grant.likely@linaro.org, rob.herring@calxeda.com, shawn.guo@linaro.org, fabio.estevam@freescale.com, broonie@opensource.wolfsonmicro.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi,

On Fri, Apr 19 2013, Marek Vasut wrote:
> Dear Wei Yongjun,
>
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> Fix to return -ENODEV in the request dma error case instead
>> of 0, as done elsewhere in this function.
>> 
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Seems ok to me.
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
