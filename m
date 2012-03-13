From: joancarles <joancarles@fqingenieria.es>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Tue, 13 Mar 2012 12:20:12 +0100
Message-ID: <cab1626d3e00da738d95a7c4a9db0457@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <20120312214545.GC28087@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsd478-a03.servidoresdns.net ([82.223.190.30]:41930 "EHLO
	llsb708-a03.servidoresdns.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751363Ab2CMLUS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Mar 2012 07:20:18 -0400
In-Reply-To: <20120312214545.GC28087@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, shawn.guo@linaro.org, Hong-Xing.Zhu@freescale.com

>> >I'd recommend:
>> >
>> >git log v2.6.39.. drivers/mmc/host/sdhci-esdhc-imx.c
>>
>> I have been staring at those commits, however with very little
>> domain knowledge it's a shot in the dark.
>
> Have you tried copying sdhci-esdhc-imx.c from 2.6.39 to the current 
> kernel
> (might need some build fixes)? If that doesn't work, there might be 
> something
> wrong in the sdhci-driver itself, and not the esdhc-extension.

I have now, and it results in a bigger mess than I believe is worth 
pursuing for.

Therefore, I will create a stashing tree next to linux.git with our 
device specific changes (minimal setup for the PCB to boot up) that 
should theoretically apply to any kernel tree between 2.6.x and 3.3-rcX 
to subsequently bisect the biest.

Thanks for your help and best regards
-- 
Joan C. Abelaira

