Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB2C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jun 2022 23:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiFNXNK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiFNXNJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2022 19:13:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6CA29365
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2022 16:13:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l20so4618225lji.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2022 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUunLY44x6NNlNGNr31bcD59A3LaPrJdVn5zb7u0ytk=;
        b=FrBl3ipUeJQidZaT7ANXTgAt/lX+6esE9ZcxdDHYNScew//nKmVTSwnZtrrGtRryw+
         dBEHmA1GQ0k5TRNslCdnoLCcOFzvTVRw/Sr933VFc3RbY5HiEVBJlZBylIoitsm6F5CL
         McCNfaLOuIF3/JD4zDih50lNyWlEtrHY5QIfgP97bdf5s9qV9ymI5My7zCm2Rb7B5OcY
         zqciDBMMZ4jojsGjQAnVh4AeVnnzMOKBk0+ORg3i09zJ1OjDHuER94zY9PxRjdRYARC9
         G6JSJijjrkc7cRUT2O8f2+j+M2TElRePXd02Ne6IE1dWX3SM4YWiinPPfVPlEr3VrNtN
         8Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUunLY44x6NNlNGNr31bcD59A3LaPrJdVn5zb7u0ytk=;
        b=NvMY86+P5H3WbzfmPq29qfdkHmoCxA4r8WTRurH2XU2GgWm7gJqJlF8ydB6ogKgaHB
         F2qcolhWsOEvDn0YoATy2z8FeYkR5pTIYeMFfM0KPiyZKEKFW9rx+9gcrUjNJAf3RvwS
         qUO7mlSlXI7UPrBZOqvJO1nk4DvaJXLErfWwM3/XdyUbnpZT6AqAjy3ID42fLvyCvHqE
         XuKW9PkiAoxKPGh9fwk31fIl3n1SmURixzm7fBmMTGVg3a70y7CZZ1I9aSNybzZ/9Su3
         WQOC1gHqWggYd1818AbTGvuwLbT2umZ04tOadP0fQu2D20KtdqiYWvdAJ3AZ46GQ6Xqb
         fNbQ==
X-Gm-Message-State: AJIora9hQVT6emn6HipzedsP+Nghjvj80jmB4zuD8qhBc2tabkPbwtMh
        j7pWeHS/0FSw8TlcabpIzyGrkJpZnjbn4S/xHONOzg==
X-Google-Smtp-Source: AGRyM1v2ZNUCVYWCf7S9PNkRndV+sEHJPCwkLoRBj7OBxshNMdSxi6hKjL5cT/mhRLnOx+2flcHOY3e/jxflW/AORtM=
X-Received: by 2002:a05:651c:886:b0:258:df66:5040 with SMTP id
 d6-20020a05651c088600b00258df665040mr3900576ljq.16.1655248386197; Tue, 14 Jun
 2022 16:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
In-Reply-To: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Jun 2022 16:12:30 -0700
Message-ID: <CAPDyKFrBNaeRTosWEAFvEB8Z6yB+umbWhm41AFf7DZ=XBeGJPA@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: Add wakeup functionality support for sdio cards
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_kamasali@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 May 2022 at 05:13, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> Changes since V1:
>         - Define a new vendor ops to let vendor enable wakeup capability
>           as per their needs.
>
> Sarthak Garg (2):
>   mmc: core: Define a new vendor ops to enable wakeup capability
>   mmc: sdhci-msm: Add wakeup functionality to sdio cards
>
>  drivers/mmc/core/bus.c       |  3 +++
>  drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
>  include/linux/mmc/host.h     |  7 +++++++
>  3 files changed, 24 insertions(+)
>

Hi Sarthak,

I don't think this is the right solution.

Please have a look at another series [1], which is currently under
review and it's adding support for SDIO wakeup. I think you should be
able to get influenced from that, to understand how you should
implement this.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg70506.html
