Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBCC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C47B2078B
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 09:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2tKtBVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgEYJOk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbgEYJOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 05:14:39 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5800FC061A0E
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 02:14:39 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id j28so4099475vkn.8
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXuwN3ZmRV2excJ3p2CN9NG8Qr8rioJgcoc6aldNCD8=;
        b=u2tKtBViXH6AWKT3Mn2m0UzeHw0JqODyMKiID+MEZt8Z5kBzw8yPsSzMjDOEVeaAab
         QwpdL2Zu3ahm/UO3jOafsr6irTlUnPzNpbMh/LGi5r8+tJCKDL5PYNrNqNO6/3dcS6KH
         dourbb3n31h5TXTxH/nj+3o9KKjlOwK0t2BjFoFpo9EUVbMveik8QwOg55/PW9YjRIg1
         OTfRK+zzXlgl4+RreEkb+O0L2W+dCw9zgLtXl87Dkk6uivRrB28msX5BVD2iHKNpzEMk
         wO7CmlonEjJQcdXAX07R/R8qk1Ki5wbHp8/hsg6wi3iO2ykOBo2rdjxi97q3siQgPro1
         dmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXuwN3ZmRV2excJ3p2CN9NG8Qr8rioJgcoc6aldNCD8=;
        b=tK2E9A0P8iSCzXOd6AGOzMG5Lidqc+nl0pXwjtPZxDsDYMCrHKwL/OEbBm+23LHH+e
         A+P04PZtNC0hSHqOc1NTWfVbBn3k2c66B1fcH7gL6XM7e4IN7EHdG868Y7l521OBW6eB
         BsaNdKXogZaW2CQsbPPdmH48sWDmN+l2xOhMIH/ci+0MvDcM04qTtfUBwoX8rphD3ON/
         yJQZpsBqq3AxwR7XnER00iF9qd+PfhlPKVFP1K5X3dj2igcpYn404OHFM7+o29dBOXLL
         toMSKl2ry+17xnDa9n3SrL8feJOw8uxPgeJjswpaCZ/uUODPuRe1IZbZxlSilEiCJ0C7
         xlTw==
X-Gm-Message-State: AOAM530TBZFLioVR9swWZCwz/91F/j9QDuz+8oUnx6XB096agcSlbUvB
        ShM4ayR+V/6nIfu7NCJZ5p5yLN3Pig9FAexKSCt1tQ==
X-Google-Smtp-Source: ABdhPJyUrplC+1r41BytkTJiP8Iq/ghMHkizMPyE3irQHWuQvTdmtRtJghTTJybAI3GWbvgH4KnAvMG3hCnhVfe85h8=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr18893350vkl.53.1590398078147;
 Mon, 25 May 2020 02:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <491cfef4-4a97-b6e8-0f41-d44e1c73eea4@gmail.com>
In-Reply-To: <491cfef4-4a97-b6e8-0f41-d44e1c73eea4@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 11:14:01 +0200
Message-ID: <CAPDyKFqAWVPU=mJ=RzMyJsBiMTfSQqFTXw1oLqb=cZCM4e9ebw@mail.gmail.com>
Subject: Re: sdhci_msm issues with cold-plugged SD cards
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     kernelnewbies@kernelnewbies.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Bjorn, Sarthak, Veerabhadrarao

On Fri, 22 May 2020 at 17:51, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>
>
> Hello,
>
> I'm trying to add SD Card support to a smartphone (Samsung Galaxy S5). After
> configuring the sdhci-msm driver through DT, it all seems to work fine except
> the case when the phone boots with the SD card inserted. If the card is
> re-inserted, or the driver is polling, or the probe code is forcefully executed
> a second time the card is properly detected.
>
> I logged the SD interrupts, commands and responses, and it looks like the
> hardware is returning Command Index Error and/or Command End Bit Error via the
> Error Interrupt Status Register, which gets converted to -EILSEQ error. On
> a second attempt (due to re-insertion, polling or re-execution) these errors
> are missing, and the card behaves correctly.
>
> On the downstream kernel, these errors resulting in EILSEQ do not appear, so it
> might be related to setup. Also I see that sdhci-msm driver has hardcoded
> a SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk, which might imply that polling
> should be used (instead Card Detection GPIO), in which case this issue won't
> manifest itself. But polling wastes power, and the Card Detect pin works well,
> at least for this device, so I feel it can be made better.
>
> Any suggestions on how to track this down are appreciated!

I think the device is intended to be used with GPIO card detection.
Polling mode shouldn't be needed if there is GPIO.

Anyway, to me it sounds like the HW/controller isn't properly
initialized during ->probe(), but I can't help you much more than
that. I have looped in some of the recent active sdhci-msm developers
to see if they have some ideas that we can try.

Kind regards
Uffe
