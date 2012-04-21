From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/8] mmc: omap_hsmmc: release correct resource
Date: Fri, 20 Apr 2012 22:35:59 -0400
Message-ID: <871unhhkvk.fsf@laptop.org>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
	<E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk>
	<20120420222305.GI21106@atomide.com> <878vhqggbc.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42671 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab2DUCfr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Apr 2012 22:35:47 -0400
In-Reply-To: <878vhqggbc.fsf@laptop.org> (Chris Ball's message of "Fri, 20 Apr
	2012 18:59:51 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 20 2012, Chris Ball wrote:
> On Fri, Apr 20 2012, Tony Lindgren wrote:
>> * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
>>> res can be one of several resources, as this variable is re-used several
>>> times during probe.  This can cause the wrong resource parameters to be
>>> passed to release_mem_region().
>>> 
>>> Get the original memory resource before calling release_mem_region().
>>> 
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Thanks, pushed to mmc-next for 3.4.

(Actually, that's premature of me, sorry -- just noticed that this
is part of an RFC patchset.  I'll wait for the rest of the patches.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
