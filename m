From: Ian Molton <ian@mnementh.co.uk>
Subject: initialisation freqency patch problem.
Date: Tue, 29 Sep 2009 04:01:58 +0100
Message-ID: <c09aa50a0909282001g6830c9ddvdd985d335f91701b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43874 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZI2DCQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 23:02:16 -0400
Received: by bwz6 with SMTP id 6so1717419bwz.37
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 20:02:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi folks,

The commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21 is causing one of
my MMC cards to fail to initialise.

Has anyone else seen initialisation failures since this patch?

I suspect the problem is in tmio-mmc but its a weird one - only one of
my two tc6393xb based hosts has this issue, and none of t7l66 or
tc6387, and only with one card.

I'll look into it tomorrow and see what actual clock frequency is
getting selected.

I'm off to bed now.

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
