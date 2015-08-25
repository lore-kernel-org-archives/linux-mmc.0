From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Initial signal voltage ?
Date: Tue, 25 Aug 2015 14:05:39 +0200
Message-ID: <CAPDyKFpDzBV9zXAZH_KddZVdUQ_t2W3Qb3yG70ceagv4+oy7cQ@mail.gmail.com>
References: <1439225438.3120.94.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35018 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbbHYMFk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:40 -0400
Received: by igbjg10 with SMTP id jg10so10225425igb.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:05:39 -0700 (PDT)
In-Reply-To: <1439225438.3120.94.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10 August 2015 at 18:50, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> in mmc_power_up() we have:
>         /* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
>         if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
>                 dev_err(mmc_dev(host), "Initial signal voltage of 3.3v\n");
>         else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0)
>                 dev_err(mmc_dev(host), "Initial signal voltage of 1.8v\n");
>         else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) == 0)
>                 dev_err(mmc_dev(host), "Initial signal voltage of 1.2v\n");
>
> Here one jut brutally tries to set the initial power to 3.3 but nowhere in
> general code there is a check if the controller can handle this w.r.t
> HOST CAPS.

You are right, it's brutal. :-)

Perhaps the host driver should return -EINVAL when a voltage level
can't be reached. The above code should not print messages as errors,
at least as long some voltage level can be used.

> Where should this check be performed, I am guessing either here or in sdhci?
> This is all new to me so I am just throwing this out there

Do you want to send a patch?

>
>  Jocke--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
