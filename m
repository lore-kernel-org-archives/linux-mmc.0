From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Thu, 19 Mar 2015 18:21:31 +0200
Message-ID: <550AF78B.6020800@linaro.org>
References: <1426769720-18657-1-git-send-email-georgi.djakov@linaro.org> <CAJAp7Oj9XMHcbsMGfTCUWoi5tGi=eR2AxG_0Bkn4tzAiks89xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:35879 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbCSQVD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2015 12:21:03 -0400
Received: by wetk59 with SMTP id k59so61573975wet.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2015 09:21:02 -0700 (PDT)
In-Reply-To: <CAJAp7Oj9XMHcbsMGfTCUWoi5tGi=eR2AxG_0Bkn4tzAiks89xg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn@kryo.se>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

Hi Bjorn,
Thanks for taking a look.

On 03/19/2015 05:36 PM, Bjorn Andersson wrote:
> On Thu, Mar 19, 2015 at 5:55 AM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> [..]
> 
>> @@ -516,6 +527,22 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>                 host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
>>                                SDHCI_VENDOR_VER_SHIFT));
>>
>> +       core_version = readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION);
>> +       core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
>> +                     CORE_VERSION_MAJOR_SHIFT;
>> +       core_minor = core_version & CORE_VERSION_MINOR_MASK;
>> +       dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
>> +               core_version, core_major, core_minor);
>> +
>> +       /*
>> +        * Support for 3v and 8bit bus-width is not advertised by some
>> +        * controller versions and must be explicitly enabled.
>> +        */
>> +       if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12)
>> +               writel_relaxed(readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES)
>> +                              | CORE_3_0V_SUPPORT | CORE_8_BIT_SUPPORT,
>> +                              host->ioaddr + CORE_VENDOR_SPEC_CAPABILITIES0);
> 
> Please split this into read, modify, write statements and put braces around it.

Ok, i will.

> 
>> +
> 
> Does the 8916 board you have work without bumping the
> regulator_set_load() (previously regulator_set_optimum_mode())? None
> of my 8974 boards work reliably without it.

My 8916 board seems to be working fine with this, at least when doing basic tests
like mounting filesystems and file transfers. I'm not calling any regulator_set_load()
functions. Is your board a dragonboard or something else? If you are doing any
specific tests maybe i can try the same on my board?

Thanks,
Georgi
