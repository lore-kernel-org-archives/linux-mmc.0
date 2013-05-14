From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] mmc: core: Add a capability for disabling mmc cards
Date: Tue, 14 May 2013 12:50:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1305141246180.31158@syhkavp.arg>
References: <1368517100-22243-1-git-send-email-adam.lee@canonical.com> <20130514075333.GA22435@adam-laptop> <874ne5n6zv.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:51603 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3ENQun (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 12:50:43 -0400
Received: by mail-qa0-f49.google.com with SMTP id bs12so550084qab.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 May 2013 09:50:42 -0700 (PDT)
In-Reply-To: <874ne5n6zv.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, linux-mmc@vger.kernel.org

On Tue, 14 May 2013, Chris Ball wrote:

> Hi,
> 
> On Tue, May 14 2013, Adam Lee wrote:
> > On Tue, May 14, 2013 at 03:38:17PM +0800, Adam Lee wrote:
> >> On some systems we need a way to disable MMC card support in a MMC/SD
> >> card slot due to the legal concern.
> >> 
> >> Add support in the core SD/MMC code to support this.
> >
> > CC more addresses.
> >
> > Yes, this capability seems odd, but linux computer vendors need this to
> > avoid legal problems. Please review, thanks.
> 
> This has already been NACKed by Nicolas:
> 
> https://patchwork.kernel.org/patch/1359121/
> 
> (At least, I think it has -- your forward doesn't include the patch
> itself.)

I certainly did.  Technical amputations driven by legal stupidities 
don't belong in the mainline kernel.


Nicolas
