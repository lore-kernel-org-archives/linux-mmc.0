From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] mmc_test: how use mmc_test on only eMMC board
Date: Thu, 19 May 2011 10:58:29 -0400
Message-ID: <m3vcx6d9ey.fsf@pullcord.laptop.org>
References: <4DD4A23F.10400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40732 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363Ab1ESO4q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 May 2011 10:56:46 -0400
In-Reply-To: <4DD4A23F.10400@samsung.com> (Jaehoon Chung's message of "Thu, 19
	May 2011 13:53:19 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, May 19 2011, Jaehoon Chung wrote:
> Hi mailing..
>
> I want to know how use mmc_test..
>
> In my case, i used only eMMC board.
> So i didn't use unbind/bind for mmc_test.
>
> echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
> then rootfs of my board has be broken 

mmc_test destroys the data on the card being tested, so there is no way
to use it on your active rootfs.

You would have to boot from external SD (or USB, or network, or
something else) in order to run it on your internal eMMC.  If you do
this, first make sure your eMMC doesn't contain any data needed to boot
your system far enough to be able to boot a kernel from another device.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
