From: Chris Ball <cjb@laptop.org>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Sat, 30 Jun 2012 08:52:14 -0400
Message-ID: <8762a99d35.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
	<87sjdf8q8h.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206291701110.9084@axis700.grange>
	<87ehoy84oy.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206292041340.9152@axis700.grange>
	<87lij5aefy.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206301243320.19932@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57204 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab2F3MwT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Jun 2012 08:52:19 -0400
In-Reply-To: <Pine.LNX.4.64.1206301243320.19932@axis700.grange> (Guennadi
	Liakhovetski's message of "Sat, 30 Jun 2012 12:45:55 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Sat, Jun 30 2012, Guennadi Liakhovetski wrote:
>> Could we get a file in Documentation/devicetree/bindings/mmc/ for the
>> new sh_mmcif DT bindings you've added, please?  It can come as a new
>> patch on top of these.  I know it'll be very short right now; you can
>> at least show an example of a DT node that works.
>
> I added OF support to both sh_mmcif and sh_mobile_sdhi (tmio_mmc), but in 
> both cases it's just at the most primitive level. This means, those 
> drivers will only use reg and interrupts DT properties, nothing else so 
> far. More shall be added in the future.

Right.

> Does this level of support also have to be documented?

Well, I think the idea is that someone should know how to hook up their
DT to the driver without hunting through the source code; right now they
at least have to read the source to find out that the required
compatible nodes are "renesas,sh-mmcif" and "renesas,shmobile-sdhi".

So the point of adding minimal documentation now would be to show how to
hook it up, and have some placeholder documentation that can be added to
once the driver supports more of the core MMC DT bindings (bus-width,
non-removable, ..).  Seems like it couldn't hurt to add it?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
