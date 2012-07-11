From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Prevent eMMC VCC supply to be cut from late init
Date: Wed, 11 Jul 2012 18:10:49 +0530
Message-ID: <CAGxe1ZH349XqUqe4kkDff6LbTGVzmmfKZXFrM-Hb-_cM4t+pLA@mail.gmail.com>
References: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZEnVNLs=sh3kB4w8nvvbGuqowwz9pDtwAdCGLm-M+dKuQ@mail.gmail.com>
	<87ehojr06s.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61024 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab2GKMku (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jul 2012 08:40:50 -0400
Received: by qadb17 with SMTP id b17so3027273qad.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jul 2012 05:40:49 -0700 (PDT)
In-Reply-To: <87ehojr06s.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jasi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

On 10 July 2012 23:02, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Tue, Jul 10 2012, Girish K S wrote:
>>> @@ -2063,7 +2074,8 @@ void mmc_rescan(struct work_struct *work)
>>>
>>>  void mmc_start_host(struct mmc_host *host)
>>>  {
>>> -       mmc_power_off(host);
>>> +       host->f_init = max(freqs[0], host->f_min);
>>> +       mmc_power_up(host);
>>>         mmc_detect_change(host, 0);
>>>  }
>>>
>> sorry to comment late on this.
>> This patch breaks the card detect with the designware host controller.
>> Anybody using the same host controller please let me know.
>> The problem is caused by the power_up call from the mmc_start_host
>> function. If i comment this powerup then card detect is fine
>
> Thanks.  Ulf, sounds like we should revert this for 3.5-rc (which would
> have to happen soon) while we investigate; let me know what you think.
power_up function in the mmc_start_host can be completely omitted as
it will be anyway called in the mmc_detect_change.
I will test this change on the available host controllers and will
publish the result. If this removal doesnt cause any side affect, will
post it as a patch.

Ulf,
waiting for your comments on the same
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
