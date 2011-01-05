From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio_mmc: fix PIO fallback on DMA descriptor
	allocation failure
Date: Wed, 5 Jan 2011 19:42:09 +0000
Message-ID: <20110105194209.GB9198@void.printf.net>
References: <Pine.LNX.4.64.1011111215120.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011111215120.15747@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Thu, Nov 11, 2010 at 12:19:47PM +0100, Guennadi Liakhovetski wrote:
> The easiest way to fall back to PIO, when a DMA descriptor allocation fails is
> to disable DMA on the controller but continue with the current request in PIO
> mode. This way tmio_mmc_start_dma() can become void, since it cannot be failing
> any more. The current version is also broken: it is testing a wrong 
> pointer and thus failing to recognise, that a descriptor allocation wasn't 
> successful.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for .38.  I wrapped the commit message back
to 72 chars, so that it doesn't overflow when running "git log" on an
80-char term.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
