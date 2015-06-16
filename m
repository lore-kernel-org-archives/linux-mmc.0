From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc-imx: Use pinctrl PM helpers
Date: Tue, 16 Jun 2015 11:05:46 +0200
Message-ID: <f668b0c77c6e297bd4b89cbb74dcb15e@agner.ch>
References: <1434101473-4109-1-git-send-email-mirza.krak@hostmobility.com>
 <CAPDyKFoqAV4fW=V56vvPh5-9=w+0Di8VzTBNRmpF_2ETp_pHNA@mail.gmail.com>
 <CAJ=nTsvT-0UZTRhGrRvqG0Gp5yhPVhUWzMtupXrXVxnwwhfS=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:46421 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933069AbbFPJIF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 05:08:05 -0400
In-Reply-To: <CAJ=nTsvT-0UZTRhGrRvqG0Gp5yhPVhUWzMtupXrXVxnwwhfS=Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mirza Krak <mirza.krak@hostmobility.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 2015-06-16 08:52, Mirza Krak wrote:
> 2015-06-15 11:55 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 12 June 2015 at 11:31, Mirza Krak <mirza.krak@hostmobility.com> wrote:
>>> From: Mirza Krak <mirza.krak@hostmobility.com>
>>>
>>> Add support for current states of pinctrl, which are "default", "idle"
>>> and "sleep".
>>>
>>> The "default" pinctrl state is set by Drivers core before
>>> calling the driver's probe, hence we do not need a initial call to
>>> "default" state.
>>>
>>> Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
>>
>> Hi Mirza,
>>
>> This looks okay to me, but it seems like it needs a re-base towards my
>> mmc next branch.
>>
>> Kind regards
>> Uffe
> 
> Looked at the mmc next branch.
> 
> I see that the suspend/resume methods of sdhci-esdhci-imx have been
> removed and the generic sdhci_pltfm_suspend/resume are used. So I am
> unsure if it is OK to set the pinctl "sleep" state in
> sdhci_pltfm_suspend or is there a better location for this.

The pltfm_suspend/resume functions have been used since quite some time.
However, the Toradex branch carries a patch which introduces local
suspend/resume functions to work around a system PM vs. runtime PM
suspend issue.

My upstream patch for the same issue is in v3 and solves the issue by
introducing a generic runtime PM enabled pltfm_suspend/resume function:
https://lkml.org/lkml/2015/5/21/104

I'm not sure if that is going to be accepted, maybe Ulf can have a look
at it first?

> 
> I am thinking sdhci_suspend_host would be good location, but then the
> change will effect a lot more drivers. Maybe a good thing?

I guess most device trees don't have a specific idle/sleep state
specification, how does the pinctrl API act in this situation?

FWIW, the Vybrid SoC is not able to control pins during LPSTOP suspend,
hence configuring the sleep mode explicitly for system PM is not very
useful on that platform. However, for runtime PM it coud still be
valuable I guess.

--
Stefan
