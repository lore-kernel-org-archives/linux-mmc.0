From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -resend] mmc: ushc: fix an endianness conversion in
 ushc_request()
Date: Wed, 27 Jun 2012 12:02:58 +0300
Message-ID: <20120627090258.GH31212@elgon.mountain>
References: <20120627085800.GA3007@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:23235 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab2F0JDY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jun 2012 05:03:24 -0400
Content-Disposition: inline
In-Reply-To: <20120627085800.GA3007@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

The ->cmd_idx field is 8 bits, not 16 so the call to cpu_to_le16()
will probably set cmd_idx to zero here on big endian systems.  My guess
is that this works because it has been tested on little endian systems
where the conversion to le16 is a nop.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have a way to test this.

I have added a sentence to the changelog.  I have added David Vrabel to
the CC list.  This was originally sent to the mailing list on Mon, 21
Nov 2011 and there was no response.

diff --git a/drivers/mmc/host/ushc.c b/drivers/mmc/host/ushc.c
index c0105a2..25932f5 100644
--- a/drivers/mmc/host/ushc.c
+++ b/drivers/mmc/host/ushc.c
@@ -278,7 +278,7 @@ static void ushc_request(struct mmc_host *mmc, struct mmc_request *req)
 	ushc->current_req = req;
 
 	/* Start cmd with CBW. */
-	ushc->cbw->cmd_idx = cpu_to_le16(req->cmd->opcode);
+	ushc->cbw->cmd_idx = req->cmd->opcode;
 	if (req->data)
 		ushc->cbw->block_size = cpu_to_le16(req->data->blksz);
 	else
