From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] mmc: core: Revert "skip card initialization if powerclass
 selection fails"
Date: Mon, 2 Jul 2012 19:14:25 +0530
Message-ID: <CAKLKtzfEZx764-OqC+bpaaiuJKConFOTxv0hVrWJd3obkJww1Q@mail.gmail.com>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com>
	<CAKLKtzcHnvoi66J4q=SEZmWhtHh3+V3_=4+B7u0XNukCckpm7g@mail.gmail.com>
	<1724838.XSl2kMpQ3Z@fb07-iapwap2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58423 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab2GBNo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 09:44:26 -0400
Received: by ghrr11 with SMTP id r11so4076657ghr.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jul 2012 06:44:25 -0700 (PDT)
In-Reply-To: <1724838.XSl2kMpQ3Z@fb07-iapwap2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, girish.shivananjappa@linaro.org, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 2 July 2012 16:47, Marc Dietrich <marvin24@gmx.de> wrote:
> Am Montag, 2. Juli 2012, 14:13:31 schrieb Saugata Das:
>> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
>> > This reverts commit 3d93576e(skip card initialization if
>> > power class selection fails).
>> > Problem has been reported when this is used with eMMC4.41
>> > card with Tegra Platform. Till the issue is root caused,
>> > bus width selection failure should not be treated as fatal.
>>
>> According to me, we need to find the root issue (which could be either
>> host not able to provide enough current or faulty eMMC). Do we know,
>> what could be the side effect of working on eMMC  with less power than
>> what it has requested in PWR_CL ?
>>
>> One known issue with the current power class selection is that we do
>> not check the current requirement for a selected power class. It
>> assumes that host is able to provide the maximum current needed at
>> highest speed (> 800mA). Is it already checked on Tegra ?
>
> Acording to the schematic, the emmc is "fused" with 150mA and 450mA. There are
> many supplies connected to it, so it is hard to tell what is the maximum, but
> certainly not 800 mA. Why do you think it should be such high? Powerclass "7"
> means 270 mA max and 160 mA RMS (dual voltage card). Btw, you may successfully
> google for the "schematic document" for this "paz00" board in question.
>

I was referring to maximum current as per 4.5 spec (power class 15). I
saw the logs which you sent earlier and the driver is trying to set
power class 3 (=> 180mA RMS / 280mA peak). May be, you can check the
regulators, if 450mA supply is enabled.


> Marc
>
