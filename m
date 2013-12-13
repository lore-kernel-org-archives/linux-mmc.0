From: Stephen Warren <swarren@wwwdotorg.org>
Subject: max_discard anomaly on certain Sandisk eMMC
Date: Fri, 13 Dec 2013 15:43:46 -0700
Message-ID: <52AB8DA2.9000001@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43391 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3LMWnt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 17:43:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On one of my eMMC devices, I see the following results from calling
mmc_do_calc_max_discard() with various parameters:

[    3.057263] MMC_DISCARD_ARG max_discard 1
[    3.057266] MMC_ERASE_ARG   max_discard 4096
[    3.057267] MMC_TRIM_ARG    max_discard 1

This causes mmc_calc_max_discard() to return 1, which makes the discard
IOCTL extremely slow.

For almost all my other eMMC devices, either:

* Both arguments to mmc_do_calc_max_discard() yield zero. Hence, the
discard IOCTL is not supported.

* Both arguments to mmc_do_calc_max_discard() yield some reasonable
large value. Hence, the discard IOCTL executes reasonably quickly.

Do you think that TRIM_ARG result is expected, or is the eMMC firmware
simply buggy?

If I modify mmc_calc_max_discard() to simply ignore the TRIM_ARG result
and always use the ERASE_ARG result, I see no errors when executing
discard operations from either mke2fs, or from the blkdiscard utility. I
have no idea if the discard operation is doing anything useful though.

As an aside, another eMMC device (with same manfid/oemid/name) I have
returns the same 1 for TRIM_ARG, but returns 0 for ERASE_ARG, and hence
discard is disabled, so I don't see this problem:

[    1.835747] MMC_DISCARD_ARG max_discard 1
[    1.839779] MMC_ERASE_ARG   max_discard 0
[    1.843791] MMC_TRIM_ARG    max_discard 1

To solve my slow discard operations, I'm tempted to modify
mmc_calc_max_discard() as follows:

if (max_discard == 1)
	max_discard = 0;

... but I'm not sure if that would be seen as a regression, since it'd
disable the discard operation completely on theoretically working (but
perhaps practically useless) systems.

Alternatively, perhaps I should replace:

	if (mmc_can_trim(card)) {
		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
		if (max_trim < max_discard)
			max_discard = max_trim;

with:

	if (mmc_can_trim(card)) {
		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
		if (max_trim > 1 && max_trim < max_discard)
			max_discard = max_trim;

Alternatively, should I install a quirk for the specific eMMC device,
which guards one of the changes above, or completely ignores the
TRIM_ARG result?

The eMMC device is question is:

manfid = 0x45
oemid = 0x100
name = SEM16G

Strangely, this is apparently a Sandisk eMMC device, yet there already
exist some quirks for a set of similarly named Sandisk devices, yet they
are triggered by manfid == 2, not 0x45. I'm not sure why Sandisk uses
two separate manufacturer IDs...
