From: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Subject: git clone linux-mmc tree issue: remote hung up unexpected
Date: Thu, 13 Oct 2011 16:36:05 +0800
Message-ID: <20111013083556.GA16076@gmail.com>
Reply-To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60697 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab1JMItP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 04:49:15 -0400
Received: by iaek3 with SMTP id k3so1024978iae.19
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2011 01:49:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Hi Chris,
I want to clone a linux-mmc tree in my local machine by using command:
#git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

But seems I can always hit "remote hung up unexpectedly" after using this
command. Also checked git.kernel.org, and didn't find the
linux/kernel/git/cjb/mmc.git data base.

Has linux-mmc server changed its address? Or I was using a wrong
command...Can you help me on this? Thanks in advance

Thanks
Shawn
