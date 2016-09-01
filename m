From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 1 Sep 2016 16:08:50 +0200
Message-ID: <CAPDyKFrdrWOkRJSL2r01eXzBQrkFm14wKn=rvABQ7EWvaNtZnQ@mail.gmail.com>
References: <20160901101021.26371-1-pramod.gurav@linaro.org> <CAPDyKFqg4jq2dK579eTR1fen1Fhr93p6SpPfDcMxKhiVR9sTPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38471 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbcIAOIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:08:53 -0400
Received: by mail-wm0-f41.google.com with SMTP id 1so97304236wmz.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2016 07:08:52 -0700 (PDT)
In-Reply-To: <CAPDyKFqg4jq2dK579eTR1fen1Fhr93p6SpPfDcMxKhiVR9sTPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

[...]

>> +
>> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
>> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)

One more thing. Why do you need the late versions of the system PM callbacks?

I think it's fine to use the regular:
SET_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)

[...]

Kind regards
Uffe
