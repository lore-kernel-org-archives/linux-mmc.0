Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C98C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiEYQLH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiEYQLG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 12:11:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D00AE27A
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z15so6958678wrg.11
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CPLQ14WaiCX+ILz1Hrgp1Qbb/fI6CZrPndnwjE4cb0=;
        b=bjg0YEnXgGSPysZv/QsYyuc6SlwU0HsbcG+2lJ5biIG8XUTtXJ0IXRooICluaTFiZW
         x/71ssLox5GE5C/gYtX7JF+/RAI1gXUQZcbiWYoiX7XPUpEHQ0sMkLug5EA1s1kKTfw2
         i5e8L5FPS6gqKufi+55OhSiYsUZ7FmsPvniCP8tIr7XAgRFWXc8WFXY9tFnH0EIMo/Cs
         QHgcL9TGiij1Y1zK9tGsBql9Y5Ng4cmMrDJMzD+xLcSsG5KEL4ihtvtyLPWiXDtFoMuq
         vEifY77fl88ZfD27gYLuc3vVulnB2AaWjw2MPlkVaAWdUEtXHk0H5UBf75+ExeCEDjvf
         x6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CPLQ14WaiCX+ILz1Hrgp1Qbb/fI6CZrPndnwjE4cb0=;
        b=k+imNPKuhO21RC3Wv5VN9dEWh3aIbpK5uKUYXHo+DZRlvvRYEEYz5mXFhONDvrqR3j
         tBeX8pBEbrIRop+bZsxHDQo0es8m5fKGfMrjrRLGAw990zz/kM/uGUpa5nt+kT5YieND
         van3yizE+EkmIgjAR+7eWCJqs4q2MGbq4EqpDXDAfYXAWcaNsrHHZHNTVjbumsD6uREE
         mvySOn3MZA1D0XRJq0/Ztj2TgM9HQ9gzDgvvMni56Ucz0T2GcLpenDlRiE9HWgNosO2P
         2A+OL80fuLaYDWMN/j/x2b6PWxksq8bWjECmE0vQzS0BEISAvTiKijnaPyUvgDtviIuf
         wckg==
X-Gm-Message-State: AOAM530yqStNv1HPi7uwXnFZmcr+o4DnnE1C+P+f2k+K4Yf3Fd/HNAWT
        2XJjci1zWDw3RaWa0migZv1WrksdmFbvOcgKHbrE4g==
X-Google-Smtp-Source: ABdhPJya9POSR16TPN0e/q8mW1cFMbbUYlTzpoiumLvvphZabXWlEbHKhIWt0nAFBXWP7vgbnXf7hUJ4jmzGIiL3yGc=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr27861460wri.90.1653495063669; Wed, 25
 May 2022 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-10-brad@pensando.io>
 <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
 <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com> <CAK9rFnwsMd1+oQ8cg8Biw7HM=R6aOudfK7Ja+E+iGVgfrvC9Gg@mail.gmail.com>
 <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
In-Reply-To: <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:10:52 -0700
Message-ID: <CAK9rFnzBDgBCFN+UJJnpkEPFGwbjkwAcjGjM2E_yF43iMDs+2Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Arnd,

On Thu, Apr 7, 2022 at 1:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 7, 2022 at 7:06 PM Brad Larson <brad@pensando.io> wrote:
> > On Thu, Apr 7, 2022 at 12:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > What is the relationship between cadence and pensando elba?
> >
> > Pensando licensed the cadence controller, its 100% cadence IP.  The
> > integration issue we ran into was with the accessors where we have the
> > workaround.  The initial patch added a separate Elba driver file but
> > the feedback was the Elba support didn't justify doing that and to add
> > to sdhci-cacence.c.
>
> I looked back at the earlier reviews now, I think the main problem with
> versions 1 and 2 was that it had the abstraction the wrong way around,
> so you added the complexity of having multiple files, without the benefits.
>
> I still think that the cleanest approach would be to have it the way I
> suggested in my reply to v1, with an elba specific platform driver
> that calls into the generic cadence code, but the generic code knowing
> nothing about the front-end.
>
> Then again, it sounds like there was already an agreement about
> the approach you took here, so let's stay with that and hope we don't
> get any other chips with the same IP block in the future.

Thanks for looking this over.  I won't change for now in the patch
update in process.  This will likely get another look as I've added a
node to the device tree to enable an added reset driver which can
hardware reset the emmc.  The current cadence sdhci driver does not
include this and I've currently added filling out
mmc_host_ops.card_hw_reset like below, yet one more thing different
for our platforms not in the common driver.

@@ -404,6 +550,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
        if (ret)
                goto free;

+       if (host->mmc->caps & MMC_CAP_HW_RESET) {
+               priv->rst_hw =
devm_reset_control_get_optional_exclusive(dev, "hw");
+               if (IS_ERR(priv->rst_hw)) {
+                       ret = PTR_ERR(priv->rst_hw);
+                       if (ret == -ENOENT)
+                               priv->rst_hw = NULL;
+               } else {
+                       host->mmc_host_ops.card_hw_reset = sdhci_mmc_hw_reset;
+               }
+       }
+
        ret = sdhci_add_host(host);

Regards,
Brad
