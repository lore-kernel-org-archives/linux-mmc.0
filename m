From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Mon, 20 Sep 2010 23:16:18 -0400
Message-ID: <AANLkTi=Rwj7hDfDxKqLNwyparxWv3RvQ2HJvo1qbJVe2@mail.gmail.com>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
	<20100921010324.GA5873@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40790 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab0IUDQU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 23:16:20 -0400
Received: by wwj40 with SMTP id 40so93271wwj.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 20:16:19 -0700 (PDT)
In-Reply-To: <20100921010324.GA5873@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

On Mon, Sep 20, 2010 at 9:03 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Zhangfei/Saeed,
>
> On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:
>> Hi, Chris,
>>
>> Here is patch to support pxa168(aspen)/pxa910(ttc)/mmp2, the
>> controller follow sdh 3.0.
>> Currently verified sd, Micron 16G emmc need some workaround, 8G is O=
K,
>> marvell 8787 would be verified later.
>> Help review.
>
> Could you help me understand how this new driver relates to the Marve=
ll
> SoC driver that I merged last week (CONFIG_MMC_SDHCI_MV)? =A0Are the =
SD
> IPs in Dove and MMP2 different enough to warrant a separate driver, o=
r
> could support for both be included in sdhci-mv.c?
>
> If we're going to have multiple drivers for the SD blocks in Armada/P=
XA,
> it at least seems that MMC_SDHCI_MV has been mis-named. =A0Any though=
ts?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

Hi, Chris

We have considered using the same driver with dove once saeed push the
driver, but at last we decide to use seperate driver to easy
maintaince and further extension.

There are different IP developed by different group between Dove and
pxa168/pxa910/mmp2, and would be more and more different.
The pxa serious ip is follow sdh spec 3.0, and support sd 3.0 and emmc
4.4, which need ddr50 and 1.8v requirement, the limitation is adma
still has some issue and in fixing.
Still some private register with differnt address, such as power
control, clock timming tunning and etc.

The dove ip is follow sdh spec 2.0, and it has own limitation, such as
1.8v may not be supported.

In a word, they are differnt ip, and it is reasonable to use seprate dr=
iver.

Thanks
