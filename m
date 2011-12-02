From: Sangwook Lee <sangwook.lee@linaro.org>
Subject: Re: Build breakage in sdhci-s3c
Date: Fri, 2 Dec 2011 12:59:42 +0000
Message-ID: <CADPsn1aRwUfP+TjDXisoFqJUxg+H7m+OE3GVBE3PF1JZq-_PfA@mail.gmail.com>
References: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38766 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487Ab1LBM7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2011 07:59:42 -0500
Received: by dadv6 with SMTP id v6so1402208dad.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Dec 2011 04:59:42 -0800 (PST)
In-Reply-To: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linaro-dev@linaro.org, linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Kukjin

I checked out your git to look into Mark's email.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git f=
or-next

and I found out that the following patch wasn't applied This  patch
was acked by you and Thomas.

http://comments.gmane.org/gmane.linux.kernel.samsung-soc/7832
This patch has the title : [PATCH v2 1/2] ARM: SAMSUNG: Add pm_caps
into platform data

Could you help me to solve the below problem ?

Thanks
Sangwook


On 2 December 2011 11:58, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The mmc and therefore -next currently fail to build on Samsung platfo=
rms
> due to commit 666b6a (mmc: sdhci-s3c: Add pm_caps into SD/MMC host)
> which added use of a new field pm_caps in the platform data without
> actually adding that field to the struct. =A0I guess there's a separa=
te
> patch floating about somewhere which adds the field but it's not in
> -next and both commits should be going in via the same tree to avoid
> bisection breakage - ideally both the field and its use should be add=
ed
> as part of a single commit.
