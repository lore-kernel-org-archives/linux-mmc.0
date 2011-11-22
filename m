From: David Taylor <dmtaylor@skytex.net>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Tue, 22 Nov 2011 20:18:31 +0000 (UTC)
Message-ID: <loom.20111122T210615-276@post.gmane.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47733 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab1KVVkJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Nov 2011 16:40:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1RSy4W-0005nO-11
	for linux-mmc@vger.kernel.org; Tue, 22 Nov 2011 22:40:08 +0100
Received: from 192.94.92.11 ([192.94.92.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2011 22:40:08 +0100
Received: from dmtaylor by 192.94.92.11 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2011 22:40:08 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Sujit Reddy Thumma <sthumma <at> codeaurora.org> writes:

> 
> Kill block requests when the host knows that the card is
> removed from the slot and is sure that subsequent requests
> are bound to fail. Do this silently so that the block
> layer doesn't output unnecessary error messages.
> 
> This patch implements suggestion from Adrian Hunter,
> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma <at> codeaurora.org>
> ---
>  drivers/mmc/card/queue.c |    5 +++++
>  drivers/mmc/core/bus.c   |    2 ++
>  include/linux/mmc/card.h |    3 +++
>  3 files changed, 10 insertions(+), 0 deletions(-)
> 

Thanks, this patch worked nicely to control a seemingly endless series of 
driver complaints when the SD card was removed during a transfer.

The OMAP4 I'm working on has hardware assisted detection of card removal, and 
this patch looks like it will be sufficient.

