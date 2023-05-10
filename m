Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A8C77B7D
	for <linux-mmc@archiver.kernel.org>; Wed, 10 May 2023 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjEJU6R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 May 2023 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjEJU6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 16:58:00 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725E272A
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 13:56:49 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so72886585a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683752089; x=1686344089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2A1mAdk2jOSOv/+D4yJ/kc5JQaEL+k6dZ6J6cz5nkBA=;
        b=h5Am1CZODLAoNZOHBxyY7P9MAPAef9ZK1WJCCAFWIAGakQWUCqhV5QXFL0rPqkVWqs
         hhVDIGlEqbDcp7z430xNX9T37ynoYTc/83BAlC0hWpEIMFNxyb8rGSW5Fb7/UGeh6BOs
         +2vOVzOewq85No5g+uFRoSYpuc45qDCdDABOfJN16QP+XZzu9eVxIpakGWSqF4Ls7rNK
         XeBXYuo/JI8bCC8H2B4+XGV9DTP8daoGnlPQ1dbq3F0dgynvh/EU/jzlffUQ3rwo5yLj
         1Mdq/HfJavzA8/bmYI7b+BODMdrEPa+T3GYrfruyfUrTIc4J43dED1yojmmKNKyEA5dC
         FfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683752089; x=1686344089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2A1mAdk2jOSOv/+D4yJ/kc5JQaEL+k6dZ6J6cz5nkBA=;
        b=ApgUFjB3AJR28YpGeStgJzBrsZ3X1n2W4bQ4ksKxLQ2yYikIBDfshahUwJK5v/v/+M
         /9uWbMZTaeSqAcikSdCWkPb/Coz4ME7fQZD3XDIfr7//OAs9hrSzC8zmBh64em2fKBxV
         0elVCYTVncdCPr//dFp3KvP3Kfqo5NDZTh97WRxEwyQjJKzkSbqWFMTtERQH5QvORzrz
         AD85CD2GgEGIq+qHvcujWlxoiNfmPoDfXSLGFBryoB1mvW72x3MMQAVW1eEL8S0TjOd9
         3Fj5VHiUfrYyc77YwoggvQL152zse7o4Wd3X8vAHI8Mp1owZBmNW2Fq8AaRoTek5LhWh
         remA==
X-Gm-Message-State: AC+VfDwn+DaMnwvVogBkGw+yW2SB3J4kClZH6XChAZJMePX1YrDh/yPL
        rE3NdJfpY7Twg+7qFqaF3lsp2tkIAnn01dhcAqA=
X-Google-Smtp-Source: ACHHUZ70YYiCCbxqfkUQeSmtWGEtbxx2oMxAiVRlYho8p+Rd6ym4ITJ1Y8RJO5yhsVJZPd7PCEvU1NzNTaZdQjilp58=
X-Received: by 2002:a17:907:26c6:b0:94a:4739:bed9 with SMTP id
 bp6-20020a17090726c600b0094a4739bed9mr16472312ejc.13.1683752088968; Wed, 10
 May 2023 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
In-Reply-To: <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 May 2023 22:54:38 +0200
Message-ID: <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: multipart/mixed; boundary="000000000000273e3505fb5d151f"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--000000000000273e3505fb5d151f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, May 10, 2023 at 4:21=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
[...]
> Thanks for reporting - and my apologies for the long delay! It's been
> a busy period with lots of travelling for me.
Thank you for taking the time to look into this now - no need to apologize!

[...]
> > In this state I get:
> > # cat /sys/kernel/debug/mmc1/ios
> > clock:          52000000 Hz
> > actual clock:   51000000 Hz
> > vdd:            21 (3.3 ~ 3.4 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    9 (mmc HS200)
> > signal voltage: 1 (1.80 V)
> > driver type:    0 (driver type B)
>
> It looks to me that we are in the process of enabling the HS200 mode,
> but hangs at some point. Unless I am mistaken.
>
> More precisely, I suspect it's either the call to mmc_set_clock() or
> the call to mmc_switch_status(), in mmc_select_hs200(). Can you have a
> closer look to confirm this?
Indeed, removing mmc_set_clock() from mmc_select_hs200() also makes my
eMMC appear again on top of Linux 6.4-rc1.
See the attached diff in case it's not fully clear which
mmc_set_clock() call I removed.


Best regards,
Martin

--000000000000273e3505fb5d151f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="drop-mmc_set_clock-from-mmc_select_hs200.diff"
Content-Disposition: attachment; 
	filename="drop-mmc_set_clock-from-mmc_select_hs200.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhi6fva30>
X-Attachment-Id: f_lhi6fva30

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21t
Yy5jCmluZGV4IDg5Y2Q0OGZjZWM3OS4uMzFkN2ZmZjVhMWExIDEwMDY0NAotLS0gYS9kcml2ZXJz
L21tYy9jb3JlL21tYy5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKQEAgLTE1MDAsNyAr
MTUwMCw2IEBAIHN0YXRpYyBpbnQgbW1jX3NlbGVjdF9oczIwMChzdHJ1Y3QgbW1jX2NhcmQgKmNh
cmQpCiAJCW9sZF90aW1pbmcgPSBob3N0LT5pb3MudGltaW5nOwogCQlvbGRfY2xvY2sgPSBob3N0
LT5pb3MuY2xvY2s7CiAJCW1tY19zZXRfdGltaW5nKGhvc3QsIE1NQ19USU1JTkdfTU1DX0hTMjAw
KTsKLQkJbW1jX3NldF9jbG9jayhjYXJkLT5ob3N0LCBjYXJkLT5leHRfY3NkLmhzX21heF9kdHIp
OwogCiAJCS8qCiAJCSAqIEZvciBIUzIwMCwgQ1JDIGVycm9ycyBhcmUgbm90IGEgcmVsaWFibGUg
d2F5IHRvIGtub3cgdGhlCg==
--000000000000273e3505fb5d151f--
