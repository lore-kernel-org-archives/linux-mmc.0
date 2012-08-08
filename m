From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Tue, 07 Aug 2012 23:31:06 -0400
Message-ID: <87zk66vz45.fsf@octavius.laptop.org>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
	<CAJxxZ0M9oReELfJ_ncu=eHd=Qy0Bpx=06Jv3MzvOPbRTh_h-jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48725 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab2HHDbO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:31:14 -0400
In-Reply-To: <CAJxxZ0M9oReELfJ_ncu=eHd=Qy0Bpx=06Jv3MzvOPbRTh_h-jg@mail.gmail.com>
	(Sonic Zhang's message of "Wed, 8 Aug 2012 11:23:09 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Cliff Cai <cliff.cai@analog.com>

Hi,

On Tue, Aug 07 2012, Sonic Zhang wrote:
> Could you review this series of patches for Blackfin on-chip SD
> controller? The head file and new BF60x machine code have been merged
> upstream. These patches are necessary to get SD driver built on BF60x.

I see that Cliff Cai <cliff.cai@analog.com> is listed as the maintainer
of bfin_sdh.c in MAINTAINERS -- is it possible for you to get his ACK?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
