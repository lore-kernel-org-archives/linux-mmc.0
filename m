Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E1C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259AD6320D
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 10:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhKOKwX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhKOKwO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 05:52:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E5C061746;
        Mon, 15 Nov 2021 02:49:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so4135828wmq.5;
        Mon, 15 Nov 2021 02:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VEVm94Au7j3K7GJe4k1J7afaK0l1MrS2wNvN8Q0/o/o=;
        b=gdGqBIqST1Jh3LQ9ZQrscXgJNPPC3WnKOB0uc02YpYB3VMdGoVONpVezRjk1/ED+QV
         S2PR/W4V98BRxYP72wPTpxAWT9mnHaTnsO39TM4EKa3jfZspfBcvLKfYAHyVY6DiVwNB
         CV0aadcJugBCffFslqyQq/kFKPgdD/sd1AV7XE/FAEjvvSsx8vWKw/Kw+BAllkvx5vnM
         /msEQ4+prbmC5cTJZIgGRGPM2lwtns9I1twrUD44kDnnGdXDtl7bEkgSNraX5zylfoRA
         inCElKB8KN1KKDrIoiYnp6yUFVVn8gqWU2aV0W5yOz05IQsqC6vaXjchFlSwt73cT71c
         NoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VEVm94Au7j3K7GJe4k1J7afaK0l1MrS2wNvN8Q0/o/o=;
        b=dKRwD8ipjor0heNzFBTmRlKOeH+TeqZ5JafJYZkVIJNTId/ru5NNayur8x44f97+Tu
         Wa0T5mmj92zvpAtPneTfK2uYhVNi5jkTOiS6UE8OoC3x0RhOzxd4p2uGExABh2Z01lDH
         vTPPrL2hT/4eWUK/Qn13wX8MoxS/MX3tSZHY0yy/a2EX4UhPjyd2963l+2mcv/Fkl3rr
         VRSMtYWsaPML/3cEuPcAY0mtGpVUoFiCf3wRwgqGbs99xtP1h+iwqsIbv1jZT+rePgo3
         WMfQocExqLHUFfjjk5deigUySW/R2vMoRgAMHhflAVFkMSLI6WWOiVeRnhmUsdcDOmBg
         m5IA==
X-Gm-Message-State: AOAM53317wDpAfK89H0x3RfNV2teMWMqmx1ROtu1NJXrL9st8waZswW4
        7nvS5VkYWwY17A4W+xynJ44=
X-Google-Smtp-Source: ABdhPJyQdAii3MRPNu7vU4D08VwiZrxWD7/mB/2rSx9G8rmyO5oDpgS40Hg+CxikAwIEND1nM3C56Q==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr60572380wmh.117.1636973357088;
        Mon, 15 Nov 2021 02:49:17 -0800 (PST)
Received: from p200300e94719c9aa03f58ab728c81581.dip0.t-ipconnect.de (p200300e94719c9aa03f58ab728c81581.dip0.t-ipconnect.de. [2003:e9:4719:c9aa:3f5:8ab7:28c8:1581])
        by smtp.googlemail.com with ESMTPSA id m21sm13941065wrb.2.2021.11.15.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:49:16 -0800 (PST)
Message-ID: <937514c9cbb3dd86a659d3fff11fb0f6fa3de8e9.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
From:   Bean Huo <huobean@gmail.com>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Date:   Mon, 15 Nov 2021 11:49:15 +0100
In-Reply-To: <CAHP4M8VAhcTysoBRfNQSiN3fTY6GK9fTz5+hzvzoEuNfC+9CHQ@mail.gmail.com>
References: <20211114204331.39555-1-huobean@gmail.com>
         <20211114204331.39555-2-huobean@gmail.com>
         <CAHP4M8VAhcTysoBRfNQSiN3fTY6GK9fTz5+hzvzoEuNfC+9CHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ajay,
thanks for your review.

On Mon, 2021-11-15 at 12:39 +0530, Ajay Garg wrote:
> Hi Bean.
> 
> > -               strncpy(lbuf,
> > (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> > +               memcpy(lbuf,
> > (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> > +               lbuf[8] = '\0';
> 
> Above copies exactly 8 bytes, without any regard to the sizes of
> destination-buffer (lbuf) or source-buffer (ext_csd). Thus, there are
> high chances of overflow/underflow/out-of-bounds.
> 
I don't understand how above memcpy() overflow/underflow/out-of-bounds?
would you please provide more specific reason? 
 
memcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);

here lbuf is a char array lbuf[10], and ext_csd is a __u8 array, __u8
ext_csd[512]. 


> If ext_csd contains, say a string 5 characters long, you would want
> to
> copy 6 characters (5 for length, 1 for null-terminator).
> 
> I guess you are trying to copy as-many-bytes as possible to lbuf,
> including the null-character.
> Thus, strlcpy/strscpy should be used here.
> 
> Something like :
> 
> strlcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION],
> sizeof(lbuf));
> or
> strscpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION],
> sizeof(lbuf));
> 
> Note that you do not need to worry about putting the null-terminator.
> strlcpy/strscpy already take care of that for you.
> 



Yes, but please remember that mmc-utils is mainly used for embedded
platforms, they are not easy/inconvenient to update to the latest
library to support these two APIs(strlcpy needs libbsd-dev, and strscpy
needs some one else.).  If we use strlcpy or strscpy, mmc-utils will
not be portable. Do you know any other API that can be used and make
code more portable and simpler?


Kind regards,
Bean

> 
> Thanks and Regards,
> Ajay

