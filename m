From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
Date: Mon, 02 Apr 2012 12:08:23 -0700
Message-ID: <4F79F927.5060707@samsung.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com> <m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com> <m239abgc32.fsf@bob.laptop.org> <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com> <m2vcn0496y.fsf@bob.laptop.org> <87k426vy9r.fsf@laptop.org> <20120328095450.GA23005@sirena.org.uk> <4F73D3D7.1010202@samsung.com> <87zkawmf08.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64607 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab2DBTI0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 15:08:26 -0400
In-Reply-To: <87zkawmf08.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, 'Thomas Abraham' <thomas.abraham@linaro.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, 'Olof Johansson' <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

Chris Ball wrote:
> Hi Kukjin,
>
Hi,

Sorry for late response.

[...]

>
> I can't send the tree as it is to Linus now, because Arnd has asked us
> to hold off on these device tree bindings and work with the unified
> bindings he's proposing instead.  (Rebasing to drop that patch will
> introduce new conflicts.)
>
OK, I see.

> I'm going to send Mark Brown's two patches to Linus now, even though it
> will cause a conflict in -next.  The rest (other than the device tree
> bindings) are mergable after -rc1, because they're fixes, so we'll
> eventually get everything except DT in to 3.4.  I think you should
> just drop this patchset from your tree in linux-next entirely now.
>
Yep, I dropped it in my -next.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
