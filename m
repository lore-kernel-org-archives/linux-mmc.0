From: Mitch Bradley <wmb@laptop.org>
Subject: SD cards die when power is removed
Date: Wed, 15 Sep 2010 19:25:57 -1000
Message-ID: <4C91AA65.5080802@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from solarsail.media.mit.edu ([18.85.2.155]:52378 "EHLO
	solarsail.media.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0IPFcC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2010 01:32:02 -0400
Received: from [10.20.0.14] (user-118btu4.cable.mindspring.com [66.133.247.196])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by solarsail.media.mit.edu (Postfix) with ESMTPSA id 48D567BC57D
	for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2010 01:26:00 -0400 (EDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

  At One Laptop Per Child we recently ran afoul of an ugly problem with some 8GB SD cards.  It turns out that the cards 
can die if you turn off power sooner than 1.6 seconds after a write.  That 1.6 seconds is measured from after the SD bus 
has already said "that programming step is done".

After some discussion with the vendor, we learned that this is an artifact of the way they are handling the TLC (three 
level cell) array.  The write first goes into a cache that is written in SLC (single level cell) mode, then is moved 
into the TLC "backing store".  If you turn off power during the write-back, the device can fail so badly that you have 
to use a special machine to recover it.

The 1.6 seconds is not documented anywhere, and is not discoverable by reading card configuration or status information.

OLPC can suspend so quickly that we can easily run afoul of this problem.

Clearly, this is bad firmware in the controller, but it does bring up an interesting point.  As FLASH devices get more 
and more complex, the necessity of doing background housekeeping increases.  Ideally, the algorithms should be safe 
against power loss, but on the other hand, it would also be a good idea to give controllers a chance to shut down 
gracefully when the OS knows it is about to turn off power.

Does anybody know of any standardization efforts to address the "clean shutdown" issue for SD or other FLASH interfaces?

Mitch Bradley

