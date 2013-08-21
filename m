From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] mmc: sdhci-bcm-kona: '|' vs '&' typo
Date: Wed, 21 Aug 2013 12:14:07 +0300
Message-ID: <20130821091407.GX4713@mwanda>
References: <20130821082423.GA5240@elgon.mountain>
 <52148115.3050703@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45298 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3HUJO0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 05:14:26 -0400
Content-Disposition: inline
In-Reply-To: <52148115.3050703@bfs.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: walter harms <wharms@bfs.de>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Christian Daudt <csd@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Aug 21, 2013 at 10:57:57AM +0200, walter harms wrote:
> 
> 
> Am 21.08.2013 10:24, schrieb Dan Carpenter:
> > The intent was to test if a flag was set.  In the current code the
> > conditions are always true.
> 
> I guess that it worked before ...
> That leaves the Question: are the tests needed at all ?

It's flagging everything as broken, and I presume that isn't good.
But on the other hand, these changes do occasionally break things
because now a lot of new untested code is used.  It really is a good
idea for someone to test this.

> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Static checker stuff.  Untested.

regards,
dan carpenter

