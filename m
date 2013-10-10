From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: help with 'discard' mount option on eMMC
Date: Thu, 10 Oct 2013 09:40:25 +0000 (UTC)
Message-ID: <loom.20131010T112824-880@post.gmane.org>
References: <loom.20131010T083357-685@post.gmane.org> <52566B05.3000204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54753 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab3JJJkr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Oct 2013 05:40:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VUCje-0005qq-4J
	for linux-mmc@vger.kernel.org; Thu, 10 Oct 2013 11:40:46 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 11:40:46 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 11:40:46 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


> Hello,
> Could you please post kernel log of such failure?
> What hw are you using?
I'm using sdhci controller. Hynix eMMC4.41. Linux Kernel 3.4.5
There are no kernel log failures as such.

If i add print while sending CMD38 when 'discard' mount option is specified,
then CMD38 with Arg 1 are continuously sent.
After 5 secs, when reboot command is issued, the partitions are remounted as
RO and CMD38 stops! 
After shutdown, while booting up, files are getting corrupted. I'm checking
log file in /data/system/uiderrors.txt :-
10/9/13 12:32 PM: Error reading settings:
org.xmlpull.v1.XmlPullParserException: name expected (position:START_TAG
<pa>@791:65540 in java.io.InputStreamReader@42150148)
If i check the file where read error happened, there is a big chunk of
ZERO's in the file.
I'm thinking, eMMC has erased, but ext4 meta data is not updated?? (or) 
Do we need to have BKOPS in eMMC and wait for BKOPS to complete before
shutting down? (Or) 
Is it necessary to provide clock for some more time during shutdown so as
eMMC completes internal operations with that clock?

I'm thinking what could be possibly going wrong or what extra needs to be
taken care of?



