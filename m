From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 1/2] mmc: core: enhance card removal judgement for slow removal
Date: Thu, 28 Feb 2013 09:46:55 +0100
Message-ID: <CAPDyKFq5-4=tnzA5hUOeqru1cO6J-t3N0Nrj8_HiUXbzTbgRgw@mail.gmail.com>
References: <1362036569-14364-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:53144 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab3B1Iq5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 03:46:57 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so1506039lab.16
        for <linux-mmc@vger.kernel.org>; Thu, 28 Feb 2013 00:46:55 -0800 (PST)
In-Reply-To: <1362036569-14364-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

On 28 February 2013 08:29, Kevin Liu <kliu5@marvell.com> wrote:
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
> ---
>  drivers/mmc/core/core.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b8c3d41..d9ac96c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2290,6 +2290,19 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>                 return 1;
>
>         ret = host->bus_ops->alive(host);
> +       /*
> +        * Card detect status and alive check may out of sync if card is
> +        * removed slowly when card detect switch changed while card/slot
> +        * pads still contacted in hardware.(refer to "SD Card Mechanical
> +        * Addendum, Appendix C: Card Detection Switch") So reschedule a
> +        * detect work 200ms later for this case.
> +        */
> +       if (!ret && host->ops->get_cd && !host->ops->get_cd(host)) {
> +               mmc_detect_change(host, msecs_to_jiffies(200));
> +               pr_debug("%s: card remove too slowly\n",
> +                               mmc_hostname(host));
> +       }
> +
>         if (ret) {
>                 mmc_card_set_removed(host->card);
>                 pr_debug("%s: card remove detected\n", mmc_hostname(host));
> --
> 1.7.9.5
>

Great work Kevin and thanks for convincing me around this patch! :-)

I also intend to remove the MMC_CAP2_DETECT_ON_ERR code, I don't see a
need for it anymore.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
