From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test mmc0:0001: Can't create file. Perhaps debugfs is
	disabled
Date: Tue, 4 Jan 2011 18:01:13 +0000
Message-ID: <20110104180113.GA17407@void.printf.net>
References: <4D11E833.7000506@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38747 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1ADSBP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 13:01:15 -0500
Content-Disposition: inline
In-Reply-To: <4D11E833.7000506@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: linux-mmc@vger.kernel.org, Shiraz HASHIM <shiraz.hashim@st.com>

Hi Viresh,

On Wed, Dec 22, 2010 at 05:29:47PM +0530, viresh kumar wrote:
> I am using mmc_test.c driver present in drivers/mmc/test.c
> 
> Whenever i insert my card after booting linux i get this error:
> "mmc_test mmc0:0001: Can't create file. Perhaps debugfs is disabled"
> 
> I debugged a bit and found something strange. In file drivers/mmc/core/bus.c
> following code is present.
> 
> int mmc_add_card(struct mmc_card *card)
> {
> ...
> 
> 	ret = device_add(&card->dev);
> 	if (ret)
> 		return ret;
> 
> #ifdef CONFIG_DEBUG_FS
> 	mmc_add_card_debugfs(card);
> #endif
> 
> ...
> }
> 
> After device_add is called mmc_test_register_file_test routine (present in mmc_test.c) is
> called and it tries to add "test" file inside card->debugfs_root directory.
> 
> But this directory is not actually present till the time mmc_add_card_debugfs() is called,
> which actually creates it.
> 
> reversing the sequence of above routines seems to solve this issue.
> I am not sure if i am doing something wrong or it is actually a bug.

Thanks, I've reproduced this now.  It's a bug.  The reason I hadn't seen
it before is that my workflow is always to insert a card, then rmmod
mmc_block && modprobe mmc_test -- this works because the debugfs dir is
created late on the initial insertion, but still before mmc_test loads.
I compiled a kernel with MMC and mmc_test built in, and no mmc_block
support, and hit your bug.  

Here's your patch: could you send a Signed-off-by: line for it, please?

From: Viresh Kumar <viresh.kumar@st.com>
Date: Tue, 4 Jan 2011 12:55:14 -0500
Subject: [PATCH] mmc: register debugfs dir before calling card probe function

This way, the probe function may register debugfs files if it wants to.

This fixes a bug with mmc_test where mmc_test_register_file_test() is
called before the card's debugfs dir exists, and so it fails.
---
 drivers/mmc/core/bus.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index af8dc6a..63667a8 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -303,14 +303,14 @@ int mmc_add_card(struct mmc_card *card)
 			type, card->rca);
 	}
 
-	ret = device_add(&card->dev);
-	if (ret)
-		return ret;
-
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
 
+	ret = device_add(&card->dev);
+	if (ret)
+		return ret;
+
 	mmc_card_set_present(card);
 
 	return 0;
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
