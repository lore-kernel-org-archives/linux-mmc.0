From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 5 Mar 2011 03:23:55 -0600
Message-ID: <AANLkTik1VR+Of_9oi_eyvMBiE2_sbgYCj0XF3zAWou+m@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102251321.09232.arnd@arndb.de>
	<4D6D3F71.4040605@kernel.dk>
	<201103012011.51855.arnd@arndb.de>
	<AANLkTimLnd=8oiLeZaaJLNwifG3KJ71kmwy5DDY25j_V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:36886 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1CEJX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 04:23:58 -0500
In-Reply-To: <AANLkTimLnd=8oiLeZaaJLNwifG3KJ71kmwy5DDY25j_V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wed, Mar 2, 2011 at 4:34 AM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
> Before the generic improvements are made to the block layer, I think
> there is some value
> in implementing the (simpler) ones in mmc block code, as well as
> expose an mmc block quirk interface by which its easy to add complex
> workarounds. Some things will never be able to completely stay above
> mmc block code, for example, when splitting up smaller accesses, you
> need to be careful on the Toshiba card, since the 4th consecutive 8KB
> block results in the entire 32KB getting pushed =A0into the bigger 4M=
B
> buffer. On our platform, there are a lot of accesses in the 16KB-32KB
> range which benefit from the splitting. Data collected showed
> splitting more than 32KB to have adverse effect on performance (I
> guess that sort of makes sense, after all, why else would the
> controller treat 4 consecutive 8KB accesses as a larger access and
> treat it accordingly?) On the other hand, that data was collected on
> code that used reliable write for every portion of the split access,
> so I'm going to have to get some new data...
>

Just want to correct myself - any consecutive write that exceeds 8K
goes into the 4MB buffer.
Also, according to vendor, there is no performance penalty for using
reliable write.
This is why in the patch set, for splitting larger requests (to
improve lifetime by reducing the number of AU write/erase cycles) I
perform a reliable write for each split block set.
