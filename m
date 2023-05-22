Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C65C7EE26
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 06:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEVGxI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 02:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjEVGwa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 02:52:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B72680
        for <linux-mmc@vger.kernel.org>; Sun, 21 May 2023 23:50:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561c5b5e534so75049077b3.2
        for <linux-mmc@vger.kernel.org>; Sun, 21 May 2023 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738164; x=1687330164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srw7ucIfC/5OeRnIMtL1cXf2KeT7TF+ezb33HBVqndE=;
        b=jfHJgAclYOCpZnVYwHQClOGj72/gRBDmhMr7hJi487dtvkRI8Q5DsevbASg3dJ5tYQ
         Avz9oKiKLw0jTdXnZhNRkWHSKF5G+Vu4NpY+EyJ2RWDgDmY4uST4TjFRWAEXPJOsrdgc
         b1RQGWF29DJmF+bgXTPhxv0z0qnC9aWQlw//sJEtHmraU1729Lyy8lh5lRU4SRcHw+/l
         B32rpDHxMlkjyddRFlZqAM+YzvXJRXnsM0FnBQOzE+PM+cHgyncUpLtMtT9cK/FaSIiN
         zk32BlWiwsg+JRT/jHCaa0uSd1oyKvFJWUl35J7PcuFCcWe3Sd+Ot+MaAbuK8dCA1o2B
         4+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738164; x=1687330164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srw7ucIfC/5OeRnIMtL1cXf2KeT7TF+ezb33HBVqndE=;
        b=KSLw8WKRXprNqrk5sLu0e2lrrkwhAk/Cx3U57vxsFiI6laT7xu9tCMx5DCwH7KYXrF
         dJt+paL4iHZv1B96oa/Xs0ZK1KcFX6i64Dw35CadyOiuGlKv4GoucmWmoYivReColvxp
         9Z7K4qSmkH5Huk7xTclPbXa61d1APWhnpud/Vv5mtNKgOJt9oCWR981oxvrUETINzQRE
         C8JSqbdxGKBQ3PeiIet3yJyP7CA+9GV4RtlrTtnhTTT6v4sahCVLeQbf0sVJzYHQ/Bsd
         Pj4Qt8FxF3cuVWVIsaJkwKk8RB+b9B9bYtrBoYir+mh6JM8PrJLS9E+zgshRLHh3u3xe
         wFHA==
X-Gm-Message-State: AC+VfDzOvsx2ZS/eS59BfwKhpi7l8iwaltU9/4HSkHB0W5ujuy1SXO2E
        8hRGhph19psdx2onG+j1RlfaKkIMQAC24LxrRUpz0H4KMJbO8wQK
X-Google-Smtp-Source: ACHHUZ6Q7RsqWGPIcQ3JBMdEBS4SK/jmI1H8DA8MXUBTMYlg5VmyjMYTXyn1bYRjIyiEOi9iT3uzP2Zpp6oYMCrnodE=
X-Received: by 2002:a81:88c6:0:b0:564:bc99:cde8 with SMTP id
 y189-20020a8188c6000000b00564bc99cde8mr9098144ywf.6.1684738163951; Sun, 21
 May 2023 23:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230518210246.2401737-1-linus.walleij@linaro.org>
In-Reply-To: <20230518210246.2401737-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 08:49:12 +0200
Message-ID: <CACRpkdbTgL33+KjoNx4hOsGEmqXM3Rw2HucC38stiBik=5f3eg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mmci: Add busydetect timeout
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        phone-devel@vger.kernel.org, Stefan Hansson <newbyte@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 18, 2023 at 11:02=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> ChangeLog v2->v3:
> - Took out the most urgent fix from the pile of changes
>   and send separately, without the rest of the refactorings
>   that were used for debugging the issue. After this the
>   Skomer and Codina with problematic eMMC boots fine.

Scratch this, while this gets the phones to boot it does not make
the eMMC partitions mountable. When I try to balance the
scheduled timeout with cancelling of the delayed work things
screw up as well, so I need to progress with the "big" patch
series, some of the other issues is coming into play as
well as it seems..

Yours,
Linus Walleij
