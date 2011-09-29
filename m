From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Support of PCI mode for the dw_mmc driver This
 Patch adds the support for the scenario where the Synopsys Designware IP is
 present on the PCI bus.The patch adds the minimal modifications necessary for
 the driver to work on PCI pl
Date: Thu, 29 Sep 2011 10:24:27 +0100
Message-ID: <CAFbHwiTXKM+69kQ1x5HfwCjoqLfZ+Eb5Lb1Vp7Um-3xXEekMcA@mail.gmail.com>
References: <CAFbHwiQ1zKPUjXLinZukbgbz1wqFs9q93W6y_owLiTvn=i-=Bw@mail.gmail.com>
	<CANYdXnr+uHW5kq==tVkYAwY10qmZzxhWz-=bjbRJ3j10jjL+dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41176 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1I2JY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 05:24:28 -0400
Received: by pzk1 with SMTP id 1so1131116pzk.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 02:24:27 -0700 (PDT)
In-Reply-To: <CANYdXnr+uHW5kq==tVkYAwY10qmZzxhWz-=bjbRJ3j10jjL+dA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

On Thu, Sep 29, 2011 at 5:49 AM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
>>> + =A0 =A0 =A0 .detect_delay_ms =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 2=
00,
>>> + =A0 =A0 =A0 .fifo_depth =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 32,
>>> +};
>>> +#endif
>>> +
>>> =A0static struct workqueue_struct *dw_mci_card_workqueue;
>>>
>>> =A0#if defined(CONFIG_DEBUG_FS)
>>> @@ -682,6 +698,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct dw_mci_slot *slot =3D mmc_priv(mmc);
>>> =A0 =A0 =A0 =A0u32 regs;
>>> +#ifdef CONFIG_MMC_DW_PCI
>>> + =A0 =A0 =A0 u32 card_detect;
>>> +#endif
>>>
>>> =A0 =A0 =A0 =A0/* set default 1 bit mode */
>>> =A0 =A0 =A0 =A0slot->ctype =3D SDMMC_CTYPE_1BIT;
>>> @@ -716,7 +735,15 @@ static void dw_mci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
>>> =A0 =A0 =A0 =A0switch (ios->power_mode) {
>>> =A0 =A0 =A0 =A0case MMC_POWER_UP:
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(DW_MMC_CARD_NEED_INIT, &slot=
->flags);
>>> +#ifdef CONFIG_MMC_DW_PCI
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable Power to the card that has =
been detected */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card_detect =3D mci_readl(slot->host,=
 CDETECT);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, PWREN, ((~card=
_detect) & 0x1));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 case MMC_POWER_OFF:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(slot->host, PWREN, 0);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> +#endif
>>
>> It may be safe to not #ifdef this, all the hardware I have uses an
>> external regulator so the PWREN bits do nothing. I could imagine
>> hardware that was non-PCI that could use PWREN however.
> The hardware that I was using required this to be done .else there wa=
s
> not power to the card.

I think it is safe to remove the #ifdef from around this block though
- for devices with external regulators setting PWREN does nothing so
it should be safe to do it unconditionally.
