From: Matt Fleming <matt@console-pimps.org>
Subject: Re: V3 - mmc and omap_hsmmc patches
Date: Sat, 12 Sep 2009 10:49:37 +0100
Message-ID: <20090912094936.GB21695@console-pimps.org>
References: <004e01ca3239$14eb9ab0$544ff780@am.dhcp.ti.com>
 <4AA9FA4D.7060701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AA9FA4D.7060701@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan <madhu.cr@ti.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 11, 2009 at 10:20:45AM +0300, Adrian Hunter wrote:
> Madhusudhan wrote:
> > Hi Adrian,
> > 
> >> [PATCH V3 0/30] mmc and omap_hsmmc patches
> > 
> > What is the reason for V3? What is the difference between V2 and V3 series?
> 
> The reason for V3 is that the SD-only and MMC-only host capability patches were
> not wanted.
> 
> The difference is that patches originally numbered 0007 and 0027 were dropped
> and the rest re-rolled.
> i.e.
> 
> 	Subject: [PATCH V2 7/32] mmc: add host capabilities for SD only and MMC only
> 	File: 0007-mmc-add-host-capabilities-for-SD-only-and-MMC-only.patch
> 
> 	Subject: [PATCH V2 27/32] omap_hsmmc: pass host capabilities for SD only and MMC only
> 	File: 0027-omap_hsmmc-pass-host-capabilities-for-SD-only-and-M.patch
> 
> were removed.
> 
> 

I think my Reviewed-by can just be carried forward if this is a simple
re-rolling. Though if for some reason they need reviewing again just
nudge me.
