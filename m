From: Radovan Lekanovic <lekanovic@gmail.com>
Subject: MMC - Driver hangs if using bad SDCard
Date: Fri, 21 May 2010 12:13:25 +0000 (UTC)
Message-ID: <loom.20100521T141144-491@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58175 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801Ab0EUMUF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 May 2010 08:20:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1OFRCt-0007hl-Ob
	for linux-mmc@vger.kernel.org; Fri, 21 May 2010 14:20:03 +0200
Received: from 192.16.134.69 ([192.16.134.69])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 21 May 2010 14:20:03 +0200
Received: from lekanovic by 192.16.134.69 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 21 May 2010 14:20:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi
 
I have experienced problems with the MMC driver if using an bad SD card the MMC 
driver ends up in an infinite loop in file block.c function mmc_blk_issue_rq.
 
if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
                                                                                       
do {
                                                                                                                    
int err;
 
                                                                                                                    
cmd.opcode = MMC_SEND_STATUS;
                                                                                                                    
cmd.arg = card->rca << 16;
                                                                                                                    
cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
                                                                                                                    
err = mmc_wait_for_cmd(card->host, &cmd, 5);
                                                                                                                    
if (err) {
                                                                                                                                                 
printk(KERN_ERR "%s: error %d requesting status\n",
                                                                                                                                                        
req->rq_disk->disk_name, err);
                                                                                                                                                 
goto cmd_err;
                                                                                                                    
}
                                                                                                                    
/*
                                                                                                                     
* Some cards mishandle the status bits,
                                                                                                                     
* so make sure to check both the busy
                                                                                                                     
* indication and the card state.
                                                                                                                     
*/
                                                                                       
} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
                                                                                                                    
(R1_CURRENT_STATE(cmd.resp[0]) == 7));
 
 
The problem is that  R1_CURRENT_STATE(cmd.resp[0]) == 7 will always be TRUE. 
This problem will drain the battery on portabel devices.
The card works fine on other devices.
My idea to solve this problem is to break this loop by an timer if it take too 
long time for the SD-Card to replay. Will that solution break anything? Any 
other better solutions?
 
BR
Lekan

