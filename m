From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/3] MMC / PM: Make it possible to use PM QoS latency
 constraints
Date: Tue, 06 Mar 2012 12:30:20 +0200
Message-ID: <4F55E73C.10907@intel.com>
References: <201203040101.53177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51107 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758536Ab2CFKaO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Mar 2012 05:30:14 -0500
In-Reply-To: <201203040101.53177.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On 04/03/12 02:01, Rafael J. Wysocki wrote:
> Hi all,
> 
> The goal of this patchset is to allow user space to control the
> responsiveness of the MMC stack related to runtime power management.

I wonder why this is build into mmc and not just a generic runtime pm
facility. e.g.

	/* Set maximum resume latency target to 100ms */
	pm_runtime_set_max_latency(dev, 100);

And then runtime pm will create sysfs attributes etc
