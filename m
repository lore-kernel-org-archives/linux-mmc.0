From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec violation
Date: Fri, 27 Sep 2013 11:56:26 +0200
Message-ID: <CAPDyKFoXmfzSG931MTUhg3B4KPL3aR_0Uw=N=iiRKBg94YHntw@mail.gmail.com>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1309162253320.17217@axis700.grange>
	<CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
	<Pine.LNX.4.64.1309171008190.20367@axis700.grange>
	<CAPDyKFpfe7mL4aLBo4S4tibpoL8DoiK3TiVzPvc4V-eG1Yrm_w@mail.gmail.com>
	<20130917110429.GR21013@sirena.org.uk>
	<CAPDyKFqMhE54bi-B+8TswObs=PTj31kxjPcDoDuyLoOQsKStFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:36339 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3I0J41 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 05:56:27 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so1823408veb.17
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 02:56:26 -0700 (PDT)
In-Reply-To: <CAPDyKFqMhE54bi-B+8TswObs=PTj31kxjPcDoDuyLoOQsKStFA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>

On 17 September 2013 14:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 September 2013 13:04, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Sep 17, 2013 at 11:29:21AM +0200, Ulf Hansson wrote:
>>
>>> If you want to change voltage level for eMMC, both VCC and VCCQ must
>>> be possible to power cycle, unless you have a hw-reset wire connected
>>> to the eMMC which is implemented by a host->ops callback. This
>>> complicates things for SD/SDIO as well, while trying to setup the
>>> conditions for when to set the PWR_CYCLE flag.
>>
>> Should the hardware resets not be being converted over to be represented
>> as GPIOs (or the reset controller API) to factor things out?
>
> In some cases the power is controlled from inside the mmc controller,
> thus writing to some of it's registers will affect the power to the
> card. In other cases I believe we should be able to consider them as
> GPIOs. I think this is the reason to why a specific mmc host->ops is
> being used, to cover all cases.
>
> Maybe converting them to the "reset controller API" would be suitable
> for all cases, not sure.
>
> Note that, as of today only some sdhci variants have implemented the
> hw-reset support.
>
> Kind regards
> Ulf Hansson

Hi Mark & Guennadi,

I appreciated you ideas and thoughts around this patchset.

To go forward, I suppose our discussion shall not prevent Chris from
merging this patchset? We shall be able to address your input as work
on top if this patchset, right?

Kind regards
Ulf Hansson
