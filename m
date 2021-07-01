Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B57C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 03:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C939C61461
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 03:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhGADoY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADoY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 23:44:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9CEC061756;
        Wed, 30 Jun 2021 20:41:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z3so4756563qkl.4;
        Wed, 30 Jun 2021 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VhM4pPQsX2jvi1Hr26+bWdnColR+Yy2aHlEsyV945cQ=;
        b=Y92c3YBt+WFSyIJr9AZLpb6tG1n1DC86sx9DzsUDTYz3fhkE/ihkBNbqPE+vuG2ocY
         dv66fFY8612s2n+OMrCAf9ou3w5zZq27GUv/JjbujZDudo9u+wywqjK7YXeJBJZvKIrW
         4keRNZ2IKqZR0OmWt27RmMczC8nvkAW0XqmDDQwm437S5RR1Z4BSn5vPjvENZpc7gvXj
         rx2XV/7fhzCr+ON0bcSvifHNgQz8K6LnMq3ygsKEn9o9FN9cWvS5N9F/oIvUfpbGPaXi
         9fd2UcS7ZnpvNr6mm4/IuljhIhrNlCCUpTEuVa2+dywJEbxCMZYN8+CrdKMki37GZvah
         2Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VhM4pPQsX2jvi1Hr26+bWdnColR+Yy2aHlEsyV945cQ=;
        b=ky3pFRb05iPN1knjaKwEk8bJtl/I7fCH4Ez0IHvzPJiS78NQ8Rr7sDlQQfr+427/3u
         1ZDNbQfb9ffWFkoScQltu7rcW1eo3c3ap936SllZKVz9Kbv7OKIvWfYkRs5PxkVaSUPA
         671OoKkk4qkkahjQQEzxwvbJvvrlVygFx0AoA04UfSYeoU0MFiLM8VkRBlw3tsydwXf+
         7hf0FUTWCiN5DydgkS89L7LfJ8sNVqTxkV71wx6Jh0JrKOVOcyShORCHAOllbAajQ6k9
         Eq/jMY+hLr0+Xpf594rkYqwcIFyhGMnkRNJz4TJR9Y29TnQKnBQaWhEQDxTSJx1TVUEr
         DoYA==
X-Gm-Message-State: AOAM531mjC1AWQRlbYz73SEuKiMIUeLZhN8AMMHRXwXlb2CTh733oQ8z
        I6GKHA9KXqdYOyMzckApfye6OasKo0if+rEZ9v8=
X-Google-Smtp-Source: ABdhPJxUAxHyUqqsEeK7b/yReMQRkNOJe/b5D2eF54KpwHswOvWXOUq17Q79PJRUecB1FQ2YeThnlGjxPNJL1ASRfVo=
X-Received: by 2002:a05:620a:c84:: with SMTP id q4mr20190735qki.495.1625110912539;
 Wed, 30 Jun 2021 20:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210624025647.101387-1-reniuschengl@gmail.com> <CAPDyKFoQNDTe8__eUmmbE=98HgjERYudzjyRu1fr2ZCyWXuqew@mail.gmail.com>
In-Reply-To: <CAPDyKFoQNDTe8__eUmmbE=98HgjERYudzjyRu1fr2ZCyWXuqew@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Thu, 1 Jul 2021 11:41:41 +0800
Message-ID: <CAJU4x8tAoHebcynA1+UdAiqF4kRYgzEpu2qpzcikfUSKxjL3AQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune GL9763E L1 Entry Delay
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=8830=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, 24 Jun 2021 at 04:56, Renius Chen <reniuschengl@gmail.com> wrote:
> >
> > Finetune the L1 entry delay to 20us for better balance of performance a=
nd
> > battery life.
> >
> > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 302a7579a9b3..4e3c0561354d 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -90,7 +90,7 @@
> >
> >  #define PCIE_GLI_9763E_CFG2      0x8A4
> >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > +#define   GLI_9763E_CFG2_L1DLY_MID 0x50
>
> We just changed from 21us to 20us. Really, how big of a difference can
> this make?
>
> Moreover, I suppose the difference is related to the running use case. No=
?
>
> If you really want this, at least I want an ack from Ben for it, then
> let's be done with it.
>
> Kind regards
> Uffe
>
Yes, according to the result of our customer's PLT test for battery life,
It will pass the test with 20us and will not pass the test with 21us.
I'll ask Ben for acking this, thank you.

> >
> >  #define PCIE_GLI_9763E_MMC_CTRL  0x960
> >  #define   GLI_9763E_HS400_SLOW     BIT(3)
> > @@ -810,7 +810,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *=
slot)
> >
> >         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
> >         value &=3D ~GLI_9763E_CFG2_L1DLY;
> > -       /* set ASPM L1 entry delay to 21us */
> > +       /* set ASPM L1 entry delay to 20us */
> >         value |=3D FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DL=
Y_MID);
> >         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
> >
> > --
> > 2.27.0
> >
