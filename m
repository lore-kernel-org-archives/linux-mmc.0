From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 19 Dec 2011 12:45:09 +0800
Message-ID: <CAN1soZxmKct+qGUE2_W+FZufR+gcYZu6Dsj+TkJ06PaO8rV-TQ@mail.gmail.com>
References: <87r51fwxgt.fsf@laptop.org>
	<1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<874nxkmaky.fsf@laptop.org>
	<m2sjklfmuf.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58796 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab1LSEpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Dec 2011 23:45:10 -0500
Received: by vbbfc26 with SMTP id fc26so3731590vbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Dec 2011 20:45:09 -0800 (PST)
In-Reply-To: <m2sjklfmuf.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, linux-mmc@vger.kernel.org, prakity@marvell.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, jason.chagas@marvell.com

On Fri, Dec 16, 2011 at 7:15 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Eric and Jason,
>
> On Thu, Dec 01 2011, Chris Ball wrote:
>> Hi Eric, Jason,
>>
>> Please could you ACK this patch if you agree with it, and I'll take =
it
>> and the rest of the series via the MMC tree? =A0Thanks.
>
> Ping?
>
> Thanks,
>
> - Chris.
>
NACK.

>>> +/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h ar=
e for MMP2
>>> + * PXA168 has different offset */
>>> +#undef APMU_SDH2
>>> +#undef APMU_SDH3
>>> +
>>> +#define APMU_SDH2   APMU_REG(0xe0)
>>> +#define APMU_SDH3   APMU_REG(0xe4)
>>> +

Please don't use #undef at here. If the register setting is different,
I prefer to use two different clk operations.
