From: joancarles <joancarles@fqingenieria.es>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Wed, 28 Mar 2012 16:01:46 +0200
Message-ID: <cb665484c55065958358acb4fd91bbdb@mail.fqingenieria.es>
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
 <137e8b8e079af62aea2fd4d363be6273@mail.fqingenieria.es>
 <c4306c7d39eac8f1751957eefe20a6c2@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa736-a03.servidoresdns.net ([82.223.190.27]:49497 "EHLO
	llsa735-a03.servidoresdns.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752788Ab2C1OBy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 10:01:54 -0400
In-Reply-To: <c4306c7d39eac8f1751957eefe20a6c2@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: =?UTF-8?Q?Eric_B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> Anybody with more insights? Why is the interval between two CMD24
> more or less in the range of 6ms and the CMD13 follows in varying
> intervals between 1ms to 4ms? What's keeping the driver from bursting
> CMD24 and successive CMD13 requests?

A 4*128KB dd run shows the following patterns of latency between 
various CMDs issued:

http://i43.tinypic.com/2bcmsw.png

The latency distribution is plotted here:

http://i41.tinypic.com/9gvbqo.png

bin limits	freq count	pct
<0ms	0	0.0%
<1ms	922	43.6%
<6ms	491	23.2%
<10ms	411	19.4%
<20ms	113	5.3%
<100ms	163	7.7%
<300ms	9	0.4%
<1000ms	7	0.3%

It took 25 seconds to write 4*128KB to the SD-card using the current 
drivers. More than 50% of the CMD requests issued take more than 1ms 
from issuing to response between the host and the card. Anybody else 
with this issue on the i.MX25? How can I pinpoint this down to the 
culprits in the kernel source?

Regards
-- 
Joan C. Abelaira
