From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Sun, 19 Jun 2011 16:23:47 +0200
Message-ID: <201106191623.48470.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de> <BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:32919 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754067Ab1FSOXw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 19 Jun 2011 10:23:52 -0400
In-Reply-To: <BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, andreiw@motorola.com

Am Samstag 18 Juni 2011, 22:56:11 schrieb Daniel Mack:
> On Thu, Jun 2, 2011 at 9:49 PM, Heiko St=FCbner <heiko@sntech.de> wro=
te:
> > Hi,
> >=20
> > after upgrading my development kernel from 2.6.38 to 3.0rc1 I get f=
looded
> > (i.e.
>=20
> > it never stops) by messages of the form:
> Even though it's not really related to SDIO, does reverting 06e8935
> ("mmc: sdio: optimized SDIO IRQ handling for single irq") fix your
> problem?
sadly reverting this commit didn't fix the problem.
It still floods everything with CMD13s and interrupts

Heiko
