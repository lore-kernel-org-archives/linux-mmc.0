From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 0/7] mmc: omap: Fixes, cleanup and add ERASE capability
Date: Fri, 6 Dec 2013 15:41:04 +0200
Message-ID: <20131206134104.GJ30823@blackmetal.musicnaut.iki.fi>
References: <20131202193459.GL26766@atomide.com>
 <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jarkko Lavinen <j.lavinen@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Dec 04, 2013 at 09:14:07PM +0000, Jarkko Nikula wrote:
> I've sent these patches earlier to linux-mmc list. This time set is one
> patch smaller since commit 31ee9181eb92
> ("mmc: omap: Fix DMA configuration to not rely on device id") does
> practically same what one of my patch did.
> 
> Patch 1 is an obvious fix. 2-4 are preparing for 5 which also should fix
> the error introduced by 31ee9181eb92:
> http://www.spinics.net/lists/linux-omap/msg100790.html
> 
> Patch 6 continue cleanup and 7 adds the ERASE capability to the driver so
> one could utilize discards with mkfs, mount option or with the fstrim.
> 
> Set goes on top of v3.13-rc2-208-g8ecffd791448.

Patch 5 had some fuzz with plain 3.13-rc2. Otherwise these look fine.
I tested these on 770 and N800, so for all patches:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
