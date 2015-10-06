From: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: mmc : sdhci_do_start_signal_voltage_switch
Date: Tue, 6 Oct 2015 12:02:06 +0530
Message-ID: <CAHhAz+i8923qvxi8pT3MLr2wHb8PgapbV9RCA_L-rWzxq4HcCA@mail.gmail.com>
References: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
	<CAPDyKFp4BUcvew887_pFit8RsQRqmM1V2zEpZrxT0w9BsOhfMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33920 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbJFGcI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 02:32:08 -0400
Received: by iow1 with SMTP id 1so174647432iow.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 23:32:06 -0700 (PDT)
In-Reply-To: <CAPDyKFp4BUcvew887_pFit8RsQRqmM1V2zEpZrxT0w9BsOhfMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Uffe,
Could you please explain about the way to add a time suitable for my ca=
se?


On Mon, Oct 5, 2015 at 4:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> On 24 September 2015 at 14:21, Muni Sekhar <munisekharrms@gmail.com> =
wrote:
>> Hi ,
>>
>> We planned to use the standard Linux MMC driver for our FPGA based S=
D
>> Host controller hardware.
>>
>> I am having couple of doubts regarding SDIO voltage change
>> (sdhci_do_start_signal_voltage_switch()), please clarify me on this.
>>
>> The MMC driver sets and clears bit 3 of the HOST_CONTROL_2 register,
>> when an IO voltage change is required (1=3D1.8v, 0=3D3.3v).
>>
>> Our hardware detects a change in this bit value, and generates a new
>> interrupt when a change is seen.  This interrupt will be controlled =
by
>> some new registers, outside of the standard Host Controller register
>> set.
>>
>> The interrupt handling routine shall, when seeing this interrupt,
>> program the desired SDIO IO voltage change.
>>
>> MMC driver expects the voltage change to complete within 5ms - there
>> is a fixed 5ms wait in the MMC driver=E2=80=99s
>> sdhci_do_start_signal_voltage_switch() function. But our hardware is
>> nowhere near capable of conducting a voltage change in 5ms.  Instead
>> it=E2=80=99s of the order of ~300ms.  Does it causes any issues late=
r during
>> testing? If so what should be the best possible solution?
>
> I guess this is related to a regulator ramp up time somehow.
> I would advise you to model this IO voltage through a regulator and
> thus you can take care of the ramp up time within the regulator
> implementation. If that's not possible, we need a way to add a time
> suitable for your case.
>
> Kind regards
> Uffe



--=20
Thanks,
Sekhar
