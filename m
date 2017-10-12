From: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>
Subject: Re: dw_mmc: busy check incomplete?
Date: Thu, 12 Oct 2017 12:27:10 +0000
Message-ID: <FD897F46D140444CAB8DC80B08F0742B0185ABC5E7@PFDE-MX11.EU.P-F.BIZ>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.pepperl-fuchs.com ([212.21.166.229]:55005 "EHLO
        mailout.pepperl-fuchs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757180AbdJLM1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 08:27:14 -0400
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> On 2017/9/22 17:40, Shawn Lin wrote:
> Still think that should be part of mmc core's behaviour. I try to make
> sure the following ugly patch could work for you? And we could move
> forward later to see how to do it more gracefully.

Thanks for your response and sorry my answer comes with three weeks delay.
Unfortunately, I had other problems with the board in question up to now.

I can confirm the patch works for me. On the oscilloscope shots, I can clearly
see that the next request gets delayed when R1b tells the host the "card" is busy.

How can we move forward to a clean fix here?

Regards,
Simon

> 
> 
> @@ -546,6 +546,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card 
> *card, struct mmc_blk_data *md,
>                          return err;
>          }
> 
> +       /*
> +         * Don't try to rely on the host drivers to check the busy status
> +         * and do it for here. Maybe it's worth more condiction check
> +         * to see if this cmd use data line or not, as we could still 
> support
> +         * cmd in flight even the the device is busy, for instance CQE. 
> Andt
> +         * not sure how much time need to be a proper arbitrary, so bindly
> +         * resort to MMC_BLK_TIMEOUT_MS. Also not sure if we need to take
> +         * poll mathod if no card_busy available.
> +         */
> +       if (card->host->ops->card_busy) {
> +               int tries = MMC_BLK_TIMEOUT_MS;
> +               while (host->ops->card_busy(card->host) && --tries)
> +                       mmc_delay(1);
> +
> +               if (tries == 0)
> +                       return -ETIMEDOUT;
> +       }

