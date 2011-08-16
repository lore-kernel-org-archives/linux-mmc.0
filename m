From: Chris Ball <cjb@laptop.org>
Subject: Re: Testing Infrastructure for SD/MMC Commands
Date: Tue, 16 Aug 2011 12:11:13 -0400
Message-ID: <m239h1z68u.fsf@bob.laptop.org>
References: <CANYdXnoZK3OoWOnJhyq645GofnsXuk7tJm09Wv8=Y+gLujPSkQ@mail.gmail.com>
	<CANYdXnrHWGPCeAEJQq6cmsZAyYfvvcSZ_1_3jKhcMbTARJpGVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57773 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636Ab1HPQLZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2011 12:11:25 -0400
In-Reply-To: <CANYdXnrHWGPCeAEJQq6cmsZAyYfvvcSZ_1_3jKhcMbTARJpGVw@mail.gmail.com>
	(Shashidhar Hiremath's message of "Tue, 16 Aug 2011 14:56:29 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, James Hogan <james.hogan@imgtec.com>, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

Hi Shashidhar,

On Tue, Aug 16 2011, Shashidhar Hiremath wrote:
> i am planning to come up with a module that would help for testing
> the SD/MMC controller to see if supports the particular command.
>
> For example ,Through this module , we will be able to see if a
> particular command has been accepted by the device and whether device
> has responded in the expected manner or not by checking its response.
>
> Can I get some points on how useful this infrastructure would be ,and
> any inputs on what else to cover under this ?

You could consider using John Calixto's CMD passthrough ioctl for this,
and writing your tests in userspace:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=cb87ea28ed9e75a41eb456bfcb547b4e6f10e750

It would be great to include your finished tool in a testsuite, both for
testing card commands and for testing the ioctl functionality itself.  :)

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
