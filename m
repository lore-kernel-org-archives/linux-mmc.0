From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Fri, 21 Sep 2012 11:35:43 +0900
Message-ID: <505BD27F.4040800@kmckk.co.jp>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com> <20120803050039.GA1614@linux-sh.org> <20120809042844.GF1614@linux-sh.org> <87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com> <874nobqntv.wl%kuninori.morimoto.gx@renesas.com> <20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp> <87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com> <20120820031352.GC25767@linux-sh.org> <87obm6ry98.wl%kuninori.morimoto.gx@renesas.com> <20120820043853.GD25767@linux-sh.org> <87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com> <5031D9FF.8060801@kmckk.co.jp> <Pine.LNX.4.64.1208220840400.26767@axis700.grange> <m3boh2il85.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vrgw2.firstserver.ne.jp ([164.46.1.45]:51735 "EHLO
	vrgw2.firstserver.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab2IUCgA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 22:36:00 -0400
In-Reply-To: <m3boh2il85.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org, koba@kmckk.co.jp

Hello, Chris

(2012/09/19 15:24), Chris Ball wrote:
> Hi,
> 
> On Wed, Aug 22 2012, Guennadi Liakhovetski wrote:
>> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious
>> interrupts without any active request. To prevent the Oops, that results
>> in such cases, don't dereference the mmc request pointer until we make
>> sure, that we are indeed processing such a request.
>>
>> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thanks, pushed to mmc-next for 3.7.

It needs this patch for kzm9g board to boot kernel 3.6-rc6 successfully.
Can I ask you to queue this patch for 3.6-rc7 ?


