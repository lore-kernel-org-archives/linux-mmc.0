From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Wait for data transfer after response errors.
Date: Mon, 25 Apr 2016 17:29:05 +0200
Message-ID: <CAFqH_50yCSaVUm6=KLSn0GXvsM25riCCSt8=+0-huqMTLcaWxA@mail.gmail.com>
References: <1461597529-6470-1-git-send-email-enric.balletbo@collabora.com>
	<1461597529-6470-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33402 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbcDYP3L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Apr 2016 11:29:11 -0400
In-Reply-To: <1461597529-6470-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Alim Akhtar <alim.akhtar@gmail.com>

Oh, damn, I didn't include the proper tags,

[PATCH v2] mmc: dw_mmc: Wait for data transfer after response errors.
[PATCH v2] mmc: dw_mmc: Fix UHS tuning on some brand of cards

should be

[PATCH v2 0/1] mmc: dw_mmc: Fix UHS tuning on some brand of cards
[PATCH v2 1/1] mmc: dw_mmc: Wait for data transfer after response errors.

2016-04-25 17:18 GMT+02:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> From: Doug Anderson <dianders@chromium.org>
>
> According to the DesignWare state machine description, after we get a
> "response error" or "response CRC error" we move into data transfer
> mode. That means that we don't necessarily need to special case
> trying to deal with the failure right away. We can wait until we are
> notified that the data transfer is complete (with or without errors)
> and then we can deal with the failure.
>
> It may sound strange to defer dealing with a command that we know will
> fail anyway, but this appears to fix a bug. During tuning (CMD19) on
> a specific card on an rk3288-based system, we found that we could get
> a "response CRC error". Sending the stop command after the "response
> CRC error" would then throw the system into a confused state causing
> all future tuning phases to report failure.
>
> When in the confused state, the controller would show these (hex codes
> are interrupt status register):
>  CMD ERR: 0x00000046 (cmd=19)
>  CMD ERR: 0x0000004e (cmd=12)
>  DATA ERR: 0x00000208
>  DATA ERR: 0x0000020c
>  CMD ERR: 0x00000104 (cmd=19)
>  CMD ERR: 0x00000104 (cmd=12)
>  DATA ERR: 0x00000208
>  DATA ERR: 0x0000020c
>  ...
>  ...
>
> It is inherently difficult to deal with the complexity of trying to
> correctly send a stop command while a data transfer is taking place
> since you need to deal with different corner cases caused by the fact
> that the data transfer could complete (with errors or without errors)
> during various places in sending the stop command (dw_mci_stop_dma,
> send_stop_abort, etc)
>
> Instead of adding a bunch of extra complexity to deal with this, it
> seems much simpler to just use the more straightforward (and less
> error-prone) path of letting the data transfer finish. There
> shouldn't be any huge benefit to sending the stop command slightly
> earlier, anyway.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Alim Akhtar <alim.akhtar@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 242f9a0..2ebeea8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1761,6 +1761,33 @@ static void dw_mci_tasklet_func(unsigned long priv)
>                         }
>
>                         if (cmd->data && err) {
> +                               /*
> +                                * During UHS tuning sequence, sending the stop
> +                                * command after the response CRC error would
> +                                * throw the system into a confused state
> +                                * causing all future tuning phases to report
> +                                * failure.
> +                                *
> +                                * In such case controller will move into a data
> +                                * transfer state after a response error or
> +                                * response CRC error. Let's let that finish
> +                                * before trying to send a stop, so we'll go to
> +                                * STATE_SENDING_DATA.
> +                                *
> +                                * Although letting the data transfer take place
> +                                * will waste a bit of time (we already know
> +                                * the command was bad), it can't cause any
> +                                * errors since it's possible it would have
> +                                * taken place anyway if this tasklet got
> +                                * delayed. Allowing the transfer to take place
> +                                * avoids races and keeps things simple.
> +                                */
> +                               if ((err != -ETIMEDOUT) &&
> +                                   (cmd->opcode == MMC_SEND_TUNING_BLOCK)) {
> +                                       state = STATE_SENDING_DATA;
> +                                       continue;
> +                               }
> +
>                                 dw_mci_stop_dma(host);
>                                 send_stop_abort(host, data);
>                                 state = STATE_SENDING_STOP;
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
