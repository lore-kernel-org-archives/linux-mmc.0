From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/6 v3] mmc: tmio: implement SDIO IRQ
Date: Wed, 5 Jan 2011 22:10:03 +0000
Message-ID: <20110105221003.GL9198@void.printf.net>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-2-git-send-email-arnd@arndnet.de> <20110105205717.GG9198@void.printf.net> <Pine.LNX.4.64.1101052203090.5375@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101052203090.5375@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Hannemann <arnd@arndnet.de>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jan 05, 2011 at 10:09:42PM +0100, Guennadi Liakhovetski wrote:
> > -			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
> > -				sdio_status, sdio_irq_mask, sdio_ireg);
> > +			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! "
> > +				   "0x%04x 0x%04x 0x%04x\n",
> > +				   sdio_status, sdio_irq_mask, sdio_ireg);
> 
> Don't think this is a good idea. 80-columns restriction stopped being a 
> requirement since some time, and - it has always been explicitly requested 
> _not_ to break strings in prints because of this. Yes, it is not very 
> likely, that someone will grep for "IRQ.*\%" or similar, still, I would 
> prefer to keep the original version.

Okay, I'll use the original version of the pr_warning().

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
