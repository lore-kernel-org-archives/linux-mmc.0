From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
Date: Wed, 11 Aug 2010 22:21:35 -0600
Message-ID: <AANLkTinMs+brv22ES5aMvVNi=bYEVY13eJwbJCyF5o2-@mail.gmail.com>
References: <3850A844E6A3854C827AC5C0BEC7B60A0565B8@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59585 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0HLEV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2010 00:21:56 -0400
Received: by gwb20 with SMTP id 20so261379gwb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 21:21:55 -0700 (PDT)
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A0565B8@zch01exm23.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, mirqus@gmail.com, cbouatmailru@gmail.com, Kumar Gala <galak@kernel.crashing.org>

On Wed, Aug 11, 2010 at 10:00 PM, Zang Roy-R61911 <r61911@freescale.com=
> wrote:
>
>
>> -----Original Message-----
>> From: Zang Roy-R61911
>> Sent: Wednesday, August 11, 2010 12:47 PM
>> To: Zang Roy-R61911; akpm@linux-foundation.org;
>> linux-mmc@vger.kernel.org
>> Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;
>> cbouatmailru@gmail.com; grant.likely@secretlab.ca
>> Subject: RE: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for
>> more clear
>>
>>
>>
>> > -----Original Message-----
>> > From: Zang Roy-R61911
>> > Sent: Tuesday, August 10, 2010 17:47 PM
>> > To: akpm@linux-foundation.org; linux-mmc@vger.kernel.org
>> > Cc: linuxppc-dev@ozlabs.org; mirqus@gmail.com;
>> > cbouatmailru@gmail.com; grant.likely@secretlab.ca
>> > Subject: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more cle=
ar
>> >
>> > Change ACMD12 to AUTO_CMD12 to reduce the confusion.
>> > ACMD12 might be confused with MMC/SD App CMD 12 (CMD55+CMD12 combo=
).
>> >
>> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>> > ---
>> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A02 +-
>> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 =A08 ++++----
>> > =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 10 +++++-----
>> > =A03 files changed, 10 insertions(+), 10 deletions(-)
>> Andrew,
>> Could you help to pick up this minor fix?
>> Thanks.
>> Roy
> Any update?
> Thanks.
> Roy

Patience Roy.  You only sent the patch 1 day ago.

g.
