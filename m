Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EDFC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6879061090
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbhIWRaS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbhIWRaR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 13:30:17 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD8C061574
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 10:28:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso9643758otu.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=me26Oy2bP1WcgB+1yQNQe62vTZKCBt44QwycMSyu6SA=;
        b=EYmfeZqap+g0hMzms/BQeCI3hL31eCi+I9M/TYufev4DZlLKYd9RdrXRLsTPeG86Ac
         +lOdBBM2pxrIzI/Rqy8skyFzgjlEqEig/4EMS+Uuxue93Q5H3+me+2YEsjuQsBPd+tp1
         56V7X/Hr7YZj9fP9M36bdHuTsCcgRRFSygniw34cH3Oq5XjD3xr7E1Zlk4QANa+n9l3U
         cnhTuPkWDjDZghs08FmeBkA9aamCQ9/Wbx1Sq4YH04xPRimcUE1rK2czrWrhU4RKFijj
         Gs+Uo9Sj61KpCu+9USxDdNel+opXkC7bn/aWiPn8QmBTLuJwF3sn8gqjg28kaSvclC1B
         3r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=me26Oy2bP1WcgB+1yQNQe62vTZKCBt44QwycMSyu6SA=;
        b=N1SJvFSks5B5q5AynyuJvItGsejdN6Ie6Vuk/y+yiRGDhJGdAuvfY4EY6tEF+04nnb
         W+E/KPWoy3Y8C1E6/9RAW8iPPH+FBYLpbuFc7V8iAzTjSGRQ8wheWSBnfDmg+T745Kx2
         hOhqJgXJzt075s+2H+90vPEiVtHScCWqJLVS82BfHBPpchabI8TI0nZFKc6ymjJ+guPp
         TwOBe70KzITnGprVurL3t+qoifnSXG6MFae1atr4cD8eAUOLtgOpz2jiaPrm7O6+W0aF
         5s0is1m5VPBj5IlX5ZgoiP1+GKuztB1d8OLIu6UzcQ184+2xDlGMI/Hgo+At56YRpr/J
         TcDw==
X-Gm-Message-State: AOAM531e1wo5GtBUTsTsoGsxecG/Ax4GqQrAMi4dJxRfN3z/kB0Nfpac
        xhLwAE9VnBj2SovVXV6lg8lMvLn2wtFLqJVLr7/Jy90mwlo=
X-Google-Smtp-Source: ABdhPJy6tO1OMq/NyfSGTbVdee+K2ilPZo+GUWPcv9w3UdyMBz9Io04zBfvqTM8j9rTDU9iIlWmWxdV1Z+c5tVaigtY=
X-Received: by 2002:a05:6830:18e1:: with SMTP id d1mr5676150otf.87.1632418125474;
 Thu, 23 Sep 2021 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMeyCbhTcwcksdNC-1r5487oX-rmfmcdGiBiVng6E338hWzbEA@mail.gmail.com>
In-Reply-To: <CAMeyCbhTcwcksdNC-1r5487oX-rmfmcdGiBiVng6E338hWzbEA@mail.gmail.com>
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Thu, 23 Sep 2021 19:28:34 +0200
Message-ID: <CAMeyCbibWwjpiQa5oneLxuPyzH33OCUGaAz3++uzDvPH0oa8Bg@mail.gmail.com>
Subject: Re: CM23: Reliable Write Request / Forced Programming Bits
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I looked over the main use in the mmc block queue:
This hardcoded (1 << 31), (1 << 29) ...

if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
(do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
do_data_tag)) {
brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
brq->sbc.arg = brq->data.blocks |
(do_rel_wr ? (1 << 31) : 0) |
(do_data_tag ? (1 << 29) : 0);
brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
brq->mrq.sbc = &brq->sbc;
}

https://github.com/torvalds/linux/blob/master/drivers/mmc/core/block.c#L1629

I think this clears things up.
=> I need to adapt my mmc_test sample code and simply set the request member:

struct mmc_command sbc = {};
mrq->sbc = &sbc;

before calling mmc_test_prepare_sbc. Then the sbc opcode will be initialized.
And if the MMC host and card supports CMD23 the host driver will
execute the previously set mrq->sbc and disable auto CMD23 for this
request.
Am I right?
