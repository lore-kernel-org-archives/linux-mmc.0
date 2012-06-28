From: Chris Ball <cjb@laptop.org>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Thu, 28 Jun 2012 10:29:02 -0400
Message-ID: <87sjdf8q8h.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47637 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab2F1O3H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jun 2012 10:29:07 -0400
In-Reply-To: <Pine.LNX.4.64.1206281029270.31813@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 28 Jun 2012 10:36:13 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Thu, Jun 28 2012, Guennadi Liakhovetski wrote:
> There are a number of MMC patches from me outstanding for 3.6. 
> Appreciating, that it might not be very easy to keep on overview - what 
> latest versions are and in which order they should be applied - would you 
> like me to either assemble a list of patches with links to ML archives or 
> maybe set up a git branch somewhere on github? In the latter case - would 
> you require some signing process - if it is at all supported on github. 
> No, I never used one, but I'd have a look if you prefer me to use one.
>
> We still have some time until 3.6 merge window, but it would be nice to 
> let patches simmer for a while in -next.

Thanks, a github branch based on mmc-next would be great, and you don't
need to sign it.

If you have gpg setup but don't want to learn how to use git signed tags
yet, something you could do is sign the e-mail that "git request-pull"
generates that says "pull from url <foo> to go from commit <hash>
to a new HEAD hash of <hash>".

(This effectively signs all the commits, because applying all of the
correct commits is the only way to get to that new hash, and I can
verify that I have that hash as my new HEAD after pulling.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
