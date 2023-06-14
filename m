Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C93EB64DA
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 11:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbjFNLOf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjFNLOP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 07:14:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426612A
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 04:14:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso538834276.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686741253; x=1689333253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKRabDKgNdRjabGDczWZve4hAHKXZMZCSP9Y/mNfdlI=;
        b=SA34EGsYB+cg5TEAaZgbHqcm+KPXLDJ07FNu9ECtl5mn6dlm5HohM32bOFcMxYIjRc
         4JTi7tuo4IuM4C0ijR6cFYyZiBLCDIvYNNESxJbqfKtK6O5v5FruBQIFmBbK7f9Hh46D
         7WWydFG7SVdCg6Is1UM+ZdaAvIGgZuAZaeFXRKUzuI7fciRUD2ZFsnWFhv6zdM5RsGrA
         FFzS0kjENlwouHH7wndGyQ+AhS1q+5d/ytodI8zxSNJUtZawumZ1wBCAYHcyWFZtxl2P
         GUw9555b4BOWOoe1CoAArj54Pcg/UxAgrt6UFPU6YazfMWNlV31oASAF8tICfwDEFHHG
         jrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741253; x=1689333253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKRabDKgNdRjabGDczWZve4hAHKXZMZCSP9Y/mNfdlI=;
        b=IDP+j+Ik0al78qVp4jjPx9IXHAEs76XINQnTy5K9bXGtov/ZfcKiaSVL8HpgGhwdls
         j2F/9LNxq5PAZAVRrtB4o4KTW/tGAcigTT57Jh5nRINgDd77aSIvOHHSDyb7hZ5AtJov
         RIPJ1EeABqXHTRvdhTmsl/XZykUgcQC043v8X0ndo2jYjnr2kDuS0VHQ6eSdozpnL3b5
         ehxakMcIdO6DnCTBYFbOA/ySSus7I3KZ/mrUqmiJuCXQ7ILF1TU1jcJlD1meOx7EIhZd
         faApOlpfYDu9tpFaSYW8yoT11Cj3CutEG9TDvJG/rk/baW8e7oA6FblNaTNMHuiKOgvT
         3xUA==
X-Gm-Message-State: AC+VfDyJzAcwDs2ROJRzmSS0I129io/63t2pSgt05ZfI9a2Szv4nhTLZ
        UOJCI5TaNSHp2r87xdHl8sVAGg5zPtBVczqYXvp1dg==
X-Google-Smtp-Source: ACHHUZ7fC+P4Spp6eGsl26E1xC0n5raOY4TA1TrqW9ckIEH3q1G2FnCpRlONyRG9gfIwrDN5urF8kSFV/jyvnvVl1Ws=
X-Received: by 2002:a25:d787:0:b0:bcb:9b43:5a89 with SMTP id
 o129-20020a25d787000000b00bcb9b435a89mr1604952ybg.61.1686741253275; Wed, 14
 Jun 2023 04:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org> <CAPDyKFpP=G6vs-VLoTF4BhVgxDyBLZ4DqWsXy1qvH1tV_SC53A@mail.gmail.com>
In-Reply-To: <CAPDyKFpP=G6vs-VLoTF4BhVgxDyBLZ4DqWsXy1qvH1tV_SC53A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 13:14:01 +0200
Message-ID: <CACRpkdbh0dgkJdf50Nf4OB_qLtmz3kaniwKTE3Bke181BeDbaA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Fix busydetect on Ux500 PL180/MMCI
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 14, 2023 at 12:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:

> Applied patch1->patch9 for next, thanks!

Thanks!

> Let's continue to chat a bit more about patch10, to conclude.

Yeah that makes it much easier, iterating just one patch is less work :D

Yours,
Linus Walleij
