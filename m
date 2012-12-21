From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Fri, 21 Dec 2012 11:43:31 +0100
Message-ID: <CAPDyKFrQ32ANCwUo39rFNqbHwsKFyDVamMaeNTVC9j4tBjRmkg@mail.gmail.com>
References: <20121121165048.GO3290@n2100.arm.linux.org.uk>
	<CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com>
	<20121122173708.GJ5764@n2100.arm.linux.org.uk>
	<50B34270.7070403@stericsson.com>
	<20121126102712.GC19440@n2100.arm.linux.org.uk>
	<50B349D3.2050806@stericsson.com>
	<CAFEEs1nZboGyAfpYQ2hUvp366FiS0=8u5zL6Vr1RfXac_Ls_dw@mail.gmail.com>
	<20121128171221.GF19440@n2100.arm.linux.org.uk>
	<CAPDyKFoq2f2tZqoKAjMjhA3yJFinXM25rJPCyiGaqHw=fEUoMg@mail.gmail.com>
	<CAPDyKFqg0Jb0mNW4riUa7XADKZpQSO0UAjSFKM_tnEOOG3LVxg@mail.gmail.com>
	<20121221103955.GH14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59922 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2LUKnc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 05:43:32 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so1826074wib.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Dec 2012 02:43:31 -0800 (PST)
In-Reply-To: <20121221103955.GH14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>

On 21 December 2012 11:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 21, 2012 at 11:36:32AM +0100, Ulf Hansson wrote:
>> Just wanted to conclude on the way forward. Should we fixup pio_write
>> according to how pio_read has been fixed, or should we adapt the check
>> for misaligned buffers to what Per proposed?
>> What do you prefer Russell?
>
> It's really silly to have pio_read doing something that pio_write doesn't
> do - they should have the same behaviour except for the differing data
> flow direction.

I agree. Thanks for your input.

Kind regards
Ulf Hansson
