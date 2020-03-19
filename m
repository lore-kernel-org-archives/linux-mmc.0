Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C5C4332E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B367B2070A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSM3B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:29:01 -0400
Received: from foss.arm.com ([217.140.110.172]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCSM3B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Mar 2020 08:29:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E98E1FB;
        Thu, 19 Mar 2020 05:29:00 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 676733F305;
        Thu, 19 Mar 2020 05:28:59 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_mmc=5fselect=5fhs400es_failed=2c_error_-?=
 =?UTF-8?B?MTEw44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIu?=
 =?UTF-8?B?a2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?Q?Milan_P=2e_Stani=c4=87?= <mps@arvanta.net>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20200301220242.GA8276@arya.arvanta.net>
 <20200318214917.GA9112@arya.arvanta.net>
 <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <158bd6f5-2430-19bd-28ef-e18d67becaf3@arm.com>
Date:   Thu, 19 Mar 2020 12:28:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

On 2020-03-19 3:11 am, Shawn Lin wrote:
> Hi Milan
> 
> [+linux-rockchip to see if someone has a Samsung chromebook one plus
> and could confirm if it works]

FWIW I've also tried suspend on my NanoPC-T4 and seen that the eMMC 
(also HS400-ES) fails to come back properly on resume (thus resume never 
completes due to the missing root filesystem). IIRC it might even have 
been reproducible with suspend-to-idle, but I'd have to double-check that.

Robin.

> On 2020/3/19 5:49, Milan P. Stanić wrote:
>> Hello,
>>
>> Sorry to annoy again, but could you tell me if I sent this bug report
>> to right mail address or I should send it somewhere else.
>>
>> Also, did I sent bug report correctly or I did some mistakes which
>> caused it to be ignored.
>>
>> -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stanić wrote:
>>> Hello,
>>>
>>> I'm not native English speaker and I'm self taught in English so sorry
>>> if do not write or express correctly. And sorry if I posted bug report
>>> to wrong address.
>>>
>>> I'm running linux 5.6.0-rc3 without any patches on Samsung chromebook
>>> one plus, Arm64 rockchip rk3399 based model name:
>>> Machine model: Google Kevin
>>>
>>> I build kernels from upstream git.kernel.org for this machine for some
>>> time (iirc, from 5.2.1 and up) but I'm getting error messages in kernel
>>> after machine resumes from suspend-to-ram.
> 
> It sounds to me suspend-to-ram never works for this machine, at least
> since 5.2.1. Am I right?
> 
>>>
>>> excerpt from dmesg output:
>>> -----------------------------------------------------------------------
>>> Restarting tasks ... done.
>>> PM: suspend exit
>>> mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, 
>>> actual 400000HZ div = 0)
>>> mmc1: mmc_select_hs400es failed, error -110
>>> mmc1: error -110 doing runtime resume
>>> mmc1: Got data interrupt 0x00000002 even though no data operation was 
>>> in progress.
>>> mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
>>> mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
>>> mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
>>> mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
>>> mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
>>> mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
>>> mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
>>> mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
>>> mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
>>> mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
>>> mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
>>> mmc1: sdhci: Host ctl2: 0x00000000
>>> mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
>>> -----------------------------------------------------------------------
>>>
>>> I invoke suspend-to-ram by `echo mem > /sys/power/state` from ACPI power
>>> and LID button handlers.
>>>
>>> This only happens when I boot and use internal emmc card and never when
>>> boot and use external mmc card.
>>>
>>> If suspend-to-ram is not invoked (machine is always in normal state)
>>> this problem never happen (or I missed it somehow).
>>>
>>> I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf) which
>>> use to build kernel, output of the `awk -f scripts/ver_linux` as file
>>> ver_linux.txt and  output of dmesg as file mmc-err.txt (from which I
>>> deleted wifi connection logs).
>>>
>>> Sorry if I did something bad or wrong with this bug report, I don't have
>>> much experience with bug reporting, especially for kernel.
>>>
>>> I'm ready to send you more data, and investigate this more, apply
>>> patches and rebuild kernel or whatever you ask me (of course if my
>>> understanding and knowledge is enough for this job).
>>>
>>> Thank in advance
>>>
>>> -- 
>>> Kind regards
>>>
>> [...]
>>
>>
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
