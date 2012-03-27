From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus clock
Date: Mon, 26 Mar 2012 23:20:43 -0400
Message-ID: <87limmybjo.fsf@laptop.org>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
	<1332320549-28584-3-git-send-email-horms@verge.net.au>
	<Pine.LNX.4.64.1203241904150.19427@axis700.grange>
	<20120325223033.GA6860@verge.net.au> <4F70027A.9020203@renesas.com>
	<20120326055256.GE2347@verge.net.au>
	<CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
	<20120327014343.GA28782@verge.net.au>
	<CANqRtoTtXSess2UQAj1K80xmSuubrK5gw+YkWnBiyNyiY5mQfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33627 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757395Ab2C0DUq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Mar 2012 23:20:46 -0400
In-Reply-To: <CANqRtoTtXSess2UQAj1K80xmSuubrK5gw+YkWnBiyNyiY5mQfQ@mail.gmail.com>
	(Magnus Damm's message of "Tue, 27 Mar 2012 11:46:49 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi,

On Mon, Mar 26 2012, Magnus Damm wrote:
>> Do you have a feeling of if it it worth trying to start with a value close
>> to 400kHz or if it would be better to simplify the code? I can try and
>> measure the difference in start up time for particular hardware
>> combinations, but I'm not sure how far that will get us.
>
> I believe the correct way is to program the hardware to be as close to
> 400 kHz as possible. I may be wrong, but I guess that slower than 400
> kHz is also acceptable during the initial phase, but faster may mean
> out of spec. For optimal performance the code may need to be reworked
> to support both correct and slow 400 kHz as well as whatever high
> frequencies needed for fast transfers.

Hm, I think I'm missing something -- you shouldn't need to optimize f_min
in the driver at all, because the core handles retrying at lower frequencies
in the init phase (before switching to the higher frequency that comes from
the CSD) and it always begins at 400KHz if that's above f_min.  In core.c:

void mmc_rescan(struct work_struct *work)
{
        static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
        ...
        for (i = 0; i < ARRAY_SIZE(freqs); i++) {
                if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
                ...

So, why would you want f_min to be near 400KHz?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
