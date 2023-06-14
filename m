Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE656EB64DA
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 11:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbjFNLTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbjFNLS3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 07:18:29 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE01FEF
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 04:18:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so786544276.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686741470; x=1689333470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t09tdI1hKeXFBl3mW1z4mXFtI09hFjwV3/4CRkA0BA=;
        b=NJa5Mo/SsCrehAturYHySGvDtywWDo7BOp7PMYt8cTf6Ycetl2VVbRWeWGxTO3HUfy
         jDjcZDGGO7HSfH1YWqcbVaOTTmKwhQWdcPHMfVYCUslnZLwFtW3M8gd3w1HUROmbkXxZ
         JStFLHi89rfDB7AB+6rEXkDmfu390Ax4K0UsOJa3OHd2PVWMxgv68IRXnVe5m8HOTm3H
         JE9bBT7MyIb3WCeO+1bizUuWk96M8Y/dbV1mrVRr12AXfz3BCWHbi5mAvevWxuCvliFt
         YDPDXCv3JzpN5nocHSKgHm0rh6a3s+BzkzONxqa8dSqV/r8KN03mnzJSG+cpT5cw0DXr
         A6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741470; x=1689333470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t09tdI1hKeXFBl3mW1z4mXFtI09hFjwV3/4CRkA0BA=;
        b=WPdzAyxdvxV0pmSCwBHPy7ZCX3zs8Q5PRjHCkgUzO8rZfhDkxCdsdpBjuaGrHQNWDG
         ivu4R4sxwAkiq6yHac2HqSBeoY/3JzeqDUcL79gWxoDTUduq2QenYfoXO92vDOQMReHS
         fgvmCFQzM1jE64q7kNnKaqlVR4GXda102vW1hmM31JAvgN6eO0uTK7F0E4NE7+F3sz4b
         DkvmkXMNZTBJh7PgYmw0ivP8RjrPad7/fJQkwr2EY2Cr5VFUZD3s8XgerTRfdPEdVaL2
         MyH4O7uWJHNkmxJkZi3cluWlmI7QsDPBszP0QxNoTz5vkJmfbTXU+x3aoWo99uMtBMOS
         GEXA==
X-Gm-Message-State: AC+VfDw19jqJA4Dhn3/nkxHu6kQ8bb0F/wsCiblzd4sT5Od5Mplz6P7Q
        Jlu4+7aC2vLHVFAYBpxYKXnhfyBD0VfAFofd5YGeQIQVK7WNa6/XFQM=
X-Google-Smtp-Source: ACHHUZ5iHcieZrZoFD02SZ14yhYuZcLT8k/k/P8O58Hyna840pyLj4sPqIEC/1tV9M4aM4UvaotFJX6caTmjf/dl2Zc=
X-Received: by 2002:a25:258b:0:b0:bc8:42db:2c07 with SMTP id
 l133-20020a25258b000000b00bc842db2c07mr1503220ybl.25.1686741469919; Wed, 14
 Jun 2023 04:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
 <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
 <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com> <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 13:17:38 +0200
Message-ID: <CACRpkdbYNn0S7AXn_sbPb+o8L_DcffKat=tR0mLtNiBhgy7UEg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mmc: mmci: Add busydetect timeout
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

On Wed, Jun 14, 2023 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:

> However, we use the spin_lock to protect some members in the struct
> mmci_host. In this case, the mmci_cmd_irq() is using "host->cmd" to
> understand whether there is an active command to manage. When the
> command has been completed, we set host->cmd to NULL.

Hm right...

I'm leaning toward some catch-all like:

if (!host->cmd)
  state =3D MMCI_BUSY_DONE;

as if there is no command going on then surely nothing is busy on the
host controller.

Yours,
Linus Walleij
