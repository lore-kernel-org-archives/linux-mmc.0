From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: tmio: fix recursive spinlock, don't schedule with interrupts disabled
Date: Wed, 13 Jul 2011 20:39:42 -0400
Message-ID: <m2y601u241.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
	<Pine.LNX.4.64.1106201803520.11365@axis700.grange>
	<m2oc0y2pk6.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1107140132040.30737@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1107140132040.30737@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 14 Jul 2011 01:33:03 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jul 13 2011, Guennadi Liakhovetski wrote:
>> In mmc-next there's a "goto out;" after the mmc_detect_change call, which
>> looks like it's always been there.  Am I missing a patch this depends on?
>> 
>> (It'd be a good time to get a full set of tmio patches for 3.1 pulled
>> together, if you can do that.)
>
> Ok, if you don't mind, I'll get a couple of hours of sleep, and will reply 
> to you first thing in the morning:-)

Not only do I not mind, I'd strongly prefer if you did.  ;-)

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
