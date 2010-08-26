From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: example for using mmc_test.c
Date: Thu, 26 Aug 2010 01:32:19 -0400
Message-ID: <AANLkTin7UGt1e=xLmYgRHxnwSzOgXvt=56mb=4mWaPqt@mail.gmail.com>
References: <442037.35057.qm@web114216.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62538 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab0HZFcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 01:32:20 -0400
Received: by wwb28 with SMTP id 28so1068994wwb.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2010 22:32:19 -0700 (PDT)
In-Reply-To: <442037.35057.qm@web114216.mail.gq1.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Primus Mutasingwa <pmutasingwa@yahoo.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Aug 25, 2010 at 9:01 PM, Primus Mutasingwa
<pmutasingwa@yahoo.com> wrote:
> Hello,
>
> I am looking for an example that shows how to use the driver in:
> driver/mmc/card/mmc_test.c.
>
> Anyone with sample user space code or instructions on how to use plea=
se forward
> to me.
> kernel version used is 2.6.33.7
>
> thanks.
>
> P. Mutasingwa
> pmutasingwa@yahoo.com
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi Primus,

 The details are located in Kconfig

http://lxr.linux.no/#linux+v2.6.35/drivers/mmc/card/Kconfig#L41

Regards,
-- Mark
