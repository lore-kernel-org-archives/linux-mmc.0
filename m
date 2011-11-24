From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 24 Nov 2011 10:30:25 +0100
Message-ID: <CAFEEs1nBFFLNvRDfwFkkp5SaifmKeykS-jrEtiSHw2ahR_38Zg@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
	<loom.20111122T210615-276@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607Ab1KXJa0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 04:30:26 -0500
Received: by vcbfk14 with SMTP id fk14so1159072vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2011 01:30:25 -0800 (PST)
In-Reply-To: <loom.20111122T210615-276@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Taylor <dmtaylor@skytex.net>, Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org

Hi David,

On Tue, Nov 22, 2011 at 9:18 PM, David Taylor <dmtaylor@skytex.net> wro=
te:
> Sujit Reddy Thumma <sthumma <at> codeaurora.org> writes:
>
>>
>> Kill block requests when the host knows that the card is
>> removed from the slot and is sure that subsequent requests
>> are bound to fail. Do this silently so that the block
>> layer doesn't output unnecessary error messages.
>>
>> This patch implements suggestion from Adrian Hunter,
>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>>
>> Signed-off-by: Sujit Reddy Thumma <sthumma <at> codeaurora.org>
>> ---
>> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
>> =A0drivers/mmc/core/bus.c =A0 | =A0 =A02 ++
>> =A0include/linux/mmc/card.h | =A0 =A03 +++
>> =A03 files changed, 10 insertions(+), 0 deletions(-)
>>
>
> Thanks, this patch worked nicely to control a seemingly endless serie=
s of
> driver complaints when the SD card was removed during a transfer.
>
> The OMAP4 I'm working on has hardware assisted detection of card remo=
val, and
> this patch looks like it will be sufficient.
>
What happens if you run "dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D1M
count=3D1000" and during dd the card is ejected?
When I test this, the host is claimed until the dd has tried to
transfer all 1000MB.

Regards,
Per
