Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20529C001B0
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 16:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjHHQxT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjHHQwY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 12:52:24 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA05B9A
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 08:58:17 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d30554eefso35058646d6.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510291; x=1692115091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ubqfsmYb7V02nf1U7/39ZUb74vPvlvUEXZk/eI/cgk=;
        b=O8A78HFnJB/CTxySNMT/AtdNsZgdLD1N3iArR3eUjsT5kwrT/8q8F9B+SG7wDq4zBO
         5KBWZSRjnU/34HYlKc1LQNC620p6r47W6pcZXO2iczRuvjjBLR1Cc/0kIUDw5GqlgNos
         KScsRQjCnj3T01dPpEcz0fTco0nNIoM7+Glmanq7APlb6fi5/sY83D9nVzfcXTNDJuAg
         bnbEjVw5WV1SStACk+iV341i5bkIRnkgl3I6EWbO67X9xQnq0dHJB9GBR5YS7j+oOPEY
         C6HigeeCe/k6cmkE0SHplyqOlCDfKR0FFQHmgXxLvZx/TgEohDmxokq3uDs02FFCIYBZ
         LXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510291; x=1692115091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ubqfsmYb7V02nf1U7/39ZUb74vPvlvUEXZk/eI/cgk=;
        b=Q5I6uprNTxGtgMwnuuIk0zDjJf+CNIz6p3c+UeEou7b6txU8WwyNGsEL5gYeYXByfT
         2BZ9W2RiykUHJDBs5TUqaZ+7TnpGpwkCyNuVX6qEm7kgdK07sf8YQ7jEOjkLxxc5QNJw
         3PwucFTurfxP8PeGABWJvb0H0qOHZ4wG0j0NxdydYmuOSshNp7sgE2fmCA3OylNH3FjJ
         FpYcdc8uhbutAfP+XMxRi2X1Hnpy90HTx6yvAqhpnAopoi+O0rg3lng4J8ZtE1OcfKDM
         zZtAq3mvqnMExQWuC4jLXFiRP3AlwsTmb88Q3lBdT4DsdO3SS7eOkzTIgv7rQQhv1lur
         bIsQ==
X-Gm-Message-State: AOJu0YyL6I9h9VViq1YWP0ecuBPAtp0QhlS0XVlOtLxetA0MMECQpfZ2
        RiGCNu74NKspJFfPT6DzFsV+nqOH8SOSldf/bDWGoeBIpr4nxAHgDL4=
X-Google-Smtp-Source: AGHT+IHSHduNAZhtuWl0717SI9PBFnzbesbPZPWpUKYUXoQcp0TJmbb1ePGniPOczgezUXb2rRF/CgEe7L4IP+lhQpc=
X-Received: by 2002:a25:b87:0:b0:d4a:4b59:367e with SMTP id
 129-20020a250b87000000b00d4a4b59367emr8892048ybl.38.1691490522681; Tue, 08
 Aug 2023 03:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-5-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-5-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:28:06 +0200
Message-ID: <CAPDyKFrmwct=b6angucfrKOXneZXe+_2KQ4f--OQEoKD=fc5hg@mail.gmail.com>
Subject: Re: [PATCH V9 04/23] mmc: core: Extend support for mmc regulators
 with a vqmmc2
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Updates in V4:
>  - Moved the voltage defines into this patch.
>
> Update in previous version:

Please drop the version information from the commit message.

> To allow an additional external regulator to be controlled by an mmc host
> driver, let's add support for a vqmmc2 regulator to the mmc core.
>
> For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
> called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
> needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
> this too.
>
> Note that, to allow for flexibility mmc host drivers need to manage the
> enable/disable of the vqmmc2 regulator themselves, while the regulator is
> looked up through the common mmc_regulator_get_supply().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
