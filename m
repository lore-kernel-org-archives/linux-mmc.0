From: Chris Ball <cjb@laptop.org>
Subject: Re: Support for NetXtreme BCM57765 Memory Card Reader?
Date: Sat, 11 Jun 2011 21:39:19 -0400
Message-ID: <m21uyz96bc.fsf@bob.laptop.org>
References: <1307790907.3615.8.camel@horo.kamakura>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39567 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1FLBjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 21:39:24 -0400
In-Reply-To: <1307790907.3615.8.camel@horo.kamakura> (=?utf-8?Q?=22Ren?=
 =?utf-8?Q?=C3=A9_K=C3=B6cher=22's?= message
	of "Sat, 11 Jun 2011 13:15:05 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?UmVuw6kgS8O2Y2hlcg==?= <shirk@bitspin.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Sat, Jun 11 2011, Ren=C3=A9 K=C3=B6cher wrote:
> The card reader mentioned in the subject is part of the Broadcom
> NetXtreme BCM57765 chip which provides a card reader as well as a
> network interface[=C2=B9].
>
> It is recognized by the sdhci-pci driver however it won't read any ca=
rd
> (tested with different SD, SDHC, SDXC cards).
>
> I'm not sure if it is recognized by its advertised features or if it'=
s
> really supported (unlikely).

I expect there's not much we can do without access to the hardware, but
could you post dmesg output with CONFIG_MMC_DEBUG=3Dy?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
