Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79725C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Dec 2021 10:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhLTK2A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLTK2A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Dec 2021 05:28:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14FBC061574
        for <linux-mmc@vger.kernel.org>; Mon, 20 Dec 2021 02:27:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so1308522lfk.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Dec 2021 02:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iv9ezRnnrzcHGD7Zb6emmI6B8JBj8Iod8EtTwFfPyKk=;
        b=IU9FCUD6ZbT12fwfcmTgP3229sxley+tDcIVfiXETS1ySJMlCZVXeXgEeOeGzctNDF
         HTGwAdxc6B+Om9p/DoKu+Gxi/BH5dfqs3Rv2oMxKa5VwwNiHgnWjuUft/SIIfjDucfv5
         QWAiyDkaztoWvwmuWj9yuWoqBZJ6sk6JkNf2gFR2KwsmEuFyJ5/wT14zJDfuJ4ypT0qB
         VO4OdAUaPFbjQqK/10Icg/oOwuakFhZw9fyfhOkm+7hrP4Yh3HHPp4i8NZh4EpxD0TZV
         67QqXRnMW+NNuo75gd5SofLtSy596jh87wufPBa93Ske/GFz2A/kLfaqdcEt1tUNpBqx
         0STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iv9ezRnnrzcHGD7Zb6emmI6B8JBj8Iod8EtTwFfPyKk=;
        b=whogoXm4hSu3B92laChj2UW1JbncpmjUMYbBN6ipHIakCpJFEJUQNAnYiEuTMFxG47
         0jCbCJ38JWl+LqbLwu/+0fEPyWnIc+xEDRHvQN0kss4XhE+/JMPdweINUK2U7MJ0CLv1
         mH1ZRuPBLsqHbS+56bikuQK8mqR/Bq4B5bV2THneWXTJOroUyBm184w8Pg5ZVKlsK2rq
         OqcuNl8ZO5ZMJNamxx7hDfkqlCJ9lpTXJcbWaDX9JFfZ4ocY/4S82tIXNcu5N57JdALM
         ozhcwTgjGinv4BBNJwvSd2AvcX7bgXm/rk57tzm5JwIwT0QD0/yLa32WNwyiukvdkSBy
         r+RQ==
X-Gm-Message-State: AOAM531gO0leEPUYl3q2cMN33cMXFxPoeYCZs92sALM9JC3G1pBbBObb
        aDcrA4RlOR2cYNx2IbZndOEO+Wkw26wlnGIRwXd6Ew==
X-Google-Smtp-Source: ABdhPJzVD42zDGhQBZQ8mnNcZi4O56hS1KMRBbiRJIrt2G1Xnxk7kGTcitYeIsKqM4Iy7AgW5gqkRCEPzUVCypeQjAs=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr617624lfv.184.1639996078020;
 Mon, 20 Dec 2021 02:27:58 -0800 (PST)
MIME-Version: 1.0
References: <c207948f590d4e88945a314bf8299f87@hyperstone.com> <aac0cdefbd2a43329b50a803b7c46959@hyperstone.com>
In-Reply-To: <aac0cdefbd2a43329b50a803b7c46959@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Dec 2021 11:27:21 +0100
Message-ID: <CAPDyKFpoAwezgThhhWgApvfq0nfZFPV4mCJOWGF4ZFp27UhekA@mail.gmail.com>
Subject: Re: [PATCH] mmc: bus: Log bus width info when attaching card
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Dec 2021 at 14:03, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Might seem unecessary to print the bus width and a bit confusing, but it =
is the only 'bus info' that is not printed in that line.
> So I suggest adding it.

Well, I am not sure I agree with this.

There is other information too, like the clock rate for example. But,
I think it may be a bit too much to log everything. In particular as
the information is already available via debugfs, for those that want
more information.

>
> Regards,
> Christian
>

Kind regards
Uffe

>
>
>
> From: Christian L=C3=B6hle
> Sent: Wednesday, December 8, 2021 2:02 PM
> To: linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; Ulf Hansson;=
 Christian L=C3=B6hle
> Cc: johan@kernel.org; sudeep.holla@arm.com; linux@dominikbrodowski.net
> Subject: [PATCH] mmc: bus: Log bus width info when attaching card
>
> Add info about bus width of the attached card to the bring-up message
>
> For both MMC and SD cards the bus width that is used might
> not be obvious to a user. For MMC this might be 1, 4 or 8,
> for SD only 1 and 4. In both cases this would be a restriction
> by the host (setup). Like using an MMC in an SD slot or an
> eMMC to SD adapter.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index f6b7a9c5bbff..71a675dcd9b7 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -358,7 +358,7 @@ int mmc_add_card(struct mmc_card *card)
>                          mmc_card_ddr52(card) ? "DDR " : "",
>                          type);
>          } else {
> -               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> +               pr_info("%s: new %s%s%s%s%s%s %u-bit card at address %04x=
\n",
>                          mmc_hostname(card->host),
>                          mmc_card_uhs(card) ? "ultra high speed " :
>                          (mmc_card_hs(card) ? "high speed " : ""),
> @@ -366,7 +366,8 @@ int mmc_add_card(struct mmc_card *card)
>                          (mmc_card_hs200(card) ? "HS200 " : ""),
>                          mmc_card_hs400es(card) ? "Enhanced strobe " : ""=
,
>                          mmc_card_ddr52(card) ? "DDR " : "",
> -                       uhs_bus_speed_mode, type, card->rca);
> +                       uhs_bus_speed_mode, type,
> +                       1<<card->host->ios.bus_width, card->rca);
>          }
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.34.1
>     =3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
