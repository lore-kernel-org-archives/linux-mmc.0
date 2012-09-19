From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Wed, 19 Sep 2012 02:24:10 -0400
Message-ID: <m3boh2il85.fsf@pullcord.laptop.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
	<20120803050039.GA1614@linux-sh.org>
	<20120809042844.GF1614@linux-sh.org>
	<87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com>
	<874nobqntv.wl%kuninori.morimoto.gx@renesas.com>
	<20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp>
	<87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com>
	<20120820031352.GC25767@linux-sh.org>
	<87obm6ry98.wl%kuninori.morimoto.gx@renesas.com>
	<20120820043853.GD25767@linux-sh.org>
	<87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com>
	<5031D9FF.8060801@kmckk.co.jp>
	<Pine.LNX.4.64.1208220840400.26767@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60942 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab2ISGXw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 02:23:52 -0400
In-Reply-To: <Pine.LNX.4.64.1208220840400.26767@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 22 Aug 2012 08:49:47 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tetsuyuki Kobayashi <koba@kmckk.co.jp>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Aug 22 2012, Guennadi Liakhovetski wrote:
> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious 
> interrupts without any active request. To prevent the Oops, that results 
> in such cases, don't dereference the mmc request pointer until we make 
> sure, that we are indeed processing such a request.
>
> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
