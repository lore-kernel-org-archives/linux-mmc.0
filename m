From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Fixup signal voltage switch
Date: Wed, 19 Dec 2012 11:03:35 +0100
Message-ID: <CA+20K0BNWjytkL698LmbOSoA=iGaZF0msXyQF1MP82b5rkC4Bw@mail.gmail.com>
References: <1355841538-6674-1-git-send-email-johan.rudholm@stericsson.com>
	<1355841538-6674-4-git-send-email-johan.rudholm@stericsson.com>
	<CADz5_gK4eudkHGws6QxE6rSHE3AUXBMRoGs7c5bq8HeNoPNj3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:34620 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab2LSKLy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 05:11:54 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so1353332qab.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Dec 2012 02:11:53 -0800 (PST)
In-Reply-To: <CADz5_gK4eudkHGws6QxE6rSHE3AUXBMRoGs7c5bq8HeNoPNj3w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Kevin Liu <kliu5@marvell.com>

Hi Kevin,

2012/12/18 Kevin Liu <keyuan.liu@gmail.com>:
> 2012/12/18 Johan Rudholm <johan.rudholm@stericsson.com>:
<...>
>> +               host->ios.signal_voltage = signal_voltage;
>>                 err = host->ops->start_signal_voltage_switch(host, &host->ios);
>> -               mmc_host_clk_release(host);
>> +               if (err) {
>> +                       host->ios.clock = clock;
>> +                       mmc_set_ios(host);
>
> Since will power cycle and init card again so no need to set clock here?

This is true! We don't need to re-set the clock here.

>> +       mmc_host_clk_release(host);
>
> mmc_host_clk_hold and mmc_host_clk_release seems not in pairs?

Also true, thanks.

>> +
>>         return err;
>>  }
>>
>
> I still prefer to update host->ios.signal_voltage after voltage switch succeed.
> And current code use host->ios as parameter while only the voltage
> value will be used in start_signal_voltage_switch.
> how do you think?

I believe Ulf had some arguments against this, I don't remember
exactly what they were. Maybe Ulf can elaborate a bit?

Kind regards, Johan
