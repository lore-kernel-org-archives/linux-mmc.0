Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE05C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 13:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiDKNJq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346350AbiDKNJq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 09:09:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F82C661
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 06:07:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so30727668ejd.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=tfLrXguJ2Kij4nTm0tLsBlKPFAR83W6uy0r/cYZLoy0=;
        b=qg1vdFBosra1iVxd/1645bh1qeqtefMFNth6gDMAdz+FgU2K64q5LVifZZlTSk3Oq5
         ahgJkX4oi4XfhyAQMTeu8hTiRNbJeLXJjwsBZVpuXc+L3uDTFRdDNV1HKMT7bGOfyq3q
         2175MQKxKsWNkB0j2l1kjVNZOEPFY0x6EN1GUsFRdGV24EYfHIGWyHHaCmtgyNH8PR0G
         7Xo9cv+dHzBYa4S5G4LOx6nXF95M2JIsPCJLWCT+QS9iWSxGjw5r+0xh6iqbIK3+T60T
         nRsJ1kRUefx2dL8JqYpJaOfgJgPHHxbX90juGELugdwsHmD0Rx+E3D/w+F7bIBnoTIaw
         PR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tfLrXguJ2Kij4nTm0tLsBlKPFAR83W6uy0r/cYZLoy0=;
        b=qnBKoljsVjsf0vrK9RPoQgXYzOrT8vuMfO0LFzvpzzwqxh1lXM88lexIDYVCkrZNu7
         K7izUMdbGyrQIMOzURBrVAYZXZfvbClEJy1VGKY9tWHgKb8nnnDiNDe9IJt9Byp5u/Ct
         mrMvARmbYTgmCAVzixb+qZvbaXpY3g0gkoDZclmfuFk2To/F3DI11JaJzu+gxZJj6Tkr
         nhRtFiBwOJu8RtL5EBAQ0kvNOo3TT2XNvatYxjBySP+f6glswVH2HC9GHho1+CCimXSx
         dmZtm6836ZUrwTHD2PgTYyMJ4g7tpH/0woqh24k2g3QMNdwd4I6z8I2t+3N4r7tWlRi8
         +1Gw==
X-Gm-Message-State: AOAM530LrCImLkBwvdEAD3rmPbL7fojYVKU8Co4kjFmvucl1+9cnjXjY
        c0t3V5JhNKQAYPZDiDo0/jNHh8CYyxH3jPGFt9+uhULRars=
X-Google-Smtp-Source: ABdhPJzYMsTCi5ba8dWSilMV0TfZB3VpjL7VLmwhr4mR73RWMauq+LrQtSSJHOtP1xLAEmv3+oZJNRaPOT0YGvk7nts=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr29266241ejm.613.1649682448738; Mon, 11
 Apr 2022 06:07:28 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Apr 2022 08:07:17 -0500
Message-ID: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
Subject: RZ/G2M Hangs when booting some SD cards
To:     linux-mmc <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I have a small collection of microSD cards that appear to hang when
booting.  It affects Renesas' 4.19 CIP kernel as well as 5.18.0-rc2
with the following:

[    2.717601] mmc1: tuning execution failed: -5
[    2.721979] mmc1: error -5 whilst initialising SD card
[    2.839001] mmc1: tuning execution failed: -5
[    2.843378] mmc1: error -5 whilst initialising SD card

I can use these same cards on a different platform like NXP IXM8M, and
they enumerate and mount just fine on a Linux machine, and my boot
vFAT partition mounts just fine on a Windows machine, so it seems
limited to just Renesas on Linux.

I did some testing, and I found that U-Boot on the same board can also
properly initialize the microSD card and it emuerates at sdr104.

Manufacturer ID: 1d
OEM: 4144
Name: USDBus Speed: 199999992
Mode: UHS SDR104 (208MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 29.8 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
=>

This lead me to believe that U-Boot is initializing the micro SD card
differently than Linux, so I investigated the drivers in both to
compare what's happening differently.

The drivers between U-Boot [1] and Linux [2] appear very similar to
each other, but I noticed that U-Boot does something that Linux does
not do.

In U-Boot, renesas_sdhi_select_tuning checks a series of bits in
priv->smcmp and clears them.

renesas_sdhi_select_tuning()
<snip>

for (i = 0; i < priv->tap_num * 2; i++) {
    if (!(taps & BIT(i))) {
        taps &= ~BIT(i % priv->tap_num);
        taps &= ~BIT((i % priv->tap_num) + priv->tap_num);
    }
    if (!(priv->smpcmp & BIT(i))) {
        priv->smpcmp &= ~BIT(i % priv->tap_num);
        priv->smpcmp &= ~BIT((i % priv->tap_num) + priv->tap_num);
    }
}

Later in the code, it checks to see if various bits in priv->smcmp are set

for (i = 0; i < priv->tap_num * 2; i++) {
    if (priv->smpcmp & BIT(i))
        ntap++;
    else {
        if (ntap > match_cnt) {
            tap_start = i - ntap;
            tap_end = i - 1;
            match_cnt = ntap;
        }

<snip>

In Linux, the driver is split into multiple parts, so it's a little
harder to follow, but it appears to do something similar in
renesas_sdhi_select_tuning where it checks bits and clears various
bits in priv-smpcmp:

for (i = 0; i < taps_size; i++) {
    int offset = priv->tap_num * (i < priv->tap_num ? 1 : -1);

    if (!test_bit(i, priv->taps))
        clear_bit(i + offset, priv->taps);

    if (!test_bit(i, priv->smpcmp))
        clear_bit(i + offset, priv->smpcmp);
}

So far, these look fairly similar.

However,  a bit later, the code that checks the smcmp in U-Boot
appears dramatically different in Linux, and I don't understand the
tuning phase nor do  I have the sd card spec.

In U-BOot there is a comment (with some corresponding code) that states:

/*
* Find the longest consecutive run of successful probes.  If that
* is more than RENESAS_SDHI_MAX_TAP probes long then use the
* center index as the tap.
*/

This chunk of code appears drastically different from the Linux side,
but maybe it's ok.

Then later, U-Boot has a for loop which either increases the ntap if
priv->smpcmp & BIT(it) is set or does some math on adjusting
tap_start, end and match_cnt.  It's covered by a comment that reads:

/*
* If all of the TAP is OK, the sampling clock position is selected by
* identifying the change point of data.
*/

I don't understand the logic on the Linux side, but when we get down a
bit further, we end with

if (tap_cnt >= min_tap_row)
    priv->tap_set = (tap_start + tap_end) / 2 % priv->tap_num;
else
    return -EIO;

Which I believe yields the failure  of

"error -5 whilst initialising SD card" that I mentioned above.

I was thinking about taking the math from the U-Boot and porting it to
Linux to see if the issue goes away, but before I did that, I was
hoping someone might have some insights to see if that's the right
direction to go.

thanks

adam

[1] - https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/mmc/renesas-sdhi.c
[2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/renesas_sdhi_core.c?h=v5.18-rc2
