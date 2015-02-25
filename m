From: angelo <angelo70@gmail.com>
Subject: sdio sn8000 wifi module
Date: Thu, 26 Feb 2015 00:19:39 +0100
Message-ID: <54EE588B.2030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:34628 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbbBYXTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 18:19:38 -0500
Received: by wesq59 with SMTP id q59so6736354wes.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2015 15:19:37 -0800 (PST)
Received: from [192.168.0.2] (host179-171-dynamic.56-82-r.retail.telecomitalia.it. [82.56.171.179])
        by mx.google.com with ESMTPSA id hv5sm66888474wjb.16.2015.02.25.15.19.36
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 15:19:36 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear all,

i am trying to have working this module with kernel 3.10 over
sdio, 4 lines, high speed, on a imx6q.

The bcm43362 CHIP_ID is still missing in kernel 3.10 so i merged
some small parts of 3.14 wifi drivers into 3.10.

Actually, seems this module does not reply to the SDIO probing
commands, i am getting err 110 (time out).

Seems its failing here, into sdio_ops.c

int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
{
     struct mmc_command cmd = {0};
     int i, err = 0;

     BUG_ON(!host);

     cmd.opcode = SD_IO_SEND_OP_COND;
     cmd.arg = ocr;
     cmd.flags = MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR;

     for (i = 100; i; i--) {

   >>>   err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
         if (err)
             break;


I checked trough oscilloscope, the command is sent but the
recognize operation terminates in time out.

I am using device tree. usdhc controller is set as 4 lines SDIO.

Every help or suggestion is appreciated.

Many thanks,
angelo
