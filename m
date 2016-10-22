From: Natalia Portillo <claunia@claunia.com>
Subject: Help: Reading CID and CSD from MMC/SD card
Date: Sat, 22 Oct 2016 21:47:53 +0100
Message-ID: <bf47432d-6db5-0114-fb65-57568dde1fa7@claunia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 110.red-2-139-146.staticip.rima-tde.net ([2.139.146.110]:44132
        "EHLO mail.claunia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756006AbcJVUxY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2016 16:53:24 -0400
Received: from [172.26.2.1] (zeus.claunia.com [172.26.2.1])
        by mail.claunia.com (Postfix) with ESMTPSA id 1AE8214C8EFF8
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2016 21:47:54 +0100 (WEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

Sorry if this mailing list is not the correct place to ask for help but
I've been unable to find another place.

I'm trying to read CID and CSD from MMC/SD cards using ioctl (reading
from /sys is not a solution for me).

>From what I've seen I should send a CMD7 to move card to standby, then
CMD9/10 and then CMD7 to move card to transition state.

While first command seems to work, next ones get error -110, and the
card stays standby until physical ejection/reset.

After several tries I have not found the cause of this problem.

I have pasted snippet of code I'm using at the end of this email.

Test machine is QEMU with kernel 3.16.36-1+deb8u1, amd64 and QEMU's
virtual SDHCI-PCI device.

Regards,
Natalia Portillo



--------------- CODE FOLLOWS -----------------------------


#include <linux/ioctl.h>
#include <stdio.h>
#include <sys/types.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <linux/mmc/ioctl.h>
#include <string.h>
#include <sys/ioctl.h>

#define MMC_RSP_PRESENT (1 << 0)
#define MMC_RSP_CRC (1 << 2)
#define MMC_RSP_OPCODE (1 << 4)
#define MMC_RSP_R1 (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

int main(int argc, char *argv)
{
    int fd, fw;
    void *buffer;
    int address = 0;
    int ret = 0;
    struct mmc_ioc_cmd idata;

    fw = open("cid.bin", O_CREAT | O_RDWR);
    fd = open("/dev/mmcblk0", O_RDONLY);

    if(fd < 0)
    {
        perror("file open");
        return fd;
    }

    buffer = malloc(16);
    memset(&idata, 0, sizeof(idata));
    memset(buffer, 0, 16);

// Set standby
    idata.opcode = 7;
    idata.arg = 0;
    idata.flags = 0x15;
    idata.blksz = 0;
    idata.blocks = 0;
    mmc_ioc_cmd_set_data(idata, buffer);
    ret = ioctl(fd, MMC_IOC_CMD, &idata);

// Read CID
    idata.write_flag = 0;
    idata.opcode = 9;
    idata.arg = (1 << 16);
    idata.flags = 7;
    idata.blksz = 0;
    idata.blocks = 0;


    mmc_ioc_cmd_set_data(idata, buffer);

    ret = ioctl(fd, MMC_IOC_CMD, &idata);

    printf("response[0] = %d\n", idata.response[0]);

    printf("ret = %d\n", ret);

    if(ret)
        perror("ioctl");

// Set transition
    idata.opcode = 7;
    idata.arg = (1 << 16);
    idata.flags = MMC_RSP_R1;
    idata.blksz = 0;
    idata.blocks = 0;
    mmc_ioc_cmd_set_data(idata, buffer);
    ret = ioctl(fd, MMC_IOC_CMD, &idata);

    write(fw, buffer, 16);
    free(buffer);
    close(fd);
    close(fw);
    return ret;
}
