From: Greg KH <greg@kroah.com>
Subject: Re: char interface to sdio, chdio.c
Date: Thu, 17 Jul 2014 20:08:41 -0700
Message-ID: <20140718030841.GB13619@kroah.com>
References: <20140716032655.GB30412@kroah.com>
 <53C705DB.3040700@codeaurora.org>
 <20140717053347.GB22970@kroah.com>
 <7228146.FsqiNq1Vpj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7228146.FsqiNq1Vpj@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Alexander Kolesnikov <akolesni@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 17, 2014 at 12:17:00PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 July 2014 22:33:47 Greg KH wrote:
> > + mmc: Char SDIO Device Driver
> 
> A few comments on the ioctl interface, since I suppose we'll have
> to live with that once it gets merged.

Thanks for the review comments.  I'll come back to this in a week or so
when I get more cycles to spend on the driver, it's _way_ down my list
of priorities at the moment.

greg k-h
