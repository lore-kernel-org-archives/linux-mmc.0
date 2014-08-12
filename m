From: Apelete Seketeli <apelete@seketeli.net>
Subject: Re: [PATCH v6 2/2] mmc: jz4740: prepare next dma transfer in
 parallel with current transfer
Date: Tue, 12 Aug 2014 22:02:28 +0200
Message-ID: <20140812200228.GB23978@tao>
References: <1405917465-18185-1-git-send-email-apelete@seketeli.net>
 <1405917465-18185-3-git-send-email-apelete@seketeli.net>
 <86y4ut60ha.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from seketeli.net ([94.23.218.202]:37947 "EHLO ms.seketeli.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbaHLUCa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Aug 2014 16:02:30 -0400
Content-Disposition: inline
In-Reply-To: <86y4ut60ha.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alex Smith <alex.smith@imgtec.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Aug-12-2014 at 07:12:33 PM +0100, Chris Ball wrote:
> Hi Apelete,
> 
> On Mon, Jul 21 2014, Apelete Seketeli wrote:
> > It should help reduce the impact of DMA preparation overhead on the SD
> > card performance.
> 
> Did you do any benchmarking to check that this is true?  (If so, it'd
> be good to note what performance change you saw in the commit message.)

I actually did a few quick benchmarks, posted the results in the cover
letter: https://lkml.org/lkml/2014/7/21/11.
As you can see the improvement is measurable, although not significant
with zcat.

Cheers.
-- 
        Apelete
