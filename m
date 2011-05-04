From: Per Forlin <per.forlin@linaro.org>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Wed, 4 May 2011 21:13:10 +0200
Message-ID: <BANLkTi=omboE=fh16KSAa__JyG=hARmw=A@mail.gmail.com>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
	<201105031516.28907.arnd@arndb.de>
	<BANLkTi=74Mp1vWBt2F-sqqqkeNfP69+9vg@mail.gmail.com>
	<201105032202.42662.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <201105032202.42662.arnd@arndb.de>
Sender: owner-linux-mm@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-mmc@vger.kernel.org

On 3 May 2011 22:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 May 2011 20:54:43 Per Forlin wrote:
>> >> page_not_up_to_date:
>> >> /* Get exclusive access to the page ... */
>> >> error = lock_page_killable(page);
>> > I looked at the code in do_generic_file_read(). lock_page_killable
>> > waits until the current read ahead is completed.
>> > Is it possible to configure the read ahead to push multiple read
>> > request to the block device queue?add
>
> I believe sleeping in __lock_page_killable is the best possible scenario.
> Most cards I've seen work best when you use at least 64KB reads, so it will
> be faster to wait there than to read smaller units.
>
Sleeping is ok but I don't wont the read execution to stop (mmc going
to idle when there is actually more to read).
I did an interesting discovery when I forced host mmc_req_size to 64k
The reads now look like:
dd if=/dev/mmcblk0 of=/dev/null bs=4k count=256
 [mmc_queue_thread] req d955f9b0 blocks 32
 [mmc_queue_thread] req   (null) blocks 0
 [mmc_queue_thread] req   (null) blocks 0
 [mmc_queue_thread] req d955f9b0 blocks 64
 [mmc_queue_thread] req   (null) blocks 0
 [mmc_queue_thread] req d955f8d8 blocks 128
 [mmc_queue_thread] req   (null) blocks 0
 [mmc_queue_thread] req d955f9b0 blocks 128
 [mmc_queue_thread] req d955f800 blocks 128
 [mmc_queue_thread] req d955f8d8 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7811230
 [mmc_queue_thread] req d955fec0 blocks 128
 [mmc_queue_thread] req d955f800 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7811492
 [mmc_queue_thread] req d955f9b0 blocks 128
 [mmc_queue_thread] req d967cd30 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810848
 [mmc_queue_thread] req d967cc58 blocks 128
 [mmc_queue_thread] req d967cb80 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810654
 [mmc_queue_thread] req d967caa8 blocks 128
 [mmc_queue_thread] req d967c9d0 blocks 128
 [mmc_queue_thread] req d967c8f8 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810652
 [mmc_queue_thread] req d967c820 blocks 128
 [mmc_queue_thread] req d967c748 blocks 128
 [do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810952
 [mmc_queue_thread] req d967c670 blocks 128
 [mmc_queue_thread] req d967c598 blocks 128
 [mmc_queue_thread] req d967c4c0 blocks 128
 [mmc_queue_thread] req d967c3e8 blocks 128
 [mmc_queue_thread] req   (null) blocks 0
 [mmc_queue_thread] req   (null) blocks 0
The mmc queue never runs empty until end of transfer.. The requests
are 128 blocks (64k limit set in mmc host driver) compared to 256
blocks before. This will not improve performance much since the
transfer now are smaller than before. The latency is minimal but
instead there extra number of transfer cause more mmc cmd overhead.
I added prints to print the wait time in lock_page_killable too.
I wonder if I can achieve a none empty mmc block queue without
compromising the mmc host driver performance.

Regards,
Per

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
