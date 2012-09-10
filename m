From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: slot-gpio: Add support for power gpios
Date: Sun, 09 Sep 2012 22:55:36 -0400
Message-ID: <877gs2zivr.fsf@octavius.laptop.org>
References: <87oblfzypc.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1209092325350.11567@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52555 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2IJCzl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 9 Sep 2012 22:55:41 -0400
In-Reply-To: <Pine.LNX.4.64.1209092325350.11567@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 10 Sep 2012 00:05:11 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

Thanks for getting to this review so quickly!  I agree with all of your
comments.  I'm sending out v2 of both patches now.

On Sun, Sep 09 2012, Guennadi Liakhovetski wrote:
>> The zero-length array trick might be becoming unmaintainable as we add
>> more labels to the struct like this.  Do you think we should keep it
>> as-is, or change to individual allocations?  Thanks!
>
> Yeah, it's becoming a bit messy... But I also don't find dynamically 
> allocating multiple tiny memory areas with the same life-cycle 
> particularly elegant... Are you expecting many more GPIOs to be added 
> here?

No, I don't expect needing to add more -- I just found myself wondering
if there was a better way and thought I'd mention it.  Performing
multiple allocations is unattractive too, I agree.

> What we could do, though, we could add macros for various pin function
> names, their lengths, offsets and the total length, to make the
> calculations look less cryptic. Would that be a good alternative?

Adding the comments is probably fine for now; I'd be okay with waiting
to see if we need more GPIO types and revisiting a better solution then.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
