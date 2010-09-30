From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Thu, 30 Sep 2010 16:06:57 +0800
Message-ID: <AANLkTikwdewfs_1efkga-QnB+gMUXUXKKcVNq0K_TRcQ@mail.gmail.com>
References: <1278658780-26397-1-git-send-email-hanumath.prasad@stericsson.com>
	<AANLkTikBdBhJeQ-t2+0echJfAxz529QZEYPJtyHUsROd@mail.gmail.com>
	<m3pqxbsibq.fsf@pullcord.laptop.org>
	<20100823204829.GB6510@console-pimps.org>
	<20100823142816.59b12253.akpm@linux-foundation.org>
	<4C739F55.8030301@nokia.com>
	<20100914112143.GA16039@void.printf.net>
	<2A3DCF3DA181AD40BDE86A3150B27B6B031606223F@dbde02.ent.ti.com>
	<20100922022047.GA3821@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51657 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072Ab0I3IG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 04:06:58 -0400
In-Reply-To: <20100922022047.GA3821@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "STEricsson_nomadik_linux@list.st.com" <STEricsson_nomadik_linux@list.st.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Kyungmin Park <kmpark@infradead.org>

On Wed, Sep 22, 2010 at 10:20 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Sep 20, 2010 at 10:04:39AM +0530, Ghorai, Sukumar wrote:
>> Chris and all,
>> Can we plan these patches for 2.6.37 release?
>> Also let me know if I can do anything!
>
> I would like to merge this for .37, and the quirk and merge conflicts
> are not a big deal. =A0First, though, I'd like to see at least some o=
f:
>
> * a reply from Hanumath to Kyungmin on the use of MMC_DDR_MODE,
> =A0and which host controller the submitted patch was tested on.
> * an acknowledgement/comment on Adrian's fixup patch
> * an ACK on the original+fixup patch as mergeable from Adrian
> * some explicit Tested-by: lines for the commit.

Thanks Hanumath for your patch to enable ddr mode for emmc 4.4, thanks
a lot for sharing the patch.
We have verifeid on sdhci-pxa with toshiba emmc.

Tested-by Zhangfei Gao <zhangfei.gao@marvell.com>
>
> Thanks!
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
