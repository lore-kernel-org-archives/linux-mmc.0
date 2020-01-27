Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CEC33CB7
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E241E20716
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgA0L67 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:58:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:39736 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgA0L67 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jan 2020 06:58:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="428959563"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2020 03:58:22 -0800
Subject: Re: Black screen while resuming a SDXC (UHS) card (_mmc_sd_resume)
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tim Schumacher <tim@timakro.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        pher1989@hotmail.com, Hans de Goede <hdegoede@redhat.com>
References: <20190905200138.GA19037@impa.localdomain>
 <CAPDyKFqo-LecRE5R4T+vrGgNs83WFmQr84oaieEUTCjLFOLXoA@mail.gmail.com>
 <20200123104047.GA1254@impa>
 <CAPDyKFqOC8OTZZ+emKNr44yBoFnkRjW6Wd0Osgw-k4d+mJK5zw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <15677b8f-feff-0375-f165-3a1987463040@intel.com>
Date:   Mon, 27 Jan 2020 13:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqOC8OTZZ+emKNr44yBoFnkRjW6Wd0Osgw-k4d+mJK5zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/01/20 1:37 pm, Ulf Hansson wrote:
> + Adrian

Is this the same as:

	https://lore.kernel.org/linux-mmc/20200108093903.57620-2-hdegoede@redhat.com/

> 
> On Thu, 23 Jan 2020 at 11:40, Tim Schumacher <tim@timakro.de> wrote:
>>
>> On 2019-09-06, Ulf Hansson wrote:
>>> On Thu, 5 Sep 2019 at 22:01, Tim Schumacher <tim@timakro.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm sending this old bug by mail since a lot of developers don't use
>>>> bugzilla.
>>>>
>>>> Original bug report on bugzilla by Pedro Rodrigues from 2019-01-30:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=202459
>>>>
>>>>> This bug can be found on a Lenovo Miix 320-10ICR
>>>>>
>>>>> When using a SDXC (UHS) card, the screen becomes black if
>>>>> _mmc_sd_resume() is called. After some investigation, I found that an
>>>>> UHS card uses 1.8 V for signalling while a normal SD card uses 3.3 V. By
>>>>> forcing the SDXC to use 3.3 V the black screen does not appear. It seems
>>>>> that during a _mmc_sd_resume function call, while claiming the host, an
>>>>> I2C resume function is called based on an existing supplier link between
>>>>> the I2C bus and the card device.  The problem is that if the signalling
>>>>> voltage is configured to 1.8 V, during the I2C resume call, the screen
>>>>> turns black.  I was able to fix this issue by setting the initial signal
>>>>> voltage (3.3 V) before suspending the card, so that when the card is
>>>>> resumed, the voltage is in the original state. To do this I added a
>>>>> function call to mmc_set_initial_signal_voltage() during mmc_power_off
>>>>> routine (drivers/mmc/core/core.c).  As I’m not an expert on Linux,  I’m
>>>>> posting the issue and possible solution so that it could be implemented
>>>>> on a future release.
>>>>>
>>>>> Please, share your thoughts :)
>>>>
>>>> I can't provide further insight but I'm interested if this is possibly
>>>> the cause for the general issues people are having with the SD card
>>>> reader on Lenovo Miix 320 devices.
>>>>
>>>> Those issues described in posts like
>>>>
>>>> https://vincent-ventures.com/2018/12/arch-linux-on-lenovo-ideapad-miix-320/
>>>> https://esc.sh/blog/linux-on-lenovo-miix-320/
>>>>
>>>> are (1) black screen when booting with an SD card installed and (2) when
>>>> inserting an SD card after booting it shows up but upon trying to access
>>>> it the screen turns black until the card is removed again.
>>>>
>>>> I can confirm (1) on my Lenovo Miix 320-10ICR with kernel version
>>>> 5.2.11. I can also confirm that only SDXC cards are affected, SD and
>>>> SDHC cards work as expected.
>>>
>>> For the mmc community to help, you need to provide some kernel logs,
>>> output from lspci, figure out what mmc host driver that is being used,
>>> etc - in general collect more data. Then re-post the data to
>>> linux-mmc, me and a potential mmc host driver maintainer (if there is
>>> one). Yes, we can look into bugzilla as well, but first we need some
>>> more overall info in an email.
>>>
>>> Most likely, if there is any response, you will be asked to test
>>> patches. So you need to be able build and boot a new kernel, but I
>>> guess you already know that part.
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> Hi, I'm coming back to this issue now. The issue is still present in
>> kernel version 5.4.8.
>>
>> Kernel logs from boot with SD card and black screen: https://termbin.com/outp
>> Kernel logs from boot without SD card: https://termbin.com/dc2y
>>
>> I couldn't find anything conspicuous in there, the card is working as
>> expected. Only issue is the black screen (I'm doing these tests via SSH).
>>
>> lspci output: https://termbin.com/x452
>>
>> How do I figure out which mmc host driver is in use? I assume I'm
>> looking for one of these https://github.com/torvalds/linux/tree/master/drivers/mmc/host
>> I couldn't find anything like it in the kernel logs or from lsmod.
>>
>> Please read the original bug report by Pedro Rodrigues quoted above.
>> He got to the technical core of the problem already and proposed a fix
>> I assume could be understood, sanity checked and implemented by a mmc
>> maintainer.
> 
> I have read the reports and browsed the data you provided. It seems
> like this is an sdhci-acpi mmc/sd controller, Adrian Hunter (Intel
> maintains this variant). There is one eMMC, which seems to work fine
> and then the SD-card that you have inserted. The SD card looks like it
> gets detected properly.
> 
> I don't see anything in the logs that stands out. However, I would try
> a couple of different SD-cards, just to see what happens (if you have
> more then one at hand). From that and going forward, I think I will
> need to defer to Adrian's help. Perhaps we can put together some debug
> patch for you to test, or so.
> 
> I will keep monitoring the discussion and fold in if there is anything
> more I can help with.
> 
> Kind regards
> Uffe
> 

