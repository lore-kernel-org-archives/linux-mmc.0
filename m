From: Chris Ball <cjb@laptop.org>
Subject: Re: EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
Date: Sat, 04 Feb 2012 18:02:02 -0500
Message-ID: <m2ehua9p91.fsf@bob.laptop.org>
References: <CALJWcL9aHD0iQ-K4snho=KthB1OGbZ9ujaike7V8knkwZq+qRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57662 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab2BDXCH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 18:02:07 -0500
In-Reply-To: <CALJWcL9aHD0iQ-K4snho=KthB1OGbZ9ujaike7V8knkwZq+qRQ@mail.gmail.com>
	(Giuseppe D'Agostino's message of "Fri, 20 Jan 2012 16:06:54 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe D'Agostino <gdagostino79@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Jan 20 2012, Giuseppe D'Agostino wrote:
> after a series of mmc stress test on my device, based on ARM
> architecture, I noted, launching command dmesg, that it's present this
> warnings:
>
> EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
>
> Now, it's normal because, probably, I passed "max mount counts", that
> is 30 for default, but my question is:
>
> For this memory's type which is a right limit before execute e2fsck on
> partition? It's only a formal problem or is necessary, some other
> time, execute an fsck on device?

I don't think MMC is particularly different to any other media type in
this regard.  Running fsck based on mount count is just a heuristic;
it's not tied to media type.  So, go ahead and run fsck, or not,
whichever you like.  :)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
