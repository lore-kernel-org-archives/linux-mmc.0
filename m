From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: eMMC 4.51
Date: Tue, 8 Oct 2013 21:33:49 -0700
Message-ID: <CACUGKYP1TXMe5bqAb5Ro5N3ZDQU-QZMiJnOrHuQArxf_am-k2w@mail.gmail.com>
References: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
	<20131009034944.GA8861@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:53604 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3JIEdu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 00:33:50 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so308552lbd.30
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2013 21:33:49 -0700 (PDT)
In-Reply-To: <20131009034944.GA8861@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dong Aisheng <b29396@freescale.com>

Thanks for the info.

Regards,

john

On Tue, Oct 8, 2013 at 8:49 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Oct 08, 2013 at 07:00:58PM -0700, John Tobias wrote:
>> Hello,
>>
>> I am using git://gitorious.org/thierryreding/linux-next.git to boot my
>> custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
>> I/F and wifi module (Marvel SD8797). The latest update of
>> sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
>> it for my device.
>
> The latest update on sdhci-esdhc-imx.c only enables the support of UHS SD card in
> SDR104 mode.  Neither DDR50 nor eMMC is supported so far.
>
> Shawn
>
