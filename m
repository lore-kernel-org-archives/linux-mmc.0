From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: mmc: do not use CMD13 to get status after speed
 mode switch
Date: Fri, 15 Jul 2016 15:10:57 -0700
Message-ID: <CAOCOHw67NAinC6dEX0KsDn02kuXyNwznm3-bhptSVvQH0V1dqQ@mail.gmail.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com> <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36184 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcGOWK6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2016 18:10:58 -0400
Received: by mail-io0-f178.google.com with SMTP id b62so116025954iod.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2016 15:10:58 -0700 (PDT)
In-Reply-To: <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>

On Thu, May 19, 2016 at 1:47 AM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:
> Per JEDEC spec, it is not recommended to use CMD13 to get card status
> after speed mode switch. below are two reason about this:
> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> Therefore it is not recommended to use CMD13 to check busy completion
> of the timing change indication.
> 2. After switch to HS200, CMD13 will get response of 0x800, and even the
> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc.c | 112 ++++++++++++++++++++-----------------------------
>  1 file changed, 45 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
[..]
> @@ -1274,20 +1254,18 @@ static int mmc_select_hs200(struct mmc_card *card)
>                 err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                    EXT_CSD_HS_TIMING, val,
>                                    card->ext_csd.generic_cmd6_time,
> -                                  true, send_status, true);
> +                                  true, false, true);
>                 if (err)
>                         goto err;
>                 old_timing = host->ios.timing;
>                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -               if (!send_status) {
> -                       err = mmc_switch_status(card);
> -                       /*
> -                        * mmc_select_timing() assumes timing has not changed if
> -                        * it is a switch error.
> -                        */
> -                       if (err == -EBADMSG)
> -                               mmc_set_timing(host, old_timing);
> -               }
> +               err = mmc_switch_status(card);
> +               /*
> +                * mmc_select_timing() assumes timing has not changed if
> +                * it is a switch error.
> +                */
> +               if (err == -EBADMSG)
> +                       mmc_set_timing(host, old_timing);

Sorry for not spotting this earlier, but with the move of the call of
mmc_switch_status() to after mmc_set_timing() we get following error
with sdhci-msm:

mmc0: mmc_select_hs200 failed, error -110
mmc0: error -110 whilst initialising MMC card
mmc0: Reset 0x1 never completed.
sdhci: =========== REGISTER DUMP (mmc0)===========
sdhci: Sys addr: 0x00000000 | Version: 0x00002e02
sdhci: Blk size: 0x00004000 | Blk cnt: 0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present: 0x01f80000 | Host ctl: 0x00000000
sdhci: Power: 0x00000000 | Blk gap: 0x00000000
sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps: 0x322dc8b2 | Caps_1: 0x00008007
sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
sdhci: Host ctl2: 0x00000000
sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
sdhci: ===========================================

But I if I understand the commit correctly this is the intention of
the patch (not the error, but the move).

Regards,
Bjorn

>         }
>  err:
>         if (err)
> --
> 1.8.1.1.dirty
>
