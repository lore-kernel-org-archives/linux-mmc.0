Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23137ECAAD8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 12:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIUMwX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIUMwE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:52:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B6985A0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:50:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso9001151wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fnBorM5qyNu7mcscToponXq4ufmHa2XOmr0Lac37Wtw=;
        b=EirY1sgJDlIbfsPXrmIUhfdIZ05RWhNFOEuJyFlMIo3jtQDwn2i9YtEyC8QH3g4XFJ
         a6F/8gu+eiADvCiE/yoAWA9K0kBVQ24wGw5E0uz+KGw9LTi91sXQ+TKtJjoM8AN84PDZ
         elJcjiJO3vt8wF3CGiqn7jehiVKCmVW9ufbpHm9RCU3PiTbRjDWdZYKVUE4I6onN9Hwr
         ywYc60T9+RhFjb1QeODjmgHwx2L+jh/U7Thvhrq9SpgoMCVKF7A+/Rhf3YipIi++yerJ
         /mUyHfj+Ae8FtKO5VS4247PehYUizSCv51dbk0rAqrg/sdC++a2cXoiMzHY0l4/7ns4U
         jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fnBorM5qyNu7mcscToponXq4ufmHa2XOmr0Lac37Wtw=;
        b=dNvklUXrRSB4pJcu4E+FXKRxl2JP8F0yVGodGtYgNfvG7oCBg1cnxQo57SrYln8FtO
         0UMlIjGVuksPaS1aJQEKPLmh+PzPa6vclh7K4/b+I3HDQmbuzNuOCLLQ7egH26ip0csd
         89IqGneZgOX7W3whv/Sv3zKPBTTw29d6S1fU9aUmRmmrNt+iuPQ3WWCmpV6kFR9flXOm
         UAsTdf4SCOjce5/E4rwTraJGMgANiew6kpPb+C7QooeNDP8dhySMM4Lo4O85VLrOrzFb
         IEVl8S7lBR15Vypv62xXQWbVI2orD6S5eOP/xCKtb6WeHxwONzi9c2Nxaw6Yfzj9IGUU
         20Uw==
X-Gm-Message-State: ACrzQf3vGVkRyUZbu6KknHIfjX2cBIhq2e8nqFbIrM69nCWY2IlBH6xZ
        QZpz26VMwzTjqUQQJeG/Pf0n99ILUXM1VbynhWDwLA==
X-Google-Smtp-Source: AMsMyM7GTrGUTUvn/K7MGG6E7i3/6IBBtiOiZUyD5ZU/lJN45FyOgQLnyteWjLYnqX5xOw+vr84/CafW8h8eRW0qDiw=
X-Received: by 2002:a7b:ca54:0:b0:3b4:fb06:9b1 with SMTP id
 m20-20020a7bca54000000b003b4fb0609b1mr1593977wml.67.1663764606823; Wed, 21
 Sep 2022 05:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220920064648.215375-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220920064648.215375-1-ye.xingchen@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:49:30 +0200
Message-ID: <CAPDyKFpNwQfsbOmmp3i1XyggSVbJ8NO89MneyUh30aahjHdhRA@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: rtsx_usb_sdmmc: Remove the unneeded
 result variable
To:     cgel.zte@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Sept 2022 at 08:46, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value rtsx_usb_send_cmd() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 5fe4528e296e..5798aee06653 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1042,7 +1042,6 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
>                 unsigned char timing, bool *ddr_mode)
>  {
>         struct rtsx_ucr *ucr = host->ucr;
> -       int err;
>
>         *ddr_mode = false;
>
> @@ -1097,9 +1096,7 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
>                 break;
>         }
>
> -       err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
> -
> -       return err;
> +       return rtsx_usb_send_cmd(ucr, MODE_C, 100);
>  }
>
>  static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> --
> 2.25.1
