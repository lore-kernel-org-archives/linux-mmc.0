Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E1AC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiBPKRt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:17:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiBPKRt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 05:17:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69418240B1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 02:17:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e5so2875025lfr.9
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbuOK2F8b1JWHff3AN38BjVF4Lt4s6BpbFaCxaxZBHE=;
        b=w58BGJjKfuR4GMqGDRfRjWFyWI6XuNfz3CB3w6uJrDs35Rea71QigB68MyMe/lm+Jk
         xjWuPfgCHivBwkd0sfPU/4ZjlIwhhW3iurMT/Pp8tqOQ5+299jPS1kzLf5sEeSGNt+Ro
         XPnF0bAFXakgEFjGPVR1Ka5HklGWTIOz1lTF2cIyOIcAGqbXFPN7ifGxdY+2yeCKiZc3
         M67jZRHFYgZjd50qBEFw6iWvFW/b617PDJm/W2m0g8dXISEHB75Vel5lQobhyEeJYMvA
         YtY2LkLZYoSFxMUiI5WUST66h7gk3T+I7H6erex8JszHGLHFKLnQQpXO7qgHV0OPBr5n
         WNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zbuOK2F8b1JWHff3AN38BjVF4Lt4s6BpbFaCxaxZBHE=;
        b=sWv7de4ovIJ1WFfTs/aVfTt6AOqcFAtsr7wXOa79Gu5LYhnNPYtX5LTuDQlyH1kyOU
         TioRFwHHXyEeuUub+vDueBg5lEQm1KzeWRd28mHqtMH5wYNNJda6t5QtocK+vQ5XMrnV
         Zr5D8Py3sKaEncQIpBDI7kWrVO0fBBGUuQVxIH9Utj+52XYDRPwRLoYKWi6/fXAMkSva
         IPAMQD1NVsCDy/UJ4nyZskHkTydDDrn5h5vSCwlv5qDEtgpS/GaqUNm0RTsvQIeORW3L
         u2zmosHLkCSDj23xowJSlvvLMBhXl6hEEp5Lh0ChgKh2HAbt9S6A6Gh86ZocGocHXcIi
         Wq4A==
X-Gm-Message-State: AOAM5335XV94URvfSsGtduahuTuorRhQ4qgCQtxGyjZgGFT8tV0DsSI+
        9vyhSYOjHTtMNiKA+5XZZgiuuiZkJH6FcA==
X-Google-Smtp-Source: ABdhPJy3DcxCqy2Ms+eCApN6FGequerVwQtjCzCnrTDDjEiriTO8u+oRIuMji6EVkKzAKaDLplYkJQ==
X-Received: by 2002:a05:6512:694:b0:442:be61:2e02 with SMTP id t20-20020a056512069400b00442be612e02mr1497309lfe.35.1645006655745;
        Wed, 16 Feb 2022 02:17:35 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id 25sm202512lju.70.2022.02.16.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:17:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.17-rc5
Date:   Wed, 16 Feb 2022 11:17:33 +0100
Message-Id: <20220216101733.193534-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.17-rc5. More details in the signed
tag. Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit bd2db32e7c3e35bd4d9b8bbff689434a50893546:

  moxart: fix potential use-after-free on remove path (2022-01-31 15:36:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1-2

for you to fetch changes up to 54309fde1a352ad2674ebba004a79f7d20b9f037:

  mmc: block: fix read single on recovery logic (2022-02-08 16:04:49 +0100)

----------------------------------------------------------------
MMC core:
 - Fix recovery logic for multi block I/O reads (MMC_READ_MULTIPLE_BLOCK)

----------------------------------------------------------------
Christian Löhle (1):
      mmc: block: fix read single on recovery logic

 drivers/mmc/core/block.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)
