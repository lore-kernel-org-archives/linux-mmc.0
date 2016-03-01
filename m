From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: MMC broken in kernel 4.4
Date: Tue, 1 Mar 2016 10:21:54 +0800
Message-ID: <56D4FCC2.1020604@kernel-upstream.org>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
 <56D44249.7070200@kernel-upstream.org>
 <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:34567 "EHLO
	mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcCACWh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Feb 2016 21:22:37 -0500
In-Reply-To: <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

+Ulf and Adrian

On 2016-3-1 3:23, Hubert Tonneau wrote:
>
> Shawn Lin wrote:
> >
> > On 2016/2/29 18:17, Hubert Tonneau wrote:
> > > Hi everybody,
> > >
> > > MMC support seems to be broken on kernel 4.4.X as opposed to 
> kernel 4.3.X on Lenovo Yoga 8 inch tablet.
> >
> > Do you have this part of code[0] in your repository?
> >
> > [0]: https://patchwork.kernel.org/patch/7323541/
>
> Yes. I tested with stock kernel 4.4.3 and the patch your are pointing 
> is included in stock kernel 4.4.3
>

Hubert,
     Could you help revert this change to see if it's possible for your 
Yoga to work again?

> Regards,
> Hubert Tonneau
>

