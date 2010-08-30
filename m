From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Date: Mon, 30 Aug 2010 11:46:17 -0600
Message-ID: <AANLkTinhctfE_BTF3xtACMoqrtRiSNApQ3+qCaOJ=w7m@mail.gmail.com>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
 <20100830132914.GA32266@oksana.dev.rtsoft.ru> <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45607 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0H3Rqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 13:46:38 -0400
Received: by ywh1 with SMTP id 1so1725831ywh.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2010 10:46:37 -0700 (PDT)
In-Reply-To: <AANLkTik3rNpFCYDR7dxiFN_3dvxZmsSjt8PsoC415JM-@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Esben Haabendal <esbenhaabendal@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@lists.ozlabs.org

On Mon, Aug 30, 2010 at 10:04 AM, Esben Haabendal
<esbenhaabendal@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 3:29 PM, Anton Vorontsov <cbouatmailru@gmail.=
com> wrote:
>>> @@ -121,8 +136,14 @@ struct mmc_spi_platform_data
>>> *mmc_spi_get_pdata(struct spi_device *spi)
>>> =A0 =A0 =A0 =A0 if (gpio_is_valid(oms->gpios[WP_GPIO]))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oms->pdata.get_ro =3D of_mmc_spi_ge=
t_ro;
>>>
>>> - =A0 =A0 =A0 /* We don't support interrupts yet, let's poll. */
>>> - =A0 =A0 =A0 oms->pdata.caps |=3D MMC_CAP_NEEDS_POLL;
>>> + =A0 =A0 =A0 oms->detect_irq =3D irq_of_parse_and_map(np, 0);
>>> + =A0 =A0 =A0 if (oms->detect_irq !=3D NO_IRQ) {
>>
>> I'd write "if (oms->detect_irq)", which is a bit more natural
>> (and still correct, 0 is the only invalid VIRQ number).
>
> Most other architectures has NO_IRQ defined to -1, so I will stick
> with the NO_IRQ comparsion.

Not true.  NO_IRQ is only defined as -1 on ARM, microblaze, mn10300
and parisc, and I've got a patch pending to remove microblaze from
that list.  ARM just happens to be a really big user.

$ git grep NO_IRQ arch/*/include  (I've trimmed the irrelevant matches)
arch/arm/include/asm/irq.h:#ifndef NO_IRQ
arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))
arch/microblaze/include/asm/irq.h:#define NO_IRQ (-1)
arch/mn10300/include/asm/irq.h:#define NO_IRQ           INT_MAX
arch/parisc/include/asm/irq.h:#define NO_IRQ            (-1)
arch/powerpc/include/asm/irq.h:#define NO_IRQ                   (0)

> Hopefully, arm users will soon enjoy this driver/wrapper soon also.

My hope is that even on ARM when the device tree is used I'll be able
eliminate IRQs mapped to 0 (but I need to do a lot more research on
how best to do that though).  Are you actually using this on ARM?

I'm okay with you keeping the NO_IRQ test for the short term though.

g.
