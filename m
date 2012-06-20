From: Chris Ball <cjb@laptop.org>
Subject: Re: Write Timeout is too long.
Date: Wed, 20 Jun 2012 02:37:51 -0400
Message-ID: <877gv24hfk.fsf@octavius.laptop.org>
References: <CAMEN=G4ucjXyE9O=PhJwtMMMjdXni1NYnScUkT66hhQ-QGG6Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58352 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab2FTGhy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 02:37:54 -0400
In-Reply-To: <CAMEN=G4ucjXyE9O=PhJwtMMMjdXni1NYnScUkT66hhQ-QGG6Sg@mail.gmail.com>
	(Juan Carlos Garza Fernandez's message of "Mon, 18 Jun 2012 16:45:17
	+0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Juan Carlos Garza Fernandez <juancarlosgarza@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 18 2012, Juan Carlos Garza Fernandez wrote:
> Hi,
>
> On the past, the write timeout was increased from 300 ms to 3 seconds
> (see commit 3bdc9ba892d6a294d16e9e6e0c4041926aa3d58c from Paul
> Walmsley)  as some cards had issues with that limit, which is correct
> as the issue can be reproduced by me. Increasing that timeout solves
> the problem, however increasing the timeout to 3 seconds is a bit too
> much and  following error message occurs in the kernel log:
>
>  mmc1: Too large timeout requested for CMD25!

This is now fixed in mainline:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=09eeff52bf20d485bcafc441f01c142c59c3da16

by just silencing the warning.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
