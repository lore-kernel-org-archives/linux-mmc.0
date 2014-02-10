From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: UHS-1 cards with iMX6Q
Date: Mon, 10 Feb 2014 20:11:36 +0800
Message-ID: <CAA+hA=SnJHdem5F0NP3A+_ViZyVWdhWWeVJBo6W+UoOwZJEtmg@mail.gmail.com>
References: <20140207152951.GB26684@n2100.arm.linux.org.uk>
	<20140207155920.GA10195@S2101-09.ap.freescale.net>
	<20140209151441.GM26684@n2100.arm.linux.org.uk>
	<CAA+hA=TVA-4uSB+RSaCjG52N4CSD+gdw_u4iqfrLr7jYyGkf9w@mail.gmail.com>
	<20140210103335.GQ26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:36066 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbaBJMLj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2014 07:11:39 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so9417040qae.13
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2014 04:11:36 -0800 (PST)
In-Reply-To: <20140210103335.GQ26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Feb 10, 2014 at 6:33 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 10, 2014 at 11:31:40AM +0800, Dong Aisheng wrote:
>> On Sun, Feb 9, 2014 at 11:14 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Okay, I have this working now - there was a hardware problem.  However,
>> > it's obvious that this has never been tested with lockdep enabled beacuse
>> > of the following:
>> >
>> >         disable_irq(host->irq);
>> >         spin_lock(&host->lock);
>> >         host->mrq = &mrq;
>> >
>> >         sdhci_send_command(host, mrq.cmd);
>> >
>> >         spin_unlock(&host->lock);
>> >         enable_irq(host->irq);
>> >
>> > You can't "work around" stuff like this.  Use spin_lock_irq()..
>> > spin_unlock_irq().  You can't just disable the interrupt line and
>> > expect lockdep to know that it's safe.
>> >
>>
>> Yes, i missed this.
>> Such kind of code was originally referenced from sdhci_execute_tuning.
>> It was formerly fixed in commit 2b35bd83.
>> But i did miss sdhci-esdhci-imx also has such issue.
>> Thanks for the reminder.
>>
>> You can try the following fix and I will send out a patch for it later.
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index b841bb7..0372baf 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -720,6 +720,7 @@ static int esdhc_send_tuning_cmd(struct sdhci_host
>> *host, u32 opcode)
>>         struct mmc_data data = {0};
>>         struct scatterlist sg;
>>         char tuning_pattern[ESDHC_TUNING_BLOCK_PATTERN_LEN];
>> +       unsigned long flags;
>>
>>         cmd.opcode = opcode;
>>         cmd.arg = 0;
>> @@ -742,14 +743,12 @@ static int esdhc_send_tuning_cmd(struct
>> sdhci_host *host, u32 opcode)
>>         mrq.done = esdhc_request_done;
>>         init_completion(&(mrq.completion));
>>
>> -       disable_irq(host->irq);
>> -       spin_lock(&host->lock);
>> +       spin_lock_irqsave(&host->lock, flags);
>>         host->mrq = &mrq;
>>
>>         sdhci_send_command(host, mrq.cmd);
>>
>> -       spin_unlock(&host->lock);
>> -       enable_irq(host->irq);
>> +       spin_unlock_irqrestore(&host->lock, flags);
>>
>>         wait_for_completion(&mrq.completion);
>
> You don't need to use irqsave/irqrestore here - IRQs must be enabled here
> otherwise wait_for_completion() will scream - scheduling with interrupts
> disabled is not allowed.
>

Right.
Thanks for the suggestion.

Regards
Dong Aisheng

> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
