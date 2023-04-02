Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3286C7619A
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Apr 2023 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDBMsr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 Apr 2023 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDBMsq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Apr 2023 08:48:46 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339DDAD29
        for <linux-mmc@vger.kernel.org>; Sun,  2 Apr 2023 05:48:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536af432ee5so504395477b3.0
        for <linux-mmc@vger.kernel.org>; Sun, 02 Apr 2023 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680439724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAIgrqdE3MPfyJvbHSqkch4ENAZwFJPM9U7up3c8s+U=;
        b=yP5NGKPNbQm4+cg4kVrG8svhAYydLasi+I5KqHBg/PkjYcZyw+VZQx68DkSRTqppMv
         iUe1CiD05wz7vrMiO7B/I7GhWdjB5AqiW8yVBlG21AzAcPpskNhWbxDAvaIiTyhpWD3+
         REpQWmUsbEudz4gzkrwkWmbzpVuguvS1UuFH0gLrxHI3d8SYlYqqG60fhpfyEDoj1IQs
         kjsCKjbN07jIk3VhMSopQDmCeaeHlvT4CoVmkpvUUsN/jWHJCRdZXCp95qzgggJPhng/
         arTdnO8YkPKeHZapdWkfLN6tyKmsKHGY5scB9YebeIK3Mdv85MyKW9I9d7f/U4gHZ5Ps
         6CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680439724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAIgrqdE3MPfyJvbHSqkch4ENAZwFJPM9U7up3c8s+U=;
        b=73WUT/T1f8MIO24IuMC9PY9ZOHksCixk4IAppP51TUhMy36r0Xn1BO9jhlirEFbsK1
         1JeYZMoTC4VkrQefOF75Wnr88BEGfhBsmy/IQz1L83IEbkapIvnwdI5nuqO2veiCa65J
         Njre4SHx2vsmI2dn8zK3v1LsPPxvgrJY37nhIFNpArtPiGgp0wYAFJ+QAkWDhg8hTi28
         5teauLSXOVET39yIfL7LVhiNZsZJA8KdzWNZZ0SO52TTIjAfm6eZx1b8hlpF1FtkE+w3
         Ud0Q5SvdE+zi6L1OsQN4MtdR/sR6B0zdNCMymDKcZspHU2lBteWBIbFoc1E7curuoRrv
         9lXw==
X-Gm-Message-State: AAQBX9f6D42aSRi3bc786YCduti8SxJCBUpcz7oxEFjwQFkjjQ1NQFW/
        IIgEQXcJzdgJrfNHYe6d5Tl3W6EYkrY6V6dPE5qoZen9Yd+MjPZZ
X-Google-Smtp-Source: AKy350Z2pxrg73bxnmOYk3KSWveMo5H/mQj3AN3N+wKI03iMbQJiY7AXHeq+OlIKS11wHVH6SHC20Pv+bPmydVw6O4I=
X-Received: by 2002:a81:4426:0:b0:53d:2772:65d with SMTP id
 r38-20020a814426000000b0053d2772065dmr16560744ywa.9.1680439724351; Sun, 02
 Apr 2023 05:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230401165723.19762-1-quic_sartgarg@quicinc.com> <20230401165723.19762-2-quic_sartgarg@quicinc.com>
In-Reply-To: <20230401165723.19762-2-quic_sartgarg@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Apr 2023 14:48:33 +0200
Message-ID: <CACRpkdam5M+Px58hHJp30tCYz-Vh54KvMei7WeZmqmTvtw5X8w@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: core: Define new vendor ops to enable
 internal features
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_sachgupt@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Brian Norris <briannorris@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sarthak,

thanks for your patch!

On Sat, Apr 1, 2023 at 6:57=E2=80=AFPM Sarthak Garg <quic_sartgarg@quicinc.=
com> wrote:

> Define new ops to let vendor enable internal features in
> mmc_suspend/resume paths like partial init feature.
>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
(...)

> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -212,6 +212,10 @@ struct mmc_host_ops {
>
>         /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. =
*/
>         int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios =
*ios);
> +
> +       void    (*cache_card_properties)(struct mmc_host *host);
> +       bool    (*partial_init_card)(struct mmc_host *host);

These have confusing names, first it has nothing to do with
cards since the callbacks are to the host. Second the functions
are named after usecases in a certain host rather than function.

I would just call them .suspend() and .resume(), the use
is obvious and they are called from the driver .suspend()
and .resume() hooks.

Yours,
Linus Walleij
