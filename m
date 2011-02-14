From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and
 Question on Power Management
Date: Mon, 14 Feb 2011 10:55:28 +0100
Message-ID: <20110214095528.GA30100@pengutronix.de>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33286 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab1BNJzb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 04:55:31 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


> It looks like the mdelay are not in the fastpath, so why bother.

On embedded systems, we had audio streaming or CAN communication or similar
running in parallel. Currently, those mdelays (there are a couple, sadly)
produce significant latencies, e.g. when inserting/removing a card. The latter
gets especially bad with BROKEN_CARD_DETECTION.

The proper solution is probably to check the locking and see if it can be made
fine-granular, I'd assume?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
