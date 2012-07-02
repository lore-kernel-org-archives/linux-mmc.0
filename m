From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH] mmc: core: Revert "skip card initialization if powerclass selection fails"
Date: Mon, 02 Jul 2012 13:17:21 +0200
Message-ID: <1724838.XSl2kMpQ3Z@fb07-iapwap2>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com> <CAKLKtzcHnvoi66J4q=SEZmWhtHh3+V3_=4+B7u0XNukCckpm7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:41838 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770Ab2GBLRe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 07:17:34 -0400
In-Reply-To: <CAKLKtzcHnvoi66J4q=SEZmWhtHh3+V3_=4+B7u0XNukCckpm7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, girish.shivananjappa@linaro.org, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

Am Montag, 2. Juli 2012, 14:13:31 schrieb Saugata Das:
> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
> > This reverts commit 3d93576e(skip card initialization if
> > power class selection fails).
> > Problem has been reported when this is used with eMMC4.41
> > card with Tegra Platform. Till the issue is root caused,
> > bus width selection failure should not be treated as fatal.
> 
> According to me, we need to find the root issue (which could be either
> host not able to provide enough current or faulty eMMC). Do we know,
> what could be the side effect of working on eMMC  with less power than
> what it has requested in PWR_CL ?
> 
> One known issue with the current power class selection is that we do
> not check the current requirement for a selected power class. It
> assumes that host is able to provide the maximum current needed at
> highest speed (> 800mA). Is it already checked on Tegra ?

Acording to the schematic, the emmc is "fused" with 150mA and 450mA. There are 
many supplies connected to it, so it is hard to tell what is the maximum, but 
certainly not 800 mA. Why do you think it should be such high? Powerclass "7" 
means 270 mA max and 160 mA RMS (dual voltage card). Btw, you may successfully 
google for the "schematic document" for this "paz00" board in question.

Marc

