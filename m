From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V2 04/16] mmc: omap_hsmmc: reduce a bit the error handlers
 in probe()
Date: Fri, 6 May 2011 14:38:48 +0300
Message-ID: <BANLkTimBafJFE7+WBobBV7pc+X_=FBsTMw@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-5-git-send-email-adrian.hunter@nokia.com>
	<BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48432 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab1EFLit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 07:38:49 -0400
In-Reply-To: <BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Fri, May 6, 2011 at 2:34 PM, Varadarajan, Charulatha <charu@ti.com> =
wrote:
> On Fri, May 6, 2011 at 14:44, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
>> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>>
>
> Add patch description here.
You mean something like following:
"The code contains similarities in the error path of probe function.
Let's combine them at one place."
?

>
>> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> ---
>> =C2=A0drivers/mmc/host/omap_hsmmc.c | =C2=A0 17 ++++++-----------
>> =C2=A01 files changed, 6 insertions(+), 11 deletions(-)
>>
>
> <<snip>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
With Best Regards,
Andy Shevchenko
