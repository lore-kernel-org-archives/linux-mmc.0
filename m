From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Protect read-modify-write of INTMASK
 with a lock
Date: Fri, 18 Oct 2013 13:09:28 -0700
Message-ID: <CAD=FV=WMMNA5xbwSrJebsLuw78sR1gtC0Yn+4FsA9HnvaNtk_A@mail.gmail.com>
References: <1381876762-10892-1-git-send-email-dianders@chromium.org>
	<1381876762-10892-3-git-send-email-dianders@chromium.org>
	<525E611A.6070708@imgtec.com>
	<CAD=FV=V4OPOjs=4cvXOomt1UnzUdw5VApkNAX2ERKZ46DC6_gg@mail.gmail.com>
	<CAAG0J98c6eA_c2McSvFcQUMUfPy-DgdHi7Te1tZqpT8XjjMQvw@mail.gmail.com>
	<52610493.1000909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:38920 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab3JRUJ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 16:09:29 -0400
Received: by mail-vc0-f179.google.com with SMTP id hz11so586361vcb.24
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2013 13:09:28 -0700 (PDT)
In-Reply-To: <52610493.1000909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: James Hogan <james.hogan@imgtec.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Bing Zhao <bzhao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jaehoon / James

On Fri, Oct 18, 2013 at 2:51 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> In this case it'd only be a space and code complexity thing I think. I
>> suppose in some cases the benefit of finer-grained locking is probably
>> pretty marginal, but there's a good case for it here. It might be
>> worth renaming the lock to irq_lock or something like that so it's
>> clear it doesn't have to protect only for INTMASK in the future - up
>> to you.
> It seems good that use the irq_lock than intmask_lock. (It's just naming)

Done in v2.
