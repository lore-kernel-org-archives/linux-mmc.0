From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: Bus width testing needs to handle suspend/resume
Date: Sat, 09 Jul 2011 18:20:46 -0400
Message-ID: <m2liw7jdtt.fsf@bob.laptop.org>
References: <0281C9EE-5CAE-41B7-9A8D-4BE2F125EF2F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57864 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab1GIWUv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 18:20:51 -0400
In-Reply-To: <0281C9EE-5CAE-41B7-9A8D-4BE2F125EF2F@marvell.com> (Philip
	Rakity's message of "Thu, 7 Jul 2011 09:04:55 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Philip,

On Thu, Jul 07 2011, Philip Rakity wrote:
> V2
> ==
> Save the ext_csd information needed for bus width
> compare when we read the ext_csd the first time (in 1 bit mode).
>
> On every pass we make re-reading the ext_csd compare
> the data against the saved ext_csd data.

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
