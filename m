From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 1/2] MMC: add support for the Marvell Dove SDHCI controller
Date: Wed, 27 Oct 2010 21:52:08 +0800
Message-ID: <AANLkTin7vY3=u=VL08UUnszJksBv9nFiyo3qc8UX4dNd@mail.gmail.com>
References: <cover.1288178148.git.mike@compulab.co.il>
	<b0ae564fec46432f6cb845f258f5940d3ed2008d.1288178148.git.mike@compulab.co.il>
	<20101027115641.GA17418@void.printf.net>
	<FCBE654890C0334289D0AD3AF4EF009FE1475AA476@IL-MB01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab0J0NwK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 09:52:10 -0400
Received: by eye27 with SMTP id 27so560535eye.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 06:52:08 -0700 (PDT)
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FE1475AA476@IL-MB01.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Mike Rapoport <mike@compulab.co.il>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>

On Wed, Oct 27, 2010 at 8:35 PM, Saeed Bishara <saeed@marvell.com> wrote:
>
>>
>>Let's add a little text here -- something like "Implement an
>>sdhci-pltfm
>>driver for the controller found on Marvell Dove and MMP SoCs" is fine.
> This driver for Dove only. I think MMP uses sdhci-pxa.

Yes, MMP can use sdhci-pxa.
