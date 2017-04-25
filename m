From: Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Tue, 25 Apr 2017 15:28:41 +0200
Message-ID: <6CE953B4-0A5C-4DDF-B85D-6CE58031C19C@linaro.org>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com> <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com> <CACRpkdYBB1ZMnvCKet706bm12B3DWnie=0uDri835R_f81gMUw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34616 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1430565AbdDYN2q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Apr 2017 09:28:46 -0400
Received: by mail-wr0-f169.google.com with SMTP id l9so6657946wre.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Apr 2017 06:28:45 -0700 (PDT)
In-Reply-To: <CACRpkdYBB1ZMnvCKet706bm12B3DWnie=0uDri835R_f81gMUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>


> Il giorno 24 apr 2017, alle ore 10:12, Linus Walleij =
<linus.walleij@linaro.org> ha scritto:
>=20
> On Sat, Apr 22, 2017 at 9:45 AM, Adrian Hunter =
<adrian.hunter@intel.com> wrote:
>=20
>> Ulf and Linus have been doing a great job of keeping this moving, but =
it
>> would be nice to see some others taking more interest.  The first =
command
>> queue patches were posted in February 2014, over 3 years ago!
>=20
> I agree.
>=20
> I think both me & Ulf would also be doing more work if we had easily
> accessible hardware with upstream host controller support for native
> command queueing. (Hm, was just reading in libata about NCQ ...
> d=C3=A9ja vu ... https://en.wikipedia.org/wiki/Native_Command_Queuing)
>=20

That would allow me too to run some test with BFQ and MMC ...

Thanks,
Paolo

> Do we have some hardware with host-backed command queueing
> out there that is easily obtained and has upstream support for the
> basic system?
>=20
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

