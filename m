From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] mmc: pxamci: call mmc_remove_host() before freeing
	resources
Date: Wed, 2 Dec 2009 23:02:55 +0800
Message-ID: <f17812d70912020702n318089f0rd2e129b0e45458b2@mail.gmail.com>
References: <1259687838-31722-1-git-send-email-daniel@caiaq.de>
	<f17812d70912011650h48a6c391s426ffc8b4b653fc8@mail.gmail.com>
	<20091202110326.GZ14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:61940 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZLBPDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2009 10:03:09 -0500
In-Reply-To: <20091202110326.GZ14091@buzzloop.caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org

On Wed, Dec 2, 2009 at 7:03 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Wed, Dec 02, 2009 at 08:50:44AM +0800, Eric Miao wrote:
>> On Wed, Dec 2, 2009 at 1:17 AM, Daniel Mack <daniel@caiaq.de> wrote:
>> > mmc_remove_host() will cause the mmc core to switch off the bus po=
wer by
>> > eventually calling pxamci_set_ios(). This function uses the regula=
tor or
>> > the GPIO which have been freed already.
>> >
>> > This causes the following Oops on module unload.
>> >
>
> [...]
>
>> >
>> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
>> > Reported-by: Sven Neumann <s.neumann@raumfeld.com>
>> > Cc: Pierre Ossman <pierre@ossman.eu>
>> > Cc: Eric Miao <eric.y.miao@gmail.com>
>> > Cc: linux-mmc@vger.kernel.org
>> > Cc: linux-arm-kernel@lists.infradead.org
>> > Cc: stable@kernel.org
>> > ---
>> > =C2=A0drivers/mmc/host/pxamci.c | =C2=A0 =C2=A04 ++--
>>
>> Looks like a correct fix to me.
>>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
> Would be good to still get this into .32 - who will take care of pick=
ing
> this?
>

I'll send a pull request, and see if Russell will be happy to send
another one in such a short time :)
