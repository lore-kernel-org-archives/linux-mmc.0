From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc : sdhci_do_start_signal_voltage_switch
Date: Mon, 5 Oct 2015 12:56:27 +0200
Message-ID: <CAPDyKFp4BUcvew887_pFit8RsQRqmM1V2zEpZrxT0w9BsOhfMQ@mail.gmail.com>
References: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38458 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbJEK42 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 06:56:28 -0400
Received: by wiclk2 with SMTP id lk2so108703822wic.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 03:56:27 -0700 (PDT)
In-Reply-To: <CAHhAz+jUKPwVFQgkrdkX2gM1fFecZWJJofV49jE+Z3gYEpQimQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 24 September 2015 at 14:21, Muni Sekhar <munisekharrms@gmail.com> wr=
ote:
> Hi ,
>
> We planned to use the standard Linux MMC driver for our FPGA based SD
> Host controller hardware.
>
> I am having couple of doubts regarding SDIO voltage change
> (sdhci_do_start_signal_voltage_switch()), please clarify me on this.
>
> The MMC driver sets and clears bit 3 of the HOST_CONTROL_2 register,
> when an IO voltage change is required (1=3D1.8v, 0=3D3.3v).
>
> Our hardware detects a change in this bit value, and generates a new
> interrupt when a change is seen.  This interrupt will be controlled b=
y
> some new registers, outside of the standard Host Controller register
> set.
>
> The interrupt handling routine shall, when seeing this interrupt,
> program the desired SDIO IO voltage change.
>
> MMC driver expects the voltage change to complete within 5ms - there
> is a fixed 5ms wait in the MMC driver=E2=80=99s
> sdhci_do_start_signal_voltage_switch() function. But our hardware is
> nowhere near capable of conducting a voltage change in 5ms.  Instead
> it=E2=80=99s of the order of ~300ms.  Does it causes any issues later=
 during
> testing? If so what should be the best possible solution?

I guess this is related to a regulator ramp up time somehow.
I would advise you to model this IO voltage through a regulator and
thus you can take care of the ramp up time within the regulator
implementation. If that's not possible, we need a way to add a time
suitable for your case.

Kind regards
Uffe
