From: Chris Ball <cjb@laptop.org>
Subject: Re: Possible bug in sdio.c?
Date: Sun, 29 May 2011 11:24:51 -0400
Message-ID: <m37h99pm0s.fsf@pullcord.laptop.org>
References: <4DE1A7B0.7000600@manipal.net>
	<20110529141208.GC8360@rere.qmqm.pl> <4DE2639C.2090200@manipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42208 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab1E2PXu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 29 May 2011 11:23:50 -0400
In-Reply-To: <4DE2639C.2090200@manipal.net> (Prashanth Bhat's message of "Sun,
	29 May 2011 20:47:48 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prashanth Bhat <prashanth.bhat@manipal.net>
Cc: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, linux-mmc@vger.kernel.org

Hi,

On Sun, May 29 2011, Prashanth Bhat wrote:
> Could you please clarify the formal process for including these
> changes into the build? I have made the previous changes in my private
> code tree only so far.

See Documentation/SubmittingPatches, and send the patch you generate to
the same list of e-mail addresses you're using here.

If you have a git commit corresponding to the patch, you can use
git send-email or git format-patch to generate the patch file.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
