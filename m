From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: Huge delay is seen when SD card is removed while
	transferring large media file
Date: Wed, 17 Nov 2010 16:56:53 +0000
Message-ID: <20101117165653.GA15735@void.printf.net>
References: <AANLkTimO5w4cH3f6m7-YR6XcEZESuWVvX19pk+H-PDcF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37069 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933859Ab0KQQ4y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Nov 2010 11:56:54 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimO5w4cH3f6m7-YR6XcEZESuWVvX19pk+H-PDcF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy <sujitreddy243@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Sujit,

On Wed, Nov 17, 2010 at 08:08:38PM +0530, Sujit Reddy wrote:
> Problem: There is a huge delay of ~20secs when the user get notified
> about the card removal. This delay depends on the size of the file to
> be transferred.
> 
> dmesg shows continuous I/O errors even after card removal notification
> (card xxxx removed in MMC layer)

You're right, we're not handling the card removal case as quickly as we
should.  We talked about this recently:

http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474

I'll add implementing Adrian's suggestion there to my workqueue.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
