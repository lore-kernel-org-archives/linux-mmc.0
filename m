From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Thu, 19 Jul 2012 11:12:24 -0400
Message-ID: <87d33r944n.fsf@octavius.laptop.org>
References: <1339181738-22769-1-git-send-email-marex@denx.de>
	<87hat394lp.fsf@octavius.laptop.org>
	<201207191706.06058.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50824 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab2GSPMc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 11:12:32 -0400
In-Reply-To: <201207191706.06058.marex@denx.de> (Marek Vasut's message of
	"Thu, 19 Jul 2012 17:06:05 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>

Hi,

On Thu, Jul 19 2012, Marek Vasut wrote:
>> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
>> > index 34a9026..c6964e1 100644
>> > --- a/drivers/mmc/host/mxs-mmc.c
>> > +++ b/drivers/mmc/host/mxs-mmc.c
>> > @@ -164,16 +164,23 @@ struct mxs_mmc_host {
>> > 
>> >  	spinlock_t			lock;
>> >  	int				sdio_irq_en;
>> >  	int				wp_gpio;
>> > 
>> > +	int				wp_inverted:1;
>> 
>> Mind if I change this to "bool wp_inverted;"?  Other than that, looks
>> fine and I'll merge it for 3.6.
>
> That should be fine. Thanks!

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
