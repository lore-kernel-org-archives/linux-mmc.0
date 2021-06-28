Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C30C48BC2
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 02:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE59619AD
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 02:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhF1CL2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Jun 2021 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhF1CL1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Jun 2021 22:11:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905FC061574
        for <linux-mmc@vger.kernel.org>; Sun, 27 Jun 2021 19:09:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v3so20298379ioq.9
        for <linux-mmc@vger.kernel.org>; Sun, 27 Jun 2021 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=65WCVWlPc2fPhw87WClWBvO/6Wnn5ZkA22P2I+INI/c=;
        b=mwQgrGr3VAMsECxNsxop8IDjDv3rcqjEtq72p8gD0tINvWMPlBPt30ODaQ+rzeOPvg
         cb9lYipdo3MiS6+hnV0KZ+UbKn9EqmERF4dcpcocnTgMLFDd8sINNKMqNvoWZD6Fpj+4
         ghYSyLnL6/G3MvLYJrT5/QEgLqPucTRneiSWTUfFHW5oS9fWwYWOMBYnaJotPlg7kCgL
         u7bIpcgKhtANVJOIVwx35uSN4LOmnQc6wKsBTWSfRb8YvAdRi4jCPej8TuVkn3dPekjr
         l1YC7wZClFmckD5VO2fUZ55ctExdTtnwU9V7V00fPsp67CRZcpDg1+ll7/8eEMVAEb2U
         o6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=65WCVWlPc2fPhw87WClWBvO/6Wnn5ZkA22P2I+INI/c=;
        b=ebVcBAWazQnOjnoJS6X2f+asJ1NQ7rLUyQzak/gfRbj0aNUGbX+2FqWmKJ3z2elxcU
         k6uPgcrK2jhbgvNHaGzyJLckV/2RTBYTrS/nN9o1Z+zxRB4kNwAAt91jQEj9lD0GENz8
         eqDs4eWqHbOlmni/1QYH2OlQbNdQL7YpCrS0/aIqRxL7XzcCXOR197jgAxamjm/Znhz7
         ChPMleZuJtS8kMSecyN5HYKL9YMx4pSsBWNcjYsCltz71WLQ4WAEyMHph2y8VrnmMBZh
         Y6MAKx/OaLirBQCfHicfY03mieIOPtojecuJcbZJnx1JTQ6XoHo9hjwjA+gd8qSNafX6
         IGXQ==
X-Gm-Message-State: AOAM53313fDRLery0DMezAHh/QLpaqHRcWvBsQObfDh/OwLfMjxxJLOs
        i9f90GRiT3tqSuiNlqZivekILscoYAb3RNDKKvh62OaeuL0=
X-Google-Smtp-Source: ABdhPJweqyId0psS01N9s6gSvCdj/bYsOveROQIVmVZbbD8zLmXdYg2SrzWE2KXG2oXO+a86UgW/OIzcMQbbDof0wgY=
X-Received: by 2002:a6b:fa0c:: with SMTP id p12mr12891576ioh.54.1624846141545;
 Sun, 27 Jun 2021 19:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210624163045.33651-1-alcooperx@gmail.com> <CAG0XXUGrmHY_2koaFTkUH8kozZ8B5Z_eafJMm+92-NP4oSE7yA@mail.gmail.com>
 <CAG0XXUH6zVaHGatn6rjMMOzEkkwSdFBseGyGSik8a6cQLJvX2Q@mail.gmail.com>
In-Reply-To: <CAG0XXUH6zVaHGatn6rjMMOzEkkwSdFBseGyGSik8a6cQLJvX2Q@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Mon, 28 Jun 2021 10:08:50 +0800
Message-ID: <CAG0XXUHJuBEbrTd_M7tZ+1_3k13mMebW0yZ1295+GAqLhekxow@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: core: Prepare to support SD UHS-II cards
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,
     In struct mmc_host, there was added a bit definition
'MMC_CAP2_SD_UHS2'(bit 9 of caps2).
     But there was already a definition 'MMC_CAP_UHS2'(bit 26 of caps).
     Do these two bit definitions work for the same purpose?

     By the way, where can I find the 2 source
codes(a/include/linux/mmc/ and b/include/linux/mmc/) which you diff
from.

> > ---
 diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
 index a001ad2f5f23..0a777caaf7f3 100644
 --- a/include/linux/mmc/host.h
 +++ b/include/linux/mmc/host.h

 @@ -377,6 +393,7 @@  struct mmc_host {
   MMC_CAP2_HS200_1_2V_SDR)
  #define MMC_CAP2_SD_EXP (1 << 7) /* SD express via PCIe */
  #define MMC_CAP2_SD_EXP_1_2V (1 << 8) /* SD express 1.2V */
 +#define MMC_CAP2_SD_UHS2 (1 << 9) /* SD UHS-II support */
  #define MMC_CAP2_CD_ACTIVE_HIGH (1 << 10) /* Card-detect signal active high */
  #define MMC_CAP2_RO_ACTIVE_HIGH (1 << 11) /* Write-protect signal
active high */
  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14) /* Don't power up before scan */


 best regards,
 Jason Lai
