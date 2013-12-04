From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: *** GMX Spamverdacht ***  re: mmc: sh_mmcif: remove now
 superfluous sh_mmcif_host::data member
Date: Wed, 4 Dec 2013 10:55:04 +0300
Message-ID: <20131204075504.GQ5443@mwanda>
References: <20131106161603.GI15603@elgon.mountain>
 <Pine.LNX.4.64.1312032246450.22366@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22780 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab3LDHzN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 02:55:13 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1312032246450.22366@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

On Tue, Dec 03, 2013 at 10:48:58PM +0100, Guennadi Liakhovetski wrote:
> > 
> > We used to assume that host->data might be NULL but that mrq->data was
> > a valid pointer.  But now they are unified into one pointer.
> 
> Yes, formally this isn't correct, but in practice this is valid, because 
> for those two opcodes, handled in this "if" data cannot be NULL.
> 

Fine fine.  I suspected it might be something like that.  We only send
the warning messages one time so no worries.

regards,
dan carpenter
