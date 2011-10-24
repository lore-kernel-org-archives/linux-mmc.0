From: Chris Ball <cjb@laptop.org>
Subject: Re: A question on IOCTL interface for MMC
Date: Mon, 24 Oct 2011 12:39:40 -0400
Message-ID: <m2hb2y8htf.fsf@bob.laptop.org>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
	<5263525.D4yqBTjgWh@wuerfel>
	<CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43586 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933013Ab1JXQkC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Oct 2011 12:40:02 -0400
In-Reply-To: <CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com>
	(Shashidhar Hiremath's message of "Mon, 24 Oct 2011 18:02:36 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Arnd Bergmann <arnd@arndb.de>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 24 2011, Shashidhar Hiremath wrote:
> As explained in previous mail, the IOCTL is actually an inteface to
> block layer and it is only expecting read/write commands to be sent
> through the interface.The prrof of it can be seen in write_flag
> present in the IOCTL structure which indicates the either the command
> can be read or a write command.

Please just try it, using an arbitrary write_flag.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
