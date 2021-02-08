Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CB7C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277A264E76
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBHMIW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhBHMG2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 07:06:28 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D6C061756
        for <linux-mmc@vger.kernel.org>; Mon,  8 Feb 2021 04:05:48 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id d3so4586919uap.4
        for <linux-mmc@vger.kernel.org>; Mon, 08 Feb 2021 04:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZWBJIaZ/bsVP6p7XHOvoxdJcCLoPklYQ4/+m3orfc4=;
        b=ZQCT0vdtAH18I54cmEsV7LzEgSzw9x7c4g7nvwzJL635j04pCobWhbKJOmCOiqN6r+
         5IkXAW8bGhbfC93gnmBHVgGR87pJ6HRwAa1IDLcZKt1Yqdr58G+VWlMgcoevYFCQquBw
         seer1lf9o+PtoGAZrIBT5QkB1awbktnaAuGJevTXBHBkyNvWitEHL8eSa5Vf8JJ1drVf
         Mw+g6Hg+zfhAPvbAJKEFMJppA9Vz3NcLyLueIlCcKFVOU/RunduQQ8lj1XD8s7xnpiJT
         r4l+03hhnI5FUihva78gdtAaat0pNPztOjdMYftJcbX6TtqwL1jrOz+spgRGcEzlPryj
         /cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZWBJIaZ/bsVP6p7XHOvoxdJcCLoPklYQ4/+m3orfc4=;
        b=ibgkHQcb7QSWMsACLHrJGLpAQthoLltIpK4lGE/9AFEZOveDzASsOtnKRRCBG/K0AH
         aX8RTz5xXsvT3RLIqTd+ToZnm3dIgSE7IGqTW7n90uPj+xTUhl18J06v1a9oLCrO3Xva
         LrfsqBfCULxR1VevZnTKyTjQPtXzEAzkrsvas/xJMxx/01qYK5QumItfK0N9twTvAKT1
         rvZ821EIln81Fe0zJwV8r/iAoBXHSshegPE8SeRdNUT0Rqsf94VtSr5vczAKDomp42li
         IEYWv0rn8LueSMm4xSfuX3dMUUhcydbXDaxMj7LSCVArrIO9bCtqLq7omutEKTy/lg8J
         Rwvg==
X-Gm-Message-State: AOAM532J4s/mjjCYdb9+3cY7GYDJTwKThxKUTvbmIeKiIXrjF2VDS4td
        xKaWzAVevDA3QwAb+LZsq98Od4n+jccAQo5lX4qong==
X-Google-Smtp-Source: ABdhPJwVrctWDibuLobFdPmbjaCLg1dsBCnjJJtNeM+WcG1vzq5+3yOxb/KoilqBgxHQtxtYVgdzhzPKRVER66jAF9Y=
X-Received: by 2002:ab0:2e8d:: with SMTP id f13mr9556269uaa.15.1612785946923;
 Mon, 08 Feb 2021 04:05:46 -0800 (PST)
MIME-Version: 1.0
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com> <DB6PR0402MB2760CA4A3D7DC4D5D6C3D81A88B09@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760CA4A3D7DC4D5D6C3D81A88B09@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:05:10 +0100
Message-ID: <CAPDyKFpWqVAzUwH_TEX7jyTFjZk3S4_9rBpSsdkghTfisSL7HA@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] imx esdhc dt/driver update
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 7 Feb 2021 at 14:10, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH V2 0/4] imx esdhc dt/driver update
>
> Gentle ping..

I was expecting a new version from you to address the comment on the
DT bindings from Rob.

Otherwise this looks good to me.

Kind regards
Uffe

>
> Thanks,
> Peng.
>
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Patch V2:
> >  patch 1, 2, 3 is new
> >  patch 4 is not changed
> >
> > Peng Fan (4):
> >   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
> >   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
> >   arm64: dts: imx8qxp: correct usdhc clock-names sequence
> >   mmc: sdhci-esdhc-imx: validate pinctrl before use it
> >
> >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 36
> > +++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 +++++-----
> >  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
> >  3 files changed, 46 insertions(+), 10 deletions(-)
> >
> > --
> > 2.28.0
>
