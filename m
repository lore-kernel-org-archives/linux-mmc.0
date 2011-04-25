From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: add quirk to support shared bus controller
Date: Mon, 25 Apr 2011 17:43:36 -0400
Message-ID: <m37haiuhvb.fsf@pullcord.laptop.org>
References: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
	<BANLkTincOuKrTEzP3gv-d2Vk-Cih+BS4hw@mail.gmail.com>
	<BANLkTikcxk6yt72pa6QC-unawseaOQ7Dfg@mail.gmail.com>
	<BANLkTim6V5RNtrUzz+KQiG0USW72B2xjQQ@mail.gmail.com>
	<214C533D-E999-4FF2-AA99-F81526DBA529@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50402 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab1DYVkB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Apr 2011 17:40:01 -0400
In-Reply-To: <214C533D-E999-4FF2-AA99-F81526DBA529@marvell.com> (Philip
	Rakity's message of "Mon, 25 Apr 2011 11:18:06 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bin.shi@csr.com" <bin.shi@csr.com>, "Binghua.Duan@csr.com" <Binghua.Duan@csr.com>

Hi,

On Mon, Apr 25 2011, Philip Rakity wrote:
> A quirk does not seem to the right way to go since there is now 2 points of failure
>
> a) The quirk can be defined and host->ops->get_shared_pins may not be.
>
> how about
>
> 	if (host->ops->get_shared_pins)
> 		host->ops->get_shared_pins(host)

Yep, I agree with Philip -- even if you use a quirk, you should test a
function pointer before calling it.  I also agree that you don't need
a quirk here because this isn't a modification to SDHCI spec behavior,
it's just a hook into platform code.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
