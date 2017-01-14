From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
Date: Sat, 14 Jan 2017 19:10:01 +0100 (CET)
Message-ID: <841116984.219625.1484417401803@email.1und1.de>
References: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdANSLU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jan 2017 13:11:20 -0500
In-Reply-To: <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>, =?UTF-8?Q?J=C3=B6rg_Krause?= <joerg.krause@embedded.rocks>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 14. Januar 2017 um 18:40 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Sat, Jan 14, 2017 at 3:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch implements support for multiblock transfers bounded
> > by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Just curious: what is the throughput gain you notice with this patch?

unfortunately i didn't see any noticeable changes on throughput.

> 
> Thanks
