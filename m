From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v13 0/6] Cavium MMC driver
Date: Thu, 13 Apr 2017 01:37:50 +0300
Message-ID: <20170412223750.mcm62ns57uag6y7q@raspberrypi-3.musicnaut.iki.fi>
References: <20170330153128.22842-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:41655 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdDLWhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 18:37:53 -0400
Content-Disposition: inline
In-Reply-To: <20170330153128.22842-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 30, 2017 at 05:31:22PM +0200, Jan Glauber wrote:
> Hi Ulf,
> 
> we have a bug on some Octeon plattforms so I removed the Octeon driver for now
> (but kept the DT bindings for it). We'll submit the Octeon driver later when
> we've fixed the issue.

Please rather post a new version that also works with OCTEON. I don't
think a partial driver should be merged; originally this driver was
working fine with OCTEON so there should be no issue supporting that?!

A.
