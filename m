From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Tue, 19 Jun 2012 11:34:56 +0200
Message-ID: <5753942.6DRRAABTSC@avalon>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <Pine.LNX.4.64.1206150907110.11729@axis700.grange> <CANqRtoQD+sneTT7tCYji7YGpX5eJEQrWCQoX8jWJ1hiChjFh_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56747 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2FSJer (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jun 2012 05:34:47 -0400
In-Reply-To: <CANqRtoQD+sneTT7tCYji7YGpX5eJEQrWCQoX8jWJ1hiChjFh_g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 19 June 2012 15:53:30 Magnus Damm wrote:
> On Fri, Jun 15, 2012 at 4:09 PM, Guennadi Liakhovetski wrote:
> > On Fri, 15 Jun 2012, Magnus Damm wrote:
> > 
> > [snip]
> > 
> >> Guennadi, does this trigger on sh7372 as well? If not, why is that?
> > 
> > No. That message is produced by the sh_mobile_sdhi_wait_idle() function,
> > which is only used, if the TMIO_MMC_HAS_IDLE_WAIT flag is set, which is
> > not set on mackerel (or ap4evb).
> 
> Ok, thanks for checking this. It seems that we are "lucky" to find
> this breakage...
> 
> In the future, please take care to make sure this does not happen
> again. This goes without saying, but the driver should not access the
> hardware when it is Runtime PM suspended. I believe it should be
> possible to verify the code paths by manual code inspection. Also, to
> make the behavior more consistent you may want to make use of
> "pm_runtime_put_sync()" instead of "pm_runtime_put()".

For testing that's a good idea. That makes me wonder whether we should have a 
Kconfig option to turn all pm_runtime_put() into pm_runtime_put_sync() for 
stress-testing.

-- 
Regards,

Laurent Pinchart

