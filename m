From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Wed, 12 Apr 2017 23:31:50 +0300
Message-ID: <20170412203150.GB3915@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17482 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755623AbdDLUcF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 16:32:05 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jglauber@cavium.com
Cc: linux-mmc@vger.kernel.org

Hello Jan Glauber,

This is a semi-automatic email about new static checker warnings.

The patch 8047c753f3d3: "mmc: cavium: Add core MMC driver for Cavium 
SOCs" from Mar 30, 2017, leads to the following Smatch complaint:

drivers/mmc/host/cavium.c:803 cvm_mmc_request()
	 error: we previously assumed 'cmd->data' could be null (see line 782)

drivers/mmc/host/cavium.c
   781	
   782		if (cmd->data) {
                    ^^^^^^^^^
Check.

   783			if (cmd->data->flags & MMC_DATA_READ)
   784				do_read_request(host, mrq);
   785			else
   786				do_write_request(host, mrq);
   787	
   788			if (cmd->data->timeout_ns)
   789				set_wdog(slot, cmd->data->timeout_ns);
   790		} else
   791			set_wdog(slot, 0);
   792	
   793		host->dma_active = false;
   794		host->int_enable(host, MIO_EMM_INT_CMD_DONE | MIO_EMM_INT_CMD_ERR);
   795	
   796		emm_cmd = FIELD_PREP(MIO_EMM_CMD_VAL, 1) |
   797			  FIELD_PREP(MIO_EMM_CMD_CTYPE_XOR, mods.ctype_xor) |
   798			  FIELD_PREP(MIO_EMM_CMD_RTYPE_XOR, mods.rtype_xor) |
   799			  FIELD_PREP(MIO_EMM_CMD_IDX, cmd->opcode) |
   800			  FIELD_PREP(MIO_EMM_CMD_ARG, cmd->arg);
   801		set_bus_id(&emm_cmd, slot->bus_id);
   802		if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
   803			emm_cmd |= FIELD_PREP(MIO_EMM_CMD_OFFSET,
   804					64 - ((cmd->data->blocks * cmd->data->blksz) / 8));
                                               ^^^^^^^^^^^         ^^^^^^^^^^^
Unchecked dereferences.  These are maybe false postives if == MMC_CMD_ADTC
implies data is non-NULL.  In that case, don't worry about it, this is
a one time email.

   805	

regards,
dan carpenter
