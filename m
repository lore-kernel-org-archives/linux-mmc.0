From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Tue, 29 Mar 2016 20:24:26 +0200
Message-ID: <CA+7w51iYHMnup2ukrsmr9Hb6iGh+J_GMfz4d8bzGMjVuWeSX5w@mail.gmail.com>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
	<CA+7w51gXWgfU0NzfKSkRtimgOH7v5G3TMTb8WNGg6GXg-xTf5w@mail.gmail.com>
	<CAOMZO5BXRhc4hV52hnBDRL1nr1SnnTumf_8S2cHOGovVJF+yBA@mail.gmail.com>
	<CAPDyKFq74ppimCo0AGgqdtT=C-41y6LKZHELSpJXvDaSdTT=1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:32817 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbcC2SY2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 14:24:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id r72so68703402wmg.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 11:24:27 -0700 (PDT)
In-Reply-To: <CAPDyKFq74ppimCo0AGgqdtT=C-41y6LKZHELSpJXvDaSdTT=1A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>

Dear Uffe,

The problem seems to be appearing only with the rtl8723bs
 SDIO WIFI chip: [2] That one has an out-of-tree driver at [1].
As far as I can see in the kernel log, the kernel module loads the firmware to
the WIFI chip, after the module is loaded, and that happens
much later than the SD detection. SD Detection is at around 3 sec,
RTL8723BS init around 6 sec into boot (this is from a working kernel):

<...>
[    3.045290] mmc0: new HS200 MMC card at address 0001
<...>
[    3.123503] mmc1: new high speed SDIO card at address 0001
[    3.307623] mmc2: new high speed SDXC card at address 0001
<...>
[    6.120581] RTL8723BS: module init start
[    6.120590] RTL8723BS: rtl8723bs v4.3.5.5_12290.20140916_BTCOEX20140507-4E40
[    6.120593] RTL8723BS: rtl8723bs BT-Coex version = BTCOEX20140507-4E40
<...>
[    6.278909] RTL8723BS: rtw_ndev_init(wlan0)
[    6.279546] RTL8723BS: module init ret =0
<...>
[    7.035019] rtl8723bs: accquire FW from file:rtlwifi/rtl8723bs_nic.bin
<...>
[   10.748801] RTL8723BS: rtw_set_802_11_connect(wlan0)  fw_state = 0x00000008
<...>

Does it help if I create a log with MMC_DEBUG, so that we can see what
goes wrong?
Can it be a timing issue, that this chip responds too slow?

Thank you for your work.

Best regards,

Laszlo Fiat

[1]
https://github.com/hadess/rtl8723bs
[2]
https://bugzilla.kernel.org/show_bug.cgi?id=112571#c7

On Tue, Mar 29, 2016 at 12:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> +Russell, Mike
>
> On 24 March 2016 at 18:50, Fabio Estevam <festevam@gmail.com> wrote:
>> On Thu, Mar 24, 2016 at 2:45 PM, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>>> Hello,
>>>
>>> The original issue I reported on 17 Feb is that the SDIO WIFI card is
>>> not detected with 4.5RC and now mainline 4.5.0 kernel on baytrail
>>> tablets.
>>> BzukTuk commented on the bug report, that he has bisected the problem,
>>> and found that reverting  patch
>>> 520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
>>> Optimize boot time by detecting cards simultaneously")  solves the problem.
>>> I tested this, by compiling a 4.5.0 kernel with that patch reverted,
>>> and the SDIO WiFi works that way.
>>
>> Adding Ulf on Cc.
>
> From earlier discussions [1], it seems like Russell pointed out a mmc
> pwrseq related bug, but there seems to be yet another issue here.
>
> The bisected bad commit 520bd7a8b415 ("mmc: core: Optimize boot time
> by detecting cards simultaneously"), affects the timing and then maybe
> also the order of how cards (mmc, sd, sdio) may be detected.
>
> More precisely SD/(e)MMC cards may get different block ids (mmcblk[n])
> than they had before. According the information from the logs in
> bugzilla [2], a qualified guess is that the firmware to the SDIO WLAN
> chip is loaded from an hardcoded path. Since that path gets changed,
> the firmware can't be found and loaded, right?
>
> So, just to be clear, there has *never* been any deterministic way to
> always get the same mmc block id for a card. If hardcoded paths have
> worked, it's because of luck! Let me elaborate a bit on that.
>
> Earlier and with commit 520bd7a8b415, the probe order (a successful
> probe) of the mmc host device and whether removable cards are present
> or not, affects the mmc block id. The change that commit 520bd7a8b415
> introduces is that card detection can now happen simultaneously, thus
> it adds another parameter that affects the mmc block id.
>
> Unless I am mistaken, the hard coded paths should be fixed to use
> UUID/PARTUUID in favour of reverting 520bd7a8b415.
>
> Kind regards
> Uffe
>
> [1]
> http://comments.gmane.org/gmane.linux.kernel.mmc/36045
>
> [2]
> https://bugzilla.kernel.org/show_bug.cgi?id=112571
