From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH 1/2] Add OF binding helpers for MMC drivers
Date: Fri, 22 Apr 2011 11:02:30 +0200
Message-ID: <BANLkTinOip+px9J1-NkbGiWG9NTqmKjhBw@mail.gmail.com>
References: <20110421131957.GB15194@dandreoli.com>
	<20110421141450.GB32725@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43010 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab1DVJCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 05:02:31 -0400
Received: by qyg14 with SMTP id 14so229480qyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 02:02:30 -0700 (PDT)
In-Reply-To: <20110421141450.GB32725@ponder.secretlab.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Kukjin Kim <kgene.kim@samsung.com>, Ben Dooks <ben-linux@fluff.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Thu, Apr 21, 2011 at 4:14 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Thu, Apr 21, 2011 at 03:19:57PM +0200, Domenico Andreoli wrote:
>> From: Domenico Andreoli <cavokz@gmail.com>
>>
>> This patch adds helpers to manage OF binding of MMC DeviceTree confi=
gs.
>> They don't cover all the MMC configuration cases, indeed are only a
>> slight generalization of those found in the MMC-over-SPI driver. Mor=
e
>> will come later.
>
> Can the mmc-over-spi driver be generalized to use this code too?

I made a mess with the patches... the second one of this set _is_ mmc-o=
ver-spi
converted to this generalization. Instead I sent GPIO OF stuff... sorry=
=2E

>> +/* Card detect and Read only Gpio data */
>> +struct of_mmc_crg {
>> + =A0 =A0 int gpios[NUM_MMC_GPIOS];
>> + =A0 =A0 int alow_gpios[NUM_MMC_GPIOS];
>> + =A0 =A0 int cd_irq;
>> +};
>
> Many drivers currently provide this data via a platform_data. =A0It
> would probably be more useful and require less code if both DT and
> non-DT users shared the same structure for MMC gpios. =A0The structur=
e
> could both be embedded in pdata and populated by this DT parsing code=
=2E
> It would also mean that each driver wouldn't need separate DT and
> non-DT code for consuming the information.

I agree, indeed I'm not able to use these helpers within the s3c-mmc dr=
iver
without duplicating and writing ugly code.

I made some "research" so I have few patches of tries which made me lea=
rn
a bit. There is not a common management of these as well as of the
set_power() callbacks, to say those I learned about looking at S3C MMC.

In practice also MMC platform datas require some consolidation.

Kgene, Ben, do you plan to work on the S3C MCI driver? Can I spend some
time on it without duplicating the effort of anybody?

Regards,
Domenico

-----[ Domenico Andreoli, aka cavok
=A0--[ http://cavokz.wordpress.com/gpgkey/
=A0=A0 ---[ 3A0F 2F80 F79C 678A 8936=A0 4FEE 0677 9033 A20E BC50
