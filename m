From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 06/16] block: treat DMPG and SWAPIN requests as special
Date: Thu, 3 May 2012 21:52:32 +0530
Message-ID: <CANfBPZ-V86XfnA8CXVsupvWkfnXPC7upCqAFsx8+_2Ta5zTabA@mail.gmail.com>
References: <1336054995-22988-1-git-send-email-svenkatr@ti.com>
 <1336054995-22988-7-git-send-email-svenkatr@ti.com> <x49fwbhl48d.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:39650 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756252Ab2ECQWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 May 2012 12:22:55 -0400
Received: by bkcjg15 with SMTP id jg15so1669108bkc.10
        for <linux-mmc@vger.kernel.org>; Thu, 03 May 2012 09:22:52 -0700 (PDT)
In-Reply-To: <x49fwbhl48d.fsf@segfault.boston.devel.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, alex.lemberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, rmk+kernel@arm.linux.org.uk

On Thu, May 3, 2012 at 8:08 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Venkatraman S <svenkatr@ti.com> writes:
>
>> From: Ilan Smith <ilan.smith@sandisk.com>
>>
>> When exp_swapin and exp_dmpg are set, treat read requests
>> marked with DMPG and SWAPIN as high priority and move to
>> the front of the queue.
>>
> [...]
>> + =A0 =A0 if (bio_swapin(bio) && blk_queue_exp_swapin(q)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 where =3D ELEVATOR_INSERT_FLUSH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto get_rq;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (bio_dmpg(bio) && blk_queue_exp_dmpg(q)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(q->queue_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 where =3D ELEVATOR_INSERT_FLUSH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto get_rq;
>
> Is ELEVATOR_INSERT_FRONT not good enough? =A0It seems wrong to use _F=
LUSH,
> here. =A0If the semantics of ELEVATOR_INSERT_FLUSH are really what is
> required, then perhaps we need to have another think about the naming=
 of
> these flags.
>
Actually - yes, ELEVATOR_INSERT_FRONT would do as well. In the
previous version of MMC stack,
we needed the _FLUSH to trigger the write operation that was to be
preempted, to check that
it actually works.


> Cheers,
> Jeff
>
> --
