From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [GIT PULL] MMC updates for 3.7-rc1
Date: Tue, 09 Oct 2012 09:12:12 +0530
Message-ID: <1349754132.1648.5253.camel@vkoul-udesk3>
References: <87a9vxdsia.fsf@octavius.laptop.org>
	 <87pq4sco5i.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26047 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163Ab2JIDvI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Oct 2012 23:51:08 -0400
In-Reply-To: <87pq4sco5i.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, 2012-10-08 at 23:36 -0400, Chris Ball wrote:
> Hi Linus,
> 
> On Mon, Oct 08 2012, Chris Ball wrote:
> > Please pull from:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-merge-for-3.7-rc1
> >
> > to receive the MMC merge for 3.7.  There are currently two conflicts
> > due to header renames for the ARM single zImage work; they should be
> > resolved by taking the changes already in your tree.  Thanks.
> 
> Sorry, the merge isn't so one-sided -- here's my resolution for you to
> compare with:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git tags/mmc-merge-for-3.7-rc1-merged
> 
> davinci_mmc.c now uses <linux/edma.h> which is provided by a commit
> in the slave-dmaengine tree, which hasn't sent in a pull request yet.
> Vinod, please can you do that soon?
...just finished sending the request.
> 
> Let me know if I should do anything else.  Thanks,
> 
> - Chris.


-- 
~Vinod

