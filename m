From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v4][mmc/host]:Blackfin SD Host Controller Driver
Date: Sun, 29 Nov 2009 16:39:16 -0500
Message-ID: <8bd0f97a0911291339v7b0195dfjeb2065d011b47dc7@mail.gmail.com>
References: <1259162390-378-1-git-send-email-cliffcai.sh@gmail.com>
	<20091125140422.cdee4a0d.akpm@linux-foundation.org> <8bd0f97a0911251425q178993fete79b675e2730bdec@mail.gmail.com>
	<20091125144307.5e7d6d6f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:65502 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZK2Vja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2009 16:39:30 -0500
In-Reply-To: <20091125144307.5e7d6d6f.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cliffcai.sh@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com, Bryan Wu <cooloney@kernel.org>

On Wed, Nov 25, 2009 at 17:43, Andrew Morton wrote:
> On Wed, 25 Nov 2009 17:25:20 -0500 Mike Frysinger wrote:
>> > Arguably wrong from a coding-style POV and looks weird IMO. __Adds=
 a bit
>> > of risk that subsequent coders will think they're writing in pytho=
n adn
>> > will add bugs.
>>
>> i dont really get what you're referring to here. =C2=A0the code in q=
uestion
>> looks ifne to me, and i dont see anything "python-esque" about it
>
> Code like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (expr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line3;
>
> looks odd and can cause people to later add bugs along the lines of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (expr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line3a;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line3;
>
> this is particularly the case if line3 is long, or is preceded by a
> comment. =C2=A0This has happened in the past.
>
> Adding the missing braces reduces the risk that this will occur.

*shrug* people can screw up braces regardless of how many statements
and/or branches there are.  i doubt people are going to get confused
and think kernel code is python, but if you really want to be pedantic
about braces, doesnt matter that much to me.
-mike
