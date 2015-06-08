From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND v7 2/2] mmc: host: sdhci: Add support to disable
 SDR104/SDR50/DDR50 based on capability register 0.
Date: Mon, 8 Jun 2015 10:37:09 +0200
Message-ID: <CAPDyKFqk1_B-wH0Z2QwfxftJy8LLH6Ey9cg56eFxAj7zmeFmOg@mail.gmail.com>
References: <1432197817-22110-1-git-send-email-stripathi@apm.com>
	<1432197817-22110-3-git-send-email-stripathi@apm.com>
	<CAPDyKFpxkNF9C8AOJ6+18CEcpZTKycPR0i5OuwPRr1Zc+VPJ5Q@mail.gmail.com>
	<CAOHikRASDmy7PwFjqmX7JAjW52DYR+d3RkE3yd_45NN5sHK7Pg@mail.gmail.com>
	<CAOHikRBB9Uyh4Z34_pFTdmA0A-vnV09zTi8iYEU+01XvmzSr_A@mail.gmail.com>
	<20150605145323.GA15110@shlinux1.ap.freescale.net>
	<CAOHikRCXuJryKgo7pjehi-SyosE1Rr2zFjc+9yWJwke_ib=Azw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36170 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbFHIhK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 04:37:10 -0400
Received: by qkx62 with SMTP id 62so74208780qkx.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2015 01:37:09 -0700 (PDT)
In-Reply-To: <CAOHikRCXuJryKgo7pjehi-SyosE1Rr2zFjc+9yWJwke_ib=Azw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>, Dong Aisheng <b29396@freescale.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

[...]

>> >
>> >    Can you test this patch  on imx SoC ?
>> >
>>
>> (Your email have some format issue.)
>
> Yeah missed to sent in plain text mode.
>
>>
>> I have tested this patch and it does not break imx SoC.
>> You can add my tag.
>> Tested-by: Dong Aisheng <aisheng.dong@freescale.com>
>
> Thanks Dong !!
>
>>
>> However, it looks to me SDHCI_CAN_VDD_180 is only indicating the host VDD
>> capabiliies, not IO voltage capability.

I think Dong is correct. I don't think SDHCI_CAN_VDD_180 is not
related to UHS modes at all.

At least the name of the field (SDHCI_CAN_VDD_180) indicates it's
about VDD/VCC, the core power and not the IO voltage.

> Are you sure on this ?? If SDHCI host VDD is  1.8V then the cards are
> also capable to operate at 1.8V ? Didn't understand what you mean by
> IO voltage capability
>
>
>> SD3.0 cards require 1.8v IO voltage support.
>> So should this bit affect SD3.0 support?
>
> The preset value resgister says that  SDR modes requires 1.8V and we
> disable the modes based on capability or quirk.

It requires 1.8V *IO voltage*, not VDD/VCC.

[...]

Kind regards
Uffe
