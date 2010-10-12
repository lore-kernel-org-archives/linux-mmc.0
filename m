From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: mmc_core: question on mmc_do_erase function
Date: Tue, 12 Oct 2010 21:11:34 +0800
Message-ID: <5D8008F58939784290FAB48F549751982DD7F00EDB@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21916 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab0JLNLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 09:11:41 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

Hi adrian

I got some questions about MMC driver erase function. Help you can give me some suggestion. My host controller is a kind of SDHCI host controller. And testing below code by using HD micro SD card.
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_ERASE;
+	cmd.arg = arg;
+	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	mmc_set_erase_timeout(card, &cmd, arg, qty);
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (err) {
+		printk(KERN_ERR "mmc_erase: erase error %d, status %#x\n",
+		       err, cmd.resp[0]);
+		err = -EIO;
+		goto out;
+	}
As MMC 4.4 standard said, CMD38 need R1B response. So when SDHCI host controller got a SDHCI_INT_RESPONSE interrupt, driver will ignore this and keep on waiting for a SDHCI_INT_DATA_END interrupt to finish MMC_ERASE command. Then I got problems....My host controller will got a DATA_TIMEOUT interrupt if host controller cannot generate any interrupt during its waiting time, unfortunately the max waiting time for my SDHCI host controller is 5s. So if any ERASE operation need more than 5s seconds to finish, my controller will not finish the ERASE operation and only generate a DATA_TIMEOUT interrupt. The ERASE will be failed. Another, MMC driver also has a 10s timer to keep watch over the interrupt, if ERASE operation need more than 10s to finish, this timer also can report a TIMEOUT error.
I think cmd->erase_timeout can help to set the timer expires, but how to deal with this issue for SDHCI host controller? How about split ERASE groups to be smaller ones?

+	if (mmc_host_is_spi(card->host))
+		goto out;
+
+	do {
+		memset(&cmd, 0, sizeof(struct mmc_command));
+		cmd.opcode = MMC_SEND_STATUS;
+		cmd.arg = card->rca << 16;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		/* Do not retry else we can't see errors */
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err || (cmd.resp[0] & 0xFDF92000)) {
+			printk(KERN_ERR "error %d requesting status %#x\n",
+				err, cmd.resp[0]);
+			err = -EIO;
+			goto out;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
+		 R1_CURRENT_STATE(cmd.resp[0]) == 7);
+out:
+	return err;
+}
And can this code guarantee the card will finish the ERASE operation? If it can, what about send CMD38 with R1 response?(although doing this is against with MMC 4.4 standard....)

Best Regards
Chuanxiao Dong

