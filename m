From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Thu, 26 Aug 2010 11:28:17 +0100
Message-ID: <AANLkTik1ej-=WfQywFAG5yFsar1k=QmMjDnXqLHKnGAT@mail.gmail.com>
References: <4C33DFF0.3040804@renesas.com> <20100708144647.1e77364b.akpm@linux-foundation.org>
 <4C3BD041.3020705@renesas.com> <20100825225208.02a906f7@linux-g6p1.site>
 <20100825150502.33649ff0.akpm@linux-foundation.org> <AANLkTiko3vN5APNcKbFegOn_XEySyDgBnAoGzyOKSsiZ@mail.gmail.com>
 <20100826072446.GA19339@console-pimps.org> <AANLkTin+LnxRzN9yV6+iE5+zEeP9WitbW0qgf3KHDUu6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57990 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0HZK2j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 06:28:39 -0400
Received: by yxg6 with SMTP id 6so575324yxg.19
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2010 03:28:38 -0700 (PDT)
In-Reply-To: <AANLkTin+LnxRzN9yV6+iE5+zEeP9WitbW0qgf3KHDUu6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Matt Fleming <matt@console-pimps.org>, Andrew Morton <akpm@linux-foundation.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

@Matt: yes, thats what I was suggesting before.

@Magnus: that looks fine.

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 26 August 2010 08:26, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Aug 26, 2010 at 4:24 PM, Matt Fleming <matt@console-pimps.org=
> wrote:
>> On Thu, Aug 26, 2010 at 02:50:09AM +0100, Ian Molton wrote:
>>> Probably dropped because I complained about two things,
>>>
>>> 1) The patch doesnt check what the hardware is underneath before
>>> arbitrarily changing the parameters relied on by some hardware
>>
>> Has anyone thought about adding a caps or flags field to the
>> tmio_mmc_host structure so that platform code set a bit if it can't =
do
>> 2-byte data block transfers?
>
> Good idea! There is already a good place available:
>
> From include/linux/mfd/tmio.h:
> ...
> /* tmio MMC platform flags */
> #define TMIO_MMC_WRPROTECT_DISABLE =A0 =A0 =A0(1 << 0)
>
> Cheers,
>
> / magnus
>
