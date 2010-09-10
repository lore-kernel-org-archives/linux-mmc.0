From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Remove distinction between hw and phys segments
Date: Fri, 10 Sep 2010 21:25:02 +0100
Message-ID: <20100910202502.GA2874@void.printf.net>
References: <yq1occ6qi0o.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53228 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab0IJUZD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 16:25:03 -0400
Content-Disposition: inline
In-Reply-To: <yq1occ6qi0o.fsf@sermon.lab.mkp.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-mmc@vger.kernel.org

Hi Martin,

On Fri, Sep 10, 2010 at 01:33:59AM -0400, Martin K. Petersen wrote:
> We have deprecated the distinction between hardware and physical
> segments in the block layer.  Consolidate the two limits into one in
> drivers/mmc/.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks, applied to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
