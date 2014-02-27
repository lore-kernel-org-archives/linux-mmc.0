From: Aaron Lu <aaron.lu@intel.com>
Subject: SDIO driver return -ENOSYS behaviour change?
Date: Thu, 27 Feb 2014 17:10:48 +0800
Message-ID: <530F0118.2010501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49536 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbaB0JK7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Feb 2014 04:10:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf,

I was tracking some SDIO suspend problem and came across this. As Neil
mentioned here:
http://lkml.org/lkml/2012/3/25/20
Quote:
"
SDIO (and possible MMC in general) has a protocol where the suspend
 method can return -ENOSYS and this means "There is no point in suspending,
 just turn me off".
"

It seems that the following commit:

commit 810caddba42a54fe5db4e2664757a9a334ba359c
Author: Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon Jun 10 17:03:37 2013 +0200

    mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE

Changed this behaviour?

For example, the libertas SDIO driver's suspend callback still returns
-ENOSYS and before this commit, that error code will result in the SDIO
device being removed; after this commit, that would result in an error
code returned to PM core and a failure in system suspend.

I'm not sure if I understand this correctly as I do not have any SDIO
card to test. Can you please take a look at this? If this is indeed the
case, do we need to maintain this behaviour? I need to know this answer
as that would affect the way I'm going to solve my problem. Thanks.
