Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ACCC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 01:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF85C63222
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 01:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKQBbH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhKQBbH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2021 20:31:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6DC061766
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2021 17:28:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so3125384edd.9
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2021 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzvlfo3mwRIjVNI3uBTsFictJR41rZxk5TeM/Ei1okM=;
        b=dY7xWxkn7EP7A0fQBKQJAS/t/i7hXMR3B340Y/elUV8VDoipVyFbxy5jMONgm4naWQ
         H8dqN6lbybISfOjw5fnLKUkLxN5/BGp6sibWyRuKLrkVn1r9GGXspRVHL8tGN/UYmwb0
         STaq9YjmufwVATs+jU7/L8dVTgNaP/Wo13DvnHmiMCvRu5VFNlootrnqj8YCfB8HZGMg
         PjxybDwrZNpkpAyCAPI9cpgCbZCvEGKnnMNuIL6qKCOP6i7dSXiUBsCtiZVtNOIEPcjD
         VVjwoLdDhIadxmgDtD8wfExhWrl2aExZok3xu0N/bFAiKC4MQxK7Uck8Ig6e+T2EnkZB
         JdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzvlfo3mwRIjVNI3uBTsFictJR41rZxk5TeM/Ei1okM=;
        b=O30xMvkdrsMsw4vx+2HDS0xNq4NaMjmzjw/fDSj7IsqSNdmaDUDG6F+TuQJ7Xhgvcj
         8NY3UkHwvLOWgZF89fXruykTin9x5SgIgV5E7QkKNCL3W8Ljw2ZlV6qIE8z8u0Pq6rMs
         VYj/ckhe4y+LGtr92shMUxjnxWe6rx+huvszm+SoNj2mixV+VlS5nxZGofEBNmgS6Cln
         GhPR1XslLwmw+ojYdFd66zjtEffUFpVshUZeEODZFJ/7UXHMjUmFe2z9e6dUx0gS6JYR
         AUHvgFJJRRQTgupmllb473bY0tZxDrc6ccaA2I2uQBjptttMms6iFzVoYbzjCaumJmyu
         oTfA==
X-Gm-Message-State: AOAM5311Jm22wgcAye//LZIiOdPAWP44k+vQdun4agToi/7Eg566qEUC
        n3aljPRcQfjW91lVTizrENf1MHQ0OM1PCidsNdQoNQ==
X-Google-Smtp-Source: ABdhPJz8mPrCc7kO/eC8/+0RnyK+b3AbY3p624T+emqGvUizx5GBVl4RNjW24qFhHOr0XuvwQ4Abd5P+LJhWQMTB2t4=
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr16812462ejc.95.1637112487826;
 Tue, 16 Nov 2021 17:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-4-brad@pensando.io>
 <YXhErvvSfKIBvHae@robh.at.kernel.org> <CAK9rFnyk=gW_ZRZUci3byu=DNwdrmKBb30HQgxK0iWJuVVPbfQ@mail.gmail.com>
In-Reply-To: <CAK9rFnyk=gW_ZRZUci3byu=DNwdrmKBb30HQgxK0iWJuVVPbfQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 16 Nov 2021 17:27:57 -0800
Message-ID: <CAK9rFnzvcOmEUXYufa4R42xo+SY1Bq_Txfj=Y1QhkAVwfv-oXw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

On Tue, Nov 16, 2021 at 5:21 PM Brad Larson <brad@pensando.io> wrote:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - microchip,mpfs-sd4hc

"microchip,mpfs-sd4hc" was inadvertently removed in moving to
5.16.0-rc1 and won't be in the re-spin of the patchset, its recently
added.

Also, as you mentioned the patchset should be sent against rc1

Thanks
Brad
