From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: host: use platform_{get,set}_drvdata()
Date: Thu, 27 Jun 2013 11:13:28 -0400
Message-ID: <87txkjpox3.fsf@octavius.laptop.org>
References: <001d01ce6014$8d8f8a50$a8ae9ef0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59593 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3F0PNf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jun 2013 11:13:35 -0400
In-Reply-To: <001d01ce6014$8d8f8a50$a8ae9ef0$@samsung.com> (Jingoo Han's
	message of "Mon, 03 Jun 2013 13:41:03 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org, ' =?utf-8?Q?Micha=C5=82_Miros=C5=82aw_'?= <mirq-linux@rere.qmqm.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

Hi Jingoo,

On Mon, Jun 03 2013, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data usi=
ng
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->=
dev,
> so we can directly pass a struct platform_device.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
> Changes since v1:
> - Fixed the missed counterpart - cb710_slot_to_mmc() in cb710-mmc.h.

Thanks, pushed to mmc-next for 3.11.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
