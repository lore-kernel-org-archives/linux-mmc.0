From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Thu, 17 Aug 2017 21:34:14 +0800
Message-ID: <20170817133413.GD7608@dragon>
References: <1502845901-163345-1-git-send-email-shawn.lin@rock-chips.com>
 <20170817104047.ikfljcrggl2ncxqv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751585AbdHQNfz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Aug 2017 09:35:55 -0400
Content-Disposition: inline
In-Reply-To: <20170817104047.ikfljcrggl2ncxqv@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Thu, Aug 17, 2017 at 12:40:47PM +0200, Wolfram Sang wrote:
> Hi Shawn,
> 
> On Wed, Aug 16, 2017 at 09:11:41AM +0800, Shawn Lin wrote:
> > We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
> > mode as it is expected behaviour and most of the backup partition
> > tables should be located near some of the last blocks which will
> > always make open-ending read exceed the capacity of cards.
> > 
> > Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
> > Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands")
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > Tested-by: Shawn Guo <shawnguo@kernel.org>
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I'd think these Tested-by should be dropped. We changed the patch quite
> a bit meanwhile and I am quite sure Shimoda-san didn't test this new
> version of the patch. Dunno about Shawn. Hopefully they have time to
> re-test?

I just re-tested it on Hikey, so my Tested-by tag can be kept.

Shawn
