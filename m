From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Sun, 12 Dec 2010 10:57:44 +0000
Message-ID: <AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39594 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab0LLK5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Dec 2010 05:57:46 -0500
In-Reply-To: <20101211192320.GA24430@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arm-kernel@lists.infradead.org

On Sat, Dec 11, 2010 at 7:23 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Will,
>
> On Thu, Dec 09, 2010 at 05:24:26PM +0000, Will Newton wrote:
>> This adds the mmc host driver for the Synopsys DesignWare mmc
>> host controller, found in a number of embedded SoC designs.
>>
>> Signed-off-by: Will Newton <will.newton@imgtec.com>
>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
>
> Running a test build on ARM fails:
>
> drivers/mmc/host/dw_mmc.c: In function =91dw_mci_push_data64=92:
> drivers/mmc/host/dw_mmc.c:985: error: implicit declaration of functio=
n =91__raw_writeq=92
> drivers/mmc/host/dw_mmc.c: In function =91dw_mci_pull_data64=92:
> drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of functio=
n =91__raw_readq=92
>
> because arch/arm doesn't implement raw versions of these 64-bit acces=
ses.
> I'm surprised that this driver hasn't been compiled on ARM before! =A0=
What

That particular bit of code has been added since it was last built for
arm. Our architecture can do 64bit accesses so we implement readq.
Unfortunately there doesn't seem to be a sane way to conditionalize
code for architectures that have or don't have readq, so I suspect
I'll have to just remove that branch of the if statement for now.

> kind of arch are you testing on? =A0Do you have any ARM hardware (lpc=
313x?)
> to verify the driver on?

Our architecture is not merged into mainline yet (although I am
working on that). I don't have an lpc313x board but I would be happy
to work on this code with anyone who does.
