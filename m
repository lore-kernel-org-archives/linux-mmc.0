From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: sdhi / tmio: add DT DMA
Date: Sun, 26 May 2013 13:53:23 -0400
Message-ID: <87fvx9ljak.fsf@octavius.laptop.org>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Fri, 26 Apr 2013 17:47:16 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Apr 26 2013, Guennadi Liakhovetski wrote:
> These 3 patches add Device Tree DMA support to the TMIO MMC driver, when 
> used on SDHI platforms.
>
> Samuel: these patches touch an mfd header file lightly, I think, it's 
> better just to get your ack than to make a separate patch via your tree.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Guennadi Liakhovetski (3):
>   mmc: sdhi/tmio: make DMA filter implementation specific
>   mmc: sdhi/tmio: switch to using dmaengine_slave_config()
>   mmc: sdhi/tmio: add DT DMA support

Looks like this doesn't apply to mmc-next -- if you could prepare
current pull requests for 3.10 and 3.11 for me, I'd really appreciate
it.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
