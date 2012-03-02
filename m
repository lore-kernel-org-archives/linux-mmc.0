From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] Block: use a freezable workqueue for disk-event polling
Date: Fri, 02 Mar 2012 10:51:43 +0100
Message-ID: <4F50982F.7090301@kernel.dk>
References: <Pine.LNX.4.44L0.1202171615550.1194-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43864 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab2CBJwP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 04:52:15 -0500
In-Reply-To: <Pine.LNX.4.44L0.1202171615550.1194-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>, Steve French <sfrench@samba.org>, Chris Ball <cjb@laptop.org>, Jeff Layton <jlayton@poochiereds.net>, David Airlie <airlied@linux.ie>, David Howells <dhowells@redhat.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, linux-cifs@vger.kernel.org, linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org, keyrings@linux-nfs.org

On 02/17/2012 10:22 PM, Alan Stern wrote:
> This patch (as1519) fixes a bug in the block layer's disk-events
> polling.  The polling is done by a work routine queued on the
> system_nrt_wq workqueue.  Since that workqueue isn't freezable, the
> polling continues even in the middle of a system sleep transition.
> 
> Obviously, polling a suspended drive for media changes and such isn't
> a good thing to do; in the case of USB mass-storage devices it can
> lead to real problems requiring device resets and even re-enumeration.
> 
> The patch fixes things by creating a new system-wide, non-reentrant,
> freezable workqueue and using it for disk-events polling.

Thanks Alan, picked up.

-- 
Jens Axboe

