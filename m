From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc: core: Delete an error message for a failed memory allocation
 in three functions
Date: Fri, 19 May 2017 12:00:09 +0200
Message-ID: <CAPDyKFraTYQWAqSNdZG_bRpbDiLFw4nigVzC1nkmrfnr2aw2og@mail.gmail.com>
References: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
 <CAPDyKFqhNQdfr19195YfL7f4Jh0u6pGZ9QtSff0C6fe6R9wdjw@mail.gmail.com> <50f3c642-b866-27f3-1201-5490225116f4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33679 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdESKAL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 06:00:11 -0400
Received: by mail-qt0-f171.google.com with SMTP id t26so54196653qtg.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 03:00:10 -0700 (PDT)
In-Reply-To: <50f3c642-b866-27f3-1201-5490225116f4@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Shawn Lin <shawn.lin@rock-chips.com>, Tomas Winkler <tomas.winkler@intel.com>, Uri Yanai <uri.yanai@sandisk.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 19 May 2017 at 11:39, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> It's a nice cleanup. However I found one more occasion in mmc_test.c,
>> please fix that and re-spin.
>
> To which source code place does this feedback refer?
>
> Does it mean that another message removal would make sense in the
> function =E2=80=9C__mmc_test_register_dbgfs_file=E2=80=9D?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/mmc/core/mmc_test.c?h=3Dv4.11#n3202

Yes!

Br
Uffe
