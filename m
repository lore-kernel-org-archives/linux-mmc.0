Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E754EB64DD
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Aug 2023 08:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjHKIm7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Aug 2023 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHKIm6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2023 04:42:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69092737
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 01:42:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76595a7b111so131510585a.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743377; x=1692348177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIQ8i+p6xQBSmS50RICthOqhzAEen6knjOOfWucKUo0=;
        b=PK2zaxI86OBdWOplcWQrdJT4YBkklK4oNO/VuSXS+lFXm2dwqf8Q7OdES2R21uodd+
         0mCDb1oAAKsxTgVPgOBKkHD1F53bAbvC9WnARW1I19fYqJkyKN0klZ2sLVZxvfBaU4NY
         er8x8pQbPVsIO6v3EaEZd1ymermEzo2GkGbh7WP6l0AYIKt0zYvxOCmYa6cU6jmA1/8T
         fQDaD32WIvVu9c4sRfzO4A3pDQQOFj/KoIr9rWzNicQLRy/xnh+j80eqPMojvd0uBYGn
         NCybKbeUg3PHE1GRbdjMq08+94K5vFTVPhwfwMINI1KcDneOKQP+9KfP6gcBozfZ7Nic
         p69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743377; x=1692348177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIQ8i+p6xQBSmS50RICthOqhzAEen6knjOOfWucKUo0=;
        b=AxB2WXQnT21l9j3zYUSnucyWbMJeMzUgSSqzE68gwMT8ev7+ePs5kZ7ljxORPSlwlW
         o9y7c0QS30EYvTsm50+7cacXXRtW7QC4sSdPxzClsV6saX/sMksOQSWqEw98dJBZenNH
         7ujUfZqUhtVCAy0/p53Ys6cXgsNH4Ceogcg7awrAppbC0tHb/DQONp72I/+XFwfFt5sz
         iyxXEV2smskLhHYi89ZykfF7yLxNVpNP6pP0kFGjwtnuHmCZOXdWTXugerfxiG38zoqQ
         tW36VhHkvqX+fKyA8gV1bFx//A4sNPC36Xil/OvA/tXg7D9A45m4T9xotWsW1Dnx2OuJ
         FDWg==
X-Gm-Message-State: AOJu0YxwI2d3ccm3o9NmEX3wGHClz5mKNseS8jgPRCOxe/UnEI/ySo7G
        X4miil5H06pcXTvHTH2d5f4jHANI0Sn4sUp4MQdZIw==
X-Google-Smtp-Source: AGHT+IFrx/4nZm7LJ0PluTRh1rL9k5kfKdhaOHdnTImTV8OsOurdhQMQ8BuJbfOtM9H1PspnCHrz1rnGbv/vJJYac1I=
X-Received: by 2002:a05:620a:4101:b0:76c:ad46:2670 with SMTP id
 j1-20020a05620a410100b0076cad462670mr1610010qko.45.1691743377029; Fri, 11 Aug
 2023 01:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230809052952.323-1-wenchao.chen@unisoc.com> <CAPDyKFoykxdP70t2pjeiX0pkKuUCZ2AeFM4yT4-wfVijxB7OHw@mail.gmail.com>
 <CA+Da2qx52QVk5Hz2PdY78qHRmspkDkXbWCWbUOGXCt2nbjNW0Q@mail.gmail.com>
In-Reply-To: <CA+Da2qx52QVk5Hz2PdY78qHRmspkDkXbWCWbUOGXCt2nbjNW0Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 10:42:20 +0200
Message-ID: <CAPDyKFoHwg3MvyNTTTnZLhsEA0Zhj6ZU+fZkhf8rGeoTsnTDJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Aug 2023 at 09:23, Wenchao Chen <wenchao.chen666@gmail.com> wrot=
e:
>
> On Wed, Aug 9, 2023 at 6:09=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 9 Aug 2023 at 07:30, Wenchao Chen <wenchao.chen@unisoc.com> wro=
te:
> > >
> > > Added .prepare_hs_tuning and .execute_hs_tuning host
> > > callbacks to support host-specific tuning for SD high
> > > speed mode.
> >
> > This certainly needs to be clarified more. Especially why it's needed
> > for the sdhci-sprd variant.
> >
>
> First of all, Unisoc's IC provides cmd delay and read delay to ensure
> that the host can
> get the correct data. However, according to SD Spec, there is no need
> to do tuning in
> high speed mode, but with the development of chip processes, it is
> more and more difficult
> to find a suitable delay to cover all the chips.
> Therefore, we need SD high speed mode online tuning.

Thanks for sharing this information - and please add some of this in
the commit message next time.

[...]

> > > +static int mmc_send_tuning_data(struct mmc_card *card)
> > > +{
> > > +       u8 status[64];
> >
> > We use kmalloc-ed data for data transfers.
> >
>
> Why is it better to use kmalloc-ed data?

If you use DMA for example. From the core point of view, all data
should be kmalloc-ed, if it's a data transfer and possibility that
that DMA is used. Hence, it seems reasonable to conform to this
behaviour when using this helper function from the core.

[...]

Kind regards
Uffe
