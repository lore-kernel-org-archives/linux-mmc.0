Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F26C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A72310A
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhANBtc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbhANAcY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 19:32:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5BC061795
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 16:31:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n11so4629387lji.5
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Non6Z0wp0lj2wRTS63x4IYGpzg5HbiONDEmrRj3r+eQ=;
        b=RtS8a+CKg1Ge7OK2L0vmJXjs6bkEbsxGqNI4lamJ2/+p6xoR2yY5g5xiukf/QZSSxp
         UFJ0hZS3zVtQm+8PAoITpNcRkoovF5fmDuV0ZOXUHB7+zih+7FRX56AbYOEJDQdttQxO
         3IdQ7HpwKspyIfQcfdLvC0mNyTkL7EVvemR2Zs2i6NRxt8e3JvGIaDWiwbBolHKRufmK
         ZM8ohg+wQUITyhDtIoMXBYScpHs2XeTtmPDI7X+2iBCwEWj7KLqGE0T79hnf+OWKpIfn
         vMgzGeCe5zuQTJ/yrbVv8fdNaTjopX2XoyydhJwV+UNDW/yDeiB+SwuzJ/G9YrfWvxMh
         4xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Non6Z0wp0lj2wRTS63x4IYGpzg5HbiONDEmrRj3r+eQ=;
        b=nWUBcLBWj9mgeaEl2p0cwb081mB2TQ0KCJVzqR2Qop2NQb6vj5RST+qCvPBeSoHTg4
         y0zvFWWCcH5UrOrJ69PVn2XDfi2EETQT4nCNF+zBYCWFzDSLRRbbACZ0MMKu9xvygdtN
         58Np6lt0uuMCY/wBWShjJx/Nx57UMwyikjS5tn85r/14pxQ74v1aW572Szq4QUUY7TR5
         EtbdOQ9hFVL7eeH3kcaCnNP1qDlQMmgngQy38IVfsZCxHuaE+OIVgis/74GG7pX/cL16
         Em1hBkFez8rYPsh3HLG1HLOoFccs7zYxMs4CqYpL1C9IWvb00xNOzgvpsgH5XDWSbL6p
         8FvQ==
X-Gm-Message-State: AOAM531R2JShq+sKM/F0IijyNBQCXupVPLU+pa221TnBK9mmSaMw5O3O
        u0mi7lfGjvT99Bkr+IAipmOnJu4rPEj3XKXjPgqPnCNjl2A=
X-Google-Smtp-Source: ABdhPJy4N+YaNRQZUP/aw+23as+Ai1hB/lElEo7IMcyO8ntiIfGG5Fifmm1E3o+uLK4Hfq7+2gqS4aPF2HSkJNs8VTU=
X-Received: by 2002:a2e:8748:: with SMTP id q8mr2008985ljj.428.1610584283348;
 Wed, 13 Jan 2021 16:31:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?TWFydMOtbiBYacO6aG5lbCBNb3JhIFJvbGTDoW4=?= 
        <necrodos@gmail.com>
Date:   Wed, 13 Jan 2021 18:31:11 -0600
Message-ID: <CAG=_e5DcNhoVM3rbzsocpBKwuwt9C0x7-B-fLwrFwyN82zTvHQ@mail.gmail.com>
Subject: Bug Report Broadcom BCM57765/57785
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, I want to report a bug related to the drivers of the sd card
reader Broadcom Broadcom Corporation BCM57765/57785 SDXC/MMC Card
Reader. Basically It doesn't show the inserted cards, and even though
it has a workaround that has worked flawless for mac users, many acer
user seem to have problems like not being able to transfer large files
(larger than a couple or not being able to format the card. I know
this has been reported before but it keeps having problems. Thanks for
your help, here are some links to previous reports of this bug and
previous attempts to solve this issue. I experience this bug on a
laptop acer v5-131 with said sd card reader running elementary 5.1.7
Hera but I've encountered this same bug on all other ubuntu flavors on
this same device. All using Kernel 5.4

Please, if I'm doing something wrong by trying to report this bug,
please let me know

https://gist.github.com/samgooi4189/2e6e18fd1d562acaf39246e5e386d7cb

https://askubuntu.com/questions/444484/broadcom-card-reader-bcm57765-bcm577=
85-doesnt-work-on-ubuntu-12-04-lts

https://bugzilla.kernel.org/show_bug.cgi?id=3D206005

Thanks you so much for your attention

Mart=C3=ADn X.
