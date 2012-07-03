From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: Re: [PATCH] mmc: core: Revert "skip card initialization if
 powerclass selection fails"
Date: Tue, 3 Jul 2012 09:25:11 +0530
Message-ID: <CAGxe1ZFwECEqcV5aX7K2yhRLV_efGi2zWesGBvXwfS7BMrNxRw@mail.gmail.com>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com>
	<CAGxe1ZHZMMo7xzNQzoLZHULnAnZ=_J-QK3nP5dwrd=wgRQLE1w@mail.gmail.com>
	<CAGxe1ZHmm_UhkHmya63g_2YPrwZ+xwV1wdb5M5h44mxq82BvPg@mail.gmail.com>
	<4776161.gj4CVEvArs@fb07-iapwap2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33981 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab2GCDzM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 23:55:12 -0400
Received: by qadb17 with SMTP id b17so2330787qad.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jul 2012 20:55:11 -0700 (PDT)
In-Reply-To: <4776161.gj4CVEvArs@fb07-iapwap2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: Saugata Das <saugata.das@linaro.org>, Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 2 July 2012 16:50, Marc Dietrich <marvin24@gmx.de> wrote:
> Am Montag, 2. Juli 2012, 14:28:37 schrieb Girish K S:
>> On 2 July 2012 14:23, Girish K S <girish.shivananjappa@linaro.org> w=
rote:
>> > On 2 July 2012 14:13, Saugata Das <saugata.das@linaro.org> wrote:
>> >> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
>> >>> This reverts commit 3d93576e(skip card initialization if
>> >>> power class selection fails).
>> >>> Problem has been reported when this is used with eMMC4.41
>> >>> card with Tegra Platform. Till the issue is root caused,
>> >>> bus width selection failure should not be treated as fatal.
>> >>
>> >> According to me, we need to find the root issue (which could be e=
ither
>> >> host not able to provide enough current or faulty eMMC). Do we kn=
ow,
>> >> what could be the side effect of working on eMMC =A0with less pow=
er than
>> >> what it has requested in PWR_CL ?
>> >>
>> >> One known issue with the current power class selection is that we=
 do
>> >> not check the current requirement for a selected power class. It
>> >> assumes that host is able to provide the maximum current needed a=
t
>> >> highest speed (> 800mA). Is it already checked on Tegra ?
>> >
>> > and at the least bus width i.e 1 bit mode.
>>
>> The MMC card spec has 2 max current values (power class) one for 4 b=
it
>> mode and another for 8 bit mode at supported voltages. But the SDHCI
>> spec has one MaxCur register for supported voltages but doesnt menti=
on
>> for which bus width. Any input on this is very helpful to resolve th=
e
>> powerclass issue that is pending
>
> the higher nibble is for 8 bit and the lower one for 4 bit. The power=
 class is
> same for both bus width on this toshiba device.
This is true from device point of view. but my concern was with the
host controller register of SDHCI Spec MAXCURRn
where n is 1.8 / 3.3 /3.0. Each voltage supported is assigned 8 bits
(values ranging from 0-255). which means there is no split in nibbles
for 4-bit and 8-bit mode


>
> Marc
>
