Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DFEC4320A
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6022E610F8
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhHYJX5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhHYJX5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 05:23:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2306C061757
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so51491535lfg.10
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=771qu+rp6BGafDpnrM7TfmSbulL3Y6LRyi6bHCZ59SE=;
        b=LjVRBD97AoDFirac+tcvdpXdVyFR41dyauVow1TKQLexDAwfhUl93uz5nFPTA5Tgq/
         9ZPcK1dIb8iqHi/R6Vchd9ZiptuDxctvYJvEApP3WVbCCahEfUmIEyoWZErvxs5scDZR
         4lXgAg0RGgXrtKIjf/JudDddln9q7MBefIvOA9ag2i/vJwJrFmtcwEvddNRLy5sy7fYm
         PIFNG9qJ0qETCf4SjltAX3BDDYOfScFt5skEZ0yJFPygs0gHofPaKp+zaevQWeq0szOa
         aq+GLpDi+zu1shjseVAYKbxXL8afhXaskx58mTLtkoxpQ7B3O9mgpoc8rE3tLlQOs3ey
         ckcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=771qu+rp6BGafDpnrM7TfmSbulL3Y6LRyi6bHCZ59SE=;
        b=OReRIoxDS3JSgCVba+xNOU2xRaJ9ZaYBKFiCgeUlHglcL7FtsIWUyTCNesv6N6EX3Q
         jprhLqDuFik1WlbAYmjVVT9SrXPxUpWuZhfYuVuN+/Cbs0gb/6Oal7Djp9HBDbQ+KY+X
         zSsLwd6U2sIEqGwJAaRhBvXFqog27TMV0netW5wIM/ZXS2TxdHfJbh02G/sd80z99rcc
         rVgnAAycOd6GI9WZhXLp0Og2f8QJB72Sh83f8kG74tojy/DDnQeFw/anTu7EzMBpyrhh
         u8k8QLjapnvjHMvgCje+tlRP7E6tUn/dap3kzQgTFPv4YjaJ+m13/bwAAssvsMqyl58A
         r4+w==
X-Gm-Message-State: AOAM531LvvXnvI40AzdnRaFPUcWwH9iZNQPG0ngxfEcYmkMLLUeuCmpW
        6j4kjdAexcyf7H8Qhuv2hjaQ8EMWLWq3n46rlN2pPA==
X-Google-Smtp-Source: ABdhPJwYvcNUxeodfv8be5srORL/NbwXKV09h1a6yC3RGliZE4vRHmh+2BPUYpsRAlrLL+O+DDViBQwverphTfXiW6I=
X-Received: by 2002:a05:6512:318e:: with SMTP id i14mr32916390lfe.113.1629883390286;
 Wed, 25 Aug 2021 02:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFr2z6t0uefxioLHaszvwrc9Pkf1OJDi=jozjpEZcKP5ng@mail.gmail.com> <VI1PR04MB5294D4EE6173C4897ABF496090C69@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5294D4EE6173C4897ABF496090C69@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Aug 2021 11:22:33 +0200
Message-ID: <CAPDyKFrA929iRMdZMmA1qYcYtufRzahcP7uc3Vwsw1C1MGeTJA@mail.gmail.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code for
 manual tuning
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Aug 2021 at 04:16, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: 2021=E5=B9=B48=E6=9C=8824=E6=97=A5 21:53
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> > <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <festevam@gmail.com>; linux-mmc <linux-mmc@vger.kernel.org>;
> > dl-linux-imx <linux-imx@nxp.com>; DTML <devicetree@vger.kernel.org>; Li=
nux
> > ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code fo=
r
> > manual tuning
> >
> > On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > For manual tuning method, already call esdhc_prepare_tuning() config
> > > the necessary registers, so remove the redundant code in
> > > esdhc_writew_le() for SDHCI_HOST_CONTROL2.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >
> > While discussions on the DT binding, etc, continue with Lucas and Rob o=
n patch
> > 3 - do you want me to apply patch1 and patch2?
>
> Yes, thanks!
> Let's wait comments for patch 3.

Alright, patch1 and pacth2 applied for next, thanks!

[...]

Kind regards
Uffe
