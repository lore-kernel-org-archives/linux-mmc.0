Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D472C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 12:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiDDMIS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbiDDMIH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 08:08:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE5236149
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 05:06:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so16818372lfg.7
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2022 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MV4qH4Hhk8OCQ8ozHbvCNo6qYwp9Nh2KxCigjmrKGfM=;
        b=QPG4g01D8+zcutd4ZOtj14dNMDWLfgiCkpvgxVqD5vVG225UdWoO2L00EkZ72yHBw3
         JC/xzN/AO9+iCo3rIB1gnwykIgSa7zAHt7lI3EVNiAaJmV2IbEzoIU8agjY+T0wYfsfo
         ITj/cycIBpDIZ+/PB2IRgFsx4Gv9vXL73KADDZ0ioliLYXFO6B0/sGCffD/OU/qo4Kuh
         FQi2h95JmXDNwLyIp9iAUe26d6bJxwO1YP1I62NRkUQ4abeA9i9Hr7svByWVUXl4ZrCV
         zvVT/7G/Ehm0dDKj4UzR1SwStLyXPM6lgfywOqMcJedfkSWPE2rr2MdBQa+dc6yQuEKo
         8NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV4qH4Hhk8OCQ8ozHbvCNo6qYwp9Nh2KxCigjmrKGfM=;
        b=xRztDSXJ0KGRviVk8BsDXnHE/2LhV6PEOjKPCks02ZCBdfPR+4oKP2J5w4qR564qdt
         Push7Or/YKOeUmo2lb91qxSb4G4OenyjQJcW4fLBDw8FmhB4YZ9Ah7ezcCZX+yUyV2LK
         EBeYa6gYRBWl/DMlVEzSfOv+Er3/TIcDmlTN7shAGAo5Ji87AW0Az2wAstNfdo7riUNC
         OeADpntbA/EPxBdm+u8oDHbb5nPERm9biol2+/bTzpXBQN+h3UbSQmOnzfgnsb53woMT
         +whky0sA3j5lph5wFZlHD24c/2q7ouHywgZVvsq9ZKiAbIBQuwCnYr2qfmA8mrP4rdEr
         xCgQ==
X-Gm-Message-State: AOAM533YEybsLTY9HN6YeazNS5/3ZJyK3qr/Rn1kyxPM+/GxxnlDuc0S
        MvG2j9opJuafF8pbfnoKxl7YDPnumuqb7x0dVkwHXg==
X-Google-Smtp-Source: ABdhPJy+nY10ZOd1gX4mC40x2Y0PTtXWJa7ExeMPjT3XD5FYs7YqTmZo9uHZYsABpgJ9+Ub7bV+0fqQPlbahc4+Mqe8=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr23113283lfq.167.1649073968994; Mon, 04
 Apr 2022 05:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com> <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 14:05:32 +0200
Message-ID: <CAPDyKFqt8UUfGVHvpSX5ciP7qJReTYed=sffCGWPP9psS3vC_w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] mmc: core: improve API to make clear
 mmc_hw_reset is for cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Mar 2022 at 12:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> To make it unambiguous that mmc_hw_reset() is for cards and not for
> controllers, we a) add 'card' to the function name and b) make the
> function argument mmc_card instead of mmc_host. A fallback is provided
> until all users are converted.

In my opinion, I think b) is sufficient and would be a nice improvement.

In this regard, I suggest we make one big cross-subsystem patch (the
smallest change as possible) then I can pick it up and send it for the
v5.18-rc2.

Br
Uffe

>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/core/block.c    |  2 +-
>  drivers/mmc/core/core.c     | 18 +++++++++++++-----
>  drivers/mmc/core/mmc_test.c |  3 +--
>  include/linux/mmc/core.h    |  1 +
>  4 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..74674a4650b0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -993,7 +993,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>                 return -EEXIST;
>
>         md->reset_done |= type;
> -       err = mmc_hw_reset(host);
> +       err = mmc_card_hw_reset(host->card);
>         /* Ensure we switch back to the correct partition */
>         if (err) {
>                 struct mmc_blk_data *main_md =
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..71e75196bc53 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1984,7 +1984,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  }
>  EXPORT_SYMBOL(mmc_set_blocklen);
>
> -static void mmc_hw_reset_for_init(struct mmc_host *host)
> +/* we can't use mmc_card as a parameter, it is not populated yet */

Please drop this. The function is internal/static and at least to me,
rather self-explanatory.

[...]

Kind regards
Uffe
