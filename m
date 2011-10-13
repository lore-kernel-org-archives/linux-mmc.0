From: Chris Ball <cjb@laptop.org>
Subject: Re: git clone linux-mmc tree issue: remote hung up unexpected
Date: Thu, 13 Oct 2011 10:50:32 -0400
Message-ID: <m2ehyhgd3b.fsf@bob.laptop.org>
References: <20111013083556.GA16076@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304Ab1JMOuh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Oct 2011 10:50:37 -0400
In-Reply-To: <20111013083556.GA16076@gmail.com> (Shawn Dong's message of "Thu,
	13 Oct 2011 16:36:05 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 13 2011, Shawn.Dong wrote:
> Hi Chris,
> I want to clone a linux-mmc tree in my local machine by using command:
> #git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>
> But seems I can always hit "remote hung up unexpectedly" after using this
> command. Also checked git.kernel.org, and didn't find the
> linux/kernel/git/cjb/mmc.git data base.
>
> Has linux-mmc server changed its address? Or I was using a wrong
> command...Can you help me on this? Thanks in advance

The tree is temporarily at:

git://dev.laptop.org/users/cjb/mmc mmc-next

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
