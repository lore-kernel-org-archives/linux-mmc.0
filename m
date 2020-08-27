Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C80DC433E4
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782872177B
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WQPNeYqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgH0Pn5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgH0Pnt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 11:43:49 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97ADC061232
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:43:48 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s81so1352991vkb.3
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LekZT6fqormIzr3OUBB/YeLGwuYnhpwtjwtvj+hv9LU=;
        b=WQPNeYqiaulc2ojLWwrgnjus6raDUYTc4Qykz77pOH2Xth9vKVOp6jb7ZrGRaH58sl
         5v1H7aFeGNdsR6acKQzi+ThrW+f08avaHkMEpVuSNn88gbsorlV0megWSV4gUhezyX4n
         v5mFTTSxim9LK8YwQAcEMx0b+uVaRMrEi6ZoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LekZT6fqormIzr3OUBB/YeLGwuYnhpwtjwtvj+hv9LU=;
        b=Cgn3afkNQfIqNDQQ9sdbcY9ZeifZH2+pEPSsuDem2BCBULoTKZhsWfVJP+4vZJMtBD
         ux/Lw+rWldN/zCRQS+RyS2IqX5DwTqX468EE9tb0uyoY6q2zoVAkERD+Mqevpgw6qBkQ
         9JVIaFx7urgv58ftZwocL+9NLiNS1pw1G9hPZkqqxA/KVJXLkMJkR6ZjSh5LisUgQdj7
         cgF12oTDGyzkKuF5AaDqJK1e17L21A4au7Nha4dpt6fManfgXVwn8NK8Jimp9pbOtpAJ
         o/FrA5Mm8AWe7BXdbh6k2PinUtw+58aIFaOwKcBtk/Ztyla1PaYAYdGCBrsqqXM2l3C4
         ICRQ==
X-Gm-Message-State: AOAM533Upz8ItQC9WlhFbU4Da3ZHsed7hgfClNsQiojAjieG7jUwE4bN
        SqD3XgF8+bFEcybFlie48nChtzn6uy5SEQ==
X-Google-Smtp-Source: ABdhPJzgB6pABZfUCqzYU5+XoKCnqcdhCnrEVNm5buhTJd/7I3+L6cPz4jgjDah70Sqq3REfjaljbQ==
X-Received: by 2002:a1f:b6d4:: with SMTP id g203mr13144421vkf.2.1598543027253;
        Thu, 27 Aug 2020 08:43:47 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id v191sm454871vke.33.2020.08.27.08.43.46
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:43:46 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id g20so1797145uap.8
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:43:46 -0700 (PDT)
X-Received: by 2002:ab0:3114:: with SMTP id e20mr12437342ual.104.1598543025890;
 Thu, 27 Aug 2020 08:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <1598541694-15694-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1598541694-15694-1-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Aug 2020 08:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VzkwnxqZ04dqWUdZ+RJ4ioSJ4ruBp9u8NxL3mvuwJnuQ@mail.gmail.com>
Message-ID: <CAD=FV=VzkwnxqZ04dqWUdZ+RJ4ioSJ4ruBp9u8NxL3mvuwJnuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Enable restore_dll_config flag for sc7180 target
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 27, 2020 at 8:22 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On sc7180 target, issues are observed with HS400 mode due to a
> hardware limitation. If sdcc clock is dynamically gated and ungated,
> the very next command is failing with command CRC/timeout errors.
>
> To mitigate this issue, DLL phase has to be restored whenever sdcc
> clock is gated dynamically. The restore_dll_config ensures this.
> Enabling this flag with this change. And simply re-using the sdm845
> target configuration for this flag.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)

Whoops!  I was too busy debugging and preparing patches and didn't
realize that you'd already sent this.  Sorry for sending it too.
Let's take yours.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
