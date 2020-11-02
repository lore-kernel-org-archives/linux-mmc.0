Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E51C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1A2227F
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQ+FOIc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBOys (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKBOys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 09:54:48 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D859C0617A6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2020 06:54:48 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id x11so4980807vsx.12
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+PEzNBJyGsKvDmDb7/sowIJwPahGqfbvKvpEucgAzU=;
        b=gQ+FOIc7rMZfzMgQDx+DmzAxvIP0oaeHxwrk25cTpBvsLFJKJE56GaiYnZ7AVzcO8D
         S9sumbhZSdVP/6JnGzMWz/q8qI3dJuzNQOYlCfVtHsVuXZPrm+lTZHcCpVRVC2/xLQbc
         VJEkqfh43iJRBhCYO9w1JQP2XFtmrrWfv2F3yMAZ0pA6k6TVV6GnNHRZ/EtipCcRDBju
         Ec5gnEXyxHum2fbiQEjSjmjI1GRiUH++tdv8gecKLtoKTuUKw11awCVMRPSE+Xd2JmhS
         pM2/tj7T/ulSM0c3VDZ7Td9u8o6LUkVnzE0+OfGTSdfKeOPN9fghG0hVHJA4iIS+lo1c
         rQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+PEzNBJyGsKvDmDb7/sowIJwPahGqfbvKvpEucgAzU=;
        b=r29J9INinSX99rZRnosK4HPotx/F6RAa0AS7NoQ5nghHxrM5YHqjlr7Mu1jjph7PoM
         J3qV7hpJQqMZs6QnPEZyhFWHoC7fGwc+DvwWD2ePSbLIavwKFpMmNrn4a/uLVwP43muM
         MgnCNMnJVaND1KDDEDcGPgPbTTkYiOIocPNwlkmAlqNj4FwpoA1ei9MoYEJnracElX6K
         Gpl4BE8+vjJ5i9ZPMC+7mapJ5mZT7hUlbxPajfDA+uS5U8/uLaLCK9KKjXHufisXmH99
         sw7Elt3rbeWQkMtZksFEEZd6qZYT3KsgqYpXCs81IRg40bs6Tct45PLahpvj3n7vnFV+
         QKRA==
X-Gm-Message-State: AOAM530UqcwMElbS4i3pxkMx/4kz7or6iX4V8SXOfKH6ZwtXK4wnQEqS
        5y15H5DnhJd7do3+rQi5bn/uCiGwaNgRFPh3i7tdDg==
X-Google-Smtp-Source: ABdhPJxDwqyeIG36cjfG1DWi8OQZQf/npk7fOC9c1lS1SXSIiATfKrZpIPD254oVxAvvXmuqijqQ5lTW4jjHXwKldDc=
X-Received: by 2002:a67:f417:: with SMTP id p23mr8674022vsn.42.1604328887327;
 Mon, 02 Nov 2020 06:54:47 -0800 (PST)
MIME-Version: 1.0
References: <fa7f3fc5-c37a-ac49-e14a-45a1d2e0a942@gmail.com>
In-Reply-To: <fa7f3fc5-c37a-ac49-e14a-45a1d2e0a942@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Nov 2020 15:54:11 +0100
Message-ID: <CAPDyKFq9vKOODDQEEE2W+Gsx69_R3XV_Hb-owMU-=qAMbv39kg@mail.gmail.com>
Subject: Re: [BUG] cqe unable to handle buggy cards
To:     Peter Geis <pgwipeout@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        nuumiofi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ cqhci maintainers

On Sat, 31 Oct 2020 at 13:54, Peter Geis <pgwipeout@gmail.com> wrote:
>
> Good Morning,
>
> We are seeing an issue on the rk3399 with certain Foresee emmc modules
> where the module reports it supports command queuing but fails in actual
> implementation.
>
> Unfortunately there doesn't seem to be any method for the mmc core code
> to detect this situation and disable command queue automatically.
> There also appears to be no way to disable it at runtime.
>
> Certain modified kernels have added a patch to enable runtime disable of
> command queue entirely, but this will affect mmc core as a whole and not
> just the buggy card.
>
> Does anyone have any insight into this issue?
> Thank you for your time.

Unfortunate, not me personally. I assume the issue is either be card
specific or host specific. Before looking at a disable option, we need
to know more about what goes wrong, I think.

Kind regards
Uffe

>
> Very Respectfully,
> Peter Geis
>
> [   64.472882] mmc2: cqhci: timeout for tag 2
> [   64.473349] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
> [   64.474057] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
> [   64.474763] mmc2: cqhci: Config:    0x00000000 | Control:  0x00000000
> [   64.475468] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
> [   64.476172] mmc2: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
> [   64.476875] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> [   64.477578] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
> [   64.478281] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> [   64.478984] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> [   64.479687] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> [   64.489785] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> [   64.499774] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> [   64.509687] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   64.519597] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> [   64.529521] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [   64.539440] mmc2: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
> [   64.549352] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
> [   64.559277] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> [   64.569214] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [   64.579061] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [   64.588842] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> [   64.598671] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [   64.608446] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
> [   64.618161] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
> [   64.627801] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x642017d7
> [   64.637376] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
> [   64.646855] mmc2: sdhci: Host ctl2: 0x00000083
> [   64.656080] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
> [   64.665445] mmc2: sdhci: ============================================
> [   64.674998] mmc2: running CQE recovery
>
> [  125.912941] mmc2: cqhci: timeout for tag 3
> [  125.921978] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
> [  125.931200] mmc2: cqhci: Caps:      0x00000000 | Version:  0x00000510
> [  125.940389] mmc2: cqhci: Config:    0x00000001 | Control:  0x00000000
> [  125.949499] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> [  125.958527] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> [  125.967486] mmc2: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> [  125.976260] mmc2: cqhci: Doorbell:  0x00000000 | TCN:      0x00000000
> [  125.985065] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> [  125.993698] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> [  126.002244] mmc2: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> [  126.010716] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> [  126.019159] mmc2: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> [  126.027525] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  126.035955] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> [  126.044258] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [  126.052396] mmc2: sdhci: Argument:  0x00000001 | Trn mode: 0x00000010
> [  126.060370] mmc2: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000034
> [  126.068241] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> [  126.075978] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [  126.083552] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [  126.090937] mmc2: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> [  126.098219] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [  126.105403] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
> [  126.112649] mmc2: sdhci: Cmd:       0x00003013 | Max curr: 0x00000000
> [  126.119700] mmc2: sdhci: Resp[0]:   0x00400800 | Resp[1]:  0x642017d7
> [  126.126594] mmc2: sdhci: Resp[2]:   0x4e436172 | Resp[3]:  0x00880103
> [  126.133334] mmc2: sdhci: Host ctl2: 0x00000083
> [  126.139652] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf0628208
> [  126.146008] mmc2: sdhci: ============================================
> [  126.152361] mmc2: running CQE recovery
>
>
