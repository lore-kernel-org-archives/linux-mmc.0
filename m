From: James Hogan <james.hogan@imgtec.com>
Subject: mmc_test Correct xfer_size at write
Date: Tue, 28 Jun 2011 11:37:25 +0100
Message-ID: <4E09AEE5.4050505@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:53757 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756988Ab1F1Khb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 06:37:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

I'm trying to figure out why the broken write transfer tests in mmc_test
require the result to be -ETIMEDOUT, so that I can make dw_mmc pass
these tests. Perhaps somebody could explain.

I can understand for reads, that the controller is waiting for the start
bit on the data lines and so it can timeout after a while if it doesn't
see any. However for writes (as far as I can glean from the physical
layer spec and a logic analyser) the data response token which is
normally sent by the card in response to a write transfer is clocked out
immediately after the data so is either there or it isn't.

Have I misunderstood it or is -ETIMEDOUT just the error that is required
by convention when the data response token is not detected?

Thanks

James

