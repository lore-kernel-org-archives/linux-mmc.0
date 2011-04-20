From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 03/12] mmc: mmc_test: add test for none blocking transfers
Date: Wed, 20 Apr 2011 09:41:32 +0200
Message-ID: <BANLkTikhaCqW=4BD_h05QebBftVGjGQ3+w@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-4-git-send-email-per.forlin@linaro.org>
	<20110417154622.GC17935@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35902 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab1DTHld convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 03:41:33 -0400
In-Reply-To: <20110417154622.GC17935@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On 17 April 2011 17:46, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Wed, Apr 06, 2011 at 09:07:04PM +0200, Per Forlin wrote:
> [...]
>> +static int mmc_test_rw_multiple(struct mmc_test_card *test,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc=
_test_multiple_rw *tdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned i=
nt reqsize, unsigned int size)
>> +{
>> + =A0 =A0 unsigned int dev_addr;
>> + =A0 =A0 struct mmc_test_area *t =3D &test->area;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 int max_reqsize =3D max(t->mem->size_min_cmn *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min(t->max_seg=
s, t->mem->cnt), t->max_tfr);
>> +
> The 'max(..., t->max_tfr)' probably should be 'min(..., t->max_tfr)'.
> Otherwise, I see mmc_test failure on my mxs-mmc setup.
>
> mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
> mmc0: Transfer of 64 x 2048 sectors (64 x 1024 KiB) took 5.412563314 =
seconds (12
> 398 kB/s, 12108 KiB/s, 11.82 IOPS)
> mmc0: Failed to map sg list
> [mmc_test_rw_multiple] error
> mmc0: Result: ERROR (-22)
Thanks for letting me know. I think I should simplify it and use
t->max_tfr only.
I tried to optimize for one of my case when max_tfr is only 1MiB but
mmc request size is 32MiB.

>
> --
> Regards,
> Shawn
Regards,
Per
