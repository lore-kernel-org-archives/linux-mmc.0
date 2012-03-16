From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 15 Mar 2012 23:22:26 -0400
Message-ID: <87bonxcjrh.fsf@laptop.org>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
	<m2399iqtgf.fsf@bob.laptop.org>
	<alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 12 Mar 2012 04:58:00 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hi Paul,

On Mon, Mar 12 2012, Paul Walmsley wrote:
> I don't think this is the right fix.  Steve Sakoman and I discussed this a 
> few months ago -- we did some debugging and Steve observed the timeouts on 
> multiple block writes (0x19):
> [...]
> So perhaps something like the following patch instead?  Unfortunately, I 
> don't have one of these crappy SD cards as far as I know, so I can't 
> really test it.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 12 Mar 2012 04:46:29 -0600
> Subject: [PATCH] mmc: use really long write timeout to deal with crappy cards
>
> Several people have noticed that crappy SD cards take much longer to
> complete multiple block writes than the 300ms that Linux specifies.
> Try to work around this by using a three second write timeout instead.
>
> <insert Chase's patch description here>
>
> Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>

Sounds like a good idea -- want to send a signed-off patch for this?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
