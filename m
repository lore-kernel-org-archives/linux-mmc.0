Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F66C4708E
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLGMjR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLGMiq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F92537E5
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:38:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso3434770pjb.1
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftIdHXeTfvJOcHwEMmydwgNHWz0w2lMgLkoOTS6zmnM=;
        b=WekQdNmKr9w/cng+laZBpVt6ZO9l0HTAezffQk61tzfCe1yIASGEdJDbidH1t4aVTg
         c6zBu4ciPOzpCHCLuQJbAzb2xSUWwLLSJBksxF4cXdUBE1SW7oQ6jTfizGePKjHZfbX+
         RF/s/xskC80htQdKS0BN4VQraro8znw/9f8/Ao0gJvzWhg4Go2H4Ysyy5rRwRAb09VvF
         0oO0NDegcWbKPUJuZQ6G+aNaUw+zMOHs0pIQX4YG/UhoUOvdZyktwPAfmIJeMmrEjy7x
         p08XnJhcr73LqailYt6fgMOOMcKL/I0yUFJzjLYma9S08wJAD16Cgh9iuRA/46ZbgwaM
         VUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftIdHXeTfvJOcHwEMmydwgNHWz0w2lMgLkoOTS6zmnM=;
        b=l9N9HuzDrDx42fJkgMVVhahpCbUu1wTXJ5Z6ntF1hoZpLFhQoA23NOgTtXfk9buIn7
         DHrhlG6CrFQakVPTkGb64O5eAfMJA1enTQ8nD+dCsXYYk/UH4AcVLVMaXTzZnwA12LKE
         2oY6O4iRA9skvqYt+lAoD18H5WSD/+PH5bCATtzEZ0lbOe0W5bXDy/GljlcfwhZ+9o0/
         QIfkJUJOm83OlDwGYrqq5hjxFnTpQWVWPTTfvkPI5Xd5AOc4I55c6ciOsUQ/m2XQbAoP
         /tY2N/BDDSWCBe46caUNprA7A2OEQc6zqCZkZWva15K3kixL5MTZYQyqr+ZNTnAsJ5b/
         8/Kw==
X-Gm-Message-State: ANoB5plBy1oCllg9Pdx2AxTeJWSxk5jE2oOwI5492c4DtrGg53DUAo8i
        ln0EtsWgUr3VmldDkCvnKLEF+DXBeblFRPV7UmkmTw==
X-Google-Smtp-Source: AA0mqf4ubzj6wKnK5CR+BdduHGKcRpTBXdJF6vB1LmXbt/tTjXSMolNVL2IVIpY8+8+0DJ12Z8HkMdfZqA1mxPtaJYQ=
X-Received: by 2002:a17:903:40c6:b0:189:f799:676e with SMTP id
 t6-20020a17090340c600b00189f799676emr2719080pld.148.1670416712880; Wed, 07
 Dec 2022 04:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-5-adrian.hunter@intel.com>
 <20221206230321.3868754-1-michael@walle.cc> <210ed185-b98c-baee-e58d-b7ab51e3d0a1@intel.com>
In-Reply-To: <210ed185-b98c-baee-e58d-b7ab51e3d0a1@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:56 +0100
Message-ID: <CAPDyKFrBh9mEn15-U1JM4EAofsGXnxjmqr88JVvhzsF9YMTQog@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] mmc: sdhci: Enable card clock instead of ->set_clock()
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michael Walle <michael@walle.cc>
Cc:     alcooperx@gmail.com, andrew@aj.id.au, ben-linux@fluff.org,
        briannorris@chromium.org, chevron.li@bayhubtech.com,
        eugen.hristev@microchip.com, f.fainelli@gmail.com,
        haibo.chen@nxp.com, huziji@marvell.com, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, manjumb@synopsys.com,
        prabu.t@synopsys.com, quic_sartgarg@quicinc.com,
        s.hauer@pengutronix.de, thierry.reding@gmail.com, vigneshr@ti.com,
        vireshk@kernel.org, wenchao.chen@unisoc.com,
        wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Dec 2022 at 09:13, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/12/22 01:03, Michael Walle wrote:
> > Hi Adrian,
> >
> >> SDHCI has separate controls for the internal clock and enabling the
> >> clock signal to the card.
> >>
> >> The card clock signal was disabled via SDHCI_CLOCK_CARD_EN to avoid
> >> glitches on the clock line. It is not necessary to reset the internal clock
> >> to re-enable it. Instead re-enable by re-asserting SDHCI_CLOCK_CARD_EN.
> >
> > This commit breaks my board
> > (arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts). The
> > full bootlog is at the end of the mail. Reverting this commit will make my
> > board boot again on mmc/next. What is strange though, is that this board is
> > also in the kernelci and it doesn't happen there. At least on a quick
> > glance at the next-master-next runs I couldn't spot the error.
>
> sdhci-esdhc ->set_clock() is esdhc_of_set_clock() which changes its behaviour
> depending on the transfer mode, so presumably the clock must be recalculated
> for e.g. HS400 so the ->set_clock() must always be used when changing
> transfer mode even when the clock frequency does not change.  As before,
> there could be other drivers with similar issues with this patch, so Ulf,
> please drop this patch also, sorry!

Np! We have linux-next, to help us with testing of these kinds of issues.

>
> >
> > Unfortunately, I don't think I can debug that on my own. But I'm happy to
> > help and test suggested patches. But I really don't know whats going on
> > here.
> >
> > -michael
> >

Michael, thanks for reporting!

The offending patch has been dropped from my mmc tree.

Kind regards
Uffe
