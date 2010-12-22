From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH v2 2/3]mmc: enable runtime PM support of sdhci host controller
Date: Wed, 22 Dec 2010 14:26:39 +0100
Message-ID: <AANLkTinO7cgJgR0w=9dF0uSFFMh_ybb0bNXffXiCxy8p@mail.gmail.com>
References: <20101206122236.GC30654@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38237 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0LVN1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 08:27:30 -0500
In-Reply-To: <20101206122236.GC30654@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

> +int sdhci_runtime_suspend(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (host->vmmc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_disable(host->vmmc);
Please dont suspend the card's power in the sdhci's suspend function.
This means the card will die.
Think of the wifi idle use case where the wifi is working, but sdio
bus is not used. sdhci will suspend, but wifi card wont.
manipulation of the host->vmmc must be done in set_ios() (I will send
the patch later in the week...)

Regards,
--=20
Pierre
