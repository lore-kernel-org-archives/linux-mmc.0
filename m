From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: Re: [PATCH] mmc: core: Revert "skip card initialization if powerclass selection fails"
Date: Mon, 02 Jul 2012 13:20:20 +0200
Message-ID: <4776161.gj4CVEvArs@fb07-iapwap2>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com> <CAGxe1ZHZMMo7xzNQzoLZHULnAnZ=_J-QK3nP5dwrd=wgRQLE1w@mail.gmail.com> <CAGxe1ZHmm_UhkHmya63g_2YPrwZ+xwV1wdb5M5h44mxq82BvPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:32959 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750864Ab2GBLUY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 07:20:24 -0400
In-Reply-To: <CAGxe1ZHmm_UhkHmya63g_2YPrwZ+xwV1wdb5M5h44mxq82BvPg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Saugata Das <saugata.das@linaro.org>, Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

Am Montag, 2. Juli 2012, 14:28:37 schrieb Girish K S:
> On 2 July 2012 14:23, Girish K S <girish.shivananjappa@linaro.org> wrote:
> > On 2 July 2012 14:13, Saugata Das <saugata.das@linaro.org> wrote:
> >> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
> >>> This reverts commit 3d93576e(skip card initialization if
> >>> power class selection fails).
> >>> Problem has been reported when this is used with eMMC4.41
> >>> card with Tegra Platform. Till the issue is root caused,
> >>> bus width selection failure should not be treated as fatal.
> >> 
> >> According to me, we need to find the root issue (which could be either
> >> host not able to provide enough current or faulty eMMC). Do we know,
> >> what could be the side effect of working on eMMC  with less power than
> >> what it has requested in PWR_CL ?
> >> 
> >> One known issue with the current power class selection is that we do
> >> not check the current requirement for a selected power class. It
> >> assumes that host is able to provide the maximum current needed at
> >> highest speed (> 800mA). Is it already checked on Tegra ?
> > 
> > and at the least bus width i.e 1 bit mode.
> 
> The MMC card spec has 2 max current values (power class) one for 4 bit
> mode and another for 8 bit mode at supported voltages. But the SDHCI
> spec has one MaxCur register for supported voltages but doesnt mention
> for which bus width. Any input on this is very helpful to resolve the
> powerclass issue that is pending

the higher nibble is for 8 bit and the lower one for 4 bit. The power class is 
same for both bus width on this toshiba device.

Marc

