From: Chris Ball <cjb@laptop.org>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Fri, 29 Jun 2012 12:26:37 -0400
Message-ID: <87ehoy84oy.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
	<87sjdf8q8h.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1206291701110.9084@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39206 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292Ab2F2Q0m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jun 2012 12:26:42 -0400
In-Reply-To: <Pine.LNX.4.64.1206291701110.9084@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 29 Jun 2012 17:03:09 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Fri, Jun 29 2012, Guennadi Liakhovetski wrote:
> Hi Chris
>
> On Thu, 28 Jun 2012, Chris Ball wrote:
>> If you have gpg setup but don't want to learn how to use git signed tags
>> yet, something you could do is sign the e-mail that "git request-pull"
>> generates that says "pull from url <foo> to go from commit <hash>
>> to a new HEAD hash of <hash>".
>> 
>> (This effectively signs all the commits, because applying all of the
>> correct commits is the only way to get to that new hash, and I can
>> verify that I have that hash as my new HEAD after pulling.)
>
> Ok, let's try, no guarantee though :) Let me know if there are any 
> problems with my signing exercise.
>
> The following changes since commit ed99260f748d4c1894a23a4519fd59156a27a308:
>
>   mmc: tmio: remove a duplicated comment line (2012-06-26 16:10:40 -0400)
>
> are available in the git repository at:
>   https://github.com/lyakh/linux.git mmc-for-3.6

Close, but you didn't tell me what the new HEAD hash should be after
pulling.  This means that the patches could be modified on github
and as long as the diffstat doesn't change, there's no way for me
to know that I'm not pulling what you think I'm pulling.

So, just tell me (in a signed mail) what the top commit's hash is for
you, and that'll prove I'm getting what you're sending.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
