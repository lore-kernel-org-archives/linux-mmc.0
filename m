Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7951C4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851FC20776
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCSDLh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:11:37 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:45350 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDLh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2020 23:11:37 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 596EB8EBA9;
        Thu, 19 Mar 2020 11:11:31 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P20067T140595444037376S1584587490013192_;
        Thu, 19 Mar 2020 11:11:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0078fd1245032f134969b4d597bf7f7b>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Cc:     shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_mmc=5fselect=5fhs400es_failed=2c_error_-?=
 =?UTF-8?B?MTEw44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIu?=
 =?UTF-8?B?a2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
To:     =?UTF-8?Q?Milan_P=2e_Stani=c4=87?= <mps@arvanta.net>
References: <20200301220242.GA8276@arya.arvanta.net>
 <20200318214917.GA9112@arya.arvanta.net>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com>
Date:   Thu, 19 Mar 2020 11:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200318214917.GA9112@arya.arvanta.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Milan

[+linux-rockchip to see if someone has a Samsung chromebook one plus
and could confirm if it works]

On 2020/3/19 5:49, Milan P. Stanić wrote:
> Hello,
> 
> Sorry to annoy again, but could you tell me if I sent this bug report
> to right mail address or I should send it somewhere else.
> 
> Also, did I sent bug report correctly or I did some mistakes which
> caused it to be ignored.
> 
> -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stanić wrote:
>> Hello,
>>
>> I'm not native English speaker and I'm self taught in English so sorry
>> if do not write or express correctly. And sorry if I posted bug report
>> to wrong address.
>>
>> I'm running linux 5.6.0-rc3 without any patches on Samsung chromebook
>> one plus, Arm64 rockchip rk3399 based model name:
>> Machine model: Google Kevin
>>
>> I build kernels from upstream git.kernel.org for this machine for some
>> time (iirc, from 5.2.1 and up) but I'm getting error messages in kernel
>> after machine resumes from suspend-to-ram.

It sounds to me suspend-to-ram never works for this machine, at least
since 5.2.1. Am I right?

>>
>> excerpt from dmesg output:
>> -----------------------------------------------------------------------
>> Restarting tasks ... done.
>> PM: suspend exit
>> mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
>> mmc1: mmc_select_hs400es failed, error -110
>> mmc1: error -110 doing runtime resume
>> mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
>> mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>> mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
>> mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
>> mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
>> mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
>> mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>> mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
>> mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
>> mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
>> mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
>> mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
>> mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
>> mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
>> mmc1: sdhci: Host ctl2: 0x00000000
>> mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
>> -----------------------------------------------------------------------
>>
>> I invoke suspend-to-ram by `echo mem > /sys/power/state` from ACPI power
>> and LID button handlers.
>>
>> This only happens when I boot and use internal emmc card and never when
>> boot and use external mmc card.
>>
>> If suspend-to-ram is not invoked (machine is always in normal state)
>> this problem never happen (or I missed it somehow).
>>
>> I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf) which
>> use to build kernel, output of the `awk -f scripts/ver_linux` as file
>> ver_linux.txt and  output of dmesg as file mmc-err.txt (from which I
>> deleted wifi connection logs).
>>
>> Sorry if I did something bad or wrong with this bug report, I don't have
>> much experience with bug reporting, especially for kernel.
>>
>> I'm ready to send you more data, and investigate this more, apply
>> patches and rebuild kernel or whatever you ask me (of course if my
>> understanding and knowledge is enough for this job).
>>
>> Thank in advance
>>
>> --
>> Kind regards
>>
> [...]
> 
> 


