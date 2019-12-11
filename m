Return-Path: <SRS0=rVnL=2B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E11C2D0C6
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C05D2073B
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkDYur5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfLKPqj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:46:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42060 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733015AbfLKPqi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2019 10:46:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so17034496lfl.9;
        Wed, 11 Dec 2019 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hb49b1TTgt6OexHutblEuNW1wSf9d52k2K2OJyi3uuU=;
        b=PkDYur5uKLoW9VhvC2aZGxAYkKOERHduE37OR7NaumcyTiSKtWlWnL0YhAPocF4gyW
         i/2Ma5FcnPrB9FHWe3iICD5xAY3QajO+jJbaVQH6KWtwutz8e9PQj5v0KAyH2cpvEZmG
         wSdlkeBQXijgqdUDXTVJmK81fJ9UGojdfW+++x+d7hsPy+uaKYFYjdTM5X0ql9xutYaT
         7JcsaOhLlylyP4SqXdy3Kx05UKW323rSrU8cWgU/xU+MPxyIin2Qq/7wxNN/tmEfhfKo
         wIz0CBYRJgoEliIMaZmtHcB/2GJ+86fimeFGh2DjuJVshD2g2NT7hPjvo5bGyFv7wH5I
         kNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hb49b1TTgt6OexHutblEuNW1wSf9d52k2K2OJyi3uuU=;
        b=fzmGHuonwjDtWGtc8fOggXuzriJXy6bCYJ2bkx+EGXddVNhXZvXyTc3WlOKaatR5bT
         YrN7KqU0aWycsIguwp1Io+X+3Ufx0Dwx0dTC3J+4VYvyXzCc0s67AnJFBSK0HRaNDnz+
         OP+zgxzfxYHMxcpYmNmHWIW1WpHNfN9/lcsqoSAO/MDJaT6MpHYc+6F1JfHy7j255k1q
         n2miyR/hqWoyS+gGWjBb1xNcKQyoAw/fgh98k9FnbNl0bDzLI5ubM7wZX9RWsS9OPEhB
         p2xI/YREhD+12cmE3OFlj7QaQhI3MOgHRSpHByhwVdpjCJQaebCC+/yR6zoJF+xGKjv4
         xUlw==
X-Gm-Message-State: APjAAAX4LQbEicAwEYH6qHuk8cOAjVDxjAx5ZrZdTIrxpeNt7m/HPv+e
        ZzF65briUAZwFTZEkwzDhz0IY8+/
X-Google-Smtp-Source: APXvYqy67rQ6NDMYoPXkX1ni2G1d870R9UN7KWCu2PvsM+xokjKjbXFrB2RpHDe1scGGslddP6CKJg==
X-Received: by 2002:ac2:4909:: with SMTP id n9mr2693030lfi.21.1576079195882;
        Wed, 11 Dec 2019 07:46:35 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e12sm1403826ljj.17.2019.12.11.07.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:46:35 -0800 (PST)
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191210014011.21987-1-digetx@gmail.com>
 <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com>
Date:   Wed, 11 Dec 2019 18:46:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf,

11.12.2019 11:11, Ulf Hansson пишет:
> On Tue, 10 Dec 2019 at 02:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
>> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
>> In a result high-speed mode isn't enabled for the WiFi card and this
>> results in a malfunctioning SDIO communication.
> 
> Does that also mean SDIO_SPEED_SHS bit is set when reading SDIO_CCCR_SPEED?

Yes, the SDIO_SPEED_SHS bit is set.

>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>
>> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
>> the problem, let's do the same in upstream.
>>
>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
>> which overrides card's info for the TI wl1251 WiFi.
> 
> This is a temporary solution and should be replaced by doing the DT
> parsing during
> 
> So, yes, let's see if we can use a card quirk instead. That's the first option.
> 
> A second option is simply to parse the DT subnode for a new DT
> property during mmc_sdio_init_card(). Along the lines of what we do
> for the broken-hpi DT binding for eMMC.

Let's try the first option. My understanding is that the problem affects
only the specific model of the WiFi chip and it's not a board-specific
problem. I'll add Broadcom driver people to CC for the next version of
the patch, maybe they'll have something to say.

[snip]
