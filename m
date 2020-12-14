Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B8C4361B
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810B42253D
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgLNP6Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgLNP6Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 10:58:16 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C83C0613D3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 07:57:36 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id y26so5613933uan.5
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXj2L/gpA5Z+dEMYx7lFyvYb6eATLj9JT43cDhRuOs4=;
        b=mItKLRyCuzJrSK8Od8x+kXuTZfDwYKDtxNWWYttW2xt9pJ340SAw3D74IPyF1TRQkj
         bf6Zky0yKI6L5+LP6Z+6PDJ024szLWmlpSOptu0arTk+UGSLhPZE2fwXhrFv3RYdIacB
         31JgIFaLxn4sEDuUi0vZDA2LtAACNqERBnyxoq/PT6wI7jXjxKi4StzKuXaFdFifd1Pi
         Np5Drtzn1tBr0Ejw9giN/sHfJXz9aqR5upRR+I5gHTMPduzmzJZW8G9SwaWQtaD9ID/0
         34rL6Z+EfpBjoej5wMc+RbiSM75QUYfZ1qUGbnMlw6nySB1TQ1XwoGsAd9RZg9dB7AMi
         47XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXj2L/gpA5Z+dEMYx7lFyvYb6eATLj9JT43cDhRuOs4=;
        b=Qeevquqwxza78nS6kNSoaOksCoerfwxaZXXvV3eRTm2OjTxTLfc4o+q5hEXfLnd9A4
         xHNzeTFcxYg/bzye3MT9l12MqJNg3fBj5JXvRmT9MhpkN7x8HEEmth+k37lku7oqi7OO
         0Ib5f+5RHqR2/2osHscWlIHFwWKvtksaK7QVVJlLTpaQNkSRY8+Z0GNH6eMFswYaJ5Uu
         9k4kqWWfoAhwUG38zZ2e+J7AvOXXjLurOhTNX0omUMUmmGHFi8tYvQ+xkVPpEBDLZW7N
         LVz2aCs8OxH5P4aG7ym3beY7bjEjD/y3LY1OwY9jVnCiwE9aP32iGeALK76vDcS74BDx
         Dt8g==
X-Gm-Message-State: AOAM533kgCKX3cglrJNVz1sSChNiUyJozZx+aZrNe0QnNo439b7K9rTb
        YhtaVS/kK4AGa1u+wKwc8BDK32iDT9XL/RJ3Iqkd+Q==
X-Google-Smtp-Source: ABdhPJzdfWPRBW0/f0jpVNrHb1/fu5VTxg/DQ0L43Zjos4Zi2HwXvGdkwhaNygxEwdpDSjUu9VyxZY/jyLL25Bv2K38=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr23369715uad.15.1607961455333;
 Mon, 14 Dec 2020 07:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20201208012615.2717412-1-andrew@aj.id.au>
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Dec 2020 16:56:59 +0100
Message-ID: <CAPDyKFpCiA_fT0tQ58z_3mt183RJ30QZWE_qjbmXGO3imHqMzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        ryan_chen@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Dec 2020 at 02:26, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series implements support for the MMC core clk-phase-* devicetree bindings
> in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
> and is present for both the SD/MMC controller and the dedicated eMMC
> controller.
>
> v5 fixes some build issues identified by the kernel test robot.
>
> v4 can be found here:
>
> https://lore.kernel.org/linux-mmc/20201207142556.2045481-1-andrew@aj.id.au/
>
> The series has had light testing on an AST2600-based platform which requires
> 180deg of input and output clock phase correction at HS200, as well as some
> synthetic testing under qemu and KUnit.
>
> Please review!

FYI, other than the comment I had on patch1, I think the series looks
good to me.

[...]

Kind regards
Uffe
