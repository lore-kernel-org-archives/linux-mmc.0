From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 1 Sep 2016 19:49:49 +0530
Message-ID: <CANYu_0vDHLhj78egE2TkO3z7o=4wKBt_ga84ktd2bY4QuHj40w@mail.gmail.com>
References: <20160901101021.26371-1-pramod.gurav@linaro.org>
 <CAPDyKFqg4jq2dK579eTR1fen1Fhr93p6SpPfDcMxKhiVR9sTPw@mail.gmail.com> <CAPDyKFrdrWOkRJSL2r01eXzBQrkFm14wKn=rvABQ7EWvaNtZnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrdrWOkRJSL2r01eXzBQrkFm14wKn=rvABQ7EWvaNtZnQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 1 September 2016 at 19:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>> +
>>> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
>>> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)
>
> One more thing. Why do you need the late versions of the system PM callbacks?
>
> I think it's fine to use the regular:
> SET_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)
>
Should have waited for this review as well. :)
Anyway I forgot to add v3 tag in my new patch.
Will resend v3 with this change as well.

> [...]
>
> Kind regards
> Uffe
