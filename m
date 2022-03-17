Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA9C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 09:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiCQJQi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCQJQi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 05:16:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF23610BBF0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 02:15:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z26so6357209lji.8
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2022 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1MUgYWtcEMVkgHdFAk3A3kJou2fD0d65pngloGRSNTQ=;
        b=UsgH2ZiFOG8WemjFk1/D+1vka86khHzHKmc4laP4X1jZtVL8aJ8SoqtwVPiqCDANmT
         2OWzjH1cE3PUBZgUzrHyA5tPWGzz82gxLItLvmCto71845Mu2vciRDLfm90YkAYXc+Q6
         U2nuzqWB8rEZwjt/RSJdH2kuQhaTdcKb6yivGqWn0cvptPXmm3TMHG/pTRkwFPc0cjcJ
         oLwHjBpfIO4JzfhzcN+PJfeMMMxFn/xsWWiRIp3KLry8qFPAbUG4VGClOsYuPB9wHwaL
         Y+vwvZych5xzmqvNgvXNfuLUE0KAmJasopdkmwyht+2MrCPMI/AI0WYsutsYoUd4PLWO
         Qy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1MUgYWtcEMVkgHdFAk3A3kJou2fD0d65pngloGRSNTQ=;
        b=NKUgZhalX+bvWIcFQB7TkDAiVbI7s6uvaLY1DPFNgYx8fgeeV8m0Y2SC6nPudBcqtY
         C0Rb8J4RCiY+ic/6grGgTSHBFUavUVsdPcz4CRtLFJealO4mIjNgkZW/9DXg/4m6ynCh
         DzPDBap38yzkwiWHn67UQPEZvV3rsdL01uiuC6B1cmy2hItGig1QwcYmOYyO64uIyNiz
         VCWnbZ/PEwl+YPHHYOe9ZuWP2dVDDsjZOVcL7Ue3X5qia6sq+2jBb/L1DeWbvndQvNMO
         xft9iWygnT6+ulxfAFX15ONDlOLrtpyZ2bUE/ZEsrSbkJIV0evjb8jxc1KRABUvWFzGz
         2nOw==
X-Gm-Message-State: AOAM532rGIYoA7s2Tx3HmitG3pLm8jX1gvtb6bPTfzQFxUKxr2XDFoU+
        OSj2Ee+Ib8qTAfVRZPYOIwGXt0EUMhaN+ECjkBORCw==
X-Google-Smtp-Source: ABdhPJw9R7+sMQZZJsKQqijXj5U15qGAtmGwCzEJRyOE9ZSoMgZpJsRHZbCoB4X8GqqCSvZHQzRj7MGalen9VOD8z6I=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr2322462ljj.4.1647508519646; Thu, 17 Mar
 2022 02:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com> <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com> <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com> <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
In-Reply-To: <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Mar 2022 10:14:43 +0100
Message-ID: <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Michael Wu <michael@allwinnertech.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Mar 2022 at 17:08, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 16.3.2022 16.46, Christian L=C3=B6hle wrote:
> >> So we are not going to let the block layer know about SD cache?
> >> Or is it a separate change?
> >
> > I have some code for this laying around, but as it requires reading, pa=
rsing and writing Function Registers,
> > in particular PEH, it's a lot of boilerplate code to get the functional=
ity, but I'll clean it up and send a patch in the coming weeks.
> >
>
> We have the sd cache flush.  We would presumably just need to call blk_qu=
eue_write_cache()
> for the !mmc_card_mmc(card) case e.g.
>
>         if (mmc_has_reliable_write(card)) {
>                 md->flags |=3D MMC_BLK_REL_WR;
>                 enable_fua =3D true;
>         }
>
>         if (mmc_cache_enabled(card->host))
>                 enable_cache =3D true;
>
>         blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);

To me, this seems like the most reasonable thing to do.

However, I have to admit that it's not clear to me, if there was a
good reason to why commit f4c5522b0a88 ("mmc: Reliable write
support.") also added support for REQ_FLUSH (write back cache) and why
not only REQ_FUA. I assumed this was wrong too, right?

When it comes to patches for stable kernels. mmc_cache_enabled() was
introduced quite recently in v5.13, so for older kernels that call
needs to be replaced with something else.

In any case, the relevant commits that can be considered as needs to
be fixed seems like these:
commit f4c5522b0a88 ("mmc: Reliable write support.")
commit 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device")
commit 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")

[...]

Kind regards
Uffe
