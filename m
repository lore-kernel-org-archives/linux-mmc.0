From: yongd <yongd@marvell.com>
Subject: Re: [PATCH V2 0/3] mmc: remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host
Date: Wed, 31 Oct 2012 18:14:50 +0800
Message-ID: <5090FA1A.2070605@marvell.com>
References: <1351589403-26398-1-git-send-email-yongd@marvell.com> <20121030231124.GA2902@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52038 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932975Ab2JaKPh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 06:15:37 -0400
In-Reply-To: <20121030231124.GA2902@lizard>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>, Zhangfei Gao <zgao6@marvell.com>, Kevin Liu <kliu5@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2012=E5=B9=B410=E6=9C=8831=E6=97=A5 07:11, Anton Vorontsov wrote:
> On Tue, Oct 30, 2012 at 05:30:00PM +0800, yongd wrote:
>> Sorry for my so late. And eventually these updated patches are here =
for your
>> review. Thanks in advance.
>> For patch 1, add SDHCI_QUIRK_BROKEN_CARD_DETECTION setting for ESDHC=
_CD_GPIO type,
>> or the host controller detection interrupts will be redundantly enab=
led. And its
>> comment is correspondingly updated.
>> For patch 2, broaden SDHCI_QUIRK_BROKEN_CARD_DETECTION setting for a=
ll detection
>> types except S3C_SDHCI_CD_INTERNAL. Then also update the comment.
>> For patch 3, no update.
> They all look OK, but note that I did not check drivers' logic, so I =
hope
> you carefully reviewed all the drivers yourself. :)
>
> Unfortunately, you decided to go the dangerous way, instead of taking=
 my
> 100%-safe approach (i.e.
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg16555.html )=
,
> which, to me, still makes more sense (of course :).
>
> Anyways, I'm not opposed either, so hopefully it works:
>
> 	Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
>
> Thanks!
> Anton.

Anton,
Thanks for your kindly review:-)

Just as I replied to u in the past (maybe got missed due to my previous=
=20
improper mail setting.
Thanks for Shawn Guo again:-)), I don't think your approach is proper.=20
Pls forgive me, ha ha...

Something like SDHCI_QUIRK_NEEDS_POLL means all the other detection=20
types are unavailable
except polling, and then if the card is removable, polling will be=20
enabled. Based on such meaning,
host driver will need set this flag if the host and card are of the=20
case. That is exactly of the detection
type like  ESDHC_CD_NONE or S3C_SDHCI_CD_NONE, etc. So, why not directl=
y=20
set the existing
MMC_CAP_NEEDS_POLL in host driver itself (just like Au1xmmc.c, etc)? I=20
think it is better than achieving
this indirectly through one more flag and some more logic code. Yes, on=
e=20
more line for each host driver,
but it is very clear and save one unnecessary flag, isn't it?

BTW, currently not all SDHCI_QUIRK_BROKEN_CARD_DETECTION flags in other=
=20
host drivers are set to
notify we shall use polling since this flag has its own pure usage. So=20
we can not simply convert them
to the new flag u mentioned. Hope I've gotten your idea:-)

So I think my patches are the proper way:-) BTW, I've carefully review=20
those patches. Thanks for your
reminding.

Shawn,
Could u pls help review those patches again? Thanks in advance.
