From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [EXT] Re: [PATCH v2] mmc: sdhci: wait 5ms after set 1.8V signal enable
Date: Fri, 15 Dec 2017 08:05:40 +0100
Message-ID: <CAPDyKFqhsdC43RL1KWK6TtXRcbSkDAk-3iiwoCUB+jewkNuPtA@mail.gmail.com>
References: <1513208929-13578-1-git-send-email-zjwu@marvell.com>
 <CAPDyKFp=B2EBBOVky=x89Bcqw77XZyXcW1Hyn_LEHOkhtyAyFA@mail.gmail.com> <5A32CB3C.4060105@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37035 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbdLOHFm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 02:05:42 -0500
Received: by mail-it0-f53.google.com with SMTP id d137so16759826itc.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Dec 2017 23:05:41 -0800 (PST)
In-Reply-To: <5A32CB3C.4060105@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, xswang@marvell.com, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 14 December 2017 at 20:04, Zhoujie Wu <zjwu@marvell.com> wrote:
> Hi Ulf,
>
> On 12/14/2017 12:41 AM, Ulf Hansson wrote:
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>> On 14 December 2017 at 00:48, Zhoujie Wu <zjwu@marvell.com> wrote:
>>>
>>> According to SD spec 3.00 3.6.1 signal voltage switch
>>> procedure, host should wait 5ms after set 1.8V signal
>>> enable bit in Host Control 2 register and check if 1.8V
>>> is stable or not.
>>>
>> The core already deals with this. See mmc_set_uhs_voltage() and
>> mmc_host_set_uhs_voltage().
>>
>> We even have a retry mechanism in place.
>
> I checked these functions, they just make sure when do signal voltage
> switch, gate the clock to SD card 5ms and wait 1ms before check data lines.
> This patch is following below spec requirement when switching signal voltage
> to 1.8V, wait 5ms after set 1.8V signal Enable bit in Host control 2
> register.

Right, so this is an SDHCI controller requirement. Could you perhaps
clarify that in the changlog, then I  am happy.

> Current code will set 1.8V Signal Enable bit and check if this bit is
> cleared by host right after that,  the bit is not cleared and host report
> "1.8V regulator output did not became stable".
>
> You can find the steps at SD spec 3.0 3.6.1.
> (6) Set 1.8V Signal Enable in the Host Control 2 register.
> (7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
> (8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
>>
>>
>>> On some cards, found without the delay would see "1.8V
>>> regulator output did not became stable" err log.
>>
>> Seems like you need to fix the regulator instead.
>>
>> BTW, is this a regression? No?
>
> It is not regulator related, the regulator already output 1.8V and add delay
> after regulator set voltage didn't help.
> The only solution is to add 5ms after set 1.8V signal enable bit .
> Not a regression issue, we recently found it when enabling uhs on some
> platforms since they didn't enable it previously.

I see, thanks for clarifying.

Kind regards
Uffe
