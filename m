From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap: Fix a section warning regression
Date: Wed, 06 Jun 2012 09:45:04 -0400
Message-ID: <87ehps4krj.fsf@octavius.laptop.org>
References: <20120528065347.GR17852@atomide.com>
	<20120528082217.GI18918@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52534 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab2FFNpJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 09:45:09 -0400
In-Reply-To: <20120528082217.GI18918@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Mon, 28 May 2012 11:22:18 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, May 28 2012, Felipe Balbi wrote:
> On Sun, May 27, 2012 at 11:53:47PM -0700, Tony Lindgren wrote:
>> Commit b6e0703b (mmc: omap: make it behave well as a module) made some
>> __devinit changes but missed one function causing a section warning:
>> 
>> WARNING: vmlinux.o(.devinit.text+0x8604): Section mismatch in reference
>> from the function mmc_omap_probe)
>> The function __devinit mmc_omap_probe() references a function
>> __init mmc_omap_new_slot()
>> 
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
