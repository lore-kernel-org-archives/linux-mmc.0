Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1DC4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A456261002
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhHDOeF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbhHDOd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 10:33:58 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3957C061798;
        Wed,  4 Aug 2021 07:33:05 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s48so4242670ybi.7;
        Wed, 04 Aug 2021 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SqFXGAq4e3ua/Ts6/H9tHLCw4CGuQ4DInivgNoJfgjA=;
        b=ZCvp2wmpsfXcE8l5VO+teKlSfFiqZ5lnsE5oDsq/9W+BtJMZoxAhszV9mYOK7RXq2P
         yR/nxUAZiKIhFkuxe5KswpcAm+xlHN9gSxDJYaU7XwL37OLi+j4cYcnBwePyEk/TH45H
         cmLLcQaY1JWK6UspNpOYHLMsvAndroo9VgBXL+NjOdNtR7P3ru5zwl8D1p6gFb0vNd3D
         iBfVG+QPR3/ZE5LGQAou50tWCQIO/EsglLYK6vwKXIepB2F8KufSK0AtDQ4T0xHHzkJX
         sKHc3xg/0vJcu16WTbADdN2a8VtiMedeIMiHkuaEQ8US8MRmTw1Us2GlEH8h0cXDC0N7
         r5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SqFXGAq4e3ua/Ts6/H9tHLCw4CGuQ4DInivgNoJfgjA=;
        b=jREb/kvQR8DRCf+31WfhQuNnY6PiNs8EQU/RXo8u5lFAlSGoEpHkfyydQKatJXa7aV
         aXmIUpsiWLy/jYbca9sq1brWH/jUYIl+O9vhVjCLzmsY2iL3WQEDiloOUJKUirUvNym2
         q+uFPl80rIWCdwsXZREydxy6dSSsCIWx2ufed/svYb/dsfS44YsT/HWHYA16oMk9BcnV
         dD90AF1rIIEtoDjHlvw9RZ8Lnd2mvirSwKvq69CD1sHnsniIRWFQND5v/bWDpuZfSxYg
         wsYXxTOtuH/rfryT+gHS7vaAQ6pg/BGuaXHAsnOUDFoX3zP2dLf4ANrlC+7jWNR98MxK
         M3bA==
X-Gm-Message-State: AOAM530+wPpex9YP1OR+vs9kWwidQPWPGV1m25mn82tS/PNRUvPFcgJn
        srgzMnQnxP5xTRGVhzDChG280xSbzkOTeMBkn8g=
X-Google-Smtp-Source: ABdhPJwBPu3e1omSX1k+jFsXU9pGTMPB32qAD4Qpv6GErPVzktqEePPxLBwAWI/tyrxrGp/Ce8WXAvxUqi2bN7jkUGU=
X-Received: by 2002:a25:2cf:: with SMTP id 198mr36391086ybc.259.1628087584033;
 Wed, 04 Aug 2021 07:33:04 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 4 Aug 2021 10:32:52 -0400
Message-ID: <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
Subject: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Good Morning,

I've encountered a fun issue with the dw-mmc driver while working on
enabling support for the Quartz-64 Model A.
The regulator-fixed driver supports enabling via a gpio, but does not
have the ops to set voltage as it is fixed.
The dw-mmc calls mmc_regulator_set_ocr for vmmc, which attempts to set
the voltage first but fails due to the lack of the voltage ops. It
then bails returning -EINVAL.
This leads to the following message :
dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)

This can be fixed by switching to regulator-gpio for the vmmc supply
to the sdmmc controller, however the sdio controller vmmc is provided
by a fixed regulator that is always on. Obviously the regulator-gpio
isn't an option, as it has no gpio to enable.

Removing the vmmc phandle from the sdio node is an option, but then it
doesn't fully describe the hardware (it's also a non-standard 4.4v).
I had considered changing the check in dw-mmc.c [1] to continue in the
case of -EINVAL, but there are other places in the regulator framework
that can also return that and it doesn't address the underlying issue.

As such I'm reaching out to the experts to see what the best course of
action is here.
Please weigh in with what you think.

Very Respectfully,
Peter Geis
