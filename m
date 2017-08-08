From: Doug Wilson <doug.lkml@gmail.com>
Subject: Re: [PATCH] omap/hsmmc: constify dev_pm_ops
Date: Tue, 8 Aug 2017 17:09:57 +0530
Message-ID: <CALY8T6qJeu8tXJw8LTyg_jd-T_L725LrD2vTJ0dTprzJd+HjZw@mail.gmail.com>
References: <1502190857-3762-1-git-send-email-doug.lkml@gmail.com> <CAPDyKFrSTG5yWwfJfbZzBTTqsLAitbXQ_5C-Nkg-Htmr_K7NpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrSTG5yWwfJfbZzBTTqsLAitbXQ_5C-Nkg-Htmr_K7NpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Wilson <doug.wilson@gmail.com>
List-Id: linux-mmc@vger.kernel.org

>>
>> Signed-off-by: Doug Wilson <doug.wilson@gmail.com>
>
> This doesn't apply on my next branch, please re-base it.

is this your next-branch :kernel/git/ulfh/mmc.git ?

- Doug

>>
>> -static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>> +static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>>         SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
>>         .runtime_suspend = omap_hsmmc_runtime_suspend,
>>         .runtime_resume = omap_hsmmc_runtime_resume,
>> --
>> 2.7.4
>>
