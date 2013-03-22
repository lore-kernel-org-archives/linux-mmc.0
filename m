From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7 1/2] mmc: core: enhance card removal judgement for slow removal
Date: Fri, 22 Mar 2013 12:21:45 -0400
Message-ID: <87k3ozpfqe.fsf@octavius.laptop.org>
References: <1362036569-14364-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49499 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933862Ab3CVQWP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:22:15 -0400
In-Reply-To: <1362036569-14364-1-git-send-email-kliu5@marvell.com> (Kevin
	Liu's message of "Thu, 28 Feb 2013 15:29:29 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

Hi,

On Thu, Feb 28 2013, Kevin Liu wrote:
> Function _mmc_detect_card_removed will be called to know whether
> the card is still present when host->bus_ops->detect is called.
> In current code, the return value of this function generally only
> depend on the result of sending cmd13 to card, which may not safe
> for card with detection support like slot gpio detection.
> Because the communication status between host and card may out of
> sync with the detect status if remove the card slowly or hands shake
> during the process. The direct reason is the async between card
> detect switch and card/slot pad contaction in hardware, which is
> defined by spec.
>
> The spec define card insert/remove sequence as below (both standard size
> SD card and MicroSD card have the same sequence):
> "Part 1 Standard Size SD Card Mechanical Addendum Ver4.00 Final,
> Appendix C: Card Detection Switch" (Take normally open type as example)
> a)SD card insertion sequence:
>   The card detection switch should be turned on after all SD card
>   contact pads are connected to the host connector contact pads.
> b)SD removal sequence:
>   The card detection switch should be turned off when the SD card
>   is just going to be removed and before any SD card contact pad is
>   disconnected from the host connector contact pad.
>
> Below is the sequence when this issue occur (Take slot gpio detection
> as example and remove the card slowly during the process):
> 1. gpio level changed and card detect interrupt triggered.
> 2. mmc_rescan was launched.
> 3. the card pads were still contacted with the slot pads because of slow
>    removal. So _mmc_detect_card_removed and mmc_rescan think card was
>    still present (cmd13 succeed).
> 4. card pads were discontacted from the card slot pads.
> So the card was actually removed finally but the card removal event
> has been missed by system.
> The interval length between step 1 and step 4 depends on the
> card removal speed. If it's longer than the detect work schedule
> delay which is 200ms, this issue will likely happen.
>
> This patch add the card detect status check in function
> _mmc_detect_card_removed if cmd13 check succeed and host->ops->get_cd
> provided. If get_cd detect no card present then schedule another detect
> work 200ms later.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
