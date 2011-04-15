From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 15 Apr 2011 15:04:03 -0500
Message-ID: <BANLkTikoAWEMGOAHrxJT4jNknVFtyuhdqw@mail.gmail.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
	<1302863942-1774-2-git-send-email-arindam.nath@amd.com>
	<BANLkTimZGonC+D0czjiY4i7pFFW=upj_qw@mail.gmail.com>
	<6C03668EAF45B747AF947A1603D1B300EB443FB6@SAUSEXMBP01.amd.com>
	<BANLkTimEKQceSiuL=dX2yhMw+MLu7BzLvQ@mail.gmail.com>
	<BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:32782 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1DOUEH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 16:04:07 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3FK4Se0026231
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 16:04:28 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3FK0CcJ024546
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 16:04:28 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3408115wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 13:04:03 -0700 (PDT)
In-Reply-To: <BANLkTimfQo7wJ3_ecs64VSp7xKJrjYdJ3w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>, linux-mmc@vger.kernel.org

+linux-mmc

On Fri, Apr 15, 2011 at 3:03 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Fri, Apr 15, 2011 at 1:57 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> Hi Arindam,
>>
>> On Fri, Apr 15, 2011 at 12:34 PM, Nath, Arindam <Arindam.Nath@amd.com> wrote:
>>> Hi Andrei,
>>
>>>>
>>>> I've recently posted changes relating to CMD23 support in block layer.
>>>> Effectively, in order to support hosts with and without Auto-CMD23
>>>> (and with proper error handling) there is a new MMC_CAP_CMD23 for the
>>>> host, and a new field "mmc_command sbc" inside the mmc_request.
>>>>
>>>> I also have a patch enabling CMD23 use with an SDHCI host (< 3.00).
>>>>
>>>> Could you be so kind as to rebase this patch on top of that? You're
>>>> doing a lot of things here that you really shouldn't be (like
>>>> enforcing policy on what gets sent to cards, knowing what's connected
>>>> to the host, conflicting with reliable writes code if Auto-CMD23 was
>>>> enabled for MMCs, not supporting MMCs which always have
>>>> SET_BLOCK_COUNT).
>>>
>>> Our Host Controller is complaint to the Host Controller Spec v3.00, and since Auto CMD23 is a feature added to the HC, I thought it would be better to make this feature part of sdhci and not the core/block layer.
>>>
>>> But in case you want Auto CMD23 to be implemented in a different way, it would rather be great if you help me implement in your own way, and then probably based on community suggestions, we can keep either of the patch.
>>
>> Let me clarify:
>>
>> 1) Sending CMD23 on multiblock transfers is not a an SDHCI specific
>> feature. It's a feature of MMC cards and SD cards operating at UHS104
>> or greater.
>> 2) CMD23-bounded multi block writes are a generic problem already -
>> eMMC reliable writes, for example.
>> 3) CMD23 is not bound to any specific controller - so having generic
>> code to allow execution of CMD23 will speed up transfers (and enable
>> certain features) on any host.
>> 4) Auto-CMD is a specific SDHCI enhancement, meant to reduce overhead
>> of sending CMD23.
>> 5) Host controller has to be aware of CMD23 sending, because on an
>> error STOP has to be sent, and without error, no STOP has to be sent.
>>
>> You are in a unique position where you have functional SDHCI 3.0
>> hardware and are able to test Auto-CMD23. Please look at the patch set
>> I sent - it should be trivial to extend current SDHCI patch to use
>> Auto-CMD23 when possible instead of sending mmc_request->sbc.
>> Basically, I have a generic improvement that affects all host
>> controllers. Auto-CMD23 is an optimization of that for SDHCI 3.0.
>>
>> Your current patch to enable Auto-CMD23 is not useful as far as non-SD
>> cards are concerned and you push way to much policy and
>> non-host-related complexity into it.
>>
>> Thanks,
>> A
>>
>
> More clarification:
>
> The block layer patch may change slightly (whitelisting/blacklisting
> certain MMC devices for using CMD23 for multiblock transfers), but the
> changes to mmc_request and SDHCI are not. So feel free to rebase it
> without waiting for anything. If you need help, I will gladly help
> you, but keep in mind I don't have SDHCI 3.0 hardware around.
>
> Thanks,
> A
>
