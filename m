From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
Date: Wed, 31 Mar 2010 15:02:00 +0200
Message-ID: <20100331130200.GC30801@buzzloop.caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
 <20100331123856.GW2241@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:44907 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348Ab0CaNCF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2010 09:02:05 -0400
Content-Disposition: inline
In-Reply-To: <20100331123856.GW2241@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Volker Ernst <volker.ernst@txtr.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Mar 31, 2010 at 02:38:56PM +0200, Sascha Hauer wrote:
> On Tue, Mar 30, 2010 at 08:31:59PM +0200, Daniel Mack wrote:
> > +			dev_err(mmc_dev(host->mmc),
> > +				"%s: read -ETIMEDOUT\n", __func__);
> >  			data->error = -ETIMEDOUT;
> >  		} else {
> > +			dev_err(mmc_dev(host->mmc), "%s: -EIO\n", __func__);
> 
> Do we really want to have these messages with dev_err? In the subject
> you are talking about debug output.

This _is_ definitely an error if get there, so I'll rather change the
commit message ;)

> 
> >  			data->error = -EIO;
> >  		}
> > -	} else {
> > +	} else
> >  		data->bytes_xfered = host->datasize;
> > -	}
> 
> Documentation/CodingStyle says that if braces are used in one branch of
> a conditional then they should be used in both branches.
> I personally don't care much about this statement but I think we should
> leave it as is. Otherwise some day someone wants to change it back
> according to the coding style.

Ok, true. I'll fix this (and the commit message) and resend.

Thanks,
Daniel
