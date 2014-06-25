From: Derek Simkowiak <derek@webtuner.tv>
Subject: Seeking correct git repo
Date: Wed, 25 Jun 2014 12:28:57 -0700
Message-ID: <53AB22F9.40503@webtuner.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:17945
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbaFYT3B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 15:29:01 -0400
Received: from mail88-ch1 (localhost [127.0.0.1])	by mail88-ch1-R.bigfish.com
 (Postfix) with ESMTP id D4BF24601CE	for <linux-mmc@vger.kernel.org>; Wed, 25
 Jun 2014 19:29:00 +0000 (UTC)
Received: from CH1EHSMHS039.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail88-ch1.bigfish.com (Postfix) with ESMTP id 4A83A480091
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2014 19:28:59 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

      Hello,
A while ago, Romain wrote a small eMMC 5.0 patch that Ulf ack'd:

http://comments.gmane.org/gmane.linux.kernel.mmc/23795

I need this patch for my hardware.  But I don't see this patch in Linux 
stable (even though there are more recent patches from Seungwon Jeon in 
there), and I don't see it at the MMC repo either:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

# Where's the patch? I checked all branches...

$ git branch -a
* master
   remotes/origin/HEAD -> origin/master
   remotes/origin/master
   remotes/origin/mmc-next
   remotes/origin/mmc-updates-for-3.16-rc1-merged


Can you please tell me, what is the repo and branch where this patch was 
submitted?  The only reference I have to this patch is the email archive 
at the URL above.


Thank You,
Derek

