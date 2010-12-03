From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v3 2/3]set timeout control reg for such SDHCI host
Date: Fri, 3 Dec 2010 10:38:59 +0800
Message-ID: <5D8008F58939784290FAB48F54975198320B3E41F7@shsmsx502.ccr.corp.intel.com>
References: <20101202112613.GC10358@intel.com>
 <20101202115329.GE3345@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4318 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757726Ab0LCCjF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 21:39:05 -0500
In-Reply-To: <20101202115329.GE3345@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>, "prakity@marvell.com" <prakity@marvell.com>

 > 
> On Thu, Dec 02, 2010 at 07:26:13PM +0800, Chuanxiao Dong wrote:
> 
> > +	if (host->quirks & SDHCI_QUIRK_FORCE_ERASE_SINGLE) {
> > +		/* Set the timeout to be the maximum value */
> > +		if (cmd->erase_timeout)
> > +			sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
> > +	}
> > +
> >  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
> > SDHCI_COMMAND);
> 
> Hmm, this looks like another argument for Philip's idea to always use the maximum
> timeout value and skip the quirks related to it?

Yes, if always using the maximum timeout value is OK for other command, the patch2 can be removed I think.
The new added quirk in the serials patches is used to set the limitation of request queue, not only just to set the timeout control reg.
Even the timeout value was set to be 0xE (the maximum value), erasing too many sectors can still be failed since the timeout time was still not longer enough.
So the count of erased sectors passed down by request queue should be reduced by using this quirk.

