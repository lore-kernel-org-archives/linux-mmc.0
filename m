From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Prevent eMMC VCC supply to be cut from late init
Date: Tue, 10 Jul 2012 13:32:59 -0400
Message-ID: <87ehojr06s.fsf@octavius.laptop.org>
References: <1336572926-21013-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZEnVNLs=sh3kB4w8nvvbGuqowwz9pDtwAdCGLm-M+dKuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57601 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab2GJRdH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Jul 2012 13:33:07 -0400
In-Reply-To: <CAGxe1ZEnVNLs=sh3kB4w8nvvbGuqowwz9pDtwAdCGLm-M+dKuQ@mail.gmail.com>
	(Girish K. S.'s message of "Tue, 10 Jul 2012 20:49:04 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jasi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On Tue, Jul 10 2012, Girish K S wrote:
>> @@ -2063,7 +2074,8 @@ void mmc_rescan(struct work_struct *work)
>>
>>  void mmc_start_host(struct mmc_host *host)
>>  {
>> -       mmc_power_off(host);
>> +       host->f_init = max(freqs[0], host->f_min);
>> +       mmc_power_up(host);
>>         mmc_detect_change(host, 0);
>>  }
>>
> sorry to comment late on this.
> This patch breaks the card detect with the designware host controller.
> Anybody using the same host controller please let me know.
> The problem is caused by the power_up call from the mmc_start_host
> function. If i comment this powerup then card detect is fine

Thanks.  Ulf, sounds like we should revert this for 3.5-rc (which would
have to happen soon) while we investigate; let me know what you think.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
