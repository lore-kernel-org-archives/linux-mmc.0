From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 08:55:26 -0400
Message-ID: <87sjdnjykh.fsf@octavius.laptop.org>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60995 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761693Ab2FVMzb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jun 2012 08:55:31 -0400
In-Reply-To: <CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
	(T. Krishnamoorthy's message of "Fri, 22 Jun 2012 17:59:42 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Hi,

On Fri, Jun 22 2012, T Krishnamoorthy, Balaji wrote:
> On Fri, Jun 22, 2012 at 4:19 PM, Ming Lei <ming.lei@canonical.com> wrote:
>> This patch reverts the commit dba3c29ea4a1d5d544.
>>
>> After bisecting, this commit dba3c29 is found to ruin micro-SD card data
>> (writing incorrect file, or fs is corrupt after several times mount)
>> on the beagle-xm revB, and reverting the commit will fix the problem.
>
> Hi Ming,
> Rather than reverting the entire commit,
> Can you try with the below change alone, so that AutoCMD12 can be easily
> enabled back when needed.
>
> @@ -1859,7 +1859,6 @@ static int __devinit omap_hsmmc_probe(st
>  	host->mapbase	= res->start + pdata->reg_offset;
>  	host->base	= ioremap(host->mapbase, SZ_4K);
>  	host->power_mode = MMC_POWER_OFF;
> -	host->flags	= AUTO_CMD12;
>  	host->next_data.cookie = 1;
>
>  	platform_set_drvdata(pdev, host);

I'm not totally comfortable with that; seems like it should be harder
to cause data corruption than turning on a single flag in the host.

The full revert is probably best until we know what the underlying
bug is, and how to disable AUTO_CMD12 on all affected systems.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
