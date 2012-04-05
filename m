From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 05 Apr 2012 18:15:02 -0400
Message-ID: <87obr57rmh.fsf@laptop.org>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
	<m2399iqtgf.fsf@bob.laptop.org>
	<alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
	<87bonxcjrh.fsf@laptop.org> <20120405220848.GF3785@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34938 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab2DEWPG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Apr 2012 18:15:06 -0400
In-Reply-To: <20120405220848.GF3785@atomide.com> (Tony Lindgren's message of
	"Thu, 5 Apr 2012 15:08:48 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

Hi,

On Thu, Apr 05 2012, Tony Lindgren wrote:
> * Chris Ball <cjb@laptop.org> [120315 20:26]:
>> Hi Paul,
>> 
>> On Mon, Mar 12 2012, Paul Walmsley wrote:
>> > I don't think this is the right fix.  Steve Sakoman and I discussed this a 
>> > few months ago -- we did some debugging and Steve observed the timeouts on 
>> > multiple block writes (0x19):
>> > [...]
>> > So perhaps something like the following patch instead?  Unfortunately, I 
>> > don't have one of these crappy SD cards as far as I know, so I can't 
>> > really test it.
>> >
>> >
>> > - Paul
>> >
>> > From: Paul Walmsley <paul@pwsan.com>
>> > Date: Mon, 12 Mar 2012 04:46:29 -0600
>> > Subject: [PATCH] mmc: use really long write timeout to deal with crappy cards
>> >
>> > Several people have noticed that crappy SD cards take much longer to
>> > complete multiple block writes than the 300ms that Linux specifies.
>> > Try to work around this by using a three second write timeout instead.
>> >
>> > <insert Chase's patch description here>
>> >
>> > Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
>> 
>> Sounds like a good idea -- want to send a signed-off patch for this?
>
> This seems like the right fix to me too. Works on my pandaboard es and
> some random card that produces I/O errors without this.
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks.  Paul, just waiting for your Signed-off-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
