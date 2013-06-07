From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH v2 1/8] clk: flag to use upper half of the register as
 change indicator
Date: Fri, 7 Jun 2013 23:21:00 +0800
Message-ID: <CAD6h2NRBHh-4XNnDvyWmVPSpLzLCG32=xuwGZg4nu+WAD6r=Kg@mail.gmail.com>
References: <201306062107.58875.heiko@sntech.de>
	<201306062108.38587.heiko@sntech.de>
	<CACRpkda+QwnhCHBhQ3d-zUE9dD75Rv0_qt02h6prrzCBzNm5zw@mail.gmail.com>
	<201306071427.20512.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:55910 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab3FGPVB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2013 11:21:01 -0400
Received: by mail-qa0-f41.google.com with SMTP id f14so991044qak.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jun 2013 08:21:00 -0700 (PDT)
In-Reply-To: <201306071427.20512.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 7 June 2013 20:27, Heiko St=FCbner <heiko@sntech.de> wrote:
> Am Freitag, 7. Juni 2013, 13:46:32 schrieb Linus Walleij:
>> On Thu, Jun 6, 2013 at 9:08 PM, Heiko St=FCbner <heiko@sntech.de> wr=
ote:
>> > There exist platforms, namely at least all Rockchip Cortex-A9 base=
d ones,
>> > that don't use the paradigm of reading-changing-writing the regist=
er
>> > contents, but instead only write the changes to the register with =
a mask
>> > that indicates the changed bits.
>> >
>> > This patch adds flags and code to support the case where the lower=
 16 bit
>> > of hold the information and the upper 16 bit are used as mask to
>> > indicate the written changes.
>> >
>> > As hardware-specific flags should not be added to the common clk f=
lags,
>> > the flags are added to gate, mux and divider clocks individually.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> (...)
>>
>> > +       if ((clk_gate_flags & CLK_GATE_MASK_UPPER_HALF) && bit_idx=
 > 15)
>> > { +               pr_err("%s: bit_idx %d invalid\n", __func__, bit=
_idx);
>> > +               return ERR_PTR(-EINVAL);
>> > +       }
>>
>> Now this looks *EXTREMELY* familiar to a patch just sent by Haojian
>> for HiSilicon.
>>
>> "[PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag"
>> http://marc.info/?l=3Dlinux-arm-kernel&m=3D137035873916777&w=3D2
>>
>> What kind of coincidence is this? Are Rockchip and HiSilicon using
>> the same silicon IP or are they of a common origin? (It is a small
>> world after all.)
>
> Now this is really interesting :-) and the handling really seems to f=
ollow the
> same pattern.
>
>
>> I think you two guys need to read each others patch sets closely
>> here. I'd like Haojian to look at Heiko's patches and Heiko to look
>> at Haojian's patches, just to make sure you're not actually writing
>> two drivers for the same hardware in the end.
>
> I'll take a look
>
>
> Heiko

Me too :)

Regards
Haojian
