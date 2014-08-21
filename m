From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Thu, 21 Aug 2014 18:08:46 +0800
Message-ID: <CAGsJ_4yC+7G26pPGCMSmfKSCbw+k7VxhBMmxn3BNtqF-A08pqw@mail.gmail.com>
References: <1408453153-8125-1-git-send-email-21cnbao@gmail.com> <lt2b4j$tk3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44429 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaHUKJH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Aug 2014 06:09:07 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so13883125pab.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2014 03:09:06 -0700 (PDT)
In-Reply-To: <lt2b4j$tk3$1@ger.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: linux-mmc@vger.kernel.org, Minda Chen <Minda.Chen@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-08-20 22:25 GMT+08:00 Romain Izard <romain.izard.pro@gmail.com>:
> ["Followup-To:" header set to gmane.linux.kernel.mmc.]
> On 2014-08-19, Barry Song <21cnbao@gmail.com> wrote:
>> From: Minda Chen <Minda.Chen@csr.com>
>>
>> 8bit-width enable bit of CSR MMC hosts is 3, while stardard hosts use
>> bit 5. this patch fixes the functionality of 8bit transfer in CSR mmc
>> controllers and improve performance for mmc0 a lot.
>>
>> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v2: check for host->version >= SDHCI_SPEC_300
>>
>
> Hi Barry,
>
> Did you check the runtime behaviour of the device after this change ?
>
> From the SiRFprimaII/SiRFatlasVI data sheets, it appears that the
> implementation of the SDHCI controller is a modified version of the one
> described in the 1.0 specification, and not a normal 3.0 controller.
> This explains why the independent development of the 8-bit wide transfer
> bus does not use the same bit as the standard one.
>
> As a result, the description of the SPEC_VER field in the
> SD_SLOT_INT_STATUS register indicates a read-only value of 0, which
> corresponds to SDHCI_SPEC_100 in the "sdhci.h" header. On a real
> SiRFatlasVI chip, the value is 0 as well.
>
> I believe the correct change would be to remove the control on the
> version >= SDHCI_SPEC_300 in both 4-bit and 8-bit cases, instead of
> adding it in both cases. There are no supported SiRF SoCs where the 8-bit
> bus is not supported at the controller level.
>
> In my opinion, this should look like this:
>
> +static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
> +{
> +       u8 ctrl;
> +
> +       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +       /* The 8-bit bus width configuration bit is not standard */
> +       ctrl &= ~(SDHCI_CTRL_4BITBUS | SDHCI_SIRF_8BITBUS);
> +       if (width == MMC_BUS_WIDTH_8) {
> +               ctrl |= SDHCI_SIRF_8BITBUS;
> +       } else if (width == MMC_BUS_WIDTH_4)
> +               ctrl |= SDHCI_CTRL_4BITBUS;
> +       }
> +       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +

hi Romain,
thanks very much! Minda will double-check the HW behaviour and confirm
what you said.

>
> You can use it verbatim with my signoff if you want.
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>
>
> But you should try it on your board, as I do not have a setup to test
> the mainline kernel on SiRFatlasVI available.
>
> Best regards,
> --
> Romain Izard
>
-barry
