From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Sat, 29 Sep 2012 13:07:30 +0200
Message-ID: <20120929110730.GA27797@liondog.tnic>
References: <cover.1347330871.git.wei_wang@realsil.com.cn>
 <50664814.30407@turmel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50664814.30407@turmel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Phil Turmel <philip@turmel.org>, wei_wang@realsil.com.cn, cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@arndb.de, oakad@yahoo.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 28, 2012 at 09:00:04PM -0400, Phil Turmel wrote:
> > Wei WANG (3):
> >   drivers/mfd: Add realtek pcie card reader driver
> >   drivers/mmc: Add realtek pcie sdmmc host driver
> >   drivers/memstick: Add realtek pcie memstick host driver
> 
> I have a recent HP Pavilion dv6 with this card reader, 10ec:5209
> (rev 01).  I just applied these patches on top of 3.6-rc7.  Appears
> to work properly with a SanDisk 8GB SDHC card.  I don't have a
> memstick to test.
> 
> For patches 1 & 2, feel free to add my:
> 
> Tested-by: Philip J. Turmel <philip@turmel.org>

Ok, good. Thanks for doing that.

So, I think that this driver has seen a bunch of testing and reviewing
and we might start considering upstreaming it. There are a bunch of
laptops integrating those readers and maybe a single three-month-ish -rc
period of testing wouldn't hurt before it appears upstream.

Now, AFAICT, there is another driver in staging which supports the same
or a subset of the cardreaders this driver does so I don't know what
Realsil want to do with that. Wei?

And since this driver touches multiple drivers/{mfd,mmc,memstick}
subdirs, maybe akpm would like to merge it? At least I haven't seen any
other maintainers complaining about its design or wanting to take it so
...

Thanks.

-- 
Regards/Gruss,
    Boris.
