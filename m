From: Madhav Chauhan <madhav.imsec@gmail.com>
Subject: Re: MMC insert remove issue
Date: Wed, 19 May 2010 18:59:58 +0530
Message-ID: <AANLkTilDl243C5bvJGr1Id_lAItr9QLq6k6Q0qab7bDf@mail.gmail.com>
References: <AANLkTimg_VbK2uPZNCn3Il8klv22JhF7iEe-MTCA5NYe@mail.gmail.com>
	 <m3632lb61t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34170 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab0ESN36 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 May 2010 09:29:58 -0400
Received: by pwi5 with SMTP id 5so1538062pwi.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 May 2010 06:29:58 -0700 (PDT)
In-Reply-To: <m3632lb61t.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Chris,
Thanks for your response...
Below is the back trace for Soft lock up occured also my host
controller uses the SDHCI interface.

 [  118.038802] BUG: spinlock lockup on CPU#0, mmcqd/1284, c42e7200
[  118.043248] [<c047f164>] (dump_stack+0x0/0x14) from [<c02adf30>]
(_raw_spin_lock+0x12c/0x16c)
[  118.051745] [<c02ade04>] (_raw_spin_lock+0x0/0x16c) from
[<c0481c24>] (_spin_lock_irq+0x14/0x18)
[  118.060505]  r8:c33b4b7c r7:c33b4a40 r6:c42e721c r5:c42e7214 r4:c459=
4000
[  118.067182] [<c0481c10>] (_spin_lock_irq+0x0/0x18) from
[<c0370504>] (mmc_queue_thread+0x48/0xe8)
[  118.076029] [<c03704bc>] (mmc_queue_thread+0x0/0xe8) from
[<c016ef04>] (kthread+0x54/0x80)
[  118.084269] [<c016eeb0>] (kthread+0x0/0x80) from [<c015d9a8>]
(do_exit+0x0/0x640)
[  118.091728]  r5:00000000 r4:00000000

Regards,
Madhav

On Tue, May 18, 2010 at 8:39 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> =A0 > In one ARM based boards I am facing soft lock up issue while
> =A0 > inserting/removing MMC/SD card continuously having 2K files. =A0=
Can
> =A0 > someone point me where should i look whether host controller
> =A0 > driver or MMC block layer/Kernel block layer??
>
> Could be any of the above, but perhaps most likely your host
> controller driver -- which one are you using? =A0Can you perform
> alt-sysrq-t when the lockup happens, or get a kgdb backtrace?
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org>
> One Laptop Per Child
>
