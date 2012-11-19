From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] at91: fixes for 3.7-rc7
Date: Mon, 19 Nov 2012 08:52:42 -0800
Message-ID: <CAOesGMjAYtEkmEYnzCQ4G821BWG9D6LHvgt5aOMJgus_hzFkRA@mail.gmail.com>
References: <50AA5ED5.8090901@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57314 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942Ab2KSQwp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 11:52:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7070842iea.19
        for <linux-mmc@vger.kernel.org>; Mon, 19 Nov 2012 08:52:43 -0800 (PST)
In-Reply-To: <50AA5ED5.8090901@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Nicolas,

On Mon, Nov 19, 2012 at 8:31 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Arnd, Olof,
>
> Here is another "fixes" pull request for AT91. It enables the sd/mmc driver
> for Device Tree enabled platforms. Those patches where part of a series that
> was split in two for reaching upstream: the MMC part is already in Linus' tree
> and this is the arm-soc part.
> I have placed these patches on top of the fixes that you already have for AT91.

What regressions do these fixes resolve?

It looks more like they are DT-enablement patches to me, and thus 3.8
material, not 3.7. I'll be happy to queue them up in next/dt though.

Thanks,

-Olof
