Return-Path: <SRS0=ACzm=CR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F7C43461
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AEE21D82
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599576819;
	bh=Brp8TIcbZOawirkNxDlzWLx4FB0DE1MXhPLvIYt2XC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ris26xC4SnfDwtezmGZhk3P0P8NAiAsBLO3lolJkkm3qcguV930Ej4wKYnNTOboLJ
	 TkrQGnkqjx94HPnQw4Rcx6UynhkuAwo5XjWEUPny+fOboV1YoHHmKtmDwQNcsbeL/C
	 tmLbHiDcJQUlc1cz7alHIY8ZnQ/jearYvkqd8PR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgIHOwy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbgIHO0G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:06 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12E5222E9
        for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2020 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599574647;
        bh=Brp8TIcbZOawirkNxDlzWLx4FB0DE1MXhPLvIYt2XC4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gcnsEAQmSakMGw/tuYx8DMCd4kqhO4oSvTv8rC4aQPjEllWBeW1eiF+fLbvhBMrkP
         4aPBlm3i0fEjYmyAacGgVkOGVEC75NVX9ja2jXWGTzWKT+Mmv8D0Co5SiAeD9jdhWr
         9rKrlNXdkzsL8aSPBLAunxm6iNSh+4Yj/UmRCfHE=
Received: by mail-ej1-f54.google.com with SMTP id z22so22766324ejl.7
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2020 07:17:27 -0700 (PDT)
X-Gm-Message-State: AOAM532WxfsDUExIkdCmdi3cNexHC3Sjp3KSygMI9O7eWAhLmlIV/a7A
        0d/Uqsud1QtB8vXje3ZAo9gvmkEFfbjC8Cjsmjo=
X-Google-Smtp-Source: ABdhPJzNRFm7vd8VzBIGLZ4OYJhc1FtXr06Ekn8rVcSP6+KUcbTILEMbBxJEooCtwuuJMTwVhi2JhbHvlIbU4UWQVlU=
X-Received: by 2002:a17:906:82d1:: with SMTP id a17mr25667769ejy.385.1599574646240;
 Tue, 08 Sep 2020 07:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200908140242.743234-1-ulf.hansson@linaro.org>
In-Reply-To: <20200908140242.743234-1-ulf.hansson@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 8 Sep 2020 16:17:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfKh0VZKyEgJ0xvwA-1yTuvCS8TuasR1rzWmpb2ZQHBwA@mail.gmail.com>
Message-ID: <CAJKOXPfKh0VZKyEgJ0xvwA-1yTuvCS8TuasR1rzWmpb2ZQHBwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Drop COMPILE_TEST Kconfig option for MMC_S3C
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Sep 2020 at 16:02, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> MMC_S3C isn't ready yet to be built with COMPILE_TEST, hence drop it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
