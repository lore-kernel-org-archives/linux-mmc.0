From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] MMC:mmc_spi: Recover from CRC error
	for SD read/write operation over SPI.
Date: Fri, 9 Jul 2010 11:43:25 -0400
Message-ID: <AANLkTimy9Y7udFmHiR2mSwVFXyenb08hFF6jRWxlntuq@mail.gmail.com>
References: <1278662607.16528.8.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46946 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973Ab0GIPnr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jul 2010 11:43:47 -0400
In-Reply-To: <1278662607.16528.8.camel@eight.analog.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>, linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, Jul 9, 2010 at 04:03, sonic zhang <sonic.adi@gmail.com> wrote:
> SPI bus is not reliable on all platforms when doing large dada transfer.

dada -> data

> occational CRC error is reported by SD device. This patch makes the

occational -> occasional
-mike
