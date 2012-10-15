From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Support all MMC capabilities when booting
 from Device Tree
Date: Mon, 15 Oct 2012 17:07:40 +0100
Message-ID: <20121015160740.GC7662@gmail.com>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
 <201210151420.29930.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:34499 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2JOQHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 12:07:46 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1212037eaa.19
        for <linux-mmc@vger.kernel.org>; Mon, 15 Oct 2012 09:07:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201210151420.29930.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org

> On Monday 15 October 2012, Lee Jones wrote:
> > Capabilities are an important part of the MMC subsystem. Much
> > supported functionality would be lost if we didn't provide the
> > same level of support when booting Device Tree as we currently
> > do when the subsystem is passed capabilities via platform data.
> > This patch supplies this support with one simple call to a
> > DT parsing function.
>=20
> We already document all the commonly used properties
> in Documentation/devicetree/bindings/mmc/mmc.txt

<snip>

> and so on. What are you actually missing in the properties that
> are already there?

MMC_CAP_ERASE
MMC_CAP_UHS_SDR12
MMC_CAP_UHS_SDR25
MMC_CAP_UHS_DDR50
MMC_CAP_1_8V_DDR

MMC_CAP2_DETECT_ON_ERR
MMC_CAP2_NO_SLEEP_CMD

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
