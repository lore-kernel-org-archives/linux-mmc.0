From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH -next] mmc: omap_hsmmc: pass IRQF_ONESHOT to request_threaded_irq
Date: Thu, 17 May 2012 10:32:37 -0400
Message-ID: <87y5oq3mka.fsf@laptop.org>
References: <1337221633-26656-1-git-send-email-ming.lei@canonical.com>
	<CANfBPZ__JCHs01yt_AwgqjVXebBCxMiqCyThPf4Rr8MB191h5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60587 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204Ab2EQOcj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 10:32:39 -0400
In-Reply-To: <CANfBPZ__JCHs01yt_AwgqjVXebBCxMiqCyThPf4Rr8MB191h5g@mail.gmail.com>
	(Venkatraman S.'s message of "Thu, 17 May 2012 19:26:38 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Thu, May 17 2012, S, Venkatraman wrote:
> On Thu, May 17, 2012 at 7:57 AM, Ming Lei <ming.lei@canonical.com> wr=
ote:
>> The flag of IRQF_ONESHOT should be passed to request_threaded_irq,
>> otherwise the following failure message should be dumped because
>> hardware handler is defined as NULL:
>>
>> [ =C2=A0 =C2=A03.383483] genirq: Threaded irq requested with handler=
=3DNULL and
>> !ONESHOT for irq 368
>> [ =C2=A0 =C2=A03.392730] omap_hsmmc: probe of omap_hsmmc.0 failed wi=
th error -22
>>
>> The patch fixes one kernel hang bug which is caused by mmc card
>> probe failure and root device can't be brought up.
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>
> Right thing to do!
> Acked-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.5 with a stable@ tag added.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
