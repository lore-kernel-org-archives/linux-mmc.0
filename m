Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14012C55179
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CEF21D24
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ck9y9jNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440592AbgJ0MoP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:44:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440548AbgJ0MoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 08:44:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id h5so1734856wrv.7
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HBFttdYAiRM1KfFacsdZju3R8FEz52UG6psn2mn812k=;
        b=Ck9y9jNdJH1H9KVu2owJyTBu42rV4XSWLdMUbByrEIQhakBN7YO3viBNE7ywGE3yJV
         21nxkfIOqKJYmVR7phi6Mzl7xabBrqCSHVDvC6wQjQdXQwgh7fpBlxLd0spJm6TD1f/z
         i8rfkkdL3rv1kNNzjwl5ccwoTqDMuUQz+sXBzzY6oWTJcr7pbtuUho/VDBaGCbA+JUFy
         8rFIc0Mph/wTGNCdJiEdu+j+TUPeGOqq7vp55s9RrKz7oPhApmbGbRXD5yrp3Ko8tRiS
         uvrWHwR+8dFXWShuf4c5KsxIDyJiXxw78K3ZGM/ChFHu1dDwpDKmBilfGofXcucVgkOj
         pjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HBFttdYAiRM1KfFacsdZju3R8FEz52UG6psn2mn812k=;
        b=pf62aOz+BNV6QuZWOm+fVwUFZxegbD7x9IOKllGpue6DpFaSUw/1xPEWaWJJ0q8qIR
         XRuKqhgjPt6ZC5loVuFCG2sirgQfRC1ksk1spwMcIv6NxuinggDVpeJQBkBNLmvKB8Bt
         G9QHyIJDk60WO6wLu+B0HgTuSWrn+j1pbgs9Y6xUi0A5olO4pZ4roKvW/4R2JUWnfmg7
         fXHtXe9fbTn/kl/P5ZoI8L0Fu9ffCdrSY3y5DzLQJLUHoTLKBkx264GPNP2TiTuEiOGP
         C8qC0NQdm2RK7L8N/xeyRI1HjSIjXFAlbFrFO3MgLE0bG9Vw7bwMDulxqv2tTblK3WhL
         /o8w==
X-Gm-Message-State: AOAM533wAKJ0iVWJ5/3kS0GxJGe+E9vwChzCU38bXX6BSYHR4O7A7Ah4
        i6vzhTtI5g8+1y2/Ih64yWe3kQ==
X-Google-Smtp-Source: ABdhPJxGIvXpfpZxv774x6oG+TdKSVGildynsy97gcSuNQ0khyKnhSHNQjEj6Ais+Xmhl4PIo0XW7A==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr2855003wrg.152.1603802651408;
        Tue, 27 Oct 2020 05:44:11 -0700 (PDT)
Received: from localhost ([2a01:cb19:8ae7:9d00:68a3:7a03:6c11:8947])
        by smtp.gmail.com with ESMTPSA id m14sm1891082wro.43.2020.10.27.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:44:10 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list\:ARM\/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
In-Reply-To: <CAPDyKFrMwLeuQoFDgXYo_-T_e2AzfqM-rgp3-SgeuC6Qn6rxMA@mail.gmail.com>
References: <20201023122950.60903-1-fparent@baylibre.com> <CAPDyKFrMwLeuQoFDgXYo_-T_e2AzfqM-rgp3-SgeuC6Qn6rxMA@mail.gmail.com>
Date:   Tue, 27 Oct 2020 13:44:08 +0100
Message-ID: <87wnzbg7on.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

Ulf Hansson <ulf.hansson@linaro.org> writes:

> + Yong Mao, Chaotian Jing
>
> On Fri, 23 Oct 2020 at 14:29, Fabien Parent <fparent@baylibre.com> wrote:
>>
>> MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
>> devices sometimes unstable. Make use of the new property
>> recheck_sdio_irq to fix the SDIO stability issues on MT8516.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Maybe this is a common problem, thus I am thinking that potentially we
> should enable the workaround for all variants?
Not sure if this is of any help, but: we use the btmtksdio driver on a
MT8183 soc with an Android kernel based on upstream.

With that kernel, we did not to apply this work-around in order to
have a stable bluetooth experience (pairing with a remote controller)

However, on the MT8516 SoC, it's impossible for us to use btmtksdio
without Fabien's fix.

>
> I have looped in Yong Mao (who invented the workaround) and Chaotian
> Jing, to see if they can advise us how to proceed.
>
> In any case, I think we should add a stable tag and a fixes tag.
>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/mtk-sd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>> index a704745e5882..3dc102eefe49 100644
>> --- a/drivers/mmc/host/mtk-sd.c
>> +++ b/drivers/mmc/host/mtk-sd.c
>> @@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>>
>>  static const struct mtk_mmc_compatible mt8516_compat = {
>>         .clk_div_bits = 12,
>> -       .recheck_sdio_irq = false,
>> +       .recheck_sdio_irq = true,
>>         .hs400_tune = false,
>>         .pad_tune_reg = MSDC_PAD_TUNE0,
>>         .async_fifo = true,
>> --
>> 2.28.0
>>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
