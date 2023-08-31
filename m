Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0053C83F12
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Aug 2023 13:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbjHaNiU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 31 Aug 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjHaNiT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Aug 2023 09:38:19 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE9AE49
        for <linux-mmc@vger.kernel.org>; Thu, 31 Aug 2023 06:38:16 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-573ac2fa37aso504862eaf.3
        for <linux-mmc@vger.kernel.org>; Thu, 31 Aug 2023 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693489095; x=1694093895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnfBvAXT1xVE37ZcKh2hKMLAng14FgF20JU9vZkoeeg=;
        b=Y4PUw8aTqFgplFKaVDCn7nNK7UTFSUXtRhH3jPtWkd1iQmLh9vH5XX9+mqQRfvcoka
         NlAiLKFPH12nOnVHzbaRPmAWklKvJQkyQKSdLuwMFITwegNwGScWvarYAyj1hZ+ORWw6
         Uk0eehnWh73fkDdZ4DzOwwbTFS/oxqxd4Zsxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489095; x=1694093895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnfBvAXT1xVE37ZcKh2hKMLAng14FgF20JU9vZkoeeg=;
        b=VZx6RDOcQRt9IxXOPCOWqBh/QRZ3GS+5DHkZ0g3q6gS1t3/KPmbKv54TBwlvFSYx9h
         badgha+rUbXq7wrA73EyrciU2uqO365gYQtvYf90faPfN4zT5lwwNVZZ3Bl/POo0gOde
         JYUbDUgwhiU7oKlTUIQhd8Ma2p0dOL4Wgu4yJ3YE8cuvZM9W9mHGF1/1rrwVBhCj4MMm
         lL2B4uJNnzyoVnPHdyPrCkh3T33I2IFnOQqneXNczD9VIUizvxGF3LYgEMMWv95eZJcf
         LgURde+eNxefzTcyBZwqbxXcvyjD5QqEk/QceMjYndqEJSTXbnr0ACMsQKpsFZYOeP3g
         klPg==
X-Gm-Message-State: AOJu0YwGgoUP4rOAL94gaXc7AtSJGaPvWKvLvtvL/N3FZJK6Y/I6po5z
        z7FpddWVSRJt2fV2xNTYAUmQfmnhJf2kfXC0PUzrTQ==
X-Google-Smtp-Source: AGHT+IFRwYUBge4ieB/At4zcOGYmWN/rQxRgzqgNJfiPCPV89l6sTDHL6sduj2YM3P1+3vEtXtqYKMGsjveoBo/C85s=
X-Received: by 2002:a05:6808:1406:b0:3a4:57a7:b30e with SMTP id
 w6-20020a056808140600b003a457a7b30emr6975375oiv.26.1693489095366; Thu, 31 Aug
 2023 06:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230823174134.v2.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
 <e22c4a5f-c592-7121-7173-eef669ebdf89@intel.com> <f8a6bdee-4abb-b69d-874e-c0a13e2ac4a9@intel.com>
In-Reply-To: <f8a6bdee-4abb-b69d-874e-c0a13e2ac4a9@intel.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 31 Aug 2023 09:38:04 -0400
Message-ID: <CAG-rBigAJbZ34bf7ZEuEM+OyEQ0i2yj=sQ+10KXAquQ7HHcwBw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        jason.lai@genesyslogic.com.tw, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        linux-mmc@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Thu, Aug 31, 2023 at 9:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> I think the discussion was a little uncertain over
> moving this, so maybe leave it alone.

Agree, will do.

>
> However please consider my other comments.

Of course !
