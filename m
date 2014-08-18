From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCHv10 3/5] ARM: dts: exynos: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
Date: Mon, 18 Aug 2014 16:10:29 +0200
Message-ID: <53F20955.2050806@suse.de>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com> <1407397082-32495-4-git-send-email-jh80.chung@samsung.com> <53F1F027.7060609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaHROKf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Aug 2014 10:10:35 -0400
In-Reply-To: <53F1F027.7060609@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jaehoon,

Am 18.08.2014 14:23, schrieb Jaehoon Chung:
> Socfpga and Rockchip were queued into each SoC tree.
> I want to know whether this patch is queued or not into Samsung-Soc t=
ree.
> Do you have any other plan for this patch?

It isn't applied in his tree:

http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/

In fact Kukjin has not applied any patches for 3 weeks now, which likel=
y
means he's on vacation. I am hoping he will review this and the other
pending conflicting patches to decide on a merge order and fix any
trivial conflicts himself. ;)

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
