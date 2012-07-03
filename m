From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH] mmc: core: Revert "skip card initialization ifpowerclass selection fails"
Date: Tue, 03 Jul 2012 22:19:27 +0200
Message-ID: <4960128.Dt0d2ayz8G@ax5200p>
References: <1341212194-24650-1-git-send-email-svenkatr@ti.com> <4776161.gj4CVEvArs@fb07-iapwap2> <CAGxe1ZFwECEqcV5aX7K2yhRLV_efGi2zWesGBvXwfS7BMrNxRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:56473 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751409Ab2GCUUw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 16:20:52 -0400
In-Reply-To: <CAGxe1ZFwECEqcV5aX7K2yhRLV_efGi2zWesGBvXwfS7BMrNxRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Saugata Das <saugata.das@linaro.org>, Venkatraman S <svenkatr@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Subhash Jadavani <subhashj@codeaurora.org>

On Tuesday 03 July 2012 09:25:11 Girish K S wrote:
> On 2 July 2012 16:50, Marc Dietrich <marvin24@gmx.de> wrote:
> > Am Montag, 2. Juli 2012, 14:28:37 schrieb Girish K S:
> >> On 2 July 2012 14:23, Girish K S <girish.shivananjappa@linaro.org> wrote:
> >> > On 2 July 2012 14:13, Saugata Das <saugata.das@linaro.org> wrote:
> >> >> On 2 July 2012 12:26, Venkatraman S <svenkatr@ti.com> wrote:
> >> >>> This reverts commit 3d93576e(skip card initialization if
> >> >>> power class selection fails).
> >> >>> Problem has been reported when this is used with eMMC4.41
> >> >>> card with Tegra Platform. Till the issue is root caused,
> >> >>> bus width selection failure should not be treated as fatal.
> >> >> 
> >> >> According to me, we need to find the root issue (which could be either
> >> >> host not able to provide enough current or faulty eMMC). Do we know,
> >> >> what could be the side effect of working on eMMC  with less power than
> >> >> what it has requested in PWR_CL ?
> >> >> 
> >> >> One known issue with the current power class selection is that we do
> >> >> not check the current requirement for a selected power class. It
> >> >> assumes that host is able to provide the maximum current needed at
> >> >> highest speed (> 800mA). Is it already checked on Tegra ?
> >> > 
> >> > and at the least bus width i.e 1 bit mode.
> >> 
> >> The MMC card spec has 2 max current values (power class) one for 4 bit
> >> mode and another for 8 bit mode at supported voltages. But the SDHCI
> >> spec has one MaxCur register for supported voltages but doesnt mention
> >> for which bus width. Any input on this is very helpful to resolve the
> >> powerclass issue that is pending
> > 
> > the higher nibble is for 8 bit and the lower one for 4 bit. The power
> > class is same for both bus width on this toshiba device.
> 
> This is true from device point of view. but my concern was with the
> host controller register of SDHCI Spec MAXCURRn
> where n is 1.8 / 3.3 /3.0. Each voltage supported is assigned 8 bits
> (values ranging from 0-255). which means there is no split in nibbles
> for 4-bit and 8-bit mode

I don't know if it matters but I just checked the TRMs and found that Tegra2 
only support MMC 4.3 standard while Tegra3 supports 4.41. If I understnad it 
right, v4.3 does not support the extented register yet (see changes from 4.3-
>4.4 in Annex B of the eMMC spec). But maybe this is irrelevant because it 
does not apply to the host controller.

Marc

