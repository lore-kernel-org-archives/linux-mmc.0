From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: fixed regulator control
Date: Tue, 10 May 2011 21:23:24 -0400
Message-ID: <m3boza6neb.fsf@pullcord.laptop.org>
References: <4DBA90BD.8070804@samsung.com>
	<m3iptv2027.fsf@pullcord.laptop.org> <4DBE62FE.6020402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48069 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab1EKBVB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 21:21:01 -0400
In-Reply-To: <4DBE62FE.6020402@samsung.com> (Jaehoon Chung's message of "Mon,
	02 May 2011 16:53:34 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>

Hi Jaehoon,

On Mon, May 02 2011, Jaehoon Chung wrote:
> Hi Chris..
>
> Thanks for comments...
> I think that could confuse that message when didn't set CONFIG_REGULATOR.

The message *does not appear* when CONFIG_REGULATOR is unset, because
NULL -- which the regulator subsystem returns via the regulator_get()
stub -- is not an IS_ERR().  Do you agree?

> And i wonder how do you think about regulator control in suspend (dw_mmc.c)?

Yes, that patch looks correct, although I can't test it myself.  Please
send it separately.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
