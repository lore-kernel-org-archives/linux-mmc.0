From: Simon Horman <horms@verge.net.au>
Subject: mmcoops + mmcblk
Date: Tue, 12 Jul 2011 15:32:25 +0900
Message-ID: <20110712063225.GA12742@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55091 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1GLGcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 02:32:31 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, 'Andrew Morton' <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>

Hi,

I am looking over the "[RFC] mmcoops with panic/oops" and is strikes
me that although platform data is used to limit the area of the MMC
device to which the oops is witten, the entire device has to belong
(be bound to) the mmc_oops driver and as such no part of the device
can be used for anything else.

I am wondering if I am missing something?

In particular, I would like to allow a single MMC chip to be
used both by mmcblk (as a filesystem) and as mmc_oops (a small
area reserved for writing oops messages).

