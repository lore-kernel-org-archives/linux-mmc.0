Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D71C47086
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 22:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71550613CC
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 22:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhEYWuD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYWuD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 18:50:03 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77697C061574
        for <linux-mmc@vger.kernel.org>; Tue, 25 May 2021 15:48:32 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x1so11011553uau.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 May 2021 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bACz+uWUWzOp4UEC6O9uu3jXtuOafDPeE6VNUTx5ei0=;
        b=UzDE7fC0O77x6tkWPluXHZp3DSFJALRojTENB9zST/zQFLyTsk9wiQ7/eLkkWPVcEM
         vAZxYS1XH35fxaajf5sIA2/4sLzZ+YdUFxA+78qZbQ1ISnOsj6+L5oDaEvISAVUyRjnU
         6ZQQL0w3x6TtzbRBhhjXNmG5P3sPmbLBqlvmz6gQi5lLlFdaMQgcua9GSCQOjtFf1Q2j
         dVL0zxRbVi4d3I31g7PrNuTCYYCN29ecbdGN+wM4qYTfWXbZyPVMcaYZY7TvgCTU0+Zg
         +nsgNw81NoQDlLDgKDfAGB6NFt9SjdGuEUHRGTs5RGBClOpZq7MtwnioMYl7yXyhqk0C
         Mevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bACz+uWUWzOp4UEC6O9uu3jXtuOafDPeE6VNUTx5ei0=;
        b=VUuw7qjfR7y9/VuT3TJz3WiYRcEd8jrtmVXfI5e8ixG0H8q2XBV4BGBBoSBWoWo15Q
         uMCeaIc4ktL1VJcOn4zVTZp8c/aDJ0mAZ969P16uZ2Mqtd+TMRZfHCy6gm1iwuXSwRWb
         GPoFfdhLcDb/p3wtlytmwxQuwOT7Nvg7fb41HNAPCfmxLHcdfsWsexv6snh2AAsn6oyA
         Fqs5JM/poAh6wRd3D3uzXWBkKCp4EAqB2ov82hBomM7TtV/6WuZTzujLxcjHKZOLwAeL
         Jx7AXBBzoN5yAkfHxyz2oqNjGTpTWU7M1k47IGjMC1lCJIekIp1Y3qwWiiDH8o4AdR3E
         O1cw==
X-Gm-Message-State: AOAM533jk4XukqIU/CzQnlkZyHNdCwKP9E5pn+HSOYAKdwxMsDyLVQeY
        cm+q6mB4ZC/wtbbRRT5aELdMShsAAFBIi0lGBQIYJw==
X-Google-Smtp-Source: ABdhPJyme8DOfut1deY3oWH9+ZvPbcbZ8DL6LY3gvwTY3/NOWOaJNwqpxMlWwT9iFXPtMIPXMHDmL+3y1f8kIeHD0R4=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr11170948uak.104.1621982911286;
 Tue, 25 May 2021 15:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
 <CAPDyKFrS3wdYs3AQtjZEOsLzNvxgy1n3EfxZ+a8w8J8rH8kQ-w@mail.gmail.com> <7c973bfd-8fc3-026d-351c-dc00e92c8b01@wanadoo.fr>
In-Reply-To: <7c973bfd-8fc3-026d-351c-dc00e92c8b01@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 May 2021 00:47:54 +0200
Message-ID: <CAPDyKFptO4PRc=kxd9k8CkofGfyfJB6pdxP-wzrNpSHv0+ya0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs-mmc: Disable the 'reg_vmmc' regulator when needed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Chris Ball <cjb@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 May 2021 at 21:31, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 24/05/2021 =C3=A0 15:59, Ulf Hansson a =C3=A9crit :
> > On Fri, 21 May 2021 at 14:36, Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> The 'reg_vmmc' regulator is never disabled. Neither in the error handl=
ing
> >> of the probe, nor in the remove function.
> >>
> >> Add a managed action to do the required clean-up before a 'regulator_p=
ut()'
> >> call.
> >>
> >> Fixes: 4dc5a79f1350 ("mmc: mxs-mmc: enable regulator for mmc slot")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >>   drivers/mmc/host/mxs-mmc.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> >> index 947581de7860..b043d53dd728 100644
> >> --- a/drivers/mmc/host/mxs-mmc.c
> >> +++ b/drivers/mmc/host/mxs-mmc.c
> >> @@ -552,6 +552,13 @@ static const struct of_device_id mxs_mmc_dt_ids[]=
 =3D {
> >>   };
> >>   MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
> >>
> >> +static void regulator_disable_action(void *_data)
> >> +{
> >> +       struct regulator *regulator =3D _data;
> >> +
> >> +       regulator_disable(regulator);
> >> +}
> >> +
> >>   static int mxs_mmc_probe(struct platform_device *pdev)
> >>   {
> >>          struct device_node *np =3D pdev->dev.of_node;
> >> @@ -591,6 +598,10 @@ static int mxs_mmc_probe(struct platform_device *=
pdev)
> >>                                  "Failed to enable vmmc regulator: %d\=
n", ret);
> >>                          goto out_mmc_free;
> >>                  }
> >> +               ret =3D devm_add_action_or_reset(&pdev->dev,
> >> +                                       regulator_disable_action, reg_=
vmmc);
> >> +               if (ret)
> >> +                       goto out_mmc_free;
> >
> > Even if this improves the behaviour, there is a standardized way for
> > how we deal with regulators for mmc.
> >
> > 1. Call mmc_regulator_get_supply() during probe to fetch the optional
> > regulator. If a regulator is found a corresponding OCR mask, in
> > host->ocr_avail is assigned.
> >
> > 2. In the ->set_ios() callback, invoke mmc_regulator_set_ocr(). This
> > will also set the correct voltage-level and turn on/off the regulator,
> > depending on the requested OCR/voltage-level.
>
> Hi,
> I don't know this API.
> I've tried to look at a few drivers to see how it was used, but it
> didn't help me either.

Okay.

>
> So, I won't be able to provide any other proposal on this. It would only
> be trial/error.
> It is yours if something needs to be fixed here.
>
> Anyway, thanks for your time for answering and trying to show the right
> direction.

If I put together some patch and submit it, would you be able help to
run some tests of it, as I don't have access to HW?

Kind regards
Uffe
