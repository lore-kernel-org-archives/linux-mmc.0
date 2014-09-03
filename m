From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: sdhci-esdhc-imx : cannot read eMMC
Date: Wed, 3 Sep 2014 16:15:41 +0800
Message-ID: <CAA+hA=QQ=AYnKts0cq0VpWkWUyt-r1v-LxCk1pQiyo=CFSCurA@mail.gmail.com>
References: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
	<CAL8zT=gpiV9OMToH80Qr5B7HUUbVDp0m_WK9PaCvuaMGwrBSJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:57130 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbaICIPm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 04:15:42 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so7482298qaj.21
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 01:15:42 -0700 (PDT)
In-Reply-To: <CAL8zT=gpiV9OMToH80Qr5B7HUUbVDp0m_WK9PaCvuaMGwrBSJA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi JM,

On Tue, Sep 2, 2014 at 11:10 PM, Jean-Michel Hautbois
<jhautbois@gmail.com> wrote:
> 2014-09-02 11:20 GMT+02:00 Jean-Michel Hautbois
> <jean-michel.hautbois@vodalys.com>:
>> Hi there,
>>
>> I start a new thread, as I have done lots of test and this will be clearer.
>> I have problems reading and writing eMMC on my i.MX6 board with 3.17-rc3.
>> Sometimes I don't have read errors explicitly in dmesg, but fdisk has
>> no effects.
>> I activated MMC debug in my config file, and here is an extract of
>> mmc0 register dump and all mmc1 part.
>> On Freescale kernel, I confirm it works well with the same board and
>> sample, I can write a partition on mmc1.
>

My iMX6Q SabreSD board seems ok.
What board did you use?
What reading/writing problems did you meet?
I did not see errors in your log.
Can you paste the error log?

> <snip>
>
>> [    3.099853] sdhci [sdhci_add_host()]: mmc1: Auto-CMD23 available
>> [ 3.100143] sdhci-esdhc-imx 219c000.usdhc: No vqmmc regulator found
>
> I have set my vqmmc-supply in my DT, and it works well now...
> I don't really know why specifying vqmmc-supply is better, but I can
> assure it is : I can mount the partition created on the eMMC.
> The only remaining errors are on boot partitions reading.
> Maybe should we have a parameter in DT in order to tell if we want to
> get thse partitions or not, instead of the return value of
> mmc_boot_partition_access() which is always 1 (if I don't miss
> something) ?
>

Currently I also can't see why specifying  vqmmc-supply is better.
You can measure if the voltage is different after using vqmmc-supply.

If the error you see is CRC errors(-84), usually you may want to double check
the pad setting,  board layout, which could affect the signal quality,
or capture the waveform of DATA signal and ask HW expert to help analyze
whether it's good enough.

Regards
Dong Aisheng

> Thanks,
> JM
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
