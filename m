Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE58C04A6A
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Aug 2023 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjHKMCk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Aug 2023 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjHKMCh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2023 08:02:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3A110
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 05:02:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d63457dd8b8so1736369276.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Aug 2023 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691755354; x=1692360154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CXtgREuhmv47Kw+ao1teWaVgLC9bV06E2de0JQaJVM=;
        b=oNTkC6acME+G8I0ioLywq/8DK095y6KyDHOJnLXIypQYGQn0xuoJCqexNEZqANfLNc
         A8DKfeV3zNVlvOSzO3nmjZTvaULEKrrInwod/wC5VAZqljMXg7nRhdya/ZbEyt10WEHn
         i6UCiWPm18c0MteNkKvCYZ9Rxb4h6oevJ2GwatAPF0lOU26TY4I1XfZQnZer2iRF5+B4
         nuGYcC59Pyf4aZFBh0isMayaSpV1+QjqVbEjMevnTuQC7Ukf8wS3AQLMtU5ISE32xs0i
         RomEhXEWtqTDbg/11TUT9X6DOC8/qwX792IRPqJrVVSgGzRFtneo+GJKSe9VmldEx4up
         qqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755354; x=1692360154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CXtgREuhmv47Kw+ao1teWaVgLC9bV06E2de0JQaJVM=;
        b=TeM2hWtL+wFDA1WJ/2ByQvAlurxYbg+bXjSLJlHkAZpF41vrlkZ7dmIiFDRzYn0XYo
         svnWbX9r9UHypQdiG/AWqbkAhx9V9WZIseCb+g3MexKbB1hsugn1Oo6Gm7rtv6EomS41
         M0BpsUpUQ2jfFAT2brIoVsYvPWW4Cvvn2MfVTnBhUHFTcXS4PkTPqaF2aSmgAD5LlERO
         TSZP6cKI+xlaCiVwLEsuhzroUw4cCzM6FGStb0DV/s1xsikI6ieBUqcRD/k/S240DlWh
         E3PodLOQaxM7+UgS4+CdNFgeZxRWZM3tSq6sTNm3yLOI9X66XMhGNgLnLQBQ59fsgYEc
         1dzg==
X-Gm-Message-State: AOJu0YypFmvj8Aw6vK87gPkonWqdBRKH1Ew10xWE95RKnnkHYzRZogfY
        HhWdELLDLgReeGXlEAEwFsaJjiJKxE/cXCBNLdWK6A==
X-Google-Smtp-Source: AGHT+IEqTwqYi3XFQ1XoWt+t7thSmBfY9KEZINHvtEM8V7Uyw58kziNcqtz3Ej4DxqBxltNJ8g3nehmow9akYKkMZBE=
X-Received: by 2002:a25:e7c7:0:b0:d11:ea26:3263 with SMTP id
 e190-20020a25e7c7000000b00d11ea263263mr1447177ybh.5.1691755354460; Fri, 11
 Aug 2023 05:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZM+IlctTTQLs7Qg9@lenoch> <CACRpkdZmd-nb21Cx-jp-CDRjW4VQRV=c4MekHxS3h2p3HsDwZQ@mail.gmail.com>
 <ZNYd/mNGROq22MPH@lenoch>
In-Reply-To: <ZNYd/mNGROq22MPH@lenoch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 14:02:21 +0200
Message-ID: <CACRpkdb+VQYB916TWJCrTabNMkqUReso=hC2eOiK8qxfiEXb6w@mail.gmail.com>
Subject: Re: (Octeon) MMC performance degradation due to too many requests
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     Robert Richter <rric@kernel.org>, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 11, 2023 at 1:39=E2=80=AFPM Ladislav Michl <oss-lists@triops.cz=
> wrote:

> Just for the reference, implementation based on your above mentioned patc=
h
> which restores 4.9 vendor kernel performance can be found below.

Hey looks good :)

> It still needs some love, generalization and so on, but as I have already
> started work on fixing Octeon's USB and ethernet, this is far beyond my
> time limit.
>
> I hope to return to this in the near future and convert it into proper
> patch series.

OK on the back burner, such happens.

> Btw, we really need to invent some other name than 'bounce buffer'...

I think it should be called "contiguous buffer" because that is what
it is.

Yours,
Linus Walleij
