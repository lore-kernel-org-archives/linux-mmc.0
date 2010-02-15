From: =?utf-8?b?Sm9zw6k=?= Miguel =?utf-8?b?R29uw6dhbHZlcw==?=
	<jose.goncalves@inov.pt>
Subject: Re: stalled mmc patches
Date: Mon, 15 Feb 2010 14:30:37 +0000 (UTC)
Message-ID: <loom.20100215T152610-631@post.gmane.org>
References: <20090929131540.27d72d52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35798 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab0BOOzI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Feb 2010 09:55:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Nh2Lp-0002HJ-5Y
	for linux-mmc@vger.kernel.org; Mon, 15 Feb 2010 15:55:05 +0100
Received: from gtout2.inov.pt ([146.193.64.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 15:55:05 +0100
Received: from jose.goncalves by gtout2.inov.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 15:55:05 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Andrew Morton <akpm <at> linux-foundation.org> writes:

> 
> 
> Guys, I'm still sitting on four patches which varius people have (or
> had) objections to.  
> 
> Could we please revisit these and provide advice on how to proceed? 
> Thanks.
> 
...
> 
>
http://userweb.kernel.org/~akpm/mmotm/broken-out/sdio-recognize-io-card-without-powercycle.patch

Just to tell that this patch solved me a similar problem with a Silex's SX-SDWAG
SDIO Wi-Fi card:

http://lists.infradead.org/pipermail/linux-arm/2010-February/000136.html



