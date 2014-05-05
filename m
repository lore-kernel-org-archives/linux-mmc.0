From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: TRIM timeout calculation
Date: Mon, 5 May 2014 22:50:39 +0200
Message-ID: <CAPDyKFo8ir0aKCE9HgEQj2jbNQVxSt2ENPdEshDpuuy7MYE6CQ@mail.gmail.com>
References: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:51367 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaEEUuk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 16:50:40 -0400
Received: by mail-qa0-f48.google.com with SMTP id i13so2973620qae.35
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2014 13:50:39 -0700 (PDT)
In-Reply-To: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 5 May 2014 18:55, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> I got a Micron eMMC 4.41 memory and I am trying to use the TRIM function.
> my EXT_CSD_TRIM_MULT is 15 which gets me a tmo of 15*300=4500 ms
> Then in  mmc_calc_max_discard() I have:
>         max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
>         if (mmc_can_trim(card)) {
>                 max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>                 if (max_trim < max_discard)
>                         max_discard = max_trim;
>         } else if (max_discard < card->erase_size) {
>                 max_discard = 0;
>         }
>         pr_debug("%s: calculated max. discard sectors %u for timeout %u
> ms\n",
>                  mmc_hostname(host), max_discard, host->max_busy_timeout);
> Now  mmc_do_calc_max_discard(card, MMC_TRIM_ARG) returns 0 because the
> initial trim
> timeout is so high, 4500 ms:
>   mmc0: calculated max. discard sectors 0 for timeout 2684 ms
>
> How is this supposed to work?

This piece of code in the mmc core/block layer is somewhat broken :-(

For 3.15 we merged quite some patches to fixup the hardware busy
detection mechanism supported by some host drivers/controllers.
Trim/erase may utilize hardware busy detections, it's therefore I
gives you this background.

Now, those fixes did not mean any improvements immediately for
erase/trim, but made some preparations for us to fix it. :-) I have it
on the top of my mmc-TODO list - that's all I can give you sorry. :-)

Anyway, what host driver / controller are you using?

Kind regards
Ulf Hansson


>
>  Jocke
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
