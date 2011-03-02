From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Wed, 2 Mar 2011 05:37:23 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C82A4@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110228144741.GF15532@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
 <20110301113115.GB2212@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:58462 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBFh1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 00:37:27 -0500
In-Reply-To: <20110301113115.GB2212@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Wolfram:

Best Regards
Richard Zhu


> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Tuesday, March 01, 2011 7:31 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; Zhao Richard-B20223;
> Freescale@lists.linaro.org; eric.miao@linaro.org
> Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
>
> Hi Richard,
>
> > Thanks a lot for your review-comments firstly. :)
>
> You are welcome :)
>
> > > > +/* Abort type definition in the command register  */
> > > > +#define  SDHCI_CMD_ABORTCMD        0xC0
> > >
> > > Won't that belong into sd.h (unless I misunderstood your last mail)?
> > This is the bit definitions of the ABORTCMD CMD-TYPE on the bit6~7 of
> CMD register.
> > Here is the definition of the CMD register derived from SDHC spec. FYI.
> > D15   D14 D13  D08     D07 D06       D05                  D04
> D03                       D02         D01 D00
> > Rsvd  Command  Index   Command Type  Data Present Select  Command Index
> Check Enable   Command CRC Check Enable  Rsvd        Response Type Select
>
> Ack, I found that, too. Exactly because it is in the standard, I thought
> this should rather go into sd.h than sdhci-esdhc-imx.c. Would be a
> seperate patch, though.
>
Do you means the sdhci.h file?
I find that the sd.h file doesn't contain the bit definitions stuff of SD HOST CONTROLLER registers.
The sdhci.h file has them, such as:
#define SDHCI_COMMAND           0x0E
#define  SDHCI_CMD_RESP_MASK    0x03
#define  SDHCI_CMD_CRC          0x08
#define  SDHCI_CMD_INDEX        0x10
#define  SDHCI_CMD_DATA         0x20

> > >
> > > > +/* VENDOR SPEC register */
> > > > +#define SDHCI_VENDOR_SPEC  0xC0
> > > > +
> > > > +/*
> > > > + * The CMDTYPE of the CMD register(offset 0xE) should be set to
> > >
> > > Check spaces.
> > I used the <kernel_dir>/./scripts/checkpatch.pl script to check the
> patches, and didn't find that there are issues about the spaces.
> > Can you tell me what's kinds of spaces issue should be fixed?
>
> Space before opening brace -> "register (offset ..."

Accepted.

>
> > No, we can't keep it enabled all the time.
> > This bit should be set to '1'/clear to '0' at the begin/end of the
> transfer.
> > Unfortunately, We can't use it to fix CMD12 issue either, this bit is
> only used to fix SDIO Multi-BLK NO INT case.
>
> Ok, thanks for checking.
>
You are welcome. :)

> > IC guy insist that the CMD12 case is not a bug refer to the SD HOST
> > controller spec, the bit7-6 should be Set to 11b when the abort CMD is
> issued.
>
> That's a flaw in the core then? Need to investigate that.
>
> > > Hmm, to me, just using cpu_is_mx53() is more readable than
> > > introducing another layer of flags/quirks.
> > Hi Wolfram:
> > I discussed it with Richard Zhao before sending out these V3 patches.
> > As we know that there is not only mx53 has this issue, maybe some
> following SOCs have this issue too.
> > So we make a decision that we introduce another flags/quirks to
> > declare it for all those SOCs that required this mechanism in the end.
>
> Seems I am outnumbered on this matter, so OK. I just got a bit afraid of
> that approach seeing it didn't scale very well with sdhci.c.
>
Thanks.
> > > > +
> > > > +static struct sdhci_ops sdhci_esdhc_ops;
> > > > +
> > >
> > > Move them to the front. But I did this already, so no worries :) I
> > > will ping Chris to merge my series, so we will have something better
> > > to develop on.
> > >
> > Thanks.:)
>
> He pulled the changes now, so please rebase your patches against mmc-next.
> There is already a write_le-function now, but this should be not too hard,
> hopefully.
>
> Keep in mind that you don't need to cast void*.
Accepted.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

