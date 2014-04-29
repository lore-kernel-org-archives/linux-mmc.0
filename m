From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH RESEND] mmc: core: Improve support for deferred regulators
Date: Tue, 29 Apr 2014 10:00:33 -0700
Message-ID: <CAAYSxhpr5rvfrsihYLCv4YK5sYZ96f6rWkzW9Vp_iBqqGhGXCA@mail.gmail.com>
References: <1398451211-19693-1-git-send-email-tim.kryger@linaro.org>
	<CAL1qeaFFpVNRBqmS4j1Vx1-NKX3VjJuDrVNYTsT91nB_bQ7HJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50296 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933292AbaD2RAd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 13:00:33 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so585461obc.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2014 10:00:33 -0700 (PDT)
In-Reply-To: <CAL1qeaFFpVNRBqmS4j1Vx1-NKX3VjJuDrVNYTsT91nB_bQ7HJA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Apr 25, 2014 at 2:33 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
>>
>> -       if (IS_ERR(supply))
>> -               return PTR_ERR(supply);
>> +       if (IS_ERR(mmc->supply.vmmc)) {
>> +               if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
>> +                       return -EPROBE_DEFER;
>> +               dev_info(dev, "No vmmc regulator found\n");
>> +       } else {
>> +               ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
>> +               if (ret > 0)
>> +                       mmc->ocr_avail = ret;
>> +               else
>> +                       dev_warn(dev, "Failed getting OCR mask: %d\n", ret);
>> +       }
>
> I think we also need to handle the case where supply is NULL, i.e.
> !CONFIG_REGULATOR.  The SDHCI driver, for example, calls
> regulator_is_supported_voltage() which will always return false on
> NULL regulators.  Perhaps we should set the supplies to
> ERR_PTR(-ENODEV) in that case?

As of v3.15-rc3, this function would do the right thing because
df7926f modified the regulator get optional stubs to return -ENODEV in
the !CONFIG_REGULATOR case.  However, this implementation of
mmc_regulator_get_supply doesn't actually get built for that case.  A
stub implementation is used instead.  Presently that stub
mmc_regulator_get_supply does nothing other than return zero but
perhaps it should initialize the supplies as you suggest.
Alternatively, the stub could be eliminated such that this
implementation is used in all cases.  Do you have a preference?

-Tim
