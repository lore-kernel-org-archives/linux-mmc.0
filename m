From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Revert "skip card initialization if power
 class selection fails"
Date: Mon, 2 Jul 2012 14:28:37 +0530
Message-ID: <CAGxe1ZHmm_UhkHmya63g_2YPrwZ+xwV1wdb5M5h44mxq82BvPg@mail.gmail.com>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com>
	<CAKLKtzcHnvoi66J4q=SEZmWhtHh3+V3_=4+B7u0XNukCckpm7g@mail.gmail.com>
	<CAGxe1ZHZMMo7xzNQzoLZHULnAnZ=_J-QK3nP5dwrd=wgRQLE1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46979 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583Ab2GBI6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 04:58:38 -0400
Received: by qcro28 with SMTP id o28so2780115qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jul 2012 01:58:37 -0700 (PDT)
In-Reply-To: <CAGxe1ZHZMMo7xzNQzoLZHULnAnZ=_J-QK3nP5dwrd=wgRQLE1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, marvin24@gmx.de, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 2 July 2012 14:23, Girish K S <girish.shivananjappa@linaro.org> wrot=
e:
> On 2 July 2012 14:13, Saugata Das <saugata.das@linaro.org> wrote:
>> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
>>> This reverts commit 3d93576e(skip card initialization if
>>> power class selection fails).
>>> Problem has been reported when this is used with eMMC4.41
>>> card with Tegra Platform. Till the issue is root caused,
>>> bus width selection failure should not be treated as fatal.
>>>
>>
>> According to me, we need to find the root issue (which could be eith=
er
>> host not able to provide enough current or faulty eMMC). Do we know,
>> what could be the side effect of working on eMMC =A0with less power =
than
>> what it has requested in PWR_CL ?
>>
>> One known issue with the current power class selection is that we do
>> not check the current requirement for a selected power class. It
>> assumes that host is able to provide the maximum current needed at
>> highest speed (> 800mA). Is it already checked on Tegra ?
>>
> and at the least bus width i.e 1 bit mode.
>
The MMC card spec has 2 max current values (power class) one for 4 bit
mode and another for 8 bit mode at supported voltages. But the SDHCI
spec has one MaxCur register for supported voltages but doesnt mention
for which bus width. Any input on this is very helpful to resolve the
powerclass issue that is pending
>>> Reported-by: Marc Dietrich <marvin24@gmx.de>
>>> Signed-Off-by: Venkatraman S <svenkatr@ti.com>
>>> CC: Ulf Hansson <ulf.hansson@stericsson.com>
>>> CC: Subhash Jadavani <subhashj@codeaurora.org>
>>> CC: Saugata Das <saugata.das@linaro.org>
>>> ---
>>> =A0drivers/mmc/core/mmc.c | 18 +++++++++++-------
>>> =A01 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 258b203..4f4489a 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -717,10 +717,6 @@ static int mmc_select_powerclass(struct mmc_ca=
rd *card,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
card->ext_csd.generic_cmd6_time);
>>> =A0 =A0 =A0 =A0 }
>>>
>>> - =A0 =A0 =A0 if (err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class selection for=
 ext_csd_bus_width %d"
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" failed\n", mmc_hostn=
ame(card->host), bus_width);
>>> -
>>> =A0 =A0 =A0 =A0 return err;
>>> =A0}
>>>
>>> @@ -1104,7 +1100,9 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT=
_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_powerclass(card,=
 ext_csd_bits, ext_csd);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: power=
 class selection to bus width %d"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
" failed\n", mmc_hostname(card->host),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
1 << bus_width);
>>> =A0 =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0 /*
>>> @@ -1136,7 +1134,10 @@ static int mmc_init_card(struct mmc_host *ho=
st, u32 ocr,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_=
powerclass(card, ext_csd_bits[idx][0],
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto =
err;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_wa=
rning("%s: power class selection to "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d failed\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width);
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(=
card, EXT_CSD_CMD_SET_NORMAL,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0EXT_CSD_BUS_WIDTH,
>>> @@ -1164,7 +1165,10 @@ static int mmc_init_card(struct mmc_host *ho=
st, u32 ocr,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_=
powerclass(card, ext_csd_bits[idx][1],
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto =
err;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_wa=
rning("%s: power class selection to "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d ddr %d failed\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width, ddr);
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(=
card, EXT_CSD_CMD_SET_NORMAL,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0EXT_CSD_BUS_WIDTH,
>>> --
>>> 1.7.11.1.25.g0e18bef
>>>
