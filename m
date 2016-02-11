From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Date: Thu, 11 Feb 2016 10:00:50 +0100
Message-ID: <CAPDyKFp-CMkqa-Y_C_z6bhA_KNm+6oQZhv3_f0bV8WoVDJHfVg@mail.gmail.com>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
	<1453749316-1848-10-git-send-email-wsa@the-dreams.de>
	<CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
	<20160210163623.GA15453@katana>
	<CAPDyKFrzFA_3MnkOPGLD7Fy84XAyx7+=utERbNF1cX31KWxHMg@mail.gmail.com>
	<20160211000716.GA2058@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20160211000716.GA2058@tetsubishi>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 01:07, Wolfram Sang <wsa@the-dreams.de> wrote:
>> I suspect you are using a delayed work in this driver to deal with
>> request timeouts.
>>
>> The value for the delay that is used, needs to be informed towards the
>> mmc core via the "->max_busy_timeout".
>
> Shouldn't that be a seperate patch? In patch 9, I add support for
> another SoC. But your requested change will affect all SoCs.

This is related to how the core treat hosts that announces
MMC_CAP_WAIT_WHILE_BUSY.

Therefore max_busy_timeout needs to be set within the same patch.

>
>> One more thing, as the documentation of your host controllers lacks
>> some information about the busy mode, perhaps it's worth to add some
>> comments about this in the code and as well in the change-log!?
>
> Do you mean documenting my findings with the mmc_test driver? Or
> something else?

It doesn't have to be very much data, just that the documentation
isn't clear and therefore some tests has been done to verify that it
works as expected.

Kind regards
Uffe
