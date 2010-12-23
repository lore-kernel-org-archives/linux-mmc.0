From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Thu, 23 Dec 2010 00:59:03 -0800
Message-ID: <AANLkTim3v8XzR36ZUn9dSUXpnTLZv134fRVg5VKOtetd@mail.gmail.com>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
	<1293004871-1918-4-git-send-email-olof@lixom.net>
	<4D12EA4A.4000906@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58066 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0LWI7E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 03:59:04 -0500
In-Reply-To: <4D12EA4A.4000906@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

Hi,

On Wed, Dec 22, 2010 at 10:20 PM, Mike Rapoport <mike@compulab.co.il> w=
rote:

> Only one comment below, otherwise feel free to add
> Acked-by: Mike Rapoport <mike@compulab.co.il>

Thanks!

>> + =A0 =A0 if (gpio_is_valid(plat->wp_gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rc =3D gpio_request(plat->wp_gpio, "sdhci_=
wp");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc)=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to=
 allocate wp gpio\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_gpio_enable(plat->wp_gpio);
>
> gpio_direction_input?

Yep, for cd_gpio too.


-Olof
