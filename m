From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Wed, 3 Feb 2016 13:17:15 +0100
Message-ID: <56B1EFCB.1020508@i2se.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:59522 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbcBCMSe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Feb 2016 07:18:34 -0500
In-Reply-To: <1448988109-32630-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com, linux-meson@googlegroups.com, ulf.hansson@linaro.org, Carlo Caione <carlo@endlessm.com>

Hi Carlo,

Am 01.12.2015 um 17:41 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add a driver for the SD/MMC host found on the Amlogic MesonX SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
>
> This patch adds also the binding documentation.

according to Documentation/devicetree/bindings/submitting-patches.txt

the binding should be a separate patch in a series.

Stefan




