From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 08/11] mmc: pwrseq_simple: Add support for a delay
Date: Wed, 21 Jan 2015 15:15:09 +0100
Message-ID: <CAPDyKFoYj3xBoYsn87mxjoqDDnCtopAugX5JbzYritxWn-7XaA@mail.gmail.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
	<1421338359-27467-9-git-send-email-tomeu.vizoso@collabora.com>
	<54B7F9FB.7030100@wwwdotorg.org>
	<CAPDyKFoO6evBoAbEE30XiZg51KsM-sD4viFMvqaDwGoHeVL-6w@mail.gmail.com>
	<54BFAF7E.1030703@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:61629 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbAUOPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 09:15:10 -0500
Received: by mail-qa0-f47.google.com with SMTP id n8so33120207qaq.6
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2015 06:15:09 -0800 (PST)
In-Reply-To: <54BFAF7E.1030703@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dylan Reid <dgreid@chromium.org>, Simon Glass <sjg@chromium.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 21 January 2015 at 14:54, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 01/21/2015 11:44 AM, Ulf Hansson wrote:
>> On 15 January 2015 at 18:33, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>>>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>>
>>> Ah, having read the explanation in the next patch, I think ...
>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>>>> b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>>>
>>>
>>>> +- delay : delay to wait after driving the reset gpio active [ms].
>>>
>>>
>>> ... delay is the wrong name. reset-pulse-width or reset-pulse-length would
>>> be better. delay sounds like a delay after resetting the device before it
>>> can be accessed.
>>
>> I agree with Stephen's proposal.
>
> Cool.
>
>> This patch needs to be rebased and retested on latest version the
>> mmc-pwrseq patches.
>
> Sure.
>
>> Moreover, if you think the patchset which $subject
>> patch is a part of is material for 3.20, I will need to share an
>> immutable branch with the mmc-pwrseq patches for ARM SOC to pull in,
>> tell me if you need that.
>
> I don't think this will make 3.20 as I have other series with higher
> priority and there's quite some work left to do on this one.

If that's the case, I might as well consider this patch separately and
take it through my mmc tree. Of course, that means you anyway need to
rebase/test it.

Kind regards
Uffe
