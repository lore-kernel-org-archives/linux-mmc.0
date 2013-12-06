From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/7] mmc: omap: Fixes, cleanup and add ERASE capability
Date: Fri, 06 Dec 2013 19:54:14 +0000
Message-ID: <52A22B66.8030402@bitmer.com>
References: <20131202193459.GL26766@atomide.com> <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com> <20131206134104.GJ30823@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48231 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758525Ab3LFRyY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Dec 2013 12:54:24 -0500
In-Reply-To: <20131206134104.GJ30823@blackmetal.musicnaut.iki.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jarkko Lavinen <j.lavinen@samsung.com>

On 12/06/2013 01:41 PM, Aaro Koskinen wrote:
>> Set goes on top of v3.13-rc2-208-g8ecffd791448.
> 
> Patch 5 had some fuzz with plain 3.13-rc2. Otherwise these look fine.
> I tested these on 770 and N800, so for all patches:
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
Yes, reason for your fuzz observation is that 3.13-rc2 don't have those
two patches from Tony but 8ecffd791448 had.

-- 
Jarkko
