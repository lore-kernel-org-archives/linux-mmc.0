From: Daniel Mack <zonque@gmail.com>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Sat, 18 Jun 2011 22:56:11 +0200
Message-ID: <BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59782 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab1FRU4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jun 2011 16:56:12 -0400
Received: by pvg12 with SMTP id 12so2658194pvg.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jun 2011 13:56:11 -0700 (PDT)
In-Reply-To: <201106022149.47936.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, andreiw@motorola.com

On Thu, Jun 2, 2011 at 9:49 PM, Heiko St=FCbner <heiko@sntech.de> wrote=
:
> Hi,
>
> after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flo=
oded (i.e.
> it never stops) by messages of the form:

Even though it's not really related to SDIO, does reverting 06e8935
("mmc: sdio: optimized SDIO IRQ handling for single irq") fix your
problem?

Daniel
