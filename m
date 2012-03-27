From: joancarles <joancarles@fqingenieria.es>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 12:56:31 +0200
Message-ID: <137e8b8e079af62aea2fd4d363be6273@mail.fqingenieria.es>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de> <20120327110615.3bfaf969@eb-e6520>
 <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
 <20120327114048.6af2e178@eb-e6520>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa731-a03.servidoresdns.net ([82.223.190.25]:32866 "EHLO
	llsa987-a03.servidoresdns.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750707Ab2C0K4k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 06:56:40 -0400
In-Reply-To: <20120327114048.6af2e178@eb-e6520>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

>> Might be unrelated, however I have been keeping my eyes on the fix 
>> of
>> ENGcm07207 quirk introduced with 16a790bcc. According to the
>> IMX25CE.pdf, to abort data transfers on the AHB, software can reset 
>> the
>> eSDHC by writing 1 to SYSCTL[24] (RSTA), which currently is not done
>> with SDHCI_QUIRK_NO_MULTIBLOCK. It sets the max_blk_count to 1 
>> instead
>> of 65535. Not sure if this is also limiting the speed.
>>
> I tried to increase max_blk_count and it breaks after a few tests.

I will redo your tests in a jiffy, however the latency issues worry me 
a wee bit.

> Using an oscilloscope it seems we have a big latency between each
> transfer which could explain the low throughput, I didn't have the
> time to look deeper at this problem.

The latency we can see here in the oscilloscope is tremendous between 
two CMD24: 8ms! What is causing this? It is certainly unrelated to the 
MULTIBLOCK feature. Having a clock at 33.25MHz, our maximal read, as 
confirmed by dd is:

33.25[MHz] * 4[bits data] / 8[bits/Byte] * 30 [us write] / 8000 [us 
sleep] =~ 60KB/s

So, what's keeping the driver 8ms from sending the data??? Any pointers 
on where I could twiddle some bits in the driver? Where do I start 
looking?

Cheers
-- 
Joan C. Abelaira

