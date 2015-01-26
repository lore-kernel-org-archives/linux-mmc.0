From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: mmc does not work in qemu n900
Date: Tue, 27 Jan 2015 01:21:04 +0200
Message-ID: <20150126232104.GA591@fuloong-minipc.musicnaut.iki.fi>
References: <201501262204.59305@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34010 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301AbbAZXVM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jan 2015 18:21:12 -0500
Content-Disposition: inline
In-Reply-To: <201501262204.59305@pali>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>

Hi,

On Mon, Jan 26, 2015 at 10:04:59PM +0100, Pali Roh=E1r wrote:
> problem? Why any of these two patches fix problem when mmc is not=20
> detected by kernel in qemu (machine n900)? Detection of mmc fails=20
> because function mmc_send_op_cond() without one of above patches=20
> fails.

Has it ever worked? It could be just that QEMU's emulation is broken.
Since the kernel works on actual HW, you probably should contact
QEMU maintainers.

I don't see n900 in Debian's QEMU. There's n800 and n810 but
I couldn't boot any of my kernels with those...

A.
