From: Chris Ball <cjb@laptop.org>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Fri, 29 Jun 2012 19:25:21 -0400
Message-ID: <87lij5aefy.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
	<87sjdf8q8h.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206291701110.9084@axis700.grange>
	<87ehoy84oy.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206292041340.9152@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39578 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778Ab2F2XZ2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jun 2012 19:25:28 -0400
In-Reply-To: <Pine.LNX.4.64.1206292041340.9152@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 29 Jun 2012 20:44:50 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Fri, Jun 29 2012, Guennadi Liakhovetski wrote:
> Ah, ok, right, sorry, I thought, it would be a part of the "git 
> request-pull" output.

It is for newer versions of git, FWIW.

> So, the top commit has hash
>
> 7c4cf5b31b98f51ebfc8db89b022e4f52f93f5db
>
> Hope, this is what's required :-)

Yes, perfect -- pulled and pushed out to mmc-next.  Thanks!

Could we get a file in Documentation/devicetree/bindings/mmc/ for the
new sh_mmcif DT bindings you've added, please?  It can come as a new
patch on top of these.  I know it'll be very short right now; you can
at least show an example of a DT node that works.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
