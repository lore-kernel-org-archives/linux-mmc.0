Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056ECC433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B933961A06
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCXKVt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhCXKVS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 06:21:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67122C0613DE
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:18 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id b5so11033640vsl.9
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rai9ptA+xC3/Xny8ivCblg6SnvuofFN/hfASAUVEIaY=;
        b=rarJ86KGS7v2+Yw3UgGnGrsYvjfihF4O+nb0O7Vgrh3C5fvOyNJ5LgMGSwTpXmyb66
         umOw25twZS8UP8tB/lZwc+fNTtZ0N0SDightizjnoEQy6a/H1e3J9WtyRNQvXqQelBtN
         OCp/fGEDxTuy9ZHDY3rTNsCLwxzstezONxnef0UDo18LbZt8XwoaPtCFywUTk5eOFBx/
         n8Q8oHBfiAv6FnzUP2wNklX/kewvcpsfEDhtzr5vwpQJIGkqmntxjeGUQCsM0emLr5Sc
         Y2CaOHBguTco4R7SMw72k3euQ2cr1DBvdmdbE/So4hdNNd3SGThn7fZflUVrL060/99m
         I0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rai9ptA+xC3/Xny8ivCblg6SnvuofFN/hfASAUVEIaY=;
        b=d/vyRdxmdZxw12fI1b9Yu5wVMQ/El1KZAFxrDBXYPdg4XF6pVp94XLTa5l4bGuq4cL
         xSPEhd5szWfmWoI0rm+qIzXpSX73dn4f3sjYC2GLNx2O2R0yA8uU0bVmGmnLhrCKdTSe
         lF4D8tyN0Q6XLsYEfnouttImIRlLbVRu5+d612nj2EC2BhmEr/7kRp/O+HpKvqbyww9/
         lE6eVmHP1DchOuYK1jAaKHaabQOw22jUdPVbViJE74W27tFpI5xZZWzbqu4jSg83cJ5N
         U9TjhLKptkwZtAouTYk8Xk/hX8ED3veS5WzFjHdehsts5gnBNmu/qUyUZuE7Bsk8IEMv
         QAQg==
X-Gm-Message-State: AOAM533GnrN763KuljAN95m3hx/C/JKW53/1+y31Pd3FFEd3zNvkRZ2Q
        2mC72hFMIWoE3xFoLbLbevhprDk/jkJttr+fFOQ/a5X9RzYcfw==
X-Google-Smtp-Source: ABdhPJyeFiT+4f3vNk0w+3cOIxyfVF5oBZdNxtqnXYYRA1Gm7IkUZAEtbmPIP217xMPG1nqaZpPFIyJusF7YFCS3BLA=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr929694vsc.55.1616581277550;
 Wed, 24 Mar 2021 03:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210316085717.7276-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210316085717.7276-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:41 +0100
Message-ID: <CAPDyKFrKsZ3CSTF-eN_dSmcwmhETG5O4kg_qoNMYHA=-VizB4g@mail.gmail.com>
Subject: Re: [PATCH RFT 0/2] mmc: tmio: make resets more robust
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Mar 2021 at 09:58, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Here are two more patches improving the robustness of resetting the IP
> core. Patches are on top of mmc/next and this series "[PATCH v2 0/3]
> mmc: renesas_sdhi: reset via reset controller", especially "[PATCH v2
> 1/3] mmc: tmio: abort DMA before reset".
>
> Tested on Salvator-XS with H3 ES2.0 and M3-N. A branch for testing can
> be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/for-5.13
>
> Some additional testing by Shimoda-san or the BSP team would be much
> appreciated!
>
>    Wolfram
>
>
> Takeshi Saito (1):
>   mmc: tmio: restore bus width when resetting
>
> Wolfram Sang (1):
>   mmc: tmio: always flag retune when resetting and a card is present
>
>  drivers/mmc/host/tmio_mmc_core.c | 37 +++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
