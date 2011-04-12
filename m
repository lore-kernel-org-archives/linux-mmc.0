From: Cyril Hrubis <metan-+ZI9xUNit7I@public.gmane.org>
Subject: Re: zaurus: mmcblk0: error -110
Date: Tue, 12 Apr 2011 21:39:44 +0200
Message-ID: <20110412193944.GC2665@atrey.karlin.mff.cuni.cz>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<m3aafvz30t.fsf@pullcord.laptop.org>
Reply-To: Zaurus PDA developers list <zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3aafvz30t.fsf-0VGQAjvlmrQzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/zaurus-devel>
List-Post: <mailto:zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/zaurus-devel>,
	<mailto:zaurus-devel-request-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
Errors-To: zaurus-devel-bounces-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zaurus-devel-cunTk1MwBs/k6gDgw6ADrEB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi!
> > When I insert the mmc card to zaurus, it gets properly detected and prints some
> > info into console. Mounting reading/writing files works fine.
> >
> > However when the card is removed (doesn't need to be mounted before), the
> > removal is most likely not detected, so when I insert it again, no info is
> > printed into console and moreover when I try to mount it zaurus goes into
> > infinite loop printing:
> >
> > Buffer I/O error on device mmcblk0p1, logical block 9
> > mmcblk0: error -110 sending status command
> > mmcblk0: error -110 sending read/write command, response 0xb00, card status 0xb00
> > end_request: I/O error, dev mmcblk0, sector 257
> > Buffer I/O error on device mmcblk0p1, logical block 10
> > ...
> >
> > Related part of the .config:
> >
> > #
> > # OTG and related infrastructure
> > #
> > # CONFIG_USB_GPIO_VBUS is not set
> > # CONFIG_USB_ULPI is not set
> > # CONFIG_NOP_USB_XCEIV is not set
> > CONFIG_MMC=y
> > # CONFIG_MMC_DEBUG is not set
> > CONFIG_MMC_UNSAFE_RESUME=y
> 
> Your symptoms match the bug that was fixed by:
> 
> bad3babace2ee4d ("mmc: fix CONFIG_MMC_UNSAFE_RESUME regression")
> 
> but this fix made it into 2.6.38, so if you're using 2.6.38 final then
> you shouldn't be seeing this.  Could you confirm that you have this
> patch?

It seems that the pxa tree I have is still based on 2.6.38-rc8.

And yes, turning CONFIG_MMC_UNSAFE_RESUME off seems to fix that problem.

I'll try to update the kernel tree and try again with CONFIG_MMC_UNSAFE_RESUME
enabled.

-- 
metan
