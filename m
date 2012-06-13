From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pxa: Add device tree support
Date: Wed, 13 Jun 2012 10:15:08 -0400
Message-ID: <87sjdzxpqr.fsf@octavius.laptop.org>
References: <8762aw1hcw.fsf@octavius.laptop.org>
	<CAMj5Bkge5GwQmuz2MpDx19ymAac0WxvF-s2DN=x8U4OWTvmecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37419 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2FMOPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 10:15:18 -0400
In-Reply-To: <CAMj5Bkge5GwQmuz2MpDx19ymAac0WxvF-s2DN=x8U4OWTvmecw@mail.gmail.com>
	(zhangfei gao's message of "Wed, 13 Jun 2012 11:11:49 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

Hi Zhangfei,

On Tue, Jun 12 2012, zhangfei gao wrote:
> On Wed, Jun 13, 2012 at 3:05 AM, Chris Ball <cjb@laptop.org> wrote:
>> Tested on an OLPC XO-1.75. =C2=A0(MMP2, sdhci-pxav3, CONFIG_MACH_MMP=
2_DT=3Dy)
>>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>> =C2=A0.../devicetree/bindings/mmc/sdhci-pxa.txt =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 21 ++++++++
>> =C2=A0drivers/mmc/host/sdhci-pxav2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 52 ++++++++++++++++++++
>> =C2=A0drivers/mmc/host/sdhci-pxav3.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 50 +++++++++++++++++++
>> =C2=A03 files changed, 123 insertions(+)
>> =C2=A0create mode 100644 Documentation/devicetree/bindings/mmc/sdhci=
-pxa.txt
>
> Thanks Chris for the great help, compile error if CONFIG_OF not defin=
ed.

Thanks for catching this!

How do you feel about having the compatible node say "sdhci-pxav3"
instead of "mrvl,pxav3-mmc"?  I used the mrvl prefix because it fits
in with the rest of your existing DT, but it seems like it would be
better to name the driver directly.  The DTs here live inside the
source tree, so we're not depending on anyone else's terminology.

If you're okay with sdhci-pxav{2,3} in compatible, I'll include that
in v2 of the patch with the rest of your fixes.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
