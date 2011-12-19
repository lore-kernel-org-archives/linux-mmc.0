From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 19 Dec 2011 13:24:08 +0800
Message-ID: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
References: <87r51fwxgt.fsf@laptop.org>
	<1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<874nxkmaky.fsf@laptop.org>
	<m2sjklfmuf.fsf@bob.laptop.org>
	<CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
	<4EEEC3BF.6010708@einfochips.com>
	<CAN1soZxnSsZ8SDp=ueu0iMaz59pq7p09DoYD27qCridrrAkmuw@mail.gmail.com>
	<4EEEC8E1.1060903@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37963 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab1LSFYJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 00:24:09 -0500
Received: by vbbfc26 with SMTP id fc26so3743944vbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Dec 2011 21:24:08 -0800 (PST)
In-Reply-To: <4EEEC8E1.1060903@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, prakity@marvell.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, jason.chagas@marvell.com

On Mon, Dec 19, 2011 at 1:17 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
>
>
> On Monday 19 December 2011 10:32 AM, Haojian Zhuang wrote:
>>
>> On Mon, Dec 19, 2011 at 12:55 PM, Tanmay Upadhyay
>> <tanmay.upadhyay@einfochips.com> =A0wrote:
>>>
>>>
>>> On Monday 19 December 2011 10:15 AM, Haojian Zhuang wrote:
>>>>
>>>> On Fri, Dec 16, 2011 at 7:15 AM, Chris Ball<cjb@laptop.org> =A0 =A0=
wrote:
>>>>>
>>>>> Hi Eric and Jason,
>>>>>
>>>>> On Thu, Dec 01 2011, Chris Ball wrote:
>>>>>>
>>>>>> Hi Eric, Jason,
>>>>>>
>>>>>> Please could you ACK this patch if you agree with it, and I'll t=
ake it
>>>>>> and the rest of the series via the MMC tree? =A0Thanks.
>>>>>
>>>>> Ping?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> - Chris.
>>>>>
>>>> NACK.
>>>>
>>>>>>> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.=
h are
>>>>>>> for MMP2
>>>>>>> + * PXA168 has different offset */
>>>>>>> +#undef APMU_SDH2
>>>>>>> +#undef APMU_SDH3
>>>>>>> +
>>>>>>> +#define APMU_SDH2 =A0 APMU_REG(0xe0)
>>>>>>> +#define APMU_SDH3 =A0 APMU_REG(0xe4)
>>>>>>> +
>>>>
>>>> Please don't use #undef at here. If the register setting is differ=
ent,
>>>> I prefer to use two different clk operations.
>>>>
>>> Sorry I couldn't get you. Could you please elaborate? Here regs-apm=
u.h
>>> defines clock register offsets. They are correct for MMP2, but not =
for
>>> PXA168. So I thought to correct them in a PXA168 specific file. Cou=
ld you
>>> please point me a better way?
>>>
>>> Thanks,
>>>
>>> Tanmay
>>
>> APMU_PXA168_SDH2
>> APMU_MMP2_SDH2
>>
>> I think this is better.
>>
>
> Thanks for the suggestion. This looks a better option. However, I wou=
ld like
> add here that not only the register offset, but also the register bit=
s are
> different for MMP2 & PXA168. So, the code that would control SD/MMC c=
lock
> will be architecture specific & hence in different architecture speci=
fic
> files. Hope this solution looks good to all of you in that case as we=
ll.
>
> Thanks,
>
> Tanmay

+static void sdh_clk_enable(struct clk *clk)
+{
+       void __iomem *clk_reg_offset =3D clk->clk_rst;
+
+       /* Can't see any clean way to do this: Bits 3 & 0 in registers
+        * for host 0 & 2 should be set for host 1 & 3 also */
+       if (clk_reg_offset =3D=3D APMU_SDH0 || clk_reg_offset =3D=3D AP=
MU_SDH1)
+               __raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
+       if (clk_reg_offset =3D=3D APMU_SDH2 || clk_reg_offset =3D=3D AP=
MU_SDH3)
+               __raw_writel(__raw_readl(APMU_SDH2) | 0x9, APMU_SDH2);
+
+       __raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->=
clk_rst);
+}
+
+struct clkops sdh_clk_ops =3D {
+       .enable         =3D sdh_clk_enable,
+       .disable        =3D sdh_clk_disable,
+};
+

+static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH2, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh4, SDH3, 0x12, 48000000, &sdh_clk_ops);
+

You defined both sdh_clk_ops & APMU_CLK_OPS. So you can define
pxa168_sdh_clk_ops in pxa168.c, and mmp2_sdh_clk_ops in mmp2.c.
